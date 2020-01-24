#!/bin/bash

# With this script use can take the screenshot of Android device

ADB="adb"
SCREENSHOT="screenshot"${date}".jpg"

function display_connected_devices(){
  echo
  echo "Connected devices are here."
  ${ADB} devices
  sleep 3
}

function take_screenshot(){
  echo
  echo "Taking Screenshot....Please wait."
  ${ADB} shell screencap /sdcard/${SCREENSHOT}
  sleep 3
}
function pull_screenshot(){
   echo
   echo "Pulling screenshot to your device"
   ${ADB} pull /sdcard/${SCREENSHOT}
   sleep 3
   echo "Screenshot is ready to see in your device."

}
display_connected_devices
take_screenshot
pull_screenshot
