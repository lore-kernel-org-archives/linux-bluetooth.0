Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Make haltest and bluetoothd depend on HAL lib
Date: Thu, 24 Oct 2013 17:22:41 +0300
Message-Id: <1382624561-9294-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The patch makes haltest and bluetoothd depend on bluetooth.default target
which is already defined. glib dependency Android resolves itself.
Fixes issue that for the fresh build only bluetooth.default.so is built.
---
 android/Android.mk |    1 +
 1 file changed, 1 insertion(+)

diff --git a/android/Android.mk b/android/Android.mk
index aac5c67..7049a20 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -84,6 +84,7 @@ LOCAL_MODULE := bluetooth.default
 LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
 LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE_CLASS := SHARED_LIBRARIES
+LOCAL_REQUIRED_MODULES := haltest bluetoothd
 
 include $(BUILD_SHARED_LIBRARY)
 
-- 
1.7.10.4

