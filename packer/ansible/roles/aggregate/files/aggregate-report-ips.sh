#!/usr/bin/env bash

propsFile=/var/lib/tomcat8/webapps/ROOT/WEB-INF/classes/security.properties
rawHostname=$(grep hostname ${propsFile} | awk '{split($0,a,"="); print a[2]}')
hostname=${rawHostname:-localhost}
httpPort=$(grep port ${propsFile} | awk '{split($0,a,"="); print a[2]}')
version=$(cat /usr/local/bin/aggregate-version)
ips=$(ip address | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' | awk -F'/' '{print $1}')

echo "> Welcome to ODK Aggregate VM $version"
echo "> 1. Open the web browser on your computer"
if [ ${httpPort} = "80" ]; then
  echo "> 2. Go to http://${hostname}"
else
  echo "> 2. Go to http://${hostname}:${httpPort}"
fi
echo "> 3. Sign in with the Aggregate password"
echo "> Need the password? Read the readme.txt file."
echo ""

if [ ! -z ${ips} ]; then
  echo "> If the above URL does not work, try connecting to these IP addresses instead"
  echo "${ips}" | while IFS= read -r line ; do echo "> - ${line}"; done
  echo ""
fi
