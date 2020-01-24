#!/bin/bash
# This script will help you to get Device information, Screenshots & Video Recording.
# Written by Parmod Kumar on 25 April 2019

ADB="adb"
INFO_FILE="Device_info_"$(date| sed -e 's/\ /_/g')".txt"
# These variable are set for the colored output on the terminal
Red='\033[0;31m'          # Red
Green='\033[0;32m'
Black='\033[0;30m'


function display_attached_devices(){
 # It will show the list of attached devices
   ${ADB} devices
}

function device_info(){
  # Here will pull the required information from the device
  ${ADB} shell getprop | grep -e 'ril.serialnumber' -e 'product.brand' -e 'em.model' -e 'build.tags' -e 'build.version.release' -e 'version.sdk' -e 'ril.serialnumber'  > ~/Downloads/${INFO_FILE}

  echo -e ${Red}"*******Here are the required details*******"
  echo -e ${Black}
  cat ~/Downloads/${INFO_FILE}
  echo
  echo -e ${Green}"These details are copied to - "${INFO_FILE} " -file in your Downloads folder as well."
  echo
}
SCREENSHOT="Screenshot_"$(date|sed -e 's/\ /_/g')".jpg"


function take_screenshot(){
  echo -e ${Red}"---------------------------------------------------------"
  echo "Capturing Screenshot....Please wait for further instruction"
  ${ADB} shell screencap /sdcard/${SCREENSHOT}
  sleep 3
}
function pull_screenshot(){
   echo "---------------------------------------------------------"
   echo "Pulling screenshot from your device to your local machine"
   ${ADB} pull /sdcard/${SCREENSHOT}
   sleep 3
   echo 
   echo -e ${Green}"Screenshot -"${SCREENSHOT}"- is copied to Downloads folder"
   echo
}

VIDEO_NAME="video_"$(date|sed -e 's/\ /_/g')".mp4"

function record_video(){
  ${ADB} shell screenrecord /sdcard/${VIDEO_NAME} &
  echo "--------------------------------------------"
  echo -e ${Red}"Recoding video.... "
  echo "Please press Ctrl+c to stop the recording."
  #${ADB} shell screenrecord /sdcard/${VIDEO_NAME}
  while [ "true" ]
  do
    trap 'pull_video' SIGINT
  done
}

function pull_video(){
   PID= $!
   kill -9 $PID
   echo "----------------------------------------------------"
   echo -e ${Green}"Pulling the video to Downloads folder of your device."
   sleep 5
   ${ADB} pull /sdcard/${VIDEO_NAME}
   echo
   echo -e ${Green} "Video is fetched to the Downloads folder"
   echo
   exit
}
echo
echo "Enter your choice with numeric value. "
echo
echo "Enter 1 - to take device info"
echo "Enter 2 - to take screenshot"
echo "Enter 3 - to Record video"
echo
echo "Enter choice :"
read Choice

case ${Choice} in
  "1")
    device_info
    ;;
  "2")
    take_screenshot
    pull_screenshot
    ;;
  "3")
    display_attached_devices
    record_video
    pull_video
    ;;
esac

