Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/6] android/handsfree-client: Implement events skeleton
Date: Fri, 19 Sep 2014 16:30:45 +0200
Message-Id: <1411137051-28904-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This set adds missing events for handsfree client ipc.
It also contains some fixes based on Luiz comments

Lukasz Rymanowski (6):
  android/hal-ipc-api: Fix location size and add missing feature list
  android/handsfree-client: Fix defines for action command
  android/handsfree-client: Implement hf client events
  android/handsfree-client: Implement hf client events
  android/handsfree-client: Implement hf client events
  android/handsfree-client: Implement hf client events

 android/hal-handsfree-client.c | 295 +++++++++++++++++++++++++++++++++++++++++
 android/hal-ipc-api.txt        |  36 ++++-
 android/hal-msg.h              | 208 ++++++++++++++++++++++++++++-
 3 files changed, 531 insertions(+), 8 deletions(-)

-- 
1.8.4

