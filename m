Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 0/6] android: IPC improvements
Date: Mon, 18 Nov 2013 15:34:59 +0100
Message-Id: <1384785305-17084-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Changes since v1:
 - remove fd parameter from handler proptotype - this is only needed by one
   callback in health HAL and getter function can be addded later on if needed
 - improve comments - each handler has comment with opcode define for easier
   code reading
 - some bugfixes

-- 
BR
Szymon Janc

Szymon Janc (6):
  android/hal: Add initial code for IPC message handlers
  android/hal-bluetooth: Register IPC message handlers
  android/hal-hidhost: Use generic IPC message handling for events
  android/hal-pan: Use generic IPC message handling for events
  android/hal-a2dp: Use generic IPC message handling for events
  android/hal: Check if command socket was shutdown by peer

 android/hal-a2dp.c      |  41 ++++-----
 android/hal-bluetooth.c | 218 +++++++++++++++++++++++++++++++-----------------
 android/hal-hidhost.c   |  76 ++++++++++-------
 android/hal-ipc.c       | 123 ++++++++++++++++++---------
 android/hal-ipc.h       |  10 +++
 android/hal-pan.c       |  40 ++++-----
 android/hal.h           |   4 -
 7 files changed, 321 insertions(+), 191 deletions(-)

-- 
1.8.4.2

