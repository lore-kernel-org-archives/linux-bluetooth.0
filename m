Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v2 0/5] android: IPC improvements
Date: Fri, 15 Nov 2013 01:40:12 +0000
Message-Id: <1384479617-15555-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This version uses table approach suggested by Johan.

Handlers are registered on service init and unregistered on cleanup.
Service id and opcode are used to select proper handler from tables.

Handlers are declared with expected (or minimum) payload size and this is
verified before calling proper handler.

This only implement HAL library side to demonstrate use. If this approach is
agreed on daemon patches will follow.

Comments are welcome.

-- 
BR
Szymon Janc

Szymon Janc (5):
  android: Add initial code for generic IPC msg handling
  android/hal-bluetooth: Use generic IPC message handling for events
  android/hal-hidhost: Use generic IPC message handling for events
  android/hal-pan: Use generic IPC message handling for events
  android/hal-a2dp: Use generic IPC message handling for events

 android/Android.mk      |   2 +
 android/Makefile.am     |   5 +-
 android/hal-a2dp.c      |  41 ++++-----
 android/hal-bluetooth.c | 221 ++++++++++++++++++++++++++++++------------------
 android/hal-hidhost.c   |  76 ++++++++++-------
 android/hal-ipc.c       |  45 ++--------
 android/hal-msg.c       |  94 ++++++++++++++++++++
 android/hal-msg.h       |  14 +++
 android/hal-pan.c       |  40 ++++-----
 android/hal.h           |   4 -
 android/ipc.c           |   1 +
 11 files changed, 345 insertions(+), 198 deletions(-)
 create mode 100644 android/hal-msg.c

-- 
1.8.4.3

