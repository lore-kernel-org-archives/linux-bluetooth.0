Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 08/10] tools/bneptest: Add initial support for bneptest tool
Date: Mon,  9 Mar 2015 17:24:53 +0100
Message-Id: <1425918295-21976-8-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1425918295-21976-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1425918295-21976-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This tool should be designed to help testing bnep on Bluez.
---
 .gitignore         |  1 +
 Makefile.tools     | 12 ++++++---
 android/Android.mk | 35 ++++++++++++++++++++++++++
 tools/bneptest.c   | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 119 insertions(+), 3 deletions(-)
 create mode 100644 tools/bneptest.c

diff --git a/.gitignore b/.gitignore
index a207a0f..a4f06dc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -82,6 +82,7 @@ tools/gatt-service
 tools/btgatt-client
 tools/btgatt-server
 tools/mcaptest
+tools/bneptest
 test/sap_client.pyc
 test/bluezutils.pyc
 unit/test-ringbuf
diff --git a/Makefile.tools b/Makefile.tools
index e28f3cb..1aafb28 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -223,9 +223,9 @@ noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
 			tools/hcieventmask tools/hcisecfilter \
 			tools/btmgmt tools/btinfo tools/btattach \
 			tools/btsnoop tools/btproxy \
-			tools/btiotest tools/mcaptest tools/cltest \
-			tools/oobtest tools/seq2bseq tools/ibeacon \
-			tools/btgatt-client tools/btgatt-server
+			tools/btiotest  tools/bneptest tools/mcaptest \
+			tools/cltest tools/oobtest tools/seq2bseq \
+			tools/ibeacon tools/btgatt-client tools/btgatt-server
 
 tools_bdaddr_SOURCES = tools/bdaddr.c src/oui.h src/oui.c
 tools_bdaddr_LDADD = lib/libbluetooth-internal.la @UDEV_LIBS@
@@ -267,6 +267,12 @@ tools_mcaptest_SOURCES = tools/mcaptest.c \
 				profiles/health/mcap.h profiles/health/mcap.c
 tools_mcaptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
+tools_bneptest_SOURCES = tools/bneptest.c \
+				btio/btio.h btio/btio.c \
+				src/log.c src/log.h \
+				profiles/network/bnep.h profiles/network/bnep.c
+tools_bneptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+
 tools_cltest_SOURCES = tools/cltest.c
 tools_cltest_LDADD = lib/libbluetooth-internal.la src/libshared-mainloop.la
 
diff --git a/android/Android.mk b/android/Android.mk
index 6c0eda8..f218805 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -256,6 +256,41 @@ LOCAL_MODULE := mcaptest
 include $(BUILD_EXECUTABLE)
 
 #
+# bneptest
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	bluez/src/log.c \
+	bluez/btio/btio.c \
+	bluez/lib/bluetooth.c \
+	bluez/lib/hci.c \
+	bluez/profiles/network/bnep.c \
+	bluez/tools/bneptest.c \
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
+LOCAL_MODULE := bneptest
+
+include $(BUILD_EXECUTABLE)
+
+#
 # avdtptest
 #
 
diff --git a/tools/bneptest.c b/tools/bneptest.c
new file mode 100644
index 0000000..cafeba9
--- /dev/null
+++ b/tools/bneptest.c
@@ -0,0 +1,74 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015 Intel Corporation
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
+#include <glib.h>
+
+#include "src/log.h"
+
+static GMainLoop *mloop;
+
+static void usage(void)
+{
+	printf("bneptest - BNEP testing ver %s\n", VERSION);
+	printf("Usage:\n"
+		"\tbneptest [options]\n");
+}
+
+static struct option main_options[] = {
+	{ "help",		0, 0, 'h' },
+	{ 0, 0, 0, 0 }
+};
+
+int main(int argc, char *argv[])
+{
+	int opt;
+
+	DBG("");
+
+	mloop = g_main_loop_new(NULL, FALSE);
+	if (!mloop) {
+		printf("Cannot create main loop\n");
+
+		exit(1);
+	}
+
+	while ((opt = getopt_long(argc, argv, "h", main_options, NULL))
+								!= EOF) {
+		switch (opt) {
+		case 'h':
+		default:
+			usage();
+			exit(0);
+		}
+	}
+
+	return 0;
+}
-- 
2.1.0

