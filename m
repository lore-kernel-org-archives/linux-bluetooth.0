Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 00/13] Initial code for handsfree support
Date: Sun,  2 Feb 2014 22:09:11 +0100
Message-Id: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This adds initial support for HFP. HAL library is complete, for daemon
only support for RFCOMM connection handling.

There is also minimal set of AT handling needed for SLC establishment
(proper AT parsing code is still missing).

Comments are welcome.

BR
Szymon Janc

Szymon Janc (13):
  android/handsfree: Add initial files
  android/handsfree: Add commands and events definition to IPC header
  android/handsfree: Add stubs for commands handlers
  android/hal-handsfree: Implement notifications handling
  android/hal-handsfree: Implement sending commands
  android/handsfree: Add SDP record for AG
  android/handsfree: Add support for RFCOMM connection handling
  android/handsfree: Add initial code for AT commands processing
  android/handsfree: Add connect command handling
  android/handsfree: Add disconnect command handling
  android/handsfree: Add AT+BRSF command support
  android/handsfree: Add support for AT+CIND command
  android/handsfree: Add support for AT+CMER command

 android/Android.mk      |   2 +
 android/Makefile.am     |   4 +
 android/hal-bluetooth.c |   3 +
 android/hal-handsfree.c | 598 +++++++++++++++++++++++++++++++++++++
 android/hal-msg.h       | 208 +++++++++++++
 android/hal.h           |   2 +
 android/handsfree.c     | 763 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/handsfree.h     |  25 ++
 android/main.c          |  14 +
 9 files changed, 1619 insertions(+)
 create mode 100644 android/hal-handsfree.c
 create mode 100644 android/handsfree.c
 create mode 100644 android/handsfree.h

-- 
1.8.5.3

