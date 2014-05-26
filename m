Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 0/5] android: GATT client test interface
Date: Mon, 26 May 2014 23:53:23 +0200
Message-Id: <1401141208-26912-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This adds initial implementation of GATT client test command. It seems
to be usefull when testing against PTS for executing actions that are
no possible from standard API.

This is initial implementation with enable/connect/disconnect commands.

Commands are not defined in HAL but in here:
http://androidxref.com/4.4.2_r1/xref/packages/apps/Bluetooth/src/com/android/bluetooth/gatt/GattDebugUtils.java#77

BR
Szymon Janc

Szymon Janc (5):
  android/gatt: Add initial implementation of client test command
  android/gatt: Factor out unregistering client into helper function
  android/gatt: Implement enable test command
  android/gatt: Implement connect test command
  android/gatt: Implement disconnect test command

 android/gatt.c    | 89 +++++++++++++++++++++++++++++++++++++++++++++----------
 android/hal-msg.h |  6 ++++
 2 files changed, 79 insertions(+), 16 deletions(-)

-- 
2.0.0.rc4

