Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/9] Enable building HAL with autotools
Date: Thu, 17 Oct 2013 11:55:19 +0300
Message-Id: <1382000128-23762-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This patchset creates a bunch of local headers necessary to implement the
android HAL, the headers are modified so just the bare minimal to build
is implemented.

This effort is an attempt to enable the possibility to compile and test
the HAL interface in non-android environment by linking with
libbt-internal.la, for android build and environment nothing changes.

Luiz Augusto von Dentz (9):
  android: Add hardware/hardware.h
  android: Add hardware/bluetooth.h
  android: Add hardware/bt_sock.h
  android: Add cutils/log.h
  android: Add cutils/properties.h
  build: Enable building HAL as libbt-internal.la
  android: Fix building with local cutils/log.h
  android: Fix build error when compiling with autotools
  android: Fix build error with autotools

 Makefile.android             |   6 +
 android/cutils/log.h         |  34 ++++
 android/cutils/properties.h  |  65 ++++++
 android/hal_bluetooth.c      |  53 +++--
 android/hal_bt_sock.c        |   4 +-
 android/hardware/bluetooth.h | 468 +++++++++++++++++++++++++++++++++++++++++++
 android/hardware/bt_sock.h   |  58 ++++++
 android/hardware/hardware.h  | 227 +++++++++++++++++++++
 8 files changed, 887 insertions(+), 28 deletions(-)
 create mode 100644 android/cutils/log.h
 create mode 100644 android/cutils/properties.h
 create mode 100644 android/hardware/bluetooth.h
 create mode 100644 android/hardware/bt_sock.h
 create mode 100644 android/hardware/hardware.h

-- 
1.8.3.1

