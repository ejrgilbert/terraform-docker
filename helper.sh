#!/bin/bash

if ! command -v aws 2>/dev/null; then
    echo "AWS CLI not installed locally...exiting..."
fi

if ! command -v localstack 2>/dev/null; then
    echo "localstack not installed locally...exiting..."
    echo "Run command: sudo pip install localstack"
fi

if ! command -v terraform 2>/dev/null; then
    echo "terraform not installed locally...exiting..."
fi

function run(){
    pushd src
    terraform init
    terraform apply -auto-approve -input=false
}

function start_localstack(){
    echo "here"
    # mcafee process using 8081 (localstack needs port and port + 1...the default is 8080)
    export PORT_WEB_UI=8082
    localstack start
    exit
}

function help(){
  echo "Terraform-Docker: by Diego Pacheco"
  echo "run         : run whats inside src/main.tf with terraform apply"
  echo "localstack  : run docker image with localstack a.k.a fake local aws :-)"
}

case $1 in
      "run")
          run
          ;;
      "localstack")
          start_localstack
          ;;
      *)
          help
esac
