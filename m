Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/2] Initial code for PAN and HID HALs
Date: Mon,  7 Oct 2013 16:39:16 +0300
Message-Id: <1381153158-13207-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Slightly modified code from Frederic Danis.

Frederic Danis (2):
  android: Add HID Host skeleton
  android: Add PAN skeleton

 android/Android.mk      |    2 +
 android/hal.h           |    2 +
 android/hal_bluetooth.c |    8 ++
 android/hal_hidhost.c   |  232 +++++++++++++++++++++++++++++++++++++++++++++++
 android/hal_pan.c       |  130 ++++++++++++++++++++++++++
 5 files changed, 374 insertions(+)
 create mode 100644 android/hal_hidhost.c
 create mode 100644 android/hal_pan.c

-- 
1.7.10.4

