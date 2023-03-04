#!/usr/bin/env sh

#check local port 8545 is running or not

rpc="http://localhost:8545"

if [ -z "$(lsof -i:8545)" ]; then
    echo "local endpoint (:8545) is not running"
    if [ -z "$ETH_RPC_URL" ]; then
        echo "env ETH_RPC_URL is not set, use https://rpc.ankr.com/eth"
        rpc="https://rpc.ankr.com/eth"
    else
        echo "env ETH_RPC_URL is set, use ${ETH_RPC_URL}"
        rpc=${ETH_RPC_URL}
    fi
fi

script="
var WEB3 = require('web3');
var web3 = new WEB3('${rpc}'); 
console.log(web3.currentProvider.host);
"


echo "press \033[31m <return> \033[0m key to start, use \033[31m web3.xxx \033[0m to call api of web3.js"   

node -r web3 -e "${script}" -i  --no-warnings

