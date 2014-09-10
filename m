Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 05/16] android/hf-client: Add hf-client to Android build
Date: Wed, 10 Sep 2014 13:34:03 +0200
Message-Id: <1410348854-26249-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410348854-26249-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410348854-26249-1-git-send-email-lukasz.rymanowski@tieto.com>
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

