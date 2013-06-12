Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 25/35] tools/mgmt-tester: BR/EDR Stop discovery (Device Found)
Date: Wed, 12 Jun 2013 08:57:11 -0400
Message-Id: <1371041841-21793-26-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test will check the stop BR/EDR discovery (inquiry). For this, it
verifies the following:
- Inquiry HCI command is received,
- Device found event is received, and
- Stop discovery is succeed.
---
 tools/mgmt-tester.c |  115 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 2 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 313feff..d53f94e 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -514,6 +514,7 @@ struct generic_data {
 	uint16_t setup_expect_hci_command;
 	const void *setup_expect_hci_param;
 	uint8_t setup_expect_hci_len;
+	uint16_t block_hci_command;
 	bool send_index_none;
 	uint16_t send_opcode;
 	const void *send_param;
@@ -1328,6 +1329,9 @@ static const char stop_discovery_evt[] = { 0x07, 0x00 };
 static const char stop_discovery_bredr_param[] = { 0x01 };
 static const char stop_discovery_bredr_discovering[] = { 0x01, 0x00 };
 static const char stop_discovery_inq_param[] = { 0x33, 0x8b, 0x9e, 0x08, 0x00 };
+static const char stop_device_found_bredr_evt[] = { 0x00, 0x00, 0x02, 0x01,
+			0xaa, 0x00, 0x00, 0xc4, 0x03, 0x00, 0x00, 0x00, 0x05,
+			0x00, 0x04, 0x0d, 0x00, 0x00, 0x00, };
 
 static const struct generic_data stop_discovery_success_test_1 = {
 	.send_opcode = MGMT_OP_STOP_DISCOVERY,
@@ -1360,6 +1364,23 @@ static const struct generic_data stop_discovery_bredr_success_test_1 = {
 	.expect_alt_ev_len = sizeof(stop_discovery_bredr_discovering),
 };
 
+static const struct generic_data stop_discovery_bredr_success_test_2 = {
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
+	.expect_hci_command = BT_HCI_CMD_INQUIRY_CANCEL,
+	.expect_alt_ev = MGMT_EV_DEVICE_FOUND,
+	.expect_alt_ev_param = stop_device_found_bredr_evt,
+	.expect_alt_ev_len = sizeof(stop_device_found_bredr_evt),
+};
+
 static const struct generic_data stop_discovery_rejected_test_1 = {
 	.send_opcode = MGMT_OP_STOP_DISCOVERY,
 	.send_param = stop_discovery_bredrle_param,
@@ -2085,6 +2106,7 @@ static bool setup_command_hci_callback(const void *data, uint16_t len,
 {
 	struct test_data *tdata = tester_get_data();
 	const struct generic_data *test = tdata->test_data;
+	bool *is_setup = user_data;
 
 	tester_print("HCI Command 0x%04x length %u (setup)",
 					test->setup_expect_hci_command, len);
@@ -2101,7 +2123,14 @@ static bool setup_command_hci_callback(const void *data, uint16_t len,
 		goto done;
 	}
 
-	tester_setup_complete();
+	if (is_setup && *is_setup)
+		tester_setup_complete();
+	else {
+		test_condition_complete(tdata);
+		hciemu_del_hook(tdata->hciemu, HCIEMU_HOOK_PRE_EVT,
+					test->setup_expect_hci_command);
+		return true;
+	}
 
 done:
 	hciemu_del_hook(tdata->hciemu, HCIEMU_HOOK_PRE_EVT,
@@ -2124,11 +2153,13 @@ static void setup_start_discovery_callback(uint8_t status, uint16_t length,
 	tester_print("Controller powered on");
 
 	if (test->setup_expect_hci_command) {
+		static bool is_setup = true;
+
 		tester_print("Registering HCI command callback (setup)");
 		hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT,
 				test->setup_expect_hci_command,
 				setup_command_hci_callback,
-				NULL);
+				&is_setup);
 		mgmt_send(data->mgmt, MGMT_OP_START_DISCOVERY, data->mgmt_index,
 				test->send_len, test->send_param,
 				NULL, NULL, NULL);
@@ -2675,6 +2706,83 @@ static void test_command_generic(const void *test_data)
 	test_add_condition(data);
 }
 
+static bool stop_command_hci_callback(const void *data, uint16_t len,
+								void *user_data)
+{
+	struct test_data *tdata = tester_get_data();
+	const struct generic_data *test = tdata->test_data;
+
+	tester_print("Interrupt HCI Command 0x%04x length %u",
+						test->block_hci_command, len);
+
+	test_condition_complete(tdata);
+
+	hciemu_del_hook(tdata->hciemu, HCIEMU_HOOK_POST_EVT,
+						test->block_hci_command);
+
+	return false;
+}
+
+static void start_discovery_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_warn("Error starting discovery");
+		tester_test_failed();
+		return;
+	}
+
+	tester_print("Discovery started");
+
+	tester_print("Sending command 0x%04x", test->send_opcode);
+	mgmt_send(data->mgmt, test->send_opcode, data->mgmt_index,
+					test->send_len, test->send_param,
+					command_generic_callback, NULL, NULL);
+	test_add_condition(data);
+}
+
+static void hook_stop_hci_command(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+
+	if (test->block_hci_command) {
+		tester_print("Registering hook to stop HCI command 0x%04x",
+						test->block_hci_command);
+		hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_EVT,
+				test->block_hci_command,
+				stop_command_hci_callback,
+				NULL);
+		test_add_condition(data);
+	}
+}
+
+static void test_command_start_discovery(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	uint16_t index;
+
+	index = test->send_index_none ? MGMT_INDEX_NONE : data->mgmt_index;
+
+	setup_test_command_generic(test_data);
+
+	tester_print("Registering HCI command callback (second)");
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT,
+			test->setup_expect_hci_command,
+			setup_command_hci_callback,
+			NULL);
+	test_add_condition(data);
+
+	hook_stop_hci_command(test_data);
+
+	mgmt_send(data->mgmt, MGMT_OP_START_DISCOVERY, index, test->send_len,
+			test->send_param, start_discovery_callback, NULL, NULL);
+}
+
 static GOptionEntry options[] = {
 	{ "wait-powered", 'P', 0, G_OPTION_ARG_NONE, &option_wait_powered,
 					"Add a delay after powering on" },
@@ -2965,6 +3073,9 @@ int main(int argc, char *argv[])
 	test_bredr("Stop Discovery - BR/EDR (Inquiry) Success 1",
 				&stop_discovery_bredr_success_test_1,
 				setup_start_discovery, test_command_generic);
+	test_bredr("Stop Discovery (Device Found) - Success 2",
+				&stop_discovery_bredr_success_test_2,
+				setup_le_powered, test_command_start_discovery);
 	test_bredrle("Stop Discovery - Rejected 1",
 				&stop_discovery_rejected_test_1,
 				setup_le_powered, test_command_generic);
-- 
1.7.9.5

