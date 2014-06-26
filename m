Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/7] android/mcaptest: Add skeleton for mcap test tool
Date: Thu, 26 Jun 2014 15:09:06 +0200
Message-Id: <1403788151-21025-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1403788151-21025-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1403788151-21025-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds skeleton for simple tool for testing mcap library. As mcap-lib
uses bt_io, this tool works in daemon-like mode, by utilizing Glib's main
loop.
---
 .gitignore          |   1 +
 android/Android.mk  |  35 ++++++++++
 android/Makefile.am |  10 +++
 android/mcaptest.c  | 184 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 230 insertions(+)
 create mode 100644 android/mcaptest.c

diff --git a/.gitignore b/.gitignore
index 2e08c21..d661ba9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -123,6 +123,7 @@ unit/test-*.trs
 
 android/system-emulator
 android/bluetoothd
+android/mcaptest
 android/haltest
 android/android-tester
 android/ipc-tester
diff --git a/android/Android.mk b/android/Android.mk
index fc7b59d..ec33944 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -182,6 +182,41 @@ LOCAL_MODULE := haltest
 include $(BUILD_EXECUTABLE)
 
 #
+# mcaptest
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	bluez/src/log.c \
+	bluez/btio/btio.c \
+	bluez/lib/bluetooth.c \
+	bluez/lib/hci.c \
+	bluez/android/mcap-lib.c \
+	bluez/android/mcaptest.c \
+
+LOCAL_C_INCLUDES := \
+	$(call include-path-for, glib) \
+	$(call include-path-for, glib)/glib \
+
+LOCAL_C_INCLUDES += \
+	$(LOCAL_PATH)/bluez \
+
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
+
+LOCAL_SHARED_LIBRARIES := \
+	libglib \
+
+LOCAL_STATIC_LIBRARIES := \
+	bluetooth-headers \
+
+LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
+LOCAL_MODULE_TAGS := debug
+LOCAL_MODULE := mcaptest
+
+include $(BUILD_EXECUTABLE)
+
+#
 # btmon
 #
 
diff --git a/android/Makefile.am b/android/Makefile.am
index 51c8253..a025a35 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -95,6 +95,16 @@ android_bluetooth_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
 android_bluetooth_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
 					-no-undefined
 
+noinst_PROGRAMS += android/mcaptest
+
+android_mcaptest_SOURCES = android/mcaptest.c \
+				src/log.c btio/btio.c \
+				android/mcap-lib.h android/mcap-lib.c
+
+android_mcaptest_CFLAGS = $(AM_CFLAGS)
+
+android_mcaptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+
 noinst_PROGRAMS += android/haltest
 
 android_haltest_SOURCES = android/client/haltest.c \
diff --git a/android/mcaptest.c b/android/mcaptest.c
new file mode 100644
index 0000000..cc2d9cd
--- /dev/null
+++ b/android/mcaptest.c
@@ -0,0 +1,184 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014 Intel Corporation
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
+#include <stdio.h>
+#include <stdlib.h>
+#include <getopt.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/hci_lib.h>
+
+#include <glib.h>
+
+#include "btio/btio.h"
+#include "lib/l2cap.h"
+#include "android/mcap-lib.h"
+
+enum {
+	MODE_NONE,
+	MODE_CONNECT,
+	MODE_LISTEN,
+};
+
+static GMainLoop *mloop;
+
+static int ccpsm = 0x1003, dcpsm = 0x1005;
+
+static struct mcap_instance *mcap = NULL;
+
+int control_mode = MODE_LISTEN;
+
+static void mcl_connected(struct mcap_mcl *mcl, gpointer data)
+{
+	/* TODO */
+	printf("MCL connected unsupported\n");
+}
+
+static void mcl_reconnected(struct mcap_mcl *mcl, gpointer data)
+{
+	/* TODO */
+	printf("MCL reconnected unsupported\n");
+}
+
+static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
+{
+	/* TODO */
+	printf("MCL disconnected\n");
+}
+
+static void mcl_uncached(struct mcap_mcl *mcl, gpointer data)
+{
+	/* TODO */
+	printf("MCL uncached unsupported\n");
+}
+
+static void usage(void)
+{
+	printf("mcaptest - MCAP testing ver %s\n", VERSION);
+	printf("Usage:\n"
+		"\tmcaptest <mode> [options]\n");
+	printf("Modes:\n"
+		"\t-c connect <dst_addr> (than wait for disconnect)\n");
+	printf("Options:\n"
+		"\t-i <hcidev>        HCI device\n"
+		"\t-C <control_ch>    Control channel PSM\n"
+		"\t-D <data_ch>       Data channel PSM\n");
+}
+
+static struct option main_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ "device",	1, 0, 'i' },
+	{ "connect",	1, 0, 'c' },
+	{ "control_ch",	1, 0, 'C' },
+	{ "data_ch",	1, 0, 'D' },
+	{ 0, 0, 0, 0 }
+};
+
+int main(int argc, char *argv[])
+{
+	GError *err = NULL;
+	bdaddr_t src, dst;
+	int opt;
+
+	hci_devba(0, &src);
+	bacpy(&dst, BDADDR_ANY);
+
+	mloop = g_main_loop_new(NULL, FALSE);
+	if (!mloop) {
+		printf("Cannot create main loop\n");
+
+		exit(1);
+	}
+
+	while ((opt = getopt_long(argc, argv, "+i:c:C:D:h",
+						main_options, NULL)) != EOF) {
+		switch (opt) {
+		case 'i':
+			if (!strncmp(optarg, "hci", 3))
+				hci_devba(atoi(optarg + 3), &src);
+			else
+				str2ba(optarg, &src);
+
+			break;
+
+		case 'c':
+			control_mode = MODE_CONNECT;
+			str2ba(optarg, &dst);
+
+			break;
+
+		case 'C':
+			ccpsm = atoi(optarg);
+
+			break;
+
+		case 'D':
+			dcpsm = atoi(optarg);
+
+			break;
+
+		case 'h':
+		default:
+			usage();
+			exit(0);
+		}
+	}
+
+	mcap = mcap_create_instance(&src, BT_IO_SEC_MEDIUM, 0, 0,
+					mcl_connected, mcl_reconnected,
+					mcl_disconnected, mcl_uncached,
+					NULL, /* CSP is not used right now */
+					NULL, &err);
+
+	if (!mcap) {
+		printf("MCAP instance creation failed %s\n",
+								err->message);
+		g_error_free(err);
+
+		exit(1);
+	}
+
+	switch (control_mode) {
+	case MODE_CONNECT:
+	case MODE_NONE:
+	default:
+		goto done;
+	}
+
+	g_main_loop_run(mloop);
+
+done:
+	printf("Done\n");
+
+	if (mcap)
+		mcap_instance_unref(mcap);
+
+	g_main_loop_unref(mloop);
+
+	return 0;
+}
-- 
2.0.0

