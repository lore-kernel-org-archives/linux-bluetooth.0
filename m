Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android: Suppress compiler warnings not enabled by autotools build
Date: Tue, 5 Nov 2013 11:50:13 +0100
Message-ID: <1383648613-21352-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

missing-field-initializers warning is not enabled on autotools build.
Current code rely on implicit fields intializations resulting in flood
of bogus compiler warnings while building for Android.

monitor/packet.c:348:2: warning: missing initializer
    [-Wmissing-field-initializers]
monitor/packet.c:348:2: warning: (near initialization for
    'error2str_table[64].error') [-Wmissing-field-initializers]
monitor/packet.c:542:2: warning: missing initializer
    [-Wmissing-field-initializers]
monitor/packet.c:542:2: warning: (near initialization for
    'svc_class_table[8].bit') [-Wmissing-field-initializers]
monitor/packet.c:557:2: warning: missing initializer
    [-Wmissing-field-initializers]
monitor/packet.c:557:2: warning: (near initialization for
    'major_class_computer_table[8].val') [-Wmissing-field-initializers]
---
 android/Android.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/Android.mk b/android/Android.mk
index 86af7b6..d76dfaf 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -11,7 +11,7 @@ BLUEZ_COMMON_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\" \
 	-DPLATFORM_SDK_VERSION=$(PLATFORM_SDK_VERSION)
 
 # Disable warnings enabled by Android but not enabled in autotools build
-BLUEZ_COMMON_CFLAGS += -Wno-pointer-arith
+BLUEZ_COMMON_CFLAGS += -Wno-pointer-arith -Wno-missing-field-initializers
 
 #
 # Android BlueZ daemon (bluetoothd)
-- 
1.8.4.1

