Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 0/6] Logging from Android HAL library
Date: Sun, 20 Oct 2013 19:45:40 +0200
Message-Id: <1382291146-23518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is an attempt to make library logging API similar to other parts of code.
It maps log levels used in BlueZ to Android levels and provides log printing
when HAL library is used by haltest on Linux. Since cutils/log.h is not used
directly there is no need to stub it on Linux.

Another advantage is that LOG_TAG and message format is configured in single
file (eg. modules tags could be easily added to improve readibility of
non-debug messages)

Comments are welcome.

Szymon Janc (6):
  android: Add wrapper for HAL logging
  android: Use hal-log.h for logging in bluetooth HAL
  android: Use hal-log.h for logging in hidhost HAL
  android: Use hal-log.h for logging in pan HAL
  android: Use hal-log.h for logging in socket HAL
  android: Remove not needed cutils/log.h stub

 Makefile.android        |  9 ++++---
 android/cutils/log.h    | 29 ---------------------
 android/hal-bluetooth.c | 68 ++++++++++++++++++++++++-------------------------
 android/hal-hidhost.c   | 26 +++++++++----------
 android/hal-log.h       | 35 +++++++++++++++++++++++++
 android/hal-pan.c       | 16 +++++-------
 android/hal-sock.c      | 19 ++++++--------
 7 files changed, 100 insertions(+), 102 deletions(-)
 delete mode 100644 android/cutils/log.h
 create mode 100644 android/hal-log.h

-- 
1.8.4

