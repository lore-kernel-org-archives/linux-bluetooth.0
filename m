Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 0/5] android: Update HAL to Android 4.4 API
Date: Fri, 20 Dec 2013 11:25:35 +0100
Message-Id: <1387535140-6223-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

It is important to fully implement bt_interface_t (at least with stubs/NULLs)
since Android is not checking size field from HAL and just assume memory
layout of BT HAL. This was causing crashes on 4.4 due to Android trying
to call not existing methods.

BT snoop logs enabling function is a bit special since it will be implemented
only in HAL so no need to extend IPC with that (plan is to have dedicated
service that will dump HCI traffic).

For now 4.2+ API is if-deffed in HAL library - this will be removed when
minimal Android version required will be dropped.

-- 
BR
Szymon Janc

Szymon Janc (5):
  android/hal-bluetooth: Add support for sending LE_TEST_MODE command
  android/hal-bluetooth: Add support for enabling HCI snoop dump
  android/hal-bluetooth: Add support for remote version info property
  android/hal-bluetooth: Add support for device service record property
  android/bluetooth: Add stubs for missing commands

 android/bluetooth.c         |  56 ++++++++++++++++++++++++
 android/cutils/properties.h |   1 +
 android/hal-bluetooth.c     | 104 +++++++++++++++++++++++++++++++++++++++++++-
 android/hal-msg.h           |  13 ++++++
 4 files changed, 172 insertions(+), 2 deletions(-)

-- 
1.8.3.2

