Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 29/35] tools/mgmt-tester: BR/EDR Stop discovery (Name Resolving)
Date: Wed, 12 Jun 2013 08:57:15 -0400
Message-Id: <1371041841-21793-30-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test will check the stop BR/EDR discovery during name resolving
operation. For this, it verifies the following:
- Inquiry HCI command is received,
- Device found event is received,
- Remote name request cancel is received, and
- Stop discovery is succeed.
---
 tools/mgmt-tester.c |   97 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 3 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 64f18c1..da05b4f 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1332,6 +1332,8 @@ static const char stop_discovery_inq_param[] = { 0x33, 0x8b, 0x9e, 0x08, 0x00 };
 static const char stop_device_found_bredr_evt[] = { 0x00, 0x00, 0x02, 0x01,
 			0xaa, 0x00, 0x00, 0xc4, 0x03, 0x00, 0x00, 0x00, 0x05,
 			0x00, 0x04, 0x0d, 0x00, 0x00, 0x00, };
+static const char stop_remote_name_valid_hci[] = { 0x00, 0x00, 0x02, 0x01, 0xaa,
+			0x00 };
 
 static const struct generic_data stop_discovery_success_test_1 = {
 	.send_opcode = MGMT_OP_STOP_DISCOVERY,
@@ -1381,6 +1383,25 @@ static const struct generic_data stop_discovery_bredr_success_test_2 = {
 	.expect_alt_ev_len = sizeof(stop_device_found_bredr_evt),
 };
 
+static const struct generic_data stop_discovery_bredr_success_test_3 = {
+	.setup_expect_hci_command = BT_HCI_CMD_INQUIRY,
+	.setup_expect_hci_param = stop_discovery_inq_param,
+	.setup_expect_hci_len = sizeof(stop_discovery_inq_param),
+	.block_hci_command = BT_HCI_EVT_INQUIRY_COMPLETE,
+	.send_opcode = MGMT_OP_STOP_DISCOVERY,
+	.send_param = stop_discovery_bredr_param,
+	.send_len = sizeof(stop_discovery_bredr_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = stop_discovery_bredr_param,
+	.expect_len = sizeof(stop_discovery_bredr_param),
+	.expect_hci_command = BT_HCI_CMD_REMOTE_NAME_REQUEST_CANCEL,
+	.expect_hci_param = stop_remote_name_valid_hci,
+	.expect_hci_len = sizeof(stop_remote_name_valid_hci),
+	.expect_alt_ev = MGMT_EV_DEVICE_FOUND,
+	.expect_alt_ev_param = stop_device_found_bredr_evt,
+	.expect_alt_ev_len = sizeof(stop_device_found_bredr_evt),
+};
+
 static const struct generic_data stop_discovery_rejected_test_1 = {
 	.send_opcode = MGMT_OP_STOP_DISCOVERY,
 	.send_param = stop_discovery_bredrle_param,
@@ -2593,6 +2614,65 @@ static void command_generic_callback(uint8_t status, uint16_t length,
 	test_condition_complete(data);
 }
 
+static bool block_name_complete_callback(const void *data, uint16_t len,
+								void *user_data)
+{
+	struct test_data *tdata = tester_get_data();
+
+	tester_print("Interrupt HCI Command 0x%04x length %u",
+				BT_HCI_EVT_REMOTE_NAME_REQUEST_COMPLETE, len);
+
+	hciemu_del_hook(tdata->hciemu, HCIEMU_HOOK_POST_EVT,
+				BT_HCI_EVT_REMOTE_NAME_REQUEST_COMPLETE);
+
+	return false;
+}
+
+static void confirm_name_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_warn("Error sending confirm name, status 0x%02x",
+									status);
+		tester_test_failed();
+		return;
+	}
+
+	tester_print("Confirm name sent status %u", status);
+
+	tester_print("Registering hook to stop HCI command 0x%04x",
+				BT_HCI_EVT_REMOTE_NAME_REQUEST_COMPLETE);
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_EVT,
+			BT_HCI_EVT_REMOTE_NAME_REQUEST_COMPLETE,
+			block_name_complete_callback,
+			NULL);
+
+	hciemu_send_packet(data->hciemu);
+
+	tester_print("Sending command 0x%04x", test->send_opcode);
+
+	mgmt_send(data->mgmt, test->send_opcode, data->mgmt_index,
+					test->send_len, test->send_param,
+					command_generic_callback, NULL, NULL);
+	test_add_condition(data);
+}
+
+static void send_confirm_name()
+{
+	struct test_data *tdata = tester_get_data();
+	const char param[] = { 0x00, 0x00, 0x02, 0x01, 0xaa, 0x00, 0x00, 0x00 };
+
+	tester_print("Send confirm name");
+	mgmt_reply(tdata->mgmt, MGMT_OP_CONFIRM_NAME, tdata->mgmt_index,
+					sizeof(param), param,
+					confirm_name_callback, NULL, NULL);
+
+	test_condition_complete(tdata);
+}
+
 static void command_generic_event_alt(uint16_t index, uint16_t length,
 							const void *param,
 							void *user_data)
@@ -2616,6 +2696,11 @@ static void command_generic_event_alt(uint16_t index, uint16_t length,
 	tester_print("Unregistering %s notification",
 					mgmt_evstr(test->expect_alt_ev));
 
+	if (test->expect_hci_command == BT_HCI_CMD_REMOTE_NAME_REQUEST_CANCEL) {
+		test_add_condition(data);
+		send_confirm_name();
+	}
+
 	mgmt_unregister(data->mgmt_alt, data->mgmt_alt_ev_id);
 
 	test_condition_complete(data);
@@ -2737,11 +2822,14 @@ static void start_discovery_callback(uint8_t status, uint16_t length,
 
 	tester_print("Discovery started");
 
-	tester_print("Sending command 0x%04x", test->send_opcode);
-	mgmt_send(data->mgmt, test->send_opcode, data->mgmt_index,
+	if (test->expect_hci_command != BT_HCI_CMD_REMOTE_NAME_REQUEST_CANCEL) {
+		tester_print("Sending command 0x%04x", test->send_opcode);
+
+		mgmt_send(data->mgmt, test->send_opcode, data->mgmt_index,
 					test->send_len, test->send_param,
 					command_generic_callback, NULL, NULL);
-	test_add_condition(data);
+		test_add_condition(data);
+	}
 }
 
 static void hook_stop_hci_command(const void *test_data)
@@ -3076,6 +3164,9 @@ int main(int argc, char *argv[])
 	test_bredr("Stop Discovery (Device Found) - Success 2",
 				&stop_discovery_bredr_success_test_2,
 				setup_le_powered, test_command_start_discovery);
+	test_bredr("Stop Discovery (Name Resolving) - Success 3",
+				&stop_discovery_bredr_success_test_3,
+				setup_le_powered, test_command_start_discovery);
 	test_bredrle("Stop Discovery - Rejected 1",
 				&stop_discovery_rejected_test_1,
 				setup_le_powered, test_command_generic);
-- 
1.7.9.5

