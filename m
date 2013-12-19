Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 0/5] android: Permanent storage support
Date: Thu, 19 Dec 2013 13:38:28 +0100
Message-Id: <1387456713-12794-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

V2:
 - removed file creation with open, it is up to init to set proper
   umask while staring bluetoothd
 - make system-emulator set proper umask

Szymon Janc (5):
  android/bluetooth: Add initial support for permanent storage
  android/bluetooth: Add initial support for storing device info
  android/bluetooth: Add support for storing link keys
  android/bluetooth: Add support for restoring devices from storage
  android: Set umask in system-emulator

 android/Android.mk        |   3 +-
 android/bluetooth.c       | 310 ++++++++++++++++++++++++++++++++++++++++++++--
 android/system-emulator.c |   4 +
 configure.ac              |   3 +
 4 files changed, 308 insertions(+), 12 deletions(-)

-- 
1.8.3.2

