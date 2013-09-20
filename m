Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android: Add skeleton of BlueZ Android daemon
Date: Fri, 20 Sep 2013 14:24:30 +0200
Message-Id: <1379679871-29623-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Define local mapping to glib path, otherwise this has to be inside central
place in the build repository.

Retrieve Bluetooth version from configure.ac.
---
 .gitignore         |    2 +
 Android.mk         |    9 ++++
 Makefile.am        |    1 +
 Makefile.android   |    7 ++++
 android/Android.mk |   24 +++++++++++
 android/main.c     |  119 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac       |    5 +++
 7 files changed, 167 insertions(+)
 create mode 100644 Android.mk
 create mode 100644 Makefile.android
 create mode 100644 android/Android.mk
 create mode 100644 android/main.c

diff --git a/.gitignore b/.gitignore
index 8a25a3e..331a18b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -98,3 +98,5 @@ unit/test-gobex-packet
 unit/test-gobex-transfer
 unit/test-*.log
 unit/test-*.trs
+
+android/bluezd
diff --git a/Android.mk b/Android.mk
new file mode 100644
index 0000000..5ec3bb7
--- /dev/null
+++ b/Android.mk
@@ -0,0 +1,9 @@
+LOCAL_PATH := $(call my-dir)
+
+# Retrieve BlueZ version from configure.ac file
+BLUEZ_VERSION := $(shell grep AC_INIT $(LOCAL_PATH)/configure.ac | tr -d ' ' | sed -e 's/.*(.*,\(.*\))/\1/')
+
+# Specify pathmap for glib
+pathmap_INCL += glib:external/bluetooth/glib
+
+include $(call all-subdir-makefiles)
diff --git a/Makefile.am b/Makefile.am
index 4e4b1c5..2c048bd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -179,6 +179,7 @@ test_scripts =
 
 include Makefile.tools
 include Makefile.obexd
+include Makefile.android
 
 if HID2HCI
 rulesdir = @UDEV_DIR@/rules.d
diff --git a/Makefile.android b/Makefile.android
new file mode 100644
index 0000000..7b901ff
--- /dev/null
+++ b/Makefile.android
@@ -0,0 +1,7 @@
+
+if ANDROID_DAEMON
+noinst_PROGRAMS += android/bluezd
+
+android_bluezd_SOURCES = android/main.c
+android_bluezd_LDADD = @GLIB_LIBS@
+endif
diff --git a/android/Android.mk b/android/Android.mk
new file mode 100644
index 0000000..50f3c36
--- /dev/null
+++ b/android/Android.mk
@@ -0,0 +1,24 @@
+LOCAL_PATH := $(call my-dir)
+
+#
+# Android BlueZ daemon (bluezd)
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
+	$(LOCAL_PATH)/../src \
+
+LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
+
+LOCAL_SHARED_LIBRARIES := \
+	libglib \
+
+LOCAL_MODULE := bluezd
+
+include $(BUILD_EXECUTABLE)
diff --git a/android/main.c b/android/main.c
new file mode 100644
index 0000000..37a64c1
--- /dev/null
+++ b/android/main.c
@@ -0,0 +1,119 @@
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
+#include <string.h>
+
+#include <glib.h>
+
+#include "hcid.h"
+
+#define SHUTDOWN_GRACE_SECONDS 10
+
+static GMainLoop *event_loop;
+
+void btd_exit(void)
+{
+	g_main_loop_quit(event_loop);
+}
+
+static gboolean quit_eventloop(gpointer user_data)
+{
+	btd_exit();
+	return FALSE;
+}
+
+static void signal_handler(int sig)
+{
+	static unsigned int __terminated = 0;
+
+	switch (sig) {
+	case SIGINT:
+	case SIGTERM:
+		if (__terminated == 0) {
+			g_timeout_add_seconds(SHUTDOWN_GRACE_SECONDS,
+							quit_eventloop, NULL);
+		}
+
+		__terminated = 1;
+		break;
+	}
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
+		exit(1);
+	}
+
+	g_option_context_free(context);
+
+	if (option_version == TRUE) {
+		printf("%s\n", VERSION);
+		exit(0);
+	}
+
+	event_loop = g_main_loop_new(NULL, FALSE);
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = signal_handler;
+	sigaction(SIGINT, &sa, NULL);
+	sigaction(SIGTERM, &sa, NULL);
+
+	g_main_loop_run(event_loop);
+
+	g_main_loop_unref(event_loop);
+
+	return 0;
+}
diff --git a/configure.ac b/configure.ac
index 41c2935..3b7a5d9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -242,4 +242,9 @@ AC_DEFINE_UNQUOTED(CONFIGDIR, "${configdir}",
 			[Directory for the configuration files])
 AC_SUBST(CONFIGDIR, "${configdir}")
 
+AC_ARG_ENABLE(android-daemon, AC_HELP_STRING([--enable-android-daemon],
+			[enable BlueZ Android daemon]),
+					[android_daemon=${enableval}])
+AM_CONDITIONAL(ANDROID_DAEMON, test "${android_daemon}" = "yes")
+
 AC_OUTPUT(Makefile src/bluetoothd.8 lib/bluez.pc)
-- 
1.7.9.5

