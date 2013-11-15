Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v3 0/5] android: IPC improvements
Date: Fri, 15 Nov 2013 20:49:33 +0000
Message-Id: <1384548578-18710-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Third version of RFC, changes since v2:
 - as suggested by Johan and Luiz handlers are called from IPC code,
   not from message code, this allows for informative logs while reporting
   errors
 - fixed few bugs

Comments and testing are welcome!

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
1.8.4.3

