Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@nokia.com>
Subject: [PATCH 3/3] Add hcimgmt command line test tool
Date: Mon, 20 Sep 2010 14:07:46 +0300
Message-Id: <1284980866-3974-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1284980866-3974-1-git-send-email-johan.hedberg@gmail.com>
References: <1284980866-3974-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

---
 Makefile.tools  |    5 +-
 tools/hcimgmt.c |  413 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 417 insertions(+), 1 deletions(-)
 create mode 100644 tools/hcimgmt.c

diff --git a/Makefile.tools b/Makefile.tools
index 405a42b..f354a8c 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -5,7 +5,7 @@ conf_DATA += tools/rfcomm.conf
 endif
 
 bin_PROGRAMS += tools/rfcomm tools/l2ping \
-				tools/hcitool tools/sdptool tools/ciptool
+			tools/hcitool tools/sdptool tools/ciptool tools/hcimgmt
 
 sbin_PROGRAMS += tools/hciattach tools/hciconfig
 
@@ -36,6 +36,9 @@ tools_hcitool_SOURCES = tools/hcitool.c src/oui.h src/oui.c \
 						src/textfile.h src/textfile.c
 tools_hcitool_LDADD = lib/libbluetooth.la
 
+tools_hcimgmt_SOURCES = tools/hcimgmt.c
+tools_hcimgmt_LDADD = lib/libbluetooth.la
+
 tools_sdptool_SOURCES = tools/sdptool.c src/sdp-xml.h src/sdp-xml.c
 tools_sdptool_LDADD = lib/libbluetooth.la
 
diff --git a/tools/hcimgmt.c b/tools/hcimgmt.c
new file mode 100644
index 0000000..5276e2f
--- /dev/null
+++ b/tools/hcimgmt.c
@@ -0,0 +1,413 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010  Nokia Corporation
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
+#include <errno.h>
+#include <ctype.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <getopt.h>
+#include <sys/param.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/hci_lib.h>
+
+#define HCI_MGMT_BUF_SIZE	1024
+
+#define for_each_opt(opt, long, short) while ((opt=getopt_long(argc, argv, short ? short:"+", long, NULL)) != -1)
+
+static void usage(void);
+
+/* Display local devices */
+
+static struct option dev_options[] = {
+	{ "help",	0, 0, 'h' },
+	{0, 0, 0, 0 }
+};
+
+static int hci_open_channel(int dev_id, unsigned short channel)
+{
+	struct sockaddr_hci a;
+	int dd, err;
+
+	/* Create HCI socket */
+	dd = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	if (dd < 0)
+		return -errno;
+
+	/* Bind socket to the HCI device */
+	memset(&a, 0, sizeof(a));
+	a.hci_family = AF_BLUETOOTH;
+	a.hci_dev = dev_id;
+	a.hci_channel = channel;
+	if (bind(dd, (struct sockaddr *) &a, sizeof(a)) < 0) {
+		err = -errno;
+		goto fail;
+	}
+
+	return dd;
+
+fail:
+	close(dd);
+	return err;
+}
+
+static ssize_t hci_mgmt_cmd(int dd, uint16_t opcode, void *data, uint16_t len,
+				uint16_t rsp_ev, void *rsp, uint16_t rsp_len)
+{
+	ssize_t ret;
+	size_t copied;
+	struct hci_mgmt_hdr hdr = { htobs(opcode), htobs(len) };
+	char buf[HCI_MGMT_BUF_SIZE];
+
+	memcpy(buf, &hdr, sizeof(hdr));
+	memcpy(buf + sizeof(hdr), data, len);
+
+	ret = write(dd, buf, sizeof(hdr) + len);
+	if (ret < 0)
+		return -errno;
+
+	ret = read(dd, buf, sizeof(buf));
+	if (ret < 0)
+		return -errno;
+
+	if (ret < (ssize_t) sizeof(struct hci_mgmt_hdr)) {
+		fprintf(stderr,
+			"ret (%zd) != sizeof(struct hci_mgmt_hdr) (%zu)\n",
+					ret, sizeof(struct hci_mgmt_hdr));
+		return -EIO;
+	}
+
+	memcpy(&hdr, buf, sizeof(hdr));
+
+	if (btohs(hdr.len) != ret - sizeof(hdr)) {
+		fprintf(stderr, "hdr.len (%u) != ret - sizeof(hdr) (%zu)\n",
+					btohs(hdr.len), ret - sizeof(hdr));
+		return -EIO;
+	}
+
+	if (btohs(hdr.opcode) != rsp_ev) {
+		fprintf(stderr, "hdr.opcode (%u) != rsp_ev (%u)\n",
+						btohs(hdr.opcode), rsp_ev);
+		return -EIO;
+	}
+
+	copied = rsp_len < btohs(hdr.len) ? rsp_len : btohs(hdr.len);
+
+	memcpy(rsp, buf + sizeof(hdr), copied);
+
+	return copied;
+}
+
+static void print_bytes(uint8_t *bytes, size_t count)
+{
+	size_t i;
+
+	for (i = 0; i < count; i++)
+		printf("%02x ", bytes[i]);
+}
+
+static void cmd_features(int dev_id, int argc, char **argv)
+{
+	int dd;
+	ssize_t ret;
+	uint8_t features[8];
+	uint16_t opcode;
+	char buf[HCI_MGMT_BUF_SIZE], *ptr = buf;
+
+	dd = hci_open_channel(HCI_DEV_NONE, HCI_CHANNEL_CONTROL);
+	if (dd < 0) {
+		perror("HCI Control socket open failed");
+		exit(1);
+	}
+
+	ret = hci_mgmt_cmd(dd, HCI_MGMT_OP_READ_FEATURES, NULL, 0,
+				HCI_MGMT_EV_CMD_COMPLETE, buf, sizeof(buf));
+	if (ret < 0) {
+		fprintf(stderr, "Command failed: %s (%zd)\n",
+							strerror(-ret), -ret);
+		exit(1);
+	}
+
+	if (ret != 10) {
+		fprintf(stderr, "Too short response\n");
+		exit(1);
+	}
+
+	memcpy(&opcode, ptr, 2);
+	ptr += 2;
+
+	memcpy(features, ptr, 8);
+	ptr += 8;
+
+	printf("HCI Control API features: ");
+	print_bytes(features, 8);
+	printf("\n");
+}
+
+static void cmd_version(int dev_id, int argc, char **argv)
+{
+	int dd;
+	ssize_t ret;
+	uint8_t version;
+	uint16_t revision, opcode;
+	char buf[HCI_MGMT_BUF_SIZE], *ptr = buf;
+
+	dd = hci_open_channel(HCI_DEV_NONE, HCI_CHANNEL_CONTROL);
+	if (dd < 0) {
+		perror("HCI Control socket open failed");
+		exit(1);
+	}
+
+	ret = hci_mgmt_cmd(dd, HCI_MGMT_OP_READ_VERSION, NULL, 0,
+			HCI_MGMT_EV_CMD_COMPLETE, buf, sizeof(buf));
+	if (ret < 0) {
+		fprintf(stderr, "Command failed: %s (%zd)\n",
+							strerror(-ret), -ret);
+		exit(1);
+	}
+
+	if (ret != 5) {
+		fprintf(stderr, "Too short response\n");
+		exit(1);
+	}
+
+	memcpy(&opcode, ptr, 2);
+	ptr += 2;
+
+	version = *ptr++;
+
+	memcpy(&revision, ptr, 2);
+	ptr += 2;
+
+
+	printf("HCI Control API version %u.%u\n", version, btohs(revision));
+}
+
+static const char *dev_help =
+	"Usage:\n"
+	"\tdev\n";
+
+static void cmd_dev(int dev_id, int argc, char **argv)
+{
+	int opt, dd, i;
+	ssize_t ret;
+	uint16_t count, opcode;
+	char buf[HCI_MGMT_BUF_SIZE], *ptr = buf;
+
+	for_each_opt(opt, dev_options, NULL) {
+		switch (opt) {
+		default:
+			printf("%s", dev_help);
+			return;
+		}
+	}
+
+	dd = hci_open_channel(HCI_DEV_NONE, HCI_CHANNEL_CONTROL);
+	if (dd < 0) {
+		perror("HCI Control socket open failed");
+		exit(1);
+	}
+
+	ret = hci_mgmt_cmd(dd, HCI_MGMT_OP_READ_INDEX_LIST, NULL, 0,
+				HCI_MGMT_EV_CMD_COMPLETE, buf, sizeof(buf));
+	if (ret < 0) {
+		fprintf(stderr, "Failed\n");
+		exit(1);
+	}
+
+	if (ret < 4) {
+		fprintf(stderr, "Too short response\n");
+		exit(1);
+	}
+
+	memcpy(&opcode, ptr, 2);
+	ptr += 2;
+
+	memcpy(&count, ptr, 2);
+	ptr += 2;
+
+	printf("Devices:\n\t");
+
+	for (i = 0; i < count; i++, ptr += 2) {
+		uint16_t index;
+		memcpy(&index, ptr, 2);
+		printf("hci%u ", btohs(index));
+	}
+
+	printf("\n");
+}
+
+static void cmd_info(int dev_id, int argc, char **argv)
+{
+	int dd;
+	ssize_t ret;
+	uint8_t features[8], type, status;
+	char buf[HCI_MGMT_BUF_SIZE], *ptr = buf, addr[18];
+	uint16_t id, opcode;
+	bdaddr_t bdaddr;
+
+	dd = hci_open_channel(HCI_DEV_NONE, HCI_CHANNEL_CONTROL);
+	if (dd < 0) {
+		perror("HCI Control socket open failed");
+		exit(1);
+	}
+
+	if (dev_id < 0) {
+		dev_id = hci_get_route(NULL);
+		if (dev_id < 0) {
+			perror("Device is not available");
+			exit(1);
+		}
+	}
+
+	id = (uint16_t) dev_id;
+
+	ret = hci_mgmt_cmd(dd, HCI_MGMT_OP_READ_INFO, &id, sizeof(id),
+				HCI_MGMT_EV_CMD_COMPLETE, buf, sizeof(buf));
+	if (ret < 0) {
+		fprintf(stderr, "Command failed: %s (%zd)\n",
+							strerror(-ret), -ret);
+		exit(1);
+	}
+
+	if (ret != 20) {
+		fprintf(stderr, "Unexpected response length (%zd)\n", ret);
+		exit(1);
+	}
+
+	memcpy(&opcode, ptr, 2);
+	ptr += 2;
+
+	status = *ptr;
+	ptr++;
+
+	memcpy(&id, ptr, 2);
+	ptr += 2;
+
+	type = *ptr;
+	ptr++;
+
+	bacpy(&bdaddr, (bdaddr_t *) ptr);
+	ptr += sizeof(bdaddr);
+
+	memcpy(features, ptr, 8);
+	ptr += 8;
+
+	ba2str(&bdaddr, addr);
+
+	printf("hci%u type %u addr %s features ", btohs(id), type, addr);
+	print_bytes(features, 8);
+	printf("\n");
+}
+
+static struct {
+	char *cmd;
+	void (*func)(int dev_id, int argc, char **argv);
+	char *doc;
+} command[] = {
+	{ "dev",	cmd_dev,	"Display local devices"	},
+	{ "version",	cmd_version,	"Display version"	},
+	{ "features",	cmd_features,	"Control API features"	},
+	{ "info",	cmd_info,	"Read controller info"	},
+	{ NULL, NULL, 0 }
+};
+
+static void usage(void)
+{
+	int i;
+
+	printf("hcictl - HCI Control ver %s\n", VERSION);
+	printf("Usage:\n"
+		"\thcictl [options] <command> [command parameters]\n");
+	printf("Options:\n"
+		"\t--help\tDisplay help\n"
+		"\t-i dev\tHCI device\n");
+	printf("Commands:\n");
+	for (i = 0; command[i].cmd; i++)
+		printf("\t%-4s\t%s\n", command[i].cmd,
+		command[i].doc);
+	printf("\n"
+		"For more information on the usage of each command use:\n"
+		"\thcictl <command> --help\n" );
+}
+
+static struct option main_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ "device",	1, 0, 'i' },
+	{ 0, 0, 0, 0 }
+};
+
+int main(int argc, char *argv[])
+{
+	int opt, i, dev_id = -1;
+	bdaddr_t ba;
+
+	while ((opt=getopt_long(argc, argv, "+i:h", main_options, NULL)) != -1) {
+		switch (opt) {
+		case 'i':
+			dev_id = hci_devid(optarg);
+			if (dev_id < 0) {
+				perror("Invalid device");
+				exit(1);
+			}
+			break;
+
+		case 'h':
+		default:
+			usage();
+			exit(0);
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+	optind = 0;
+
+	if (argc < 1) {
+		usage();
+		exit(0);
+	}
+
+	if (dev_id != -1 && hci_devba(dev_id, &ba) < 0) {
+		perror("Device is not available");
+		exit(1);
+	}
+
+	for (i = 0; command[i].cmd; i++) {
+		if (strncmp(command[i].cmd, argv[0], 3))
+			continue;
+		command[i].func(dev_id, argc, argv);
+		break;
+	}
+	return 0;
+}
-- 
1.7.0.4

