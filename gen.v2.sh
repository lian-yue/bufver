#!/bin/bash

CURRENT_DIR=$(dirname "$0")
if [ $CURRENT_DIR == "." ] || [ $CURRENT_DIR == ".." ] || [ $CURRENT_DIR == "" ];then
    CURRENT_DIR=$(pwd)
fi

# 检查 schemas dir 防止目录错误
if [ $CURRENT_DIR == "" ] || [ $CURRENT_DIR == "/" ] || [ $CURRENT_DIR == "." ];then
    echo "current directory was not found"
    exit
fi

echo "current dir: $CURRENT_DIR"


echo "buf dep update: ./"
buf dep update

cd "$CURRENT_DIR/pkg/type"
echo "buf dep update: ./pkg/type"
buf dep update
echo "buf generate: ./pkg/type"
buf generate --template=buf.gen.yaml

cd "$CURRENT_DIR/pkg/error"
echo "buf dep update: ./pkg/error"
buf dep update
echo "buf generate: ./pkg/error"
buf generate --template=buf.gen.yaml


cd "$CURRENT_DIR/mod/user"
echo "buf dep update: ./mod/user"
buf dep update
echo "buf generate: ./mod/user"
buf generate --template=buf.gen.yaml


echo "Code has generated"

