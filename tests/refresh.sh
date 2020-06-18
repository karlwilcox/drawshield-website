#!/bin/bash

url=http://test.drawshield.home
target=/include/drawshield.php?

if [ $# -eq 0 ]; then
  myargs='commands/*.txt'
else
  myargs="$*"
fi
for i in $myargs; do
  name=${i##*/}
  name=${name%.txt}
  args=$(sed -e '/^#/d' -e '/^[[:space:]]*$/d' -e 's/.*/--data-urlencode "&"/' $i | paste '-sd ')
  eval curl --silent $args $url$target > "expected/$name.svg"
  echo Created: $name with $args
  sleep 1
done
