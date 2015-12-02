Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Chih-Wei Huang <cwhuang@android-x86.org>
To: linux-bluetooth@vger.kernel.org
Cc: Chih-Wei Huang <cwhuang@linux.org.tw>
Subject: [PATCH 0/3] Android 6.0 porting patches
Date: Wed,  2 Dec 2015 21:19:02 +0800
Message-Id: <1449062345-31502-1-git-send-email-cwhuang@linux.org.tw>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

These patches try to fix the building errors on Android 6.0.
I'm not familiar with Bluez stack so I don't know if I did it
correctly. But At least it's buildable with the Android-x86
marshmallow-x86 branch. I'm able to pair with a BT speaking
and play music to it. However, file transfer failed.

Please help to review the patches.

Refer:
https://sourceforge.net/p/android-x86/external_bluetooth_bluez/ci/marshmallow-x86/

Chih-Wei Huang (3):
  shared/utils: add the missing header <strings.h>
  android: fix building errors of the 64-bit targets
  android: fix building errors on Android 6.0

 android/client/if-gatt.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-bluetooth.c  |  4 ++++
 android/hal-gatt.c       | 34 +++++++++++++++++++++++++++++++++-
 android/hal-ipc.c        |  2 ++
 android/hal-utils.c      |  4 ++++
 android/log.c            |  1 +
 src/shared/util.c        |  1 +
 7 files changed, 91 insertions(+), 1 deletion(-)

-- 
1.9.1

