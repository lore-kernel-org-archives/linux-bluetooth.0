Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH v3 0/5] Remote device cache support
Date: Thu, 23 Jan 2014 23:18:05 +0100
Message-Id: <1390515490-29538-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

V3:
 - bugfixes in cache handling

V2:
 - keep cache in separate file
 - patch 3/5 and 4/5 from V1 squashed to 3/4

V1:
 - set cache limit to 300
 - update timestamp of cached device
 - rebased to master
 - other minor fixes

Szymon Janc (5):
  android/bluetooth: Split devices list to devices and bonded_devices
  android/bluetooth: Use defines for settings and devices files paths
  android/bluetooth: Add support for caching remote device info
  android/bluetooth: Add support for loading caches devices from storage
  android/bluetooth: Rename devices list to cached_devices

 android/bluetooth.c | 246 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 183 insertions(+), 63 deletions(-)

-- 
1.8.5.3

