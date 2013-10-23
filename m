Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Make use of Android system headers instead of local one
Date: Wed, 23 Oct 2013 15:44:41 +0300
Message-Id: <1382532281-5445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Since the headers were copied to android/ folder Android build started
to use those instead of original Android system headers. The patch
puts Android system headers first.
---
 android/Android.mk | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index 3163763..0640842 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -71,6 +71,9 @@ LOCAL_SRC_FILES := \
 	hal-pan.c \
 	hal-av.c \
 
+LOCAL_C_INCLUDES += \
+	system/core/include \
+
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
 
-- 
1.8.1.2

