.PHONY: all setup run deploy update clean

module=lambda_slack_example
function=lambda_handler
lambda-function-name=$(module)-$(function)
role=arn:aws:iam::xxxxxxxxxxxx:role/xxxx 

all: lambda.zip

run: lib/python2.7/site-packages
	cat ./sample/team_add.sample.json | ./bin/python ./$(module).py 

lambda.zip: *.py lib/python2.7/site-packages
	rm -f $@
	zip -r $@ ./*.py
	cd ./lib/python2.7/site-packages && zip -r ../../../$@ ./*

lib/python2.7/site-packages:
	virtualenv .
	./bin/pip install -r ./requirements.txt

setup: lib/python2.7/site-packages

# FIXME: Deploy target does not work now.
deploy: lambda.zip
	aws lambda create-function \
	 --region ap-northeast-1 \
	 --function-name $(lambda-function-name) \
	 --zip-file fileb://$@ \
	 --role $(role) \
	 --handler $(module).$(function) \
	 --runtime python2.7 \
	 --timeout 3 \
	 --memory-size 128

update: lambda.zip
	aws lambda update-function-code \
	 --region ap-northeast-1 \
	 --function-name $(lambda-function-name) \
	 --zip-file fileb://$@

clean:
	rm -rf bin include lib local
	rm -f lambda.zip
