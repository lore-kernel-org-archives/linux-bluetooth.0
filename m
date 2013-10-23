Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 BlueZ 1/4] android: Fix build dependency of bluetoothd on target
Date: Wed, 23 Oct 2013 11:50:37 +0300
Message-Id: <1382518240-31896-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds missing headers necessary to build bluetoothd.
---
 android/Android.mk | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 7132279..d67a62d 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -15,9 +15,10 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := \
 	main.c \
 	log.c \
-	adapter.c \
-	hid.c \
+	adapter.c adapter.h \
+	hid.c hid.h \
 	ipc.c ipc.h \
+	../src/sdp.h \
 	../src/shared/mgmt.c \
 	../src/shared/util.c \
 	../src/sdpd-database.c \
-- 
1.8.3.1

