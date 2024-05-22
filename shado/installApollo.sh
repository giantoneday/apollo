set -x
if [ $# -lt 1 ]; then
    echo "$0 machine(prd2, prd3)"
fi
cd ../
ls *
environment=$1
# 先在各个机器上执行mkdir -p apollo-portal apollo-adminservice  apollo-configservice
cmd="mkdir -p ~/apollo/log; cd ~/apollo; mkdir -p apollo-portal apollo-adminservice  apollo-configservice"
#for machine in  work@nene-test-001 work@nene-test-002
#work1@work #work@nene-dev-001
if [ "$1" == "prd2" ];then
    machineList="ec2-user@52.4.218.156"
elif [ "$1" == "prd3" ];then
     machineList="ec2-user@52.6.174.84"
else
  echo "machine invalid: $1"
  exit 1
fi

#set -o globstar
for machine in $machineList
do
    ssh  $machine "$cmd"
    for module in apollo-portal  apollo-adminservice  apollo-configservice
    do
	    #scp  $module/target/*github.zip work@nene-test-001:~/bin/apollo/$module/
      #scp  $module/target/*github.zip $machine:~/apollo/$module/
      ls $module/target/*
      scp  $module/target/apollo*zip $machine:~/apollo/$module/
      ssh $machine "cd ~/apollo/$module/; unzip *.zip"
    done
    scp shado/*.sh $machine:~/apollo/
done
set +x