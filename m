Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 23/35] tools/mgmt-tester: LE only Start discovery (Device Found)
Date: Wed, 12 Jun 2013 08:57:09 -0400
Message-Id: <1371041841-21793-24-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test will start a LE only discovery and verifies the following:
- LE scan enable command is received, and
- Device found event is received.
---
 tools/mgmt-tester.c |  142 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 139 insertions(+), 3 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index d36b50c..4bf3235 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -29,6 +29,11 @@
 
 #include <glib.h>
 
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/hci_lib.h>
+#include <bluetooth/l2cap.h>
+
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
 
@@ -167,8 +172,118 @@ static void read_info_callback(uint8_t status, uint16_t length,
 	tester_pre_setup_complete();
 }
 
-static void setup_powered_callback(uint8_t status, uint16_t length,
-					const void *param, void *user_data);
+static gboolean received_adv_hci_event(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	char buf[1 + HCI_EVENT_HDR_SIZE + EVT_CMD_COMPLETE_SIZE + 1], *ptr;
+	evt_cmd_complete *cc;
+	hci_event_hdr *hdr;
+	uint8_t status;
+	gsize len;
+
+	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
+		goto failed;
+
+	if (g_io_channel_read_chars(io, (gchar *) buf, sizeof(buf), &len,
+						NULL) != G_IO_STATUS_NORMAL)
+		goto failed;
+
+	if (len != sizeof(buf))
+		goto failed;
+
+	ptr = buf + 1;
+	hdr = (void *) ptr;
+	if (hdr->evt != EVT_CMD_COMPLETE ||
+					hdr->plen != EVT_CMD_COMPLETE_SIZE + 1)
+		goto failed;
+
+	ptr += HCI_EVENT_HDR_SIZE;
+	cc = (void *) ptr;
+	if (btohs(cc->opcode) != cmd_opcode_pack(OGF_LE_CTL,
+						OCF_LE_SET_ADVERTISE_ENABLE))
+		goto failed;
+
+	ptr += EVT_CMD_COMPLETE_SIZE;
+	status = *ptr;
+	if (status != 0)
+		goto failed;
+
+	tester_setup_complete();
+
+	return FALSE;
+
+failed:
+	tester_setup_failed();
+
+	return FALSE;
+}
+
+static int enable_le_advertising(int hdev)
+{
+	le_set_advertise_enable_cp adv_cp;
+	struct hci_filter nf;
+	GIOChannel *channel;
+	uint16_t opcode;
+	int dd;
+
+	dd = hci_open_dev(hdev);
+	if (dd < 0) {
+		tester_warn("Could not open device");
+		return -1;
+	}
+
+	hci_filter_clear(&nf);
+	hci_filter_set_ptype(HCI_EVENT_PKT, &nf);
+	hci_filter_set_event(EVT_CMD_COMPLETE, &nf);
+	opcode = htobs(cmd_opcode_pack(OGF_LE_CTL,
+						OCF_LE_SET_ADVERTISE_ENABLE));
+	hci_filter_set_opcode(opcode, &nf);
+	if (setsockopt(dd, SOL_HCI, HCI_FILTER, &nf, sizeof(nf)) < 0) {
+		tester_warn("Error setting the socket filter");
+		return -1;
+	}
+
+	channel = g_io_channel_unix_new(dd);
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	g_io_channel_set_encoding(channel, NULL, NULL);
+	g_io_channel_set_buffered(channel, FALSE);
+
+	g_io_add_watch_full(channel, G_PRIORITY_DEFAULT,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				received_adv_hci_event, NULL, NULL);
+
+	g_io_channel_unref(channel);
+
+	adv_cp.enable = 0x01;
+	if (hci_send_cmd(dd, OGF_LE_CTL, OCF_LE_SET_ADVERTISE_ENABLE,
+						sizeof(adv_cp), &adv_cp) < 0) {
+		tester_warn("Error sending LE ADV Enable command");
+		return -1;
+	}
+
+	return 0;
+}
+
+static void setup_adv_powered_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("Controller powered on");
+
+	if (data->hciemu_type == HCIEMU_TYPE_BREDR) {
+		tester_setup_complete();
+		return;
+	}
+
+	if (enable_le_advertising(data->mgmt_index_second) < 0)
+		tester_setup_failed();
+}
 
 static void second_powered_discoverable()
 {
@@ -188,7 +303,7 @@ static void second_powered_discoverable()
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index_second,
 					sizeof(con_param), con_param,
-					setup_powered_callback, NULL, NULL);
+					setup_adv_powered_callback, NULL, NULL);
 }
 
 static void index_added_callback(uint16_t index, uint16_t length,
@@ -1121,6 +1236,9 @@ static const char start_discovery_inq_param[] = { 0x33, 0x8b, 0x9e, 0x08,
 static const char start_device_found_evt[] = { 0x00, 0x00, 0x02, 0x01, 0xaa,
 			0x00, 0x00, 0xc4, 0x03, 0x00, 0x00, 0x00, 0x05, 0x00,
 			0x04, 0x0d, 0x00, 0x00, 0x00, };
+static const char start_le_device_found_evt[] = { 0x00, 0x00, 0x02, 0x01, 0xaa,
+			0x00, 0x01, 0x7f, 0x00, 0x00, 0x00, 0x00, 0x06, 0x00,
+			0x02, 0x01, 0x06, 0x02, 0x0a, 0x00, };
 
 static const struct generic_data start_discovery_not_powered_test_1 = {
 	.send_opcode = MGMT_OP_START_DISCOVERY,
@@ -1188,6 +1306,21 @@ static const struct generic_data start_discovery_valid_param_test_3 = {
 	.expect_alt_ev_len = sizeof(start_device_found_evt),
 };
 
+static const struct generic_data start_discovery_valid_param_test_4 = {
+	.send_opcode = MGMT_OP_START_DISCOVERY,
+	.send_param = start_discovery_le_param,
+	.send_len = sizeof(start_discovery_le_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = start_discovery_le_param,
+	.expect_len = sizeof(start_discovery_le_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+	.expect_hci_param = start_discovery_valid_hci,
+	.expect_hci_len = sizeof(start_discovery_valid_hci),
+	.expect_alt_ev = MGMT_EV_DEVICE_FOUND,
+	.expect_alt_ev_param = start_le_device_found_evt,
+	.expect_alt_ev_len = sizeof(start_le_device_found_evt),
+};
+
 static const char stop_discovery_bredrle_param[] = { 0x07 };
 static const char stop_discovery_bredrle_invalid_param[] = { 0x06 };
 static const char stop_discovery_valid_hci[] = { 0x00, 0x00 };
@@ -2811,6 +2944,9 @@ int main(int argc, char *argv[])
 	test_bredr("Start Discovery (Device Found) - Success 3",
 				&start_discovery_valid_param_test_3,
 				setup_le_powered, test_command_generic);
+	test_le("Start Discovery (Device Found) - Success 4",
+				&start_discovery_valid_param_test_4,
+				setup_le_powered, test_command_generic);
 
 	test_bredrle("Stop Discovery - Success 1",
 				&stop_discovery_success_test_1,
-- 
1.7.9.5

