#!/bin/bash

set -e

workdir=$(mktemp -d)

cd "${workdir}"

export BUILD_ID=${1:-3}
export TARGET_ACCOUNT_ID=$(aws sts get-caller-identity --query 'Account' --output text)

git clone https://github.com/alpha-prosoft/alpha-docker-images.git
cd alpha-docker-images
./build.sh


git clone https://github.com/alpha-prosoft/alpha-base-infra.git
cd alpha-base-infra

./build.sh
./run.sh


git clone https://github.com/alpha-prosoft/alpha-build-svc.git
cd alpha-build-svc

./build.sh
./run.sh

git clone https://github.com/alpha-prosoft/alpha-scm-svc.git
cd alpha-scm-svc

./build.sh
./run.sh


