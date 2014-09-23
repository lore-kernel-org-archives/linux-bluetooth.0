Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/build: Add BLUEZ_EXTENSIONS to default cflags
Date: Tue, 23 Sep 2014 08:48:47 +0200
Message-Id: <1411454927-27079-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is to be sure that all modules knows when we use extensions.
---
 android/Android.mk | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index db5032d..8887a97 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -14,6 +14,10 @@ BLUEZ_COMMON_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\" \
 			-DANDROID_VERSION=$(ANDROID_VERSION) \
 			-DANDROID_STORAGEDIR=\"/data/misc/bluetooth\" \
 
+ifeq ($(BLUEZ_EXTENSIONS), true)
+BLUEZ_COMMON_CFLAGS += -DBLUEZ_EXTENSIONS
+endif
+
 # Enable warnings enabled in autotools build
 BLUEZ_COMMON_CFLAGS += -Wall -Wextra \
 			-Wdeclaration-after-statement \
@@ -142,10 +146,6 @@ LOCAL_SHARED_LIBRARIES := \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
-ifeq ($(BLUEZ_EXTENSIONS), true)
-LOCAL_CFLAGS += -DBLUEZ_EXTENSIONS
-endif
-
 LOCAL_MODULE := bluetooth.default
 LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
 LOCAL_MODULE_TAGS := optional
-- 
1.9.1

