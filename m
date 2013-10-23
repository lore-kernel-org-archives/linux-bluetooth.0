Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Use helper function for finding headers
Date: Wed, 23 Oct 2013 16:42:17 +0300
Message-Id: <1382535737-9757-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Using helper function allows us to overcome possible location
change in future Android releases. This was inspired by
Szymon Janc's comment to my previous patch.
---
 android/Android.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/Android.mk b/android/Android.mk
index dd9c36d..1f20e57 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -75,7 +75,7 @@ LOCAL_SRC_FILES := \
 	hal-av.c \
 
 LOCAL_C_INCLUDES += \
-	system/core/include \
+	$(call include-path-for, system-core) \
 
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
-- 
1.8.1.2

