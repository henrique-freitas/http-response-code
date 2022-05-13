#!/bin/bash

urls=()
i=0

while IFS='' read -r line || [[ -n "$line" ]]; do
  
  ((i++))


  if [[ "$2" && $i -lt "$2" ]]; then
    continue
  fi

  echo "[${i}] run $line"
  statusCode=$(curl -s -o /dev/null -I -w "%{http_code}" $line)
  
  echo "Code: $statusCode"
  urls+=("[${statusCode}] ${line}")


  sleep 2
done < "$1"

echo "---------------"
errorsCount=${#urls[@]}

if [[ "$statusCode" != 2* ]]; then
  echo "Found $errorsCount URL."
fi

if (( $errorsCount > 0 )); then
  printf '%s\n' "${urls[@]}"
fi