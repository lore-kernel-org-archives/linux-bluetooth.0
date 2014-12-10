Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/2] android/build: Add libcutils to LOCAL_SHARED_LIBRARIES for haltest
Date: Wed, 10 Dec 2014 10:58:10 +0200
Message-Id: <1418201890-8255-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1418201890-8255-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1418201890-8255-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes build error for Nexus 9.
...
aarch64-linux-android/bin/ld:
out/target/product/flounder/obj/EXECUTABLES/haltest_intermediates/bluez/android/hal-utils.o:
undefined reference to symbol 'property_get'
...
---
 android/Android.mk | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/Android.mk b/android/Android.mk
index 2b90cee..c1505c8 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -203,7 +203,9 @@ LOCAL_C_INCLUDES += \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS) -Wno-declaration-after-statement
 
-LOCAL_SHARED_LIBRARIES := libhardware
+LOCAL_SHARED_LIBRARIES := \
+	libhardware \
+	libcutils \
 
 LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
 LOCAL_MODULE_TAGS := debug
-- 
2.1.0

