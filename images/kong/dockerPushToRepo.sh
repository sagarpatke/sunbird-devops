#!/bin/sh
# Build script
# set -o errexit
set -e
e () {
    echo $( echo ${1} | jq ".${2}" | sed 's/\"//g')
}
m=$(./images/kong/metadata.sh)

org=$(e "${m}" "org")
hubuser=$(e "${m}" "hubuser")
name=$(e "${m}" "name")
version=$(e "${m}" "version")

docker login -u "${hubuser}" -p`cat /run/secrets/hub-pass`
docker push ${org}/${name}:${version}
docker logout
