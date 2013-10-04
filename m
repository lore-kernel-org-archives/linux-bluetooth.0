Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 5/5] android: Android version of log.c
Date: Fri,  4 Oct 2013 14:48:47 +0300
Message-Id: <1380887327-6652-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1380887327-6652-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380887327-6652-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Frederic Danis <frederic.danis@linux.intel.com>

Add logging for Android, currently print logs to stderr and stdout.
---
 Makefile.android   |    4 +--
 android/Android.mk |    2 ++
 android/log.c      |   82 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/main.c     |    6 ++++
 4 files changed, 92 insertions(+), 2 deletions(-)
 create mode 100644 android/log.c

diff --git a/Makefile.android b/Makefile.android
index e792c10..e161e6d 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -1,8 +1,8 @@
 if ANDROID
 noinst_PROGRAMS += android/bluetoothd
 
-android_bluetoothd_SOURCES = android/main.c
+android_bluetoothd_SOURCES = android/main.c src/log.c
 android_bluetoothd_LDADD = @GLIB_LIBS@
 endif
 
-EXTRA_DIST += android/Android.mk
+EXTRA_DIST += android/Android.mk android/log.c
diff --git a/android/Android.mk b/android/Android.mk
index fc3d6c2..ec820ac 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -14,10 +14,12 @@ include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
 	main.c \
+	log.c \
 
 LOCAL_C_INCLUDES := \
 	$(call include-path-for, glib) \
 	$(call include-path-for, glib)/glib \
+	$(LOCAL_PATH)/../src \
 
 LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
 
diff --git a/android/log.c b/android/log.c
new file mode 100644
index 0000000..ce07b82
--- /dev/null
+++ b/android/log.c
@@ -0,0 +1,82 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdarg.h>
+#include <unistd.h>
+#include <sys/uio.h>
+
+#include <glib.h>
+
+void info(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+
+	vfprintf(stdout, format, ap);
+	fprintf(stdout, "\n");
+
+	va_end(ap);
+}
+
+void warn(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+
+	vfprintf(stderr, format, ap);
+	fprintf(stderr, "\n");
+
+	va_end(ap);
+}
+
+void error(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+
+	vfprintf(stderr, format, ap);
+	fprintf(stderr, "\n");
+
+	va_end(ap);
+}
+
+void btd_debug(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+
+	vfprintf(stdout, format, ap);
+	fprintf(stdout, "\n");
+
+	va_end(ap);
+}
diff --git a/android/main.c b/android/main.c
index f4240c3..f75b0a8 100644
--- a/android/main.c
+++ b/android/main.c
@@ -34,6 +34,8 @@
 
 #include <glib.h>
 
+#include "log.h"
+
 #define SHUTDOWN_GRACE_SECONDS 10
 
 static GMainLoop *event_loop;
@@ -98,9 +100,13 @@ int main(int argc, char *argv[])
 	sigaction(SIGINT, &sa, NULL);
 	sigaction(SIGTERM, &sa, NULL);
 
+	DBG("Entering main loop");
+
 	g_main_loop_run(event_loop);
 
 	g_main_loop_unref(event_loop);
 
+	info("Exit");
+
 	return EXIT_SUCCESS;
 }
-- 
1.7.10.4

