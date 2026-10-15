#!/usr/bin/env bash
cd "$(dirname "$0")" || exit 1
YML=windows10.yml

case "$1" in
  on|start)
    docker compose -f "$YML" up -d
    echo "부팅 중입니다. 1~2분 뒤 Ports 탭의 8006 포트로 접속하세요."
    ;;
  off|stop)
    docker compose -f "$YML" stop
    ;;
  log|logs)
    docker logs -f windows
    ;;
  status|st)
    docker ps -a --filter name=windows --format "table {{.Names}}\t{{.Status}}"
    df -h /workspaces | tail -1
    nproc
    ;;
  quit|bye)
    docker compose -f "$YML" stop
    echo "Codespace를 중지합니다..."
    gh codespace stop -c "$CODESPACE_NAME" \
      || echo "자동 중지에 실패했습니다. github.com/codespaces에서 직접 중지하세요."
    ;;
  *)
    echo "사용법: win {on|off|log|status|quit}"
    ;;
esac
