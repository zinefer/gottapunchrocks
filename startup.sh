#!/usr/bin/env bash

PID=0
trap 'kill $PID' EXIT

if [ -z "$(which inotifywait)" ] ; then
  echo "Install inotify-tools"
  exit 1
fi

while true; do
  sleep 2;
  inotifywait -qm --event modify --format '%e' ./docker-compose.yml | echo ""
  docker-compose up -d &
done &
PID=$!

docker-compose  up

kill $PID