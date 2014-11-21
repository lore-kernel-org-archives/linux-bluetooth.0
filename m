Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 0/4] Add a2dp sink role
Date: Fri, 21 Nov 2014 16:13:51 +0100
Message-Id: <1416582835-7712-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With Android 5 A2DP Sink role was introduced. Sink in Android uses the same
HAL API as Source role does, but uses one more callback extending existing A2DP
HAL.

Some IPC defines and structs are common for both roles but of course they
have independent HALs and individual service IDs to work simultaneously.

Jakub Tyszkowski (4):
  android/hal-ipc-api: Extend a2dp hal API with A2DP Sink role
  android/hal: Add HAL for A2DP Sink role
  android/a2dp-sink: Add skeleton for a2dp sink daemon
  android/hal: Add missing a2dp handler introduced in Android 5

 android/Android.mk      |   2 +
 android/Makefile.am     |   2 +
 android/a2dp-sink.c     |  84 +++++++++++++++++++++++++
 android/a2dp-sink.h     |  25 ++++++++
 android/hal-a2dp-sink.c | 163 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-a2dp.c      |  13 ++++
 android/hal-bluetooth.c |   3 +
 android/hal-ipc-api.txt |  12 +++-
 android/hal-msg.h       |  12 +++-
 android/hal.h           |   1 +
 10 files changed, 314 insertions(+), 3 deletions(-)
 create mode 100644 android/a2dp-sink.c
 create mode 100644 android/a2dp-sink.h
 create mode 100644 android/hal-a2dp-sink.c

--
1.9.1

