Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 1/4] android: Fix build dependency of bluetoothd on target
Date: Wed, 23 Oct 2013 11:08:16 +0300
Message-Id: <1382515699-30338-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds missing headers necessary to build bluetoothd.
---
 android/Android.mk | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 7132279..d276102 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -15,18 +15,19 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := \
 	main.c \
 	log.c \
-	adapter.c \
-	hid.c \
+	adapter.c adapter.h \
+	hid.c hid.h \
 	ipc.c ipc.h \
-	../src/shared/mgmt.c \
-	../src/shared/util.c \
-	../src/sdpd-database.c \
-	../src/sdpd-service.c \
-	../src/sdpd-request.c \
-	../src/sdpd-server.c \
-	../lib/sdp.c \
-	../lib/bluetooth.c \
-	../lib/hci.c \
+	$(LOCAL_PATH)/../src/sdp.h \
+	$(LOCAL_PATH)/../src/shared/mgmt.c \
+	$(LOCAL_PATH)/../src/shared/util.c \
+	$(LOCAL_PATH)/../src/sdpd-database.c \
+	$(LOCAL_PATH)/../src/sdpd-service.c \
+	$(LOCAL_PATH)/../src/sdpd-request.c \
+	$(LOCAL_PATH)/../src/sdpd-server.c \
+	$(LOCAL_PATH)/../lib/sdp.c \
+	$(LOCAL_PATH)/../lib/bluetooth.c \
+	$(LOCAL_PATH)/../lib/hci.c \
 
 LOCAL_C_INCLUDES := \
 	$(call include-path-for, glib) \
-- 
1.8.3.1

