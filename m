Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/4] android/bluetooth: Enable privacy mode on starup
Date: Wed, 10 Dec 2014 15:16:10 +0100
Message-Id: <1418220974-12287-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This set add support for privacy mode in BfA.
This is in order to follow Android Lollipop

Lukasz Rymanowski (4):
  android/bluetooth: Start keep IRK for adapter
  android/bluetooth: Store IRK when storing adapter config
  android/bluetooth: Load IRK on adapter start
  android/bluetooth: Enable LE privacy mode on BfA startup

 android/bluetooth.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

-- 
1.8.4

