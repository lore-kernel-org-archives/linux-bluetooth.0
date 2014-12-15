Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/3] android/snoop: Use common logging API
Date: Mon, 15 Dec 2014 15:07:54 +0100
Message-Id: <1418652475-19842-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1418652475-19842-1-git-send-email-szymon.janc@tieto.com>
References: <1418652475-19842-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to log without logwrapper.
---
 android/Android.mk         |  1 +
 android/Makefile.am        |  4 ++--
 android/bluetoothd-snoop.c | 14 ++++++++++++--
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 17349bf..c1a9eff 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -447,6 +447,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/bluetoothd-snoop.c \
 	bluez/monitor/mainloop.c \
 	bluez/src/shared/btsnoop.c \
+	bluez/android/log.c \
 
 LOCAL_C_INCLUDES := \
 	$(LOCAL_PATH)/bluez \
diff --git a/android/Makefile.am b/android/Makefile.am
index 6d74c05..ac9c360 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -11,8 +11,8 @@ android_system_emulator_LDADD = src/libshared-mainloop.la
 
 noinst_PROGRAMS += android/bluetoothd-snoop
 
-android_bluetoothd_snoop_SOURCES = android/bluetoothd-snoop.c
-android_bluetoothd_snoop_LDADD = src/libshared-mainloop.la
+android_bluetoothd_snoop_SOURCES = android/bluetoothd-snoop.c src/log.c
+android_bluetoothd_snoop_LDADD = src/libshared-mainloop.la @GLIB_LIBS@
 
 noinst_PROGRAMS += android/bluetoothd
 
diff --git a/android/bluetoothd-snoop.c b/android/bluetoothd-snoop.c
index dc34869..776dca7 100644
--- a/android/bluetoothd-snoop.c
+++ b/android/bluetoothd-snoop.c
@@ -25,7 +25,6 @@
 #include <config.h>
 #endif
 
-#include <stdio.h>
 #include <ctype.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -39,6 +38,7 @@
 
 #include "monitor/mainloop.h"
 #include "src/shared/btsnoop.h"
+#include "src/log.h"
 
 #define DEFAULT_SNOOP_FILE "/sdcard/btsnoop_hci.log"
 
@@ -218,6 +218,10 @@ int main(int argc, char *argv[])
 	const char *path;
 	sigset_t mask;
 
+	__btd_log_init(NULL, 0);
+
+	DBG("");
+
 	set_capabilities();
 
 	if (argc > 1)
@@ -237,13 +241,19 @@ int main(int argc, char *argv[])
 		rename(DEFAULT_SNOOP_FILE, DEFAULT_SNOOP_FILE ".old");
 
 	if (open_monitor(path) < 0) {
-		printf("Failed to start bluetoothd_snoop\n");
+		error("bluetoothd_snoop: start failed");
 		return EXIT_FAILURE;
 	}
 
+	info("bluetoothd_snoop: started");
+
 	mainloop_run();
 
 	close_monitor();
 
+	info("bluetoothd_snoop: stopped");
+
+	__btd_log_cleanup();
+
 	return EXIT_SUCCESS;
 }
-- 
1.9.1

