Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/3] android: Add skeleton of BlueZ Android daemon
Date: Tue, 24 Sep 2013 18:11:09 +0200
Message-Id: <1380039070-825-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1380039070-825-1-git-send-email-frederic.danis@linux.intel.com>
References: <1380039070-825-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Define local mapping to glib path, otherwise this has to be inside central
place in the build repository.

Retrieve Bluetooth version from configure.ac.
---
 .gitignore         |    2 +
 Makefile.android   |    5 +++
 android/Android.mk |   24 ++++++++++++
 android/main.c     |  110 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+)
 create mode 100644 android/main.c

diff --git a/.gitignore b/.gitignore
index 8a25a3e..3707209 100644
--- a/.gitignore
+++ b/.gitignore
@@ -98,3 +98,5 @@ unit/test-gobex-packet
 unit/test-gobex-transfer
 unit/test-*.log
 unit/test-*.trs
+
+android/bluetoothd
diff --git a/Makefile.android b/Makefile.android
index 5e43730..e056dce 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -1,4 +1,9 @@
 
 if ANDROID
+noinst_PROGRAMS += android/bluetoothd
+
+android_bluetoothd_SOURCES = android/main.c
+android_bluetoothd_LDADD = @GLIB_LIBS@
+
 EXTRA_DIST += android/Android.mk
 endif
diff --git a/android/Android.mk b/android/Android.mk
index 31e2c1e..fc3d6c2 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -3,3 +3,27 @@ LOCAL_PATH := $(call my-dir)
 # Retrieve BlueZ version from configure.ac file
 BLUEZ_VERSION := $(shell grep ^AC_INIT $(LOCAL_PATH)/../configure.ac | cpp -P -D'AC_INIT(_,v)=v')
 
+# Specify pathmap for glib
+pathmap_INCL += glib:external/bluetooth/glib
+
+#
+# Android BlueZ daemon (bluetoothd)
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	main.c \
+
+LOCAL_C_INCLUDES := \
+	$(call include-path-for, glib) \
+	$(call include-path-for, glib)/glib \
+
+LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
+
+LOCAL_SHARED_LIBRARIES := \
+	libglib \
+
+LOCAL_MODULE := bluetoothd
+
+include $(BUILD_EXECUTABLE)
diff --git a/android/main.c b/android/main.c
new file mode 100644
index 0000000..1dba2d4
--- /dev/null
+++ b/android/main.c
@@ -0,0 +1,110 @@
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
+#include <signal.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+
+#include <glib.h>
+
+#define SHUTDOWN_GRACE_SECONDS 10
+
+static GMainLoop *event_loop;
+
+static gboolean quit_eventloop(gpointer user_data)
+{
+	g_main_loop_quit(event_loop);
+
+	return FALSE;
+}
+
+static void sig_term(int sig)
+{
+	static bool __terminated = false;
+
+	if (!__terminated) {
+		g_timeout_add_seconds(SHUTDOWN_GRACE_SECONDS,
+						quit_eventloop, NULL);
+	}
+
+	__terminated = true;
+}
+
+static gboolean option_detach = TRUE;
+static gboolean option_version = FALSE;
+
+static GOptionEntry options[] = {
+	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
+				G_OPTION_ARG_NONE, &option_detach,
+				"Run with logging in foreground", NULL },
+	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
+				"Show version information and exit", NULL },
+	{ NULL }
+};
+
+int main(int argc, char *argv[])
+{
+	GOptionContext *context;
+	GError *err = NULL;
+	struct sigaction sa;
+
+	context = g_option_context_new(NULL);
+	g_option_context_add_main_entries(context, options, NULL);
+
+	if (g_option_context_parse(context, &argc, &argv, &err) == FALSE) {
+		if (err != NULL) {
+			g_printerr("%s\n", err->message);
+			g_error_free(err);
+		} else
+			g_printerr("An unknown error occurred\n");
+
+		exit(EXIT_FAILURE);
+	}
+
+	g_option_context_free(context);
+
+	if (option_version == TRUE) {
+		printf("%s\n", VERSION);
+		exit(EXIT_SUCCESS);
+	}
+
+	event_loop = g_main_loop_new(NULL, FALSE);
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = sig_term;
+	sigaction(SIGINT, &sa, NULL);
+	sigaction(SIGTERM, &sa, NULL);
+
+	g_main_loop_run(event_loop);
+
+	g_main_loop_unref(event_loop);
+
+	return EXIT_SUCCESS;
+}
-- 
1.7.9.5

