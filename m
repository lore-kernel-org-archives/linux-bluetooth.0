Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>, <andrei.emeltchenko@intel.com>,
	<johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3] android: Fix build error for Android
Date: Wed, 23 Oct 2013 14:49:19 +0200
Message-ID: <1382532559-25830-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android uses functions and defines from sys/capability.h which
requires additional include. However file capability.h shows up
in bionic in version Android 4.3, therefore we do check
PLATFORM_SDK_VERSION to no break builds of previous Android versions.
In previous Android version unistd.h contain this functionality.
---
 android/Android.mk | 3 ++-
 android/main.c     | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/android/Android.mk b/android/Android.mk
index c4b0621..a569650 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -36,7 +36,8 @@ LOCAL_C_INCLUDES += \
 	$(LOCAL_PATH)/../src \
 	$(LOCAL_PATH)/../lib \
 
-LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
+LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\" \
+	-DPLATFORM_SDK_VERSION=$(PLATFORM_SDK_VERSION)
 
 LOCAL_SHARED_LIBRARIES := \
 	libglib \
diff --git a/android/main.c b/android/main.c
index 988d08b..5a85f74 100644
--- a/android/main.c
+++ b/android/main.c
@@ -52,6 +52,12 @@
 #include "hal-msg.h"
 #include "ipc.h"
 
+/* TODO: Consider to remove PLATFORM_SDKVERSION check if requirement
+*  for minimal Android platform version increases. */
+#if defined(ANDROID) && PLATFORM_SDK_VERSION >= 18
+#include <sys/capability.h>
+#endif
+
 static GMainLoop *event_loop;
 static struct mgmt *mgmt_if = NULL;
 
-- 
1.8.4

