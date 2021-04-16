# sh-health-checker
A quick health checker that sends emails on failure

This command will check if the port 5000 is being used on the remote nucpcaps2.
If it's not being used, it will send an email.
~~~sh
# --host-name defaults to --host
# --port defaults to 5000

./check-remote.sh                        \
  --email terman.emil@gmail.com          \
  --email emil.terman@gmail.com          \
  --host nucpcaps2                       \
  --host-name 'nicer-name-for-nucpcaps2' \
  --port 5000
~~~

To check every 60 seconds for example, the following command can be used:
~~~sh
watch -n 60 ./check-remote.sh            \
  --email terman.emil@gmail.com          \
  --email emil.terman@gmail.com          \
  --host nucpcaps2                       \
  --host-name 'Nicer name for nucpcaps2' \
  --port 5000
~~~

Note: to run a command in background `&` can be used. So the following will run in background
~~~sh
watch ... &
~~~
