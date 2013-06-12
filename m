Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 34/35] tools/mgmt-tester: Interleaved stop discovery (BR/EDR dev. found)
Date: Wed, 12 Jun 2013 08:57:20 -0400
Message-Id: <1371041841-21793-35-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test will check the stop interleaved discovery during inquiry. For
this, it verifies the following:
- LE Set Scan Enable HCI command is received,
- Device found event (with BR/EDR device) is received,
- Inquiry cancel is received, and
- Stop discovery is succeed.
---
 tools/mgmt-tester.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 92ae2ea..b995076 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1441,6 +1441,24 @@ static const struct generic_data stop_discovery_bredrle_success_test_5 = {
 	.expect_alt_ev_len = sizeof(start_le_device_found_evt),
 };
 
+static const struct generic_data stop_discovery_bredrle_success_test_6 = {
+	.hciemu_type_second = HCIEMU_TYPE_BREDR,
+	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+	.setup_expect_hci_param = start_discovery_valid_hci,
+	.setup_expect_hci_len = sizeof(start_discovery_valid_hci),
+	.block_hci_command = BT_HCI_EVT_INQUIRY_COMPLETE,
+	.send_opcode = MGMT_OP_STOP_DISCOVERY,
+	.send_param = stop_discovery_bredrle_param,
+	.send_len = sizeof(stop_discovery_bredrle_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = stop_discovery_bredrle_param,
+	.expect_len = sizeof(stop_discovery_bredrle_param),
+	.expect_hci_command = BT_HCI_CMD_INQUIRY_CANCEL,
+	.expect_alt_ev = MGMT_EV_DEVICE_FOUND,
+	.expect_alt_ev_param = stop_device_found_bredr_evt,
+	.expect_alt_ev_len = sizeof(stop_device_found_bredr_evt),
+};
+
 static const struct generic_data stop_discovery_rejected_test_1 = {
 	.send_opcode = MGMT_OP_STOP_DISCOVERY,
 	.send_param = stop_discovery_bredrle_param,
@@ -2740,6 +2758,21 @@ static void command_generic_event_alt(uint16_t index, uint16_t length,
 	if (test->expect_hci_command == BT_HCI_CMD_REMOTE_NAME_REQUEST_CANCEL) {
 		test_add_condition(data);
 		send_confirm_name();
+	} else if (test->setup_expect_hci_param) {
+		const char bredrle_param[] = { 0x07 };
+
+		/* Interleaved discovery */
+		if (memcmp(test->send_param, bredrle_param,
+							test->send_len) == 0) {
+			tester_print("Sending command 0x%04x (interleaved)",
+							test->send_opcode);
+
+			mgmt_send(data->mgmt, test->send_opcode,
+					data->mgmt_index,
+					test->send_len, test->send_param,
+					command_generic_callback, NULL, NULL);
+			test_add_condition(data);
+		}
 	}
 
 	mgmt_unregister(data->mgmt_alt, data->mgmt_alt_ev_id);
@@ -2864,6 +2897,14 @@ static void start_discovery_callback(uint8_t status, uint16_t length,
 	tester_print("Discovery started");
 
 	if (test->expect_hci_command != BT_HCI_CMD_REMOTE_NAME_REQUEST_CANCEL) {
+		const char bredrle_param[] = { 0x07 };
+
+		/* If interleaved discovery was started, only send opcode after
+		 * device found event */
+		if (test->setup_expect_hci_param && (memcmp(test->send_param,
+					bredrle_param, test->send_len) == 0))
+				return;
+
 		tester_print("Sending command 0x%04x", test->send_opcode);
 
 		mgmt_send(data->mgmt, test->send_opcode, data->mgmt_index,
@@ -3214,6 +3255,9 @@ int main(int argc, char *argv[])
 	test_bredrle("Stop discovery (Device Found) - Success 5",
 				&stop_discovery_bredrle_success_test_5,
 				setup_le_powered, test_command_start_discovery);
+	test_bredrle("Stop discovery (Device Found) - Success 6",
+				&stop_discovery_bredrle_success_test_6,
+				setup_le_powered, test_command_start_discovery);
 	test_bredrle("Stop Discovery - Rejected 1",
 				&stop_discovery_rejected_test_1,
 				setup_le_powered, test_command_generic);
-- 
1.7.9.5

