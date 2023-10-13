#!/bin/bash

python3.7 -m venv test
source test/bin/activate
git clone https://github.com/andmulLABS01/Deployment_5AM.git
cd Deployment_5AM
pip install -r requirements.txt
sleep 6
echo "Requirements Installed"
pip install gunicorn
sleep 6
echo "Gunicorn installed"
python database.py
sleep 1
python load_data.py
sleep 1 
python -m gunicorn app:app -b 0.0.0.0 -D
echo "Done"

