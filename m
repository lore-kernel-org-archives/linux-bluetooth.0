Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 0/9] android: IPC improvements - daemon part
Date: Fri, 29 Nov 2013 12:08:42 +0100
Message-Id: <1385723331-15603-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2:
 - rebased against latest IPC helpers improvements
 - more compact command handlers table format
 - error handling path in command handlers improved according to Johan comments
 - randmon small fixes
 - patches not directly related to refactor removed from serie, will
   be send after this is merged

v1:
This serie implements IPC message handling iprovments in daemon similar
to what is already done in HAL part.

-- 
BR
Szymon Janc

Szymon Janc (9):
  android: Add initial code for IPC message handlers
  android/main: Use generic IPC message handling for core service
  android/main: Use common exit path in core service functions
  android/bluetooth: Use generic IPC msg handling for commands
  android/bluetooth: Make property handling function return HAL status
  android/hidhost: Use generic IPC message handling for commands
  android/pan: Use generic IPC message handling for commands
  android/a2dp: Use generic IPC message handling for commands
  android/socket: Use generic IPC message handling for commands

 android/a2dp.c      |  69 ++++----
 android/a2dp.h      |   2 -
 android/bluetooth.c | 477 ++++++++++++++++++++++++++++++++++------------------
 android/hidhost.c   | 309 ++++++++++++++++++++--------------
 android/hidhost.h   |   2 -
 android/ipc.c       |  78 +++++++++
 android/ipc.h       |  10 ++
 android/main.c      | 123 +++++---------
 android/pan.c       |  57 +++----
 android/pan.h       |   2 -
 android/socket.c    | 102 ++++++-----
 11 files changed, 736 insertions(+), 495 deletions(-)

-- 
1.8.3.2

