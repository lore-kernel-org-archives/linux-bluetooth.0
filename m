Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 0/8] Buiding Andtroid HAL lib and haltester on Linux
Date: Thu, 17 Oct 2013 10:47:01 +0200
Message-ID: <1381999629-9589-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is first attempt to make all code buildable on Linux.
This includes:
 - import of needed Android HAL headers (with minor changes)
 - stubbing some Android specific code
 - some build fixes

Comments are welcome.

-- 
BR
Szymon Janc

Szymon Janc (8):
  android: Import Android HAL headers
  build: Add haltest command line tester
  android: Fix haltest build on Linux
  android: Fix build of HAL library on Linux
  android: Fix missing include in HAL library
  android: Fix missing include in HAL library
  gitignore: Add android/haltest
  build: Add missing android files to EXTRA_DIST

 .gitignore                        |   1 +
 Makefile.android                  |  56 ++++-
 android/android_compat.h          |  33 +++
 android/client/hwmodule.c         |  27 +++
 android/hal_bluetooth.c           |   5 +
 android/hal_bt_sock.c             |   6 +
 android/hardware/bluetooth.h      | 468 ++++++++++++++++++++++++++++++++++++++
 android/hardware/bt_av.h          |  90 ++++++++
 android/hardware/bt_gatt.h        |  61 +++++
 android/hardware/bt_gatt_client.h | 275 ++++++++++++++++++++++
 android/hardware/bt_gatt_server.h | 175 ++++++++++++++
 android/hardware/bt_gatt_types.h  |  48 ++++
 android/hardware/bt_hf.h          | 284 +++++++++++++++++++++++
 android/hardware/bt_hh.h          | 179 +++++++++++++++
 android/hardware/bt_hl.h          | 123 ++++++++++
 android/hardware/bt_pan.h         |  87 +++++++
 android/hardware/bt_rc.h          | 234 +++++++++++++++++++
 android/hardware/bt_sock.h        |  58 +++++
 android/hardware/hardware.h       | 232 +++++++++++++++++++
 19 files changed, 2441 insertions(+), 1 deletion(-)
 create mode 100644 android/android_compat.h
 create mode 100644 android/client/hwmodule.c
 create mode 100644 android/hardware/bluetooth.h
 create mode 100644 android/hardware/bt_av.h
 create mode 100644 android/hardware/bt_gatt.h
 create mode 100644 android/hardware/bt_gatt_client.h
 create mode 100644 android/hardware/bt_gatt_server.h
 create mode 100644 android/hardware/bt_gatt_types.h
 create mode 100644 android/hardware/bt_hf.h
 create mode 100644 android/hardware/bt_hh.h
 create mode 100644 android/hardware/bt_hl.h
 create mode 100644 android/hardware/bt_pan.h
 create mode 100644 android/hardware/bt_rc.h
 create mode 100644 android/hardware/bt_sock.h
 create mode 100644 android/hardware/hardware.h

-- 
1.8.4

