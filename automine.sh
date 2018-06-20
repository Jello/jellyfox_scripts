#!/bin/bash
#Create a service to run this on boot
export DISPLAY=:0
sleep 120

name=`uname -n`
#################### UPDATE THIS FIELD
mphusername='' #FILL THIS WITH YOUR MININGPOOLHUB USERNAME
##################### UPDATE IT
        cd ~/xmr-stak/build/bin/
#####UNCOMMENT TO CPU MINE
##### NEED TO RUN xmr-stak --noNVIDIA once from the the bin directory to setup
##### Pool address for nicehash is cryptonightv7.usa.nicehash.com:3363
##### Wallet address is <bitcoinaddress>.rigname
##### Pool password is x, use_nicehash is true
##### Pool address for mph is us-east.cryptonight-hub.miningpoolhub.com:17024
##### Wallet address is mphusername.rigname
##### Pool password is x, use_nicehash is false, use_tls is true
#        nohup ~/xmr-stak/build/bin/xmr-stak --noNVIDIA >& /dev/null & #####UNCOMMENT THIS TO CPU MINE
        ~/watchdog.sh >& /dev/null &  ######MUST SET /sbin/reboot to usable by current user (chmod 777 it will work, or set permissions for current user / group with sudo chmod u+s /sbin/reboot 
while :
do
        echo "Top of loop"
        nvidia-smi
        if [ "$?" -ne 0 ]
        then
                reboot
        fi
#       ~/nuxhash/nuxhashd.py --verbose ##############UNCOMMENT THIS ONE TO MINE WITH NUXHASH ON NICEHASH
################### MINE JUST ETHEREUM IF THIS IS ENABLED
        ethminer -U -P stratum2+tcp://"$mphusername".`uname -n`:x@us-east.ethash-hub.miningpoolhub.com:17020 #MINE ETHEREUM ON MININGPOOLHUB AND DON'T SWITCH TO OTHER ALGORITHMS 
##################
################# BELOW HERE IS AUTOSWITCHING ON MININGPOOLHUB, MUST SETUP DEFAULT ACCOUNT JOB FOR AUTOSWITCHING ON MININGPOOLHUB ACCOUNT TO USE THESE ALGORITHMS OR LESS,
#I RECOMMEND NVIDIA - Cryptonight-Monero, Ethash, Equihash, Lyra2RE2, Myriad-Groestl, Skein
        ~/bminer/bminer -uri stratum+ssl://"$mphusername".`uname -n`@us-east.equihash-hub.miningpoolhub.com:12023 -max-network-failures=0 -watchdog=false
	~/bminer/bminer -uri ethstratum://"$mphusername".`uname -n`:x@us-east.ethash-hub.miningpoolhub.com:12020 -max-network-failures=0 
-watchdog=false
#       ccminer -q -r 0 -a equihash -o 
stratum+tcp://us-east.equihash-hub.miningpoolhub.com:12023 -u "$mphusername".`uname -n` -p x
        ccminer -q -r 0 -a groestl -o stratum+tcp://hub.miningpoolhub.com:12004 -u "$mphusername".`uname -n` -p x
        ccminer -q -r 0 -a skein -o stratum+tcp://hub.miningpoolhub.com:12016 -u "$mphusername".`uname -n` -p x
        ccminer -q -r 0 -a lyra2z -o stratum+tcp://us-east.lyra2z-hub.miningpoolhub.com:12025 -u "$mphusername".`uname -n` -p x
        ccminer -q -r 0 -a neoscrypt -o stratum+tcp://hub.miningpoolhub.com:12012 -u "$mphusername".`uname -n` -p x
        ccminer -q -r 0 -a cryptonight -o stratum+tcp://us-east.cryptonight-hub.miningpoolhub.com:12024 -u "$mphusername".`uname -n` -p x
        ccminer -q -r 0 -a myr-gr -o stratum+tcp://hub.miningpoolhub.com:12005 -u "$mphusername".`uname -n` -p x
        ccminer -q -r 0 -a lyra2v2 -o stratum+tcp://hub.miningpoolhub.com:12018 -u "$mphusername".`uname -n` -p x
sleep 1
done
fi

