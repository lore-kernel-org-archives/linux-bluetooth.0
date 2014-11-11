Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 1/8] tools/btgatt-server: Introduce btgatt-server.
Date: Tue, 11 Nov 2014 13:39:40 -0800
Message-Id: <1415741987-22272-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1415741987-22272-1-git-send-email-armansito@chromium.org>
References: <1415741987-22272-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces tools/btgatt-server, which is a command-line tool
for testing and debugging shared/gatt-server.
---
 .gitignore            |   1 +
 Makefile.tools        |   8 +++
 tools/btgatt-server.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 tools/btgatt-server.c

diff --git a/.gitignore b/.gitignore
index 164cc97..82304b0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -75,6 +75,7 @@ tools/3dsp
 tools/obexctl
 tools/gatt-service
 tools/btgatt-client
+tools/btgatt-server
 tools/mcaptest
 test/sap_client.pyc
 test/bluezutils.pyc
diff --git a/Makefile.tools b/Makefile.tools
index 75a6faa..4bd683b 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -207,6 +207,14 @@ EXTRA_DIST += tools/hciattach.1 tools/hciconfig.1 \
 			tools/sdptool.1 tools/ciptool.1 tools/bccmd.1
 endif
 
+if TOOLS
+bin_PROGRAMS += tools/btgatt-server
+
+tools_btgatt_server_SOURCES = tools/btgatt-server.c src/uuid-helper.c
+tools_btgatt_server_LDADD = lib/libbluetooth-internal.la \
+						src/libshared-mainloop.la
+endif
+
 if HID2HCI
 udevdir = @UDEV_DIR@
 
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
new file mode 100644
index 0000000..4508de2
--- /dev/null
+++ b/tools/btgatt-server.c
@@ -0,0 +1,139 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Google Inc.
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
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <getopt.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/hci_lib.h>
+#include <bluetooth/l2cap.h>
+#include "lib/uuid.h"
+
+static bool verbose = false;
+
+static void usage(void)
+{
+	printf("btgatt-server\n");
+	printf("Usage:\n\tbtgatt-server [options]\n");
+
+	printf("Options:\n"
+		"\t-i, --index <id>\t\tSpecify adapter index, e.g. hci0\n"
+		"\t-m, --mtu <mtu>\t\t\tThe ATT MTU to use\n"
+		"\t-s, --security-level <sec>\tSet security level (low|"
+								"medium|high)\n"
+		"\t-v, --verbose\t\t\tEnable extra logging\n"
+		"\t-h, --help\t\t\tDisplay help\n");
+}
+
+static struct option main_options[] = {
+	{ "index",		1, 0, 'i' },
+	{ "mtu",		1, 0, 'm' },
+	{ "security-level",	1, 0, 's' },
+	{ "verbose",		0, 0, 'v' },
+	{ "help",		0, 0, 'h' },
+	{ }
+};
+
+int main(int argc, char *argv[])
+{
+	int opt;
+	int sec = BT_SECURITY_LOW;
+	uint16_t mtu = 0;
+	bdaddr_t src_addr;
+	int dev_id = -1;
+
+	while ((opt = getopt_long(argc, argv, "+hvs:m:i:",
+						main_options, NULL)) != -1) {
+		switch (opt) {
+		case 'h':
+			usage();
+			return EXIT_SUCCESS;
+		case 'v':
+			verbose = true;
+			break;
+		case 's':
+			if (strcmp(optarg, "low") == 0)
+				sec = BT_SECURITY_LOW;
+			else if (strcmp(optarg, "medium") == 0)
+				sec = BT_SECURITY_MEDIUM;
+			else if (strcmp(optarg, "high") == 0)
+				sec = BT_SECURITY_HIGH;
+			else {
+				fprintf(stderr, "Invalid security level\n");
+				return EXIT_FAILURE;
+			}
+			break;
+		case 'm': {
+			int arg;
+
+			arg = atoi(optarg);
+			if (arg <= 0) {
+				fprintf(stderr, "Invalid MTU: %d\n", arg);
+				return EXIT_FAILURE;
+			}
+
+			if (arg > UINT16_MAX) {
+				fprintf(stderr, "MTU too large: %d\n", arg);
+				return EXIT_FAILURE;
+			}
+
+			mtu = (uint16_t)arg;
+			break;
+		}
+		case 'i':
+			dev_id = hci_devid(optarg);
+			if (dev_id < 0) {
+				perror("Invalid adapter");
+				return EXIT_FAILURE;
+			}
+
+			break;
+		default:
+			fprintf(stderr, "Invalid option: %c\n", opt);
+			return EXIT_FAILURE;
+		}
+	}
+
+	argc -= optind;
+	argv -= optind;
+	optind = 0;
+
+	if (argc) {
+		usage();
+		return EXIT_SUCCESS;
+	}
+
+	if (dev_id == -1)
+		bacpy(&src_addr, BDADDR_ANY);
+	else if (hci_devba(dev_id, &src_addr) < 0) {
+		perror("Adapter not available");
+		return EXIT_FAILURE;
+	}
+
+	/* TODO: Set up mainloop and listening LE socket */
+
+	return 0;
+}
-- 
2.1.0.rc2.206.gedb03e5

