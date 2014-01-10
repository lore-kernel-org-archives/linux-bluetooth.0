Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 02/19] tools/rfcomm-tester: Add basic rfcomm test case
Date: Fri, 10 Jan 2014 10:18:12 +0100
Message-Id: <1389345509-27206-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test case verifies creating rfcomm socket.
---
 Makefile.tools        |  11 ++-
 tools/rfcomm-tester.c | 249 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 258 insertions(+), 2 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 07fbd80..93ff354 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -80,8 +80,15 @@ tools_l2cap_tester_SOURCES = tools/l2cap-tester.c monitor/bt.h \
 				src/shared/tester.h src/shared/tester.c
 tools_l2cap_tester_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
-tools_rfcomm_tester_SOURCES = tools/rfcomm-tester.c src/shared/tester.h \
-				src/shared/tester.c
+tools_rfcomm_tester_SOURCES = tools/rfcomm-tester.c monitor/bt.h \
+				emulator/btdev.h emulator/btdev.c \
+				emulator/bthost.h emulator/bthost.c \
+				src/shared/io.h src/shared/io-glib.c \
+				src/shared/queue.h src/shared/queue.c \
+				src/shared/util.h src/shared/util.c \
+				src/shared/mgmt.h src/shared/mgmt.c \
+				src/shared/hciemu.h src/shared/hciemu.c \
+				src/shared/tester.h src/shared/tester.c
 tools_rfcomm_tester_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
 tools_smp_tester_SOURCES = tools/smp-tester.c monitor/bt.h \
diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 200d953..a4f1c8e 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -25,12 +25,261 @@
 #include <config.h>
 #endif
 
+#include <stdlib.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdbool.h>
+
 #include <glib.h>
+
+#include "lib/bluetooth.h"
+#include "lib/mgmt.h"
+
+#include "monitor/bt.h"
+#include "emulator/bthost.h"
+
 #include "src/shared/tester.h"
+#include "src/shared/mgmt.h"
+#include "src/shared/hciemu.h"
+
+struct test_data {
+	struct mgmt *mgmt;
+	uint16_t mgmt_index;
+	struct hciemu *hciemu;
+	enum hciemu_type hciemu_type;
+	const void *test_data;
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
+	data->hciemu = hciemu_new(data->hciemu_type);
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
+	free(data);
+}
+
+static void client_connectable_complete(uint16_t opcode, uint8_t status,
+					const void *param, uint8_t len,
+					void *user_data)
+{
+	switch (opcode) {
+	case BT_HCI_CMD_WRITE_SCAN_ENABLE:
+		break;
+	default:
+		return;
+	}
+
+	tester_print("Client set connectable status 0x%02x", status);
+
+	if (status)
+		tester_setup_failed();
+	else
+		tester_setup_complete();
+}
+
+static void setup_powered_client_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("Controller powered on");
+
+	bthost = hciemu_client_get_host(data->hciemu);
+	bthost_set_cmd_complete_cb(bthost, client_connectable_complete, data);
+	bthost_write_scan_enable(bthost, 0x03);
+}
+
+static void setup_powered_client(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+
+	tester_print("Powering on controller");
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_SSP, data->mgmt_index,
+				sizeof(param), param, NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+			sizeof(param), param, setup_powered_client_callback,
+			NULL, NULL);
+}
+
+static void test_basic(const void *test_data)
+{
+	int sk;
+
+	sk = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
+	if (sk < 0) {
+		tester_warn("Can't create socket: %s (%d)", strerror(errno),
+									errno);
+		tester_test_failed();
+		return;
+	}
+
+	close(sk);
+
+	tester_test_passed();
+}
+
+#define test_rfcomm(name, data, setup, func) \
+	do { \
+		struct test_data *user; \
+		user = malloc(sizeof(struct test_data)); \
+		if (!user) \
+			break; \
+		user->hciemu_type = HCIEMU_TYPE_BREDR; \
+		user->test_data = data; \
+		tester_add_full(name, data, \
+				test_pre_setup, setup, func, NULL, \
+				test_post_teardown, 2, user, test_data_free); \
+	} while (0)
 
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
 
+	test_rfcomm("Basic RFCOMM Socket - Success", NULL,
+					setup_powered_client, test_basic);
+
 	return tester_run();
 }
-- 
1.8.3.1

