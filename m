Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] android: Include headers from libhardware as system headers
Date: Wed, 21 May 2014 18:18:02 +0200
Message-ID: <1400689082-12662-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Including hardware/audio.h in Android build produces sign-compare
warning due to nested include of cutils/bitops.h. Since we cannot avoid
this warning in sane way unless it's fixed in AOSP tree, we can make
GCC think this is a system header and suppress warnings.

This patch changes the way headers from libhardware are added to
search path from LOCAL_C_INCLUDES to explicit "-isystem" option added
to LOCAL_CFLAGS.
---
 android/Android.mk | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 4235a7c..d3d94ed 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -121,12 +121,12 @@ LOCAL_SRC_FILES := \
 
 LOCAL_C_INCLUDES += \
 	$(call include-path-for, system-core) \
-	$(call include-path-for, libhardware) \
 
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
 
-LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS) \
+	-isystem $(call include-path-for, libhardware)
 
 LOCAL_MODULE := bluetooth.default
 LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
@@ -163,9 +163,9 @@ LOCAL_SRC_FILES := \
 
 LOCAL_C_INCLUDES += \
 	$(call include-path-for, system-core) \
-	$(call include-path-for, libhardware) \
 
-LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS) \
+	-isystem $(call include-path-for, libhardware)
 
 LOCAL_SHARED_LIBRARIES := libhardware
 
@@ -256,14 +256,14 @@ LOCAL_SRC_FILES := bluez/android/hal-audio.c
 
 LOCAL_C_INCLUDES = \
 	$(call include-path-for, system-core) \
-	$(call include-path-for, libhardware) \
 	$(call include-path-for, sbc) \
 
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
 	libsbc \
 
-LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS) \
+	-isystem $(call include-path-for, libhardware)
 
 LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
 LOCAL_MODULE_TAGS := optional
@@ -281,14 +281,14 @@ LOCAL_SRC_FILES := bluez/android/hal-sco.c
 
 LOCAL_C_INCLUDES = \
 	$(call include-path-for, system-core) \
-	$(call include-path-for, libhardware) \
 	$(call include-path-for, audio-utils) \
 
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
 	libaudioutils \
 
-LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS) \
+	-isystem $(call include-path-for, libhardware)
 
 LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
 LOCAL_MODULE_TAGS := optional
-- 
1.9.3

