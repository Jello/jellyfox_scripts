#!/bin/bash
#REBOOTS PC IF NVIDIA CARD FAILS
#NEEDS REBOOT SET TO BE RUNNABLE BY THIS USER
export DISPLAY=:0
while :
do
        nvidia-smi
        if [ "$?" -ne 0 ]
        then
                reboot
        fi
        sleep 10m
done

