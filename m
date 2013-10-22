Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Create header links for lib
Date: Tue, 22 Oct 2013 19:42:23 +0300
Message-Id: <1382460144-11483-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

BlueZ headers are referring as bluetooth/* for headers which are
located in lib/*. Create symlinks for now until we find better solution.
---
 android/Android.mk |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index c4b0621..a13d6f1 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -41,6 +41,23 @@ LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
 LOCAL_SHARED_LIBRARIES := \
 	libglib \
 
+lib_headers := \
+        bluetooth.h \
+        hci.h \
+        hci_lib.h \
+        sco.h \
+        l2cap.h \
+        sdp.h \
+        sdp_lib.h \
+        rfcomm.h \
+        bnep.h \
+        cmtp.h \
+        hidp.h \
+
+$(shell mkdir -p $(LOCAL_PATH)/../lib/bluetooth)
+
+$(foreach file,$(lib_headers), $(shell ln -sf ../$(file) $(LOCAL_PATH)/../lib/bluetooth/$(file)))
+
 LOCAL_MODULE := bluetoothd
 
 include $(BUILD_EXECUTABLE)
-- 
1.7.10.4

