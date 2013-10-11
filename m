Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/4] Initial patches splitted
Date: Fri, 11 Oct 2013 13:01:59 +0300
Message-Id: <1381485723-15898-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <172688778.UF0VyY4IqK@uw000953>
References: <172688778.UF0VyY4IqK@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This is small chunk form my previous patch series splitted for easy review.
I need to understand what is current coding style for our project, so far it seems
very different from BlueZ I took as example first. Please comment.

Changes:
	* PATCHv2: removed unused function

Andrei Emeltchenko (4):
  android: Add Adapter Bluetooth HAL template
  android: Add Socket Bluetooth HAL template
  android: Enable Socket interface
  android: Start Android Bluetooth daemon

 android/Android.mk      |   20 +++
 android/hal.h           |   18 +++
 android/hal_bluetooth.c |  384 +++++++++++++++++++++++++++++++++++++++++++++++
 android/hal_bt_sock.c   |   85 +++++++++++
 4 files changed, 507 insertions(+)
 create mode 100644 android/hal.h
 create mode 100644 android/hal_bluetooth.c
 create mode 100644 android/hal_bt_sock.c

-- 
1.7.10.4

