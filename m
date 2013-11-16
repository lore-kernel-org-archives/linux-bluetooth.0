Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 0/5] android: IPC improvements
Date: Sat, 16 Nov 2013 15:13:23 +0100
Message-Id: <1384611208-18536-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Changes since RFCv3:
 - use correct email for commit author
 - no longer RFC - as per my testing this works fine and already
   start catching up IPC bugs which would not be introduced with those
   patches present

-- 
BR
Szymon Janc

Szymon Janc (5):
  android/hal: Add initial code for IPC message handlers
  android/hal-bluetooth: Register IPC message handlers
  android/hal-hidhost: Use generic IPC message handling for events
  android/hal-pan: Use generic IPC message handling for events
  android/hal-a2dp: Use generic IPC message handling for events

 android/hal-a2dp.c      |  40 ++++-----
 android/hal-bluetooth.c | 223 ++++++++++++++++++++++++++++++------------------
 android/hal-hidhost.c   |  75 +++++++++-------
 android/hal-ipc.c       | 115 ++++++++++++++++---------
 android/hal-ipc.h       |  10 +++
 android/hal-pan.c       |  39 ++++-----
 android/hal.h           |   4 -
 7 files changed, 312 insertions(+), 194 deletions(-)

-- 
1.8.4.2

