Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/3] android: Android version of log.c
Date: Tue, 24 Sep 2013 18:11:10 +0200
Message-Id: <1380039070-825-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1380039070-825-1-git-send-email-frederic.danis@linux.intel.com>
References: <1380039070-825-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add logging system to BlueZ Android daemon.
Android build will use android/log.c file while autotools build will use
src/log.c instead.
---
 Makefile.android   |    4 +-
 android/Android.mk |    1 +
 android/log.c      |  172 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/main.c     |   34 +++++++++++
 4 files changed, 209 insertions(+), 2 deletions(-)
 create mode 100644 android/log.c

diff --git a/Makefile.android b/Makefile.android
index e056dce..1184e5f 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -2,8 +2,8 @@
 if ANDROID
 noinst_PROGRAMS += android/bluetoothd
 
-android_bluetoothd_SOURCES = android/main.c
+android_bluetoothd_SOURCES = android/main.c src/log.c
 android_bluetoothd_LDADD = @GLIB_LIBS@
 
-EXTRA_DIST += android/Android.mk
+EXTRA_DIST += android/Android.mk android/log.c
 endif
diff --git a/android/Android.mk b/android/Android.mk
index fc3d6c2..e3f0fd7 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -14,6 +14,7 @@ include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
 	main.c \
+	log.c \
 
 LOCAL_C_INCLUDES := \
 	$(call include-path-for, glib) \
diff --git a/android/log.c b/android/log.c
new file mode 100644
index 0000000..908f883
--- /dev/null
+++ b/android/log.c
@@ -0,0 +1,172 @@
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
+#include "log.h"
+
+#define LOG_DEBUG	3
+#define LOG_INFO	4
+#define LOG_WARN	5
+#define LOG_ERR		6
+
+static const char tag[] = "BlueZ";
+static int system_fd;
+
+static void android_log(int pri, const char *fmt, va_list ap)
+{
+	char *msg;
+	struct iovec vec[3];
+
+	if (system_fd == -1)
+		return;
+
+	msg = g_strdup_vprintf(fmt, ap);
+
+	vec[0].iov_base = (unsigned char *) &pri;
+	vec[0].iov_len = 1;
+	vec[1].iov_base = (void *) tag;
+	vec[1].iov_len = strlen(tag) + 1;
+	vec[2].iov_base = (void *) msg;
+	vec[2].iov_len = strlen(msg) + 1;
+
+	writev(system_fd, vec, 3);
+
+	g_free(msg);
+}
+
+void info(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+
+	android_log(LOG_INFO, format, ap);
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
+	android_log(LOG_WARN, format, ap);
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
+	android_log(LOG_ERR, format, ap);
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
+	android_log(LOG_DEBUG, format, ap);
+
+	va_end(ap);
+}
+
+extern struct btd_debug_desc __start___debug[];
+extern struct btd_debug_desc __stop___debug[];
+
+static char **enabled = NULL;
+
+static gboolean is_enabled(struct btd_debug_desc *desc)
+{
+	int i;
+
+	if (enabled == NULL)
+		return 0;
+
+	for (i = 0; enabled[i] != NULL; i++)
+		if (desc->file != NULL && g_pattern_match_simple(enabled[i],
+							desc->file) == TRUE)
+			return 1;
+
+	return 0;
+}
+
+void __btd_enable_debug(struct btd_debug_desc *start,
+					struct btd_debug_desc *stop)
+{
+	struct btd_debug_desc *desc;
+
+	if (start == NULL || stop == NULL)
+		return;
+
+	for (desc = start; desc < stop; desc++) {
+		if (is_enabled(desc))
+			desc->flags |= BTD_DEBUG_FLAG_PRINT;
+	}
+}
+
+void __btd_toggle_debug(void)
+{
+	struct btd_debug_desc *desc;
+
+	for (desc = __start___debug; desc < __stop___debug; desc++)
+		desc->flags |= BTD_DEBUG_FLAG_PRINT;
+}
+
+void __btd_log_init(const char *debug, int detach)
+{
+	if (debug != NULL)
+		enabled = g_strsplit_set(debug, ":, ", 0);
+
+	__btd_enable_debug(__start___debug, __stop___debug);
+
+	system_fd = open("/dev/log/system", O_WRONLY);
+
+	info("Bluetooth daemon %s", VERSION);
+}
+
+void __btd_log_cleanup(void)
+{
+	close(system_fd);
+	system_fd = -1;
+
+	g_strfreev(enabled);
+}
diff --git a/android/main.c b/android/main.c
index 1dba2d4..c0a56b1 100644
--- a/android/main.c
+++ b/android/main.c
@@ -34,6 +34,8 @@
 
 #include <glib.h>
 
+#include "log.h"
+
 #define SHUTDOWN_GRACE_SECONDS 10
 
 static GMainLoop *event_loop;
@@ -57,10 +59,31 @@ static void sig_term(int sig)
 	__terminated = true;
 }
 
+static char *option_debug = NULL;
 static gboolean option_detach = TRUE;
 static gboolean option_version = FALSE;
 
+static void free_options(void)
+{
+	g_free(option_debug);
+	option_debug = NULL;
+}
+
+static gboolean parse_debug(const char *key, const char *value,
+				gpointer user_data, GError **error)
+{
+	if (value)
+		option_debug = g_strdup(value);
+	else
+		option_debug = g_strdup("*");
+
+	return TRUE;
+}
+
 static GOptionEntry options[] = {
+	{ "debug", 'd', G_OPTION_FLAG_OPTIONAL_ARG,
+				G_OPTION_ARG_CALLBACK, parse_debug,
+				"Specify debug options to enable", "DEBUG" },
 	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
 				G_OPTION_ARG_NONE, &option_detach,
 				"Run with logging in foreground", NULL },
@@ -102,9 +125,20 @@ int main(int argc, char *argv[])
 	sigaction(SIGINT, &sa, NULL);
 	sigaction(SIGTERM, &sa, NULL);
 
+	__btd_log_init(option_debug, option_detach);
+
+	/* no need to keep parsed option in memory */
+	free_options();
+
+	DBG("Entering main loop");
+
 	g_main_loop_run(event_loop);
 
 	g_main_loop_unref(event_loop);
 
+	info("Exit");
+
+	__btd_log_cleanup();
+
 	return EXIT_SUCCESS;
 }
-- 
1.7.9.5

