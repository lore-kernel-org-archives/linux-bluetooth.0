Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] android: Fix bluetoothd installation path
Date: Wed, 8 Jan 2014 17:42:01 +0100
Message-ID: <1389199321-26623-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes explicit LOCAL_MODULE_PATH definition for bluetoothd
and bluetoothd-snoop modules which caused both binaries to be installed
in /system/xbin instead of /system/bin folder.
---
 android/Android.mk | 2 --
 1 file changed, 2 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 16339b1..8eb918e 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -75,7 +75,6 @@ $(shell mkdir -p $(LOCAL_PATH)/../lib/bluetooth)
 
 $(foreach file,$(lib_headers), $(shell ln -sf ../$(file) $(LOCAL_PATH)/../lib/bluetooth/$(file)))
 
-LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
 LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE := bluetoothd
 
@@ -264,7 +263,6 @@ LOCAL_C_INCLUDES := \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
-LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
 LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE := bluetoothd-snoop
 
-- 
1.8.5.2

