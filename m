Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 38/39] android/hf-client: Add hf-client to Android build
Date: Tue,  9 Sep 2014 21:57:23 +0200
Message-Id: <1410292644-23497-39-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HF-Client is build for Android only when BLUEZ_EXTENSION flag is set
---
 android/Android.mk | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index b2b55f7..a75fe53 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -128,6 +128,10 @@ LOCAL_SRC_FILES := \
 	bluez/android/hal-utils.c \
 	bluez/android/hal-health.c \
 
+ifeq ($(BLUEZ_EXTENSIONS), true)
+LOCAL_SRC_FILES += bluez/android/hal-hf-client.c
+endif
+
 LOCAL_C_INCLUDES += \
 	$(call include-path-for, system-core) \
 	$(call include-path-for, libhardware) \
-- 
1.8.4

