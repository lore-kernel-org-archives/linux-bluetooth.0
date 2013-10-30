Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Use Android headers instead of local ones
Date: Wed, 30 Oct 2013 17:51:24 +0200
Message-Id: <1383148285-20937-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add path to Android libhardware library headers
---
 android/Android.mk |    1 +
 1 file changed, 1 insertion(+)

diff --git a/android/Android.mk b/android/Android.mk
index fc1b276..88dff4b 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -86,6 +86,7 @@ LOCAL_SRC_FILES := \
 
 LOCAL_C_INCLUDES += \
 	$(call include-path-for, system-core) \
+	$(call include-path-for, libhardware) \
 
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
-- 
1.7.10.4

