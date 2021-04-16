#!/bin/sh

emails=()
host=''
host_name=''
port=5000

print_usage() {
  echo 'usage: --email email1 --email email2'
  echo '       --host nucpcaps1'
  echo '      [--port 5000] # default 5000'
  echo '      [--host-name a-more-verbose-host-name] # default $host'
}

while test $# -gt 0; do
  case "$1" in
    -h|--healp)
      print_usage
      exit 0
      ;;

    --email)
      shift
      emails+=($1)
      shift
      ;;

    --host)
      shift
      host=$1
      shift
      ;;

    --host-name)
      shift
      host_name=$1
      shift
      ;;

    --port)
      shift
      port=$1
      ;;

    *)
      break
      ;;
  esac
done

if [ ${#emails[@]} -eq 0 ]; then
  echo 'No emails specified' >&2;
  print_usage;
  exit 1;
fi

for email in "${emails[@]}"
do
  if [[ ! $email = *@* ]]; then
    echo "${email} is not a valid email" >&2;
    exit 1;
  fi
done

if [ -z "$host" ]; then
  echo "No host given" >&2
  print_usage;
  exit 1;
fi

if [ -z "$host_name" ]; then
  host_name=${host};
fi

port_is_active() {
  nc -zvw10 ${host} ${port} 1>&- 2>&-;
}

send_healthcheck_errors() {
  echo "Healh check failed for ${host_name} (${host}:${port})" |\
  mail -s "Health Check failed for ${host_name}" ${emails[@]}
}

execute_check() {
  if ! port_is_active ; then
    echo "Failure for ${host_name}" >&2;
    send_healthcheck_errors
  fi
}

execute_check

