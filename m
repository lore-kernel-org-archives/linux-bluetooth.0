Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 0/4] android: Permanent storage support
Date: Wed, 18 Dec 2013 15:05:54 +0100
Message-Id: <1387375558-17976-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

V2:
 - no longer RFC
 - linkkeys and uuids stored as hexstrings without leading 0x
 - Android storage path changed to /data/misc/bluetooth

Szymon Janc (4):
  android/bluetooth: Add initial support for permanent storage
  android/bluetooth: Add initial support for storing device info
  android/bluetooth: Add support for storing link keys
  android/bluetooth: Add support for restoring devices from storage

 android/Android.mk  |   3 +-
 android/bluetooth.c | 313 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 configure.ac        |   3 +
 3 files changed, 307 insertions(+), 12 deletions(-)

-- 
1.8.3.2

