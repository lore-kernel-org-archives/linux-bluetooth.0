Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/build: Enable multilib build for bluetooth.default
Date: Tue,  9 Dec 2014 11:45:07 +0200
Message-Id: <1418118307-13170-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/Android.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/Android.mk b/android/Android.mk
index 9ee2fc9..2b90cee 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -154,7 +154,7 @@ LOCAL_SHARED_LIBRARIES := \
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
 LOCAL_MODULE := bluetooth.default
-LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
+LOCAL_MODULE_RELATIVE_PATH := hw
 LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE_CLASS := SHARED_LIBRARIES
 LOCAL_REQUIRED_MODULES := bluetoothd bluetoothd-snoop init.bluetooth.rc
-- 
2.1.0

