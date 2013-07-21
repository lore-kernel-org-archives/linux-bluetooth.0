Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 8/8] tools/mgmt-tester: Add stop discovery for BR/EDR only
Date: Sat, 20 Jul 2013 20:17:20 -0400
Message-Id: <1374365840-14651-9-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1374365840-14651-1-git-send-email-bruna.moreira@openbossa.org>
References: <1374365840-14651-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Send stop command during inquiry. Check if inquiry cancel is sent and
discovering event is disabled.
---
 tools/mgmt-tester.c |   72 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 844f7db..2222ca9 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -352,6 +352,9 @@ static void controller_setup(const void *test_data)
 }
 
 struct generic_data {
+	uint16_t setup_expect_hci_command;
+	const void *setup_expect_hci_param;
+	uint8_t setup_expect_hci_len;
 	bool send_index_none;
 	uint16_t send_opcode;
 	const void *send_param;
@@ -1125,6 +1128,9 @@ static const char stop_discovery_bredrle_param[] = { 0x07 };
 static const char stop_discovery_bredrle_invalid_param[] = { 0x06 };
 static const char stop_discovery_valid_hci[] = { 0x00, 0x00 };
 static const char stop_discovery_evt[] = { 0x07, 0x00 };
+static const char stop_discovery_bredr_param[] = { 0x01 };
+static const char stop_discovery_bredr_discovering[] = { 0x01, 0x00 };
+static const char stop_discovery_inq_param[] = { 0x33, 0x8b, 0x9e, 0x08, 0x00 };
 
 static const struct generic_data stop_discovery_success_test_1 = {
 	.send_opcode = MGMT_OP_STOP_DISCOVERY,
@@ -1141,6 +1147,22 @@ static const struct generic_data stop_discovery_success_test_1 = {
 	.expect_alt_ev_len = sizeof(stop_discovery_evt),
 };
 
+static const struct generic_data stop_discovery_bredr_success_test_1 = {
+	.setup_expect_hci_command = BT_HCI_CMD_INQUIRY,
+	.setup_expect_hci_param = stop_discovery_inq_param,
+	.setup_expect_hci_len = sizeof(stop_discovery_inq_param),
+	.send_opcode = MGMT_OP_STOP_DISCOVERY,
+	.send_param = stop_discovery_bredr_param,
+	.send_len = sizeof(stop_discovery_bredr_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = stop_discovery_bredr_param,
+	.expect_len = sizeof(stop_discovery_bredr_param),
+	.expect_hci_command = BT_HCI_CMD_INQUIRY_CANCEL,
+	.expect_alt_ev = MGMT_EV_DISCOVERING,
+	.expect_alt_ev_param = stop_discovery_bredr_discovering,
+	.expect_alt_ev_len = sizeof(stop_discovery_bredr_discovering),
+};
+
 static const struct generic_data stop_discovery_rejected_test_1 = {
 	.send_opcode = MGMT_OP_STOP_DISCOVERY,
 	.send_param = stop_discovery_bredrle_param,
@@ -1833,11 +1855,41 @@ static void setup_discovery_callback(uint8_t status, uint16_t length,
 	tester_setup_complete();
 }
 
+static bool setup_command_hci_callback(const void *data, uint16_t len,
+								void *user_data)
+{
+	struct test_data *tdata = tester_get_data();
+	const struct generic_data *test = tdata->test_data;
+
+	tester_print("HCI Command 0x%04x length %u (setup)",
+					test->setup_expect_hci_command, len);
+
+	if (len != test->setup_expect_hci_len) {
+		tester_warn("Invalid parameter size for HCI command (setup)");
+		tester_setup_failed();
+		goto done;
+	}
+
+	if (memcmp(data, test->setup_expect_hci_param, len) != 0) {
+		tester_warn("Unexpected HCI command parameter value (setup)");
+		tester_setup_failed();
+		goto done;
+	}
+
+	tester_setup_complete();
+
+done:
+	hciemu_del_hook(tdata->hciemu, HCIEMU_HOOK_PRE_EVT,
+			test->setup_expect_hci_command);
+
+	return false;
+}
+
 static void setup_start_discovery_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	struct test_data *data = tester_get_data();
-	unsigned char disc_param[] = { 0x07 };
+	const struct generic_data *test = data->test_data;
 
 	if (status != MGMT_STATUS_SUCCESS) {
 		tester_setup_failed();
@@ -1846,9 +1898,22 @@ static void setup_start_discovery_callback(uint8_t status, uint16_t length,
 
 	tester_print("Controller powered on");
 
-	mgmt_send(data->mgmt, MGMT_OP_START_DISCOVERY, data->mgmt_index,
+	if (test->setup_expect_hci_command) {
+		tester_print("Registering HCI command callback (setup)");
+		hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT,
+				test->setup_expect_hci_command,
+				setup_command_hci_callback,
+				NULL);
+		mgmt_send(data->mgmt, MGMT_OP_START_DISCOVERY, data->mgmt_index,
+				test->send_len, test->send_param,
+				NULL, NULL, NULL);
+	} else {
+		unsigned char disc_param[] = { 0x07 };
+
+		mgmt_send(data->mgmt, MGMT_OP_START_DISCOVERY, data->mgmt_index,
 					sizeof(disc_param), disc_param,
 					setup_discovery_callback, NULL, NULL);
+	}
 
 	if (option_wait_powered)
 		tester_wait(1, NULL, NULL);
@@ -2653,6 +2718,9 @@ int main(int argc, char *argv[])
 	test_bredrle("Stop Discovery - Success 1",
 				&stop_discovery_success_test_1,
 				setup_start_discovery, test_command_generic);
+	test_bredr("Stop Discovery - BR/EDR (Inquiry) Success 1",
+				&stop_discovery_bredr_success_test_1,
+				setup_start_discovery, test_command_generic);
 	test_bredrle("Stop Discovery - Rejected 1",
 				&stop_discovery_rejected_test_1,
 				setup_le_powered, test_command_generic);
-- 
1.7.9.5

