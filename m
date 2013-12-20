Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] android: Include btmon and l2test in userdebug builds
Date: Fri, 20 Dec 2013 13:35:19 +0100
Message-ID: <1387542919-16070-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes btmon and l2test module tags from 'eng' to 'debug' so
they are automatically installed also for userdebug variant which is
default for AOSP devices.

---
 android/Android.mk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 2865c08..d9bae40 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -200,7 +200,7 @@ LOCAL_C_INCLUDES += \
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
 LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
-LOCAL_MODULE_TAGS := eng
+LOCAL_MODULE_TAGS := debug
 LOCAL_MODULE := btmon
 
 include $(BUILD_EXECUTABLE)
@@ -247,7 +247,7 @@ LOCAL_C_INCLUDES := \
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
 LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
-LOCAL_MODULE_TAGS := eng
+LOCAL_MODULE_TAGS := debug
 LOCAL_MODULE := l2test
 
 include $(BUILD_EXECUTABLE)
-- 
1.8.5

