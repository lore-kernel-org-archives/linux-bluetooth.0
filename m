Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 03/10] tools/btatt: Add command-line tool for ATT protocol testing.
Date: Mon,  5 May 2014 21:45:56 -0700
Message-Id: <1399351563-25991-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1399351563-25991-1-git-send-email-armansito@chromium.org>
References: <1399351563-25991-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initial commit for tools/btatt. Added basic command line options parsing
and added the tool to Makefile.tools as experimental.
---
 Makefile.tools |  10 +++-
 tools/btatt.c  | 151 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 160 insertions(+), 1 deletion(-)
 create mode 100644 tools/btatt.c

diff --git a/Makefile.tools b/Makefile.tools
index 40f076b..13f6691 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -278,7 +278,7 @@ noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
 			tools/btmgmt tools/btinfo tools/btattach \
 			tools/btsnoop tools/btproxy tools/btiotest \
 			tools/mpris-player tools/cltest tools/seq2bseq \
-			tools/ibeacon
+			tools/ibeacon tools/btatt
 
 tools_bdaddr_SOURCES = tools/bdaddr.c src/oui.h src/oui.c
 tools_bdaddr_LDADD = lib/libbluetooth-internal.la @UDEV_LIBS@
@@ -342,6 +342,14 @@ tools_ibeacon_SOURCES = tools/ibeacon.c monitor/bt.h \
 				src/shared/queue.h src/shared/queue.c \
 				src/shared/ringbuf.h src/shared/ringbuf.c
 
+tools_btatt_SOURCES = tools/btatt.c src/uuid-helper.c \
+				monitor/mainloop.h monitor/mainloop.c \
+				src/shared/io.h src/shared/io-mainloop.c \
+				src/shared/queue.h src/shared/queue.c \
+				src/shared/util.h src/shared/util.c \
+				src/shared/att.h src/shared/att.c
+tools_btatt_LDADD = lib/libbluetooth-internal.la
+
 EXTRA_DIST += tools/bdaddr.1
 endif
 
diff --git a/tools/btatt.c b/tools/btatt.c
new file mode 100644
index 0000000..5287f42
--- /dev/null
+++ b/tools/btatt.c
@@ -0,0 +1,151 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
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
+#include <stdbool.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <getopt.h>
+#include <string.h>
+
+#include <bluetooth/bluetooth.h>
+
+#include "monitor/mainloop.h"
+#include "src/shared/att.h"
+
+#define ATT_CID 4
+
+static bool verbose = false;
+
+static struct {
+	char *cmd;
+	void (*func)(struct bt_att *att, int argc, char **argv);
+	char *doc;
+} command[] = {
+	{ }
+};
+
+static void usage(void)
+{
+	int i;
+
+	printf("btatt\n");
+	printf("Usage:\n"
+		"\tbtatt [options] <command> [command parameters]\n");
+
+	printf("Options:\n"
+		"\t-i, --index <id>\tSpecify adapter index, e.g. hci0\n"
+		"\t-d, --dest <addr>\tSpecify the destination address\n"
+		"\t-t, --type [random|public] \tSpecify the LE address type\n"
+		"\t-v, --verbose\tEnable extra logging\n"
+		"\t-h, --help\tDisplay help\n");
+
+	printf("Commands:\n");
+	for (i = 0; command[i].cmd; i++)
+		printf("\t%-15s\t%s\n", command[i].cmd, command[i].doc);
+
+	printf("\n"
+		"For more information on the usage of each command use:\n"
+		"\tbtatt <command> --help\n" );
+}
+
+static struct option main_options[] = {
+	{ "index",	1, 0, 'i' },
+	{ "dest",	1, 0, 'd' },
+	{ "type",	1, 0, 't' },
+	{ "verbose",	0, 0, 'v' },
+	{ "help",	0, 0, 'h' },
+	{ 0, 0, 0, 0}
+};
+
+int main(int argc, char *argv[])
+{
+	int opt, i;
+	int dev_id = -1;
+	bool dest_given = false;
+	uint8_t dest_type = BDADDR_LE_PUBLIC;
+	bdaddr_t src_addr, dst_addr;
+	int fd;
+
+	while ((opt = getopt_long(argc, argv, "+hvt:i:d:",
+						main_options, NULL)) != -1) {
+		switch (opt) {
+		case 'i':
+			dev_id = hci_devid(optarg);
+			if (dev_id < 0) {
+				perror("Invalid adapter");
+				return EXIT_FAILURE;
+			}
+			break;
+		case 'd':
+			if (str2ba(optarg, &dst_addr) < 0) {
+				fprintf(stderr, "Invalid destination address\n");
+				return EXIT_FAILURE;
+			}
+			dest_given = true;
+			break;
+		case 't':
+			if (strcmp(optarg, "random") == 0)
+				dest_type = BDADDR_LE_RANDOM;
+			else if (strcmp(optarg, "public") == 0)
+				dest_type = BDADDR_LE_PUBLIC;
+			else {
+				fprintf(stderr, "Allowed types: random, public\n");
+				return EXIT_FAILURE;
+			}
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		case 'h':
+			usage();
+			return 0;
+		default:
+			break;
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+	optind = 0;
+
+	if (argc < 1) {
+		usage();
+		return 0;
+	}
+
+	if (dev_id == -1)
+		bacpy(&src_addr, BDADDR_ANY);
+	else if (hci_devba(dev_id, &src_addr) < 0) {
+		perror("Adapter not available");
+		return EXIT_FAILURE;
+	}
+
+	if (!dest_given) {
+		fprintf(stderr, "Destination address required\n");
+		return EXIT_FAILURE;
+	}
+
+	return 0;
+}
-- 
1.9.1.423.g4596e3a

