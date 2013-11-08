Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 0/3] Reuse debug helpers for HAL client and HAL
Date: Fri,  8 Nov 2013 11:35:46 +0200
Message-Id: <1383903349-17487-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The patch uses hal-utils.[ch] to keep debug functions for decoding
HAL messages. They will be used in haltest and HALs.

Changes:
	* v4: changed bt_uuid_t -> uint8_t * since they are both used.

Andrei Emeltchenko (3):
  android: Create debug hal-utils helpers
  android/debug: Convert uuid helper to use uint8_t buffer
  android/hal: Add UUID debug print in socket HAL

 android/Android.mk        |    2 ++
 android/Makefile.am       |    3 ++-
 android/client/if-gatt.c  |    1 +
 android/client/textconv.c |   50 +++++++--------------------------------
 android/client/textconv.h |    2 --
 android/hal-sock.c        |   19 +++++++++------
 android/hal-utils.c       |   57 +++++++++++++++++++++++++++++++++++++++++++++
 android/hal-utils.h       |   26 +++++++++++++++++++++
 8 files changed, 108 insertions(+), 52 deletions(-)
 create mode 100644 android/hal-utils.c
 create mode 100644 android/hal-utils.h

-- 
1.7.10.4

