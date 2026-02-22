#!/bin/bash

TOMCAT_PATH="/c/Users/User/Downloads/apache-tomcat-9.0.107/apache-tomcat-9.0.107"
WAR_NAME="userapp.war"

echo "Stopping Tomcat..."
"$TOMCAT_PATH/bin/shutdown.sh"

sleep 5

echo "Cleaning old build..."
rm -rf target

echo "Building project..."
mvn clean package

if [ $? -ne 0 ]; then
  echo "Build Failed ❌"
  exit 1
fi

echo "Removing old WAR..."
rm -rf "$TOMCAT_PATH/webapps/userapp"
rm -f "$TOMCAT_PATH/webapps/$WAR_NAME"

echo "Copying WAR..."
cp target/$WAR_NAME "$TOMCAT_PATH/webapps/"

echo "Starting Tomcat..."
"$TOMCAT_PATH/bin/startup.sh"

echo "Deployment Successful ✅"
