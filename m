Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/build: Add liblog to LOCAL_SHARED_LIBRARIES for bluetoothd
Date: Wed, 10 Dec 2014 10:39:42 +0200
Message-Id: <1418200783-13414-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes build for Nexus 9.
...
aarch64-linux-android/bin/ld:
out/target/product/flounder/obj/EXECUTABLES/bluetoothd-main_intermediates/bluez/android/a2dp-sink.o:
undefined reference to symbol '__android_log_print'
...
---
 android/Android.mk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/Android.mk b/android/Android.mk
index 2b90cee..6547eb0 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -98,6 +98,7 @@ LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
 LOCAL_SHARED_LIBRARIES := \
 	libglib \
+	liblog \
 
 LOCAL_STATIC_LIBRARIES := \
 	bluetooth-headers \
-- 
2.1.0

