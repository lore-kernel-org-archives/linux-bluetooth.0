Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 47/47] android/build: Disable declaration-after-statement warnings
Date: Tue,  4 Nov 2014 10:19:10 +0200
Message-Id: <1415089150-18798-48-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When building Android system libraries for Audio HAL produce lots of
warnings.
---
 android/Android.mk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index bfdf03f..16f94b9 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -367,7 +367,7 @@ LOCAL_SHARED_LIBRARIES := \
 	libcutils \
 	libsbc \
 
-LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS) -Wno-declaration-after-statement
 LOCAL_LDFLAGS := -ldl
 
 LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
@@ -394,7 +394,7 @@ LOCAL_SHARED_LIBRARIES := \
 	libcutils \
 	libaudioutils \
 
-LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS) -Wno-declaration-after-statement
 
 LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
 LOCAL_MODULE_TAGS := optional
-- 
1.9.1

