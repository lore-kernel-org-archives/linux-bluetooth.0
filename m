Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 00/13] android: IPC improvements - daemon part
Date: Wed, 27 Nov 2013 12:54:52 +0100
Message-Id: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This serie implements IPC message handling iprovments in daemon similar
to what is already done in HAL part.

-- 
BR
Szymon Janc

Szymon Janc (13):
  android: Add initial code for IPC message handlers
  android/main: Use generic IPC message handling for core service
  android/main: Use IPC helper for all replies in core service
  android: Pass command socket to services while registering
  android/bluetooth: Use generic IPC msg handling for commands
  android/bluetooth: Add stubs for missing commands handlers
  android/hidhost: Use generic IPC message handling for commands
  android/hidhost: Use stack buffer in bt_hid_get_report
  android/pan: Use generic IPC message handling for commands
  android/a2dp: Use generic IPC message handling for commands
  android/socket: Use generic IPC message handling for commands
  android/hal-bluetooth: Rename create_enum_prop to enum_prop_to_hal
  android/hal-bluetooth: Fix sending invalid adapter property

 android/a2dp.c          |  80 ++++----
 android/a2dp.h          |   4 +-
 android/bluetooth.c     | 523 +++++++++++++++++++++++++++++++++++-------------
 android/bluetooth.h     |   2 +-
 android/hal-bluetooth.c |  44 +++-
 android/hidhost.c       | 330 ++++++++++++++++++------------
 android/hidhost.h       |   4 +-
 android/ipc.c           |  79 ++++++++
 android/ipc.h           |  12 ++
 android/main.c          | 128 ++++--------
 android/pan.c           |  81 ++++----
 android/pan.h           |   4 +-
 android/socket.c        | 115 ++++++-----
 android/socket.h        |   2 +-
 14 files changed, 898 insertions(+), 510 deletions(-)

-- 
1.8.3.2

