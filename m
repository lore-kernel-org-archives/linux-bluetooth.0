Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 0/5] Remote device cache support
Date: Tue, 21 Jan 2014 16:01:32 +0100
Message-Id: <1390316497-18451-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes since RFC:
 - set cache limit to 300
 - update timestamp of cached device
 - rebased to master
 - other minor fixes

Szymon Janc (5):
  android/bluetooth: Split devices list to devices and bonded_devices
  android/bluetooth: Use defines for settings and devices files paths
  android/bluetooth: Always store device info
  android/bluetooth: Add support for caching remote device info
  android/bluetooth: Add support for loading caches devices from storage

 android/bluetooth.c | 202 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 149 insertions(+), 53 deletions(-)

-- 
1.8.3.2

