Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] tools: Fix btmgmt build on Android
Date: Tue,  7 Apr 2015 10:44:36 +0200
Message-Id: <1428396276-9396-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

target Executable: btmgmt (out/target/product/mako/obj/EXECUTABLES/btmgmt_intermediates/LINKED/btmgmt)
external/bluetooth/bluez/tools/btmgmt.c:1477: error: undefined reference to 'hci_bustostr'
collect2: error: ld returned 1 exit status
---
 android/Android.mk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/Android.mk b/android/Android.mk
index f218805..1e22ca6 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -539,6 +539,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := \
 	bluez/tools/btmgmt.c \
 	bluez/lib/bluetooth.c \
+	bluez/lib/hci.c \
 	bluez/lib/sdp.c \
 	bluez/src/shared/mainloop.c \
 	bluez/src/shared/io-mainloop.c \
-- 
1.9.1

