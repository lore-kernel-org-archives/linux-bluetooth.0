Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 1/7] tools/btgatt-client: Introduce tools/btgatt-client
Date: Sat, 30 Aug 2014 09:02:43 -0700
Message-Id: <1409414569-20068-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1409414569-20068-1-git-send-email-armansito@chromium.org>
References: <1409414569-20068-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is the initial commit for tools/btgatt-client.c, a command line tool to
interactively test and debug shared/gatt-client.
---
 Makefile.tools        |  13 ++-
 tools/btgatt-client.c | 218 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 230 insertions(+), 1 deletion(-)
 create mode 100644 tools/btgatt-client.c

diff --git a/Makefile.tools b/Makefile.tools
index 3616a46..bf637e2 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -179,7 +179,7 @@ if TOOLS
 bin_PROGRAMS += tools/hciattach tools/hciconfig tools/hcitool tools/hcidump \
 			tools/rfcomm tools/rctest tools/l2test tools/l2ping \
 			tools/sdptool tools/ciptool tools/bccmd \
-			tools/bluemoon tools/mpris-proxy
+			tools/bluemoon tools/mpris-proxy tools/btgatt-client
 
 tools_hciattach_SOURCES = tools/hciattach.c tools/hciattach.h \
 						tools/hciattach_st.c \
@@ -254,6 +254,17 @@ tools_bluemoon_SOURCES = tools/bluemoon.c monitor/bt.h \
 tools_mpris_proxy_SOURCES = tools/mpris-proxy.c
 tools_mpris_proxy_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@
 
+tools_btgatt_client_SOURCES = tools/btgatt-client.c src/uuid-helper.c \
+				monitor/mainloop.h monitor/mainloop.c \
+				src/shared/io.h src/shared/io-mainloop.c \
+				src/shared/queue.h src/shared/queue.c \
+				src/shared/util.h src/shared/util.c \
+				src/shared/timeout.h src/shared/timeout-mainloop.c \
+				src/shared/att-types.h src/shared/att.h src/shared/att.c \
+				src/shared/gatt-helpers.h src/shared/gatt-helpers.c \
+				src/shared/gatt-client.h src/shared/gatt-client.c
+tools_btgatt_client_LDADD = lib/libbluetooth-internal.la
+
 dist_man_MANS += tools/hciattach.1 tools/hciconfig.1 \
 			tools/hcitool.1 tools/hcidump.1 \
 			tools/rfcomm.1 tools/rctest.1 tools/l2ping.1 \
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
new file mode 100644
index 0000000..a5ce70b
--- /dev/null
+++ b/tools/btgatt-client.c
@@ -0,0 +1,218 @@
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
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <getopt.h>
+#include <limits.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/hci_lib.h>
+
+#include "monitor/mainloop.h"
+
+static bool verbose = false;
+
+static void print_prompt(void)
+{
+	printf("[GATT client]# ");
+	fflush(stdout);
+}
+
+static void prompt_read_cb(int fd, uint32_t events, void *user_data)
+{
+	size_t len = 0;
+	char *line = NULL;
+
+	if (events & (EPOLLRDHUP | EPOLLHUP | EPOLLERR)) {
+		mainloop_quit();
+		return;
+	}
+
+	if (getline(&line, &len, stdin) == -1)
+		return;
+
+	/* TODO: Process commands here */
+	printf("  Typed line: %s\n", line);
+	print_prompt();
+
+	free(line);
+}
+
+static void usage(void)
+{
+	printf("btgatt-client\n");
+	printf("Usage:\n\tbtgatt-client [options]\n");
+
+	printf("Options:\n"
+		"\t-i, --index <id>\t\tSpecify adapter index, e.g. hci0\n"
+		"\t-d, --dest <addr>\t\tSpecify the destination address\n"
+		"\t-t, --type [random|public] \tSpecify the LE address type\n"
+		"\t-m, --mtu <mtu> \t\tThe ATT MTU to use\n"
+		"\t-s, --security-level <sec> \tSet security level (low|"
+								"medium|high)\n"
+		"\t-v, --verbose\t\t\tEnable extra logging\n"
+		"\t-h, --help\t\t\tDisplay help\n");
+}
+
+static struct option main_options[] = {
+	{ "index",		1, 0, 'i' },
+	{ "dest",		1, 0, 'd' },
+	{ "type",		1, 0, 't' },
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
+	int sec;
+	uint16_t mtu = 0;
+	uint8_t dst_type = BDADDR_LE_PUBLIC;
+	bool dst_addr_given = false;
+	bdaddr_t src_addr, dst_addr;
+	int dev_id = -1;
+
+	while ((opt = getopt_long(argc, argv, "+hvs:m:t:d:i:",
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
+		case 't':
+			if (strcmp(optarg, "random") == 0)
+				dst_type = BDADDR_LE_RANDOM;
+			else if (strcmp(optarg, "public") == 0)
+				dst_type = BDADDR_LE_PUBLIC;
+			else {
+				fprintf(stderr,
+					"Allowed types: random, public\n");
+				return EXIT_FAILURE;
+			}
+			break;
+		case 'd':
+			if (str2ba(optarg, &dst_addr) < 0) {
+				fprintf(stderr, "Invalid remote address: %s\n",
+									optarg);
+				return EXIT_FAILURE;
+			}
+
+			dst_addr_given = true;
+			break;
+
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
+	if (!argc) {
+		usage();
+		return EXIT_SUCCESS;
+	}
+
+	argc -= optind;
+	argv += optind;
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
+	if (!dst_addr_given) {
+		fprintf(stderr, "Destination address required!\n");
+		return EXIT_FAILURE;
+	}
+
+	mainloop_init();
+
+	if (mainloop_add_fd(fileno(stdin),
+				EPOLLIN | EPOLLRDHUP | EPOLLHUP | EPOLLERR,
+				prompt_read_cb, NULL, NULL) < 0) {
+		fprintf(stderr, "Failed to initialize console\n");
+		return EXIT_FAILURE;
+	}
+
+	print_prompt();
+
+	mainloop_run();
+
+	return EXIT_SUCCESS;
+}
-- 
2.1.0.rc2.206.gedb03e5

