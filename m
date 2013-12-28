Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] btmon: Fix build for Android
Date: Sat, 28 Dec 2013 11:22:35 +0200
Message-Id: <1388222555-22995-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Android build was really broken with additions of functions hwdb_*

...
external/bluetooth/bluez/android/../monitor/packet.c:406: error:
undefined reference to 'hwdb_get_company'
external/bluetooth/bluez/android/../monitor/packet.c:2487: error:
undefined reference to 'hwdb_get_vendor_model'
collect2: error: ld returned 1 exit status
...
---
 android/Android.mk | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index 2cc0064..5981379 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -185,6 +185,8 @@ LOCAL_SRC_FILES := \
 	../monitor/crc.c \
 	../monitor/ll.h \
 	../monitor/ll.c \
+	../monitor/hwdb.h \
+	../monitor/hwdb.c \
 	../lib/hci.c \
 	../lib/bluetooth.c \
 
-- 
1.8.3.2

