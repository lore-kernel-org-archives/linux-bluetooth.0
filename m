Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/5] android/hal-sock: Rename to hal-socket
Date: Tue, 18 Feb 2014 11:05:22 +0100
Message-Id: <1392717924-7712-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1392717924-7712-1-git-send-email-szymon.janc@tieto.com>
References: <1392717924-7712-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will match convention used for lib and daemon part of HAL.
---
 android/Android.mk                   | 2 +-
 android/Makefile.am                  | 2 +-
 android/{hal-sock.c => hal-socket.c} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename android/{hal-sock.c => hal-socket.c} (100%)

diff --git a/android/Android.mk b/android/Android.mk
index 2481a2c..ed72890 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -112,7 +112,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := \
 	bluez/android/hal-ipc.c \
 	bluez/android/hal-bluetooth.c \
-	bluez/android/hal-sock.c \
+	bluez/android/hal-socket.c \
 	bluez/android/hal-hidhost.c \
 	bluez/android/hal-pan.c \
 	bluez/android/hal-a2dp.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 1913b42..36a9e82 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -49,7 +49,7 @@ android_bluetoothd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 plugin_LTLIBRARIES += android/bluetooth.default.la
 
 android_bluetooth_default_la_SOURCES = android/hal.h android/hal-bluetooth.c \
-					android/hal-sock.c \
+					android/hal-socket.c \
 					android/hal-hidhost.c \
 					android/hal-pan.c \
 					android/hal-a2dp.c \
diff --git a/android/hal-sock.c b/android/hal-socket.c
similarity index 100%
rename from android/hal-sock.c
rename to android/hal-socket.c
-- 
1.8.3.2

