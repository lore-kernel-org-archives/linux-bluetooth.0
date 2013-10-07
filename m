Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/2] Basic code for HAL API
Date: Mon,  7 Oct 2013 16:37:14 +0300
Message-Id: <1381153036-12631-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Please comment what is the way to split code between common shared part
and HAL and daemon related.

Currently hal_msg.c is used by "server" - BlueZ daemon and hal_msg_client.c is used
by "client" - Android HAL.

Andrei Emeltchenko (2):
  android: Implement basic HAL server
  android: Add HAL message helpers

 Makefile.android         |    3 +-
 android/Android.mk       |    2 +
 android/hal_msg.c        |  267 ++++++++++++++++++++++++++++++++++++++++++++++
 android/hal_msg.h        |    5 +
 android/hal_msg_client.c |  123 +++++++++++++++++++++
 android/hal_msg_client.h |   25 +++++
 android/main.c           |   10 ++
 7 files changed, 434 insertions(+), 1 deletion(-)
 create mode 100644 android/hal_msg.c
 create mode 100644 android/hal_msg_client.c
 create mode 100644 android/hal_msg_client.h

-- 
1.7.10.4

