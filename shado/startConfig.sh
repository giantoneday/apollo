#!/bin/bash
if [ $# -lt 2 ];then
  echo "执行方式: $0 参数1:环境名(dev/test/prod) 参数2:机器名(必填:dev1, test1, test2, prod1, prod2)  参数3:想要注册上去的ipAddress(选填,用于一些外网可访问的情况)"
  exit 1
fi

#增加主动设置ip地址
environment=$1
machine=$2

ipAddress="";
if [ $# -ge 3 ];then
  ipAddress=$2
elif [ "$machine" == "prd2" ];then
  ipAddress="52.4.218.156"
elif [ "$machine" == "prd3" ];then
  ipAddress="52.6.174.84"
fi

sudo ./apollo-configservice/scripts/shutdown.sh
sleep 3s
sudo ./apollo-configservice/scripts/startup.sh $environment $ipAddress
