Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/2] Adapter and Socket templates
Date: Tue, 24 Sep 2013 11:31:54 +0300
Message-Id: <1380011516-7847-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

First versions of adapter and socket templates.

Andrei Emeltchenko (2):
  android: Add Adapter Bluetooth HAL template
  android: Add Socket Bluetooth HAL template

 android/Android.mk      |   20 +++
 android/hal_bluetooth.c |  367 +++++++++++++++++++++++++++++++++++++++++++++++
 android/hal_bt_sock.c   |   86 +++++++++++
 3 files changed, 473 insertions(+)
 create mode 100644 android/hal_bluetooth.c
 create mode 100644 android/hal_bt_sock.c

-- 
1.7.10.4

