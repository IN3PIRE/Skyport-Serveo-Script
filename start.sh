#!/bin/bash

INSTALL_DIR="/etc/skyport"

SERVEO_PORT=3000

echo "Installing dependencies..."
sudo apt update
sudo apt install -y nodejs git

echo "Installing Skyport..."
cd $INSTALL_DIR
git clone --branch v0.2.2 https://github.com/skyportlabs/panel  
echo "Setting up Skyport..."
cd skyport
npm install
npm run seed
npm run createUser

echo "Starting Skyport..."
node . &

echo "Creating Serveo Tunnel..."
ssh -R 80:localhost:$SERVEO_PORT serveo.net &


echo "Your Skyport server is now accessible at: https://$(serveo.net -l | awk '{print $2}')"

echo "SkyPort installation complete! 🔥🚀"s
