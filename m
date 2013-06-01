Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] tools: Add initial tester tool for ioctl() on sockets
Date: Fri, 31 May 2013 23:09:00 -0400
Message-Id: <1370056140-13920-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools       |   11 +-
 tools/ioctl-tester.c |  286 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 296 insertions(+), 1 deletion(-)
 create mode 100644 tools/ioctl-tester.c

diff --git a/Makefile.tools b/Makefile.tools
index acd403e..12dfcb1 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -28,7 +28,7 @@ endif
 if EXPERIMENTAL
 noinst_PROGRAMS += emulator/btvirt emulator/b1ee \
 					tools/mgmt-tester tools/gap-tester \
-					tools/l2cap-tester
+					tools/l2cap-tester tools/ioctl-tester
 
 emulator_btvirt_SOURCES = emulator/main.c monitor/bt.h \
 					monitor/mainloop.h monitor/mainloop.c \
@@ -57,6 +57,15 @@ tools_l2cap_tester_SOURCES = tools/l2cap-tester.c monitor/bt.h \
 				src/shared/tester.h src/shared/tester.c
 tools_l2cap_tester_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
 
+tools_ioctl_tester_SOURCES = tools/ioctl-tester.c monitor/bt.h \
+				emulator/btdev.h emulator/btdev.c \
+				emulator/bthost.h emulator/bthost.c \
+				src/shared/util.h src/shared/util.c \
+				src/shared/mgmt.h src/shared/mgmt.c \
+				src/shared/hciemu.h src/shared/hciemu.c \
+				src/shared/tester.h src/shared/tester.c
+tools_ioctl_tester_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
+
 tools_gap_tester_SOURCES = $(gdbus_sources) \
 				tools/gap-tester.c monitor/bt.h \
 				emulator/btdev.h emulator/btdev.c \
diff --git a/tools/ioctl-tester.c b/tools/ioctl-tester.c
new file mode 100644
index 0000000..9f6c35a
--- /dev/null
+++ b/tools/ioctl-tester.c
@@ -0,0 +1,286 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2013  Instituto Nokia de Tecnologia - INdT
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
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/ioctl.h>
+
+#include "lib/bluetooth.h"
+#include "lib/hci.h"
+#include "lib/mgmt.h"
+
+#include "src/shared/tester.h"
+#include "src/shared/mgmt.h"
+#include "src/shared/hciemu.h"
+
+struct test_data {
+	const void *test_data;
+	struct mgmt *mgmt;
+	uint16_t mgmt_index;
+	struct hciemu *hciemu;
+	enum hciemu_type hciemu_type;
+	int sk;
+};
+
+static void mgmt_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	tester_print("%s%s", prefix, str);
+}
+
+static void read_info_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct mgmt_rp_read_info *rp = param;
+	char addr[18];
+	uint16_t manufacturer;
+	uint32_t supported_settings, current_settings;
+
+	tester_print("Read Info callback");
+	tester_print("  Status: 0x%02x", status);
+
+	if (status || !param) {
+		tester_pre_setup_failed();
+		return;
+	}
+
+	ba2str(&rp->bdaddr, addr);
+	manufacturer = btohs(rp->manufacturer);
+	supported_settings = btohl(rp->supported_settings);
+	current_settings = btohl(rp->current_settings);
+
+	tester_print("  Address: %s", addr);
+	tester_print("  Version: 0x%02x", rp->version);
+	tester_print("  Manufacturer: 0x%04x", manufacturer);
+	tester_print("  Supported settings: 0x%08x", supported_settings);
+	tester_print("  Current settings: 0x%08x", current_settings);
+	tester_print("  Class: 0x%02x%02x%02x",
+			rp->dev_class[2], rp->dev_class[1], rp->dev_class[0]);
+	tester_print("  Name: %s", rp->name);
+	tester_print("  Short name: %s", rp->short_name);
+
+	if (strcmp(hciemu_get_address(data->hciemu), addr)) {
+		tester_pre_setup_failed();
+		return;
+	}
+
+	tester_pre_setup_complete();
+}
+
+static void index_added_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	tester_print("Index Added callback");
+	tester_print("  Index: 0x%04x", index);
+
+	data->mgmt_index = index;
+
+	mgmt_send(data->mgmt, MGMT_OP_READ_INFO, data->mgmt_index, 0, NULL,
+					read_info_callback, NULL, NULL);
+}
+
+static void index_removed_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	tester_print("Index Removed callback");
+	tester_print("  Index: 0x%04x", index);
+
+	if (index != data->mgmt_index)
+		return;
+
+	mgmt_unregister_index(data->mgmt, data->mgmt_index);
+
+	mgmt_unref(data->mgmt);
+	data->mgmt = NULL;
+
+	tester_post_teardown_complete();
+}
+
+static void read_index_list_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	tester_print("Read Index List callback");
+	tester_print("  Status: 0x%02x", status);
+
+	if (status || !param) {
+		tester_pre_setup_failed();
+		return;
+	}
+
+	mgmt_register(data->mgmt, MGMT_EV_INDEX_ADDED, MGMT_INDEX_NONE,
+					index_added_callback, NULL, NULL);
+
+	mgmt_register(data->mgmt, MGMT_EV_INDEX_REMOVED, MGMT_INDEX_NONE,
+					index_removed_callback, NULL, NULL);
+
+	data->hciemu = hciemu_new(HCIEMU_TYPE_BREDRLE);
+	if (!data->hciemu) {
+		tester_warn("Failed to setup HCI emulation");
+		tester_pre_setup_failed();
+	}
+
+	tester_print("New hciemu instance created");
+}
+
+static void test_pre_setup(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	data->mgmt = mgmt_new_default();
+	if (!data->mgmt) {
+		tester_warn("Failed to setup management interface");
+		tester_pre_setup_failed();
+		return;
+	}
+
+	if (tester_use_debug())
+		mgmt_set_debug(data->mgmt, mgmt_debug, "mgmt: ", NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0, NULL,
+					read_index_list_callback, NULL, NULL);
+}
+
+static void test_post_teardown(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	hciemu_unref(data->hciemu);
+	data->hciemu = NULL;
+}
+
+static void test_data_free(void *test_data)
+{
+	struct test_data *data = test_data;
+
+	close(data->sk);
+
+	free(data);
+}
+
+#define test_ioctl(name, data, setup, func) \
+	do { \
+		struct test_data *user; \
+		user = malloc(sizeof(struct test_data)); \
+		if (!user) \
+			break; \
+		user->hciemu_type = HCIEMU_TYPE_BREDRLE; \
+		user->test_data = data; \
+		tester_add_full(name, data, \
+				test_pre_setup, setup, func, NULL, \
+				test_post_teardown, 2, user, test_data_free); \
+	} while (0)
+
+static void setup_socket(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	data->sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	if (data->sk < 0) {
+		tester_warn("Can't create raw socket: %s (%d)", strerror(errno),
+									errno);
+		tester_setup_failed();
+	}
+
+	tester_setup_complete();
+}
+
+static void test_aclmtu_success(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct hci_dev_req dr;
+	uint16_t mtu, mpkt;
+
+	dr.dev_id = data->mgmt_index;
+	mpkt = 1;
+	mtu = 48;
+	dr.dev_opt = htobl(htobs(mpkt) | (htobs(mtu) << 16));
+	if (ioctl(data->sk, HCISETACLMTU, (unsigned long) &dr) < 0) {
+		tester_warn("Can't set ACL MTU (index %d): %s (%d)",
+					data->mgmt_index, strerror(errno),
+					errno);
+		tester_test_failed();
+	}
+
+	tester_test_passed();
+}
+
+static void test_aclmtu_invalid_mtu(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct hci_dev_req dr;
+	uint16_t mtu, mpkt;
+
+	dr.dev_id = data->mgmt_index;
+	mpkt = 1;
+	mtu = 0;
+	dr.dev_opt = htobl(htobs(mpkt) | (htobs(mtu) << 16));
+	if (ioctl(data->sk, HCISETACLMTU, (unsigned long) &dr) < 0)
+		tester_test_passed();
+	else
+		tester_test_failed();
+}
+
+static void test_aclmtu_invalid_mpkt(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct hci_dev_req dr;
+	uint16_t mtu, mpkt;
+
+	dr.dev_id = data->mgmt_index;
+	mpkt = 0;
+	mtu = 48;
+	dr.dev_opt = htobl(htobs(mpkt) | (htobs(mtu) << 16));
+	if (ioctl(data->sk, HCISETACLMTU, (unsigned long) &dr) < 0)
+		tester_test_passed();
+	else
+		tester_test_failed();
+}
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+
+	test_ioctl("ioctl(HCISETACLMTU) - Success", NULL, setup_socket,
+							test_aclmtu_success);
+	test_ioctl("ioctl(HCISETACLMTU) - Invalid MTU", NULL, setup_socket,
+						test_aclmtu_invalid_mtu);
+	test_ioctl("ioctl(HCISETACLMTU) - Invalid max. number of packets",
+						NULL, setup_socket,
+						test_aclmtu_invalid_mpkt);
+
+	return tester_run();
+}
-- 
1.7.9.5

