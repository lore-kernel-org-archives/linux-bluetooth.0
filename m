Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/build: Convert LOCAL_MODULE_PATH to LOCAL_MODULE_RELATIVE_PATH
Date: Wed,  3 Dec 2014 17:10:33 +0200
Message-Id: <1417619433-32413-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

LOCAL_MODULE_PATH needs to be replaced for multiarch builds like for
example for Nexus 9 (volantis) target.
---
 android/Android.mk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 20a1494..9ee2fc9 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -376,7 +376,7 @@ LOCAL_SHARED_LIBRARIES := \
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS) -Wno-declaration-after-statement
 LOCAL_LDFLAGS := -ldl
 
-LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
+LOCAL_MODULE_RELATIVE_PATH := hw
 LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE := audio.a2dp.default
 
@@ -402,7 +402,7 @@ LOCAL_SHARED_LIBRARIES := \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS) -Wno-declaration-after-statement
 
-LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
+LOCAL_MODULE_RELATIVE_PATH := hw
 LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE := audio.sco.default
 
-- 
1.9.1

