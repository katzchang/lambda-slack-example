from __future__ import print_function

import json
import logging
import sys

#import boto3
import slackweb

logger = logging.getLogger()
logger.setLevel(logging.INFO)


HOOK_URL = 'https://hooks.slack.com/services/xxxxx'

def lambda_handler(event, context):
    logger.info("Event: " + json.dumps(event, sort_keys=True, indent=2))
    description = 'hello'
    
    slack_message = {
        'channel': '#_katzchang',
        'username': 'github auth',
        'icon_emoji': ':github:',
        'text': description
    }

    logger.info(slack_message)

#    slack = slackweb.Slack(url=HOOK_URL)
#    slack.notify(**slack_message)

    logger.info('finished.')
    
    return json.dumps(slack_message, sort_keys=True, indent=2)

if __name__ == '__main__':
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s [%(levelname)s] %(name)s %(message)s')
    event = json.load(sys.stdin, encoding='utf-8')
    print(lambda_handler(event, {}))
