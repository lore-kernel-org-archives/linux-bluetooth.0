Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 0/2] Initial HID connect disconnect methods
Date: Mon, 28 Oct 2013 16:47:30 +0200
Message-Id: <1382971653-11727-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Patchset adds hid connect and disconnect mechanisms at
L2CAP level. It opens the control channel and interrupt
channel and listens on io events. UHID, hid server and
reconnect related features not yet done.

Ravi kumar Veeramally (2):
  android: Add initial HID connect implementation
  android: Add initial HID disconnect implementation.

 Makefile.android   |    3 +-
 android/Android.mk |    1 +
 android/hid.c      |  260 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 263 insertions(+), 1 deletion(-)

-- 
1.7.9.5

