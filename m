Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 2/5] tools/mcaptest: Add skeleton for mcap test tool
Date: Wed, 25 Jun 2014 17:49:58 +0200
Message-Id: <1403711401-11247-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1403711401-11247-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1403711401-11247-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds skeleton for simple tool for testing mcap library. As mcap-lib
uses bt_io, this tool works in daemon-like mode, by utilizing Glib's main
loop.
---
 .gitignore       |   1 +
 Makefile.tools   |   7 ++-
 tools/mcaptest.c | 184 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+), 1 deletion(-)
 create mode 100644 tools/mcaptest.c

diff --git a/.gitignore b/.gitignore
index 2e08c21..cc6dc6e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -74,6 +74,7 @@ tools/btinfo
 tools/3dsp
 tools/obexctl
 tools/gatt-service
+tools/mcaptest
 test/sap_client.pyc
 test/bluezutils.pyc
 unit/test-ringbuf
diff --git a/Makefile.tools b/Makefile.tools
index c24bdf7..402c290 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -278,7 +278,7 @@ noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
 			tools/btmgmt tools/btinfo tools/btattach \
 			tools/btsnoop tools/btproxy tools/btiotest \
 			tools/mpris-player tools/cltest tools/seq2bseq \
-			tools/hex2hcd tools/ibeacon
+			tools/hex2hcd tools/ibeacon tools/mcaptest
 
 tools_bdaddr_SOURCES = tools/bdaddr.c src/oui.h src/oui.c
 tools_bdaddr_LDADD = lib/libbluetooth-internal.la @UDEV_LIBS@
@@ -344,6 +344,11 @@ tools_ibeacon_SOURCES = tools/ibeacon.c monitor/bt.h \
 				src/shared/queue.h src/shared/queue.c \
 				src/shared/ringbuf.h src/shared/ringbuf.c
 
+tools_mcaptest_SOURCES = tools/mcaptest.c \
+				src/log.c btio/btio.c \
+				android/mcap-lib.h android/mcap-lib.c
+tools_mcaptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+
 EXTRA_DIST += tools/bdaddr.1
 endif
 
diff --git a/tools/mcaptest.c b/tools/mcaptest.c
new file mode 100644
index 0000000..cc2d9cd
--- /dev/null
+++ b/tools/mcaptest.c
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

