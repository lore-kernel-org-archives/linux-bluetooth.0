Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH] android: Fix compiler flags with Android version
Date: Wed, 30 Oct 2013 15:22:38 +0100
Message-ID: <1383142958-27510-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes commit that removed PLATFORM_SDK_VERSION when building
haltest. Now all android targets get this define.
---
 android/Android.mk |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index fc1b276..ae6d332 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -7,7 +7,8 @@ BLUEZ_VERSION := $(shell grep ^AC_INIT $(LOCAL_PATH)/../configure.ac | cpp -P -D
 pathmap_INCL += glib:external/bluetooth/glib
 
 # Specify common compiler flags
-BLUEZ_COMMON_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
+BLUEZ_COMMON_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\" \
+	-DPLATFORM_SDK_VERSION=$(PLATFORM_SDK_VERSION)
 
 # Disable warnings enabled by Android but not enabled in autotools build
 BLUEZ_COMMON_CFLAGS += -Wno-pointer-arith
@@ -45,8 +46,7 @@ LOCAL_C_INCLUDES += \
 	$(LOCAL_PATH)/../src \
 	$(LOCAL_PATH)/../lib \
 
-LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS) \
-	-DPLATFORM_SDK_VERSION=$(PLATFORM_SDK_VERSION)
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
 LOCAL_SHARED_LIBRARIES := \
 	libglib \
-- 
1.7.9.5

