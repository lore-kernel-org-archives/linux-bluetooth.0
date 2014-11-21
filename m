Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v4 3/3] mgmt-tester: Add service discovery test cases
Date: Fri, 21 Nov 2014 10:25:32 -0800
Message-Id: <1416594332-18068-3-git-send-email-jpawlowski@google.com>
In-Reply-To: <1416594332-18068-1-git-send-email-jpawlowski@google.com>
References: <1416594332-18068-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 tools/btmgmt.c      |   2 +-
 tools/mgmt-tester.c | 176 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 1ee42e2..881d482 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1553,7 +1553,7 @@ static void find_service_rsp(uint8_t status, uint16_t len, const void *param,
 	if (status != 0) {
 		fprintf(stderr,
 			"Unable to start service discovery. status 0x%02x (%s)\n",
-						status, mgmt_errstr(status));
+			status, mgmt_errstr(status));
 		mainloop_quit();
 		return;
 	}
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 7d14fe4..22e5335 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1802,6 +1802,150 @@ static const struct generic_data stop_discovery_invalid_param_test_1 = {
 	.expect_len = sizeof(stop_discovery_bredrle_invalid_param),
 };
 
+static const char start_service_discovery_invalid_param[] = { 0x00, 0x00, 0x00 };
+static const char start_service_discovery_invalid_resp[] = { 0x00 };
+static const char start_service_discovery_bredr_param[] = { 0x01, 0x00, 0x00};
+static const char start_service_discovery_bredr_resp[] = { 0x01 };
+static const char start_service_discovery_le_param[] = { 0x06, 0x01, 0x00, 0xfa,
+			0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
+			0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+static const char start_service_discovery_le_resp[] = { 0x06 };
+static const char start_service_discovery_bredrle_param[] = { 0x07, 0x01, 0x00, 0xfa,
+			0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
+			0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+static const char start_service_discovery_bredrle_resp[] = { 0x07 };
+static const char start_service_discovery_valid_hci[] = { 0x01, 0x01 };
+static const char start_service_discovery_evt[] = { 0x07, 0x01 };
+static const char start_service_discovery_le_evt[] = { 0x06, 0x01 };
+
+static const struct generic_data start_service_discovery_not_powered_test_1 = {
+	.send_opcode = MGMT_OP_START_SERVICE_DISCOVERY,
+	.send_param = start_service_discovery_bredr_param,
+	.send_len = sizeof(start_service_discovery_bredr_param),
+	.expect_status = MGMT_STATUS_NOT_POWERED,
+	.expect_param = start_service_discovery_bredr_resp,
+	.expect_len = sizeof(start_service_discovery_bredr_resp),
+};
+
+static const struct generic_data start_service_discovery_invalid_param_test_1 = {
+	.setup_settings = settings_powered,
+	.send_opcode = MGMT_OP_START_SERVICE_DISCOVERY,
+	.send_param = start_service_discovery_invalid_param,
+	.send_len = sizeof(start_service_discovery_invalid_param),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+	.expect_param = start_service_discovery_invalid_resp,
+	.expect_len = sizeof(start_service_discovery_invalid_resp),
+};
+
+static const struct generic_data start_service_discovery_not_supported_test_1 = {
+	.setup_settings = settings_powered,
+	.send_opcode = MGMT_OP_START_SERVICE_DISCOVERY,
+	.send_param = start_service_discovery_le_param,
+	.send_len = sizeof(start_service_discovery_le_param),
+	.expect_status = MGMT_STATUS_REJECTED,
+	.expect_param = start_service_discovery_le_resp,
+	.expect_len = sizeof(start_service_discovery_le_resp),
+};
+
+static const struct generic_data start_service_discovery_valid_param_test_1 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_START_SERVICE_DISCOVERY,
+	.send_param = start_service_discovery_bredrle_param,
+	.send_len = sizeof(start_service_discovery_bredrle_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = start_service_discovery_bredrle_resp,
+	.expect_len = sizeof(start_service_discovery_bredrle_resp),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+	.expect_hci_param = start_service_discovery_valid_hci,
+	.expect_hci_len = sizeof(start_service_discovery_valid_hci),
+	.expect_alt_ev = MGMT_EV_DISCOVERING,
+	.expect_alt_ev_param = start_service_discovery_evt,
+	.expect_alt_ev_len = sizeof(start_service_discovery_evt),
+};
+
+static const struct generic_data start_service_discovery_valid_param_test_2 = {
+	.setup_settings = settings_powered,
+	.send_opcode = MGMT_OP_START_SERVICE_DISCOVERY,
+	.send_param = start_service_discovery_le_param,
+	.send_len = sizeof(start_service_discovery_le_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = start_service_discovery_le_resp,
+	.expect_len = sizeof(start_service_discovery_le_resp),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+	.expect_hci_param = start_service_discovery_valid_hci,
+	.expect_hci_len = sizeof(start_service_discovery_valid_hci),
+	.expect_alt_ev = MGMT_EV_DISCOVERING,
+	.expect_alt_ev_param = start_service_discovery_le_evt,
+	.expect_alt_ev_len = sizeof(start_service_discovery_le_evt),
+};
+
+static const char stop_service_discovery_bredrle_param[] = { 0x07 };
+static const char stop_service_discovery_bredrle_invalid_param[] = { 0x06 };
+static const char stop_service_discovery_valid_hci[] = { 0x00, 0x00 };
+static const char stop_service_discovery_evt[] = { 0x07, 0x00 };
+static const char stop_service_discovery_bredr_param[] = { 0x01 };
+static const char stop_service_discovery_bredr_discovering[] = { 0x01, 0x00 };
+static const char stop_service_discovery_inq_param[] = { 0x33, 0x8b, 0x9e, 0x08, 0x00 };
+
+static const struct generic_data stop_service_discovery_success_test_1 = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_START_SERVICE_DISCOVERY,
+	.setup_send_param = start_service_discovery_bredrle_param,
+	.setup_send_len = sizeof(start_service_discovery_bredrle_param),
+	.send_opcode = MGMT_OP_STOP_SERVICE_DISCOVERY,
+	.send_param = stop_service_discovery_bredrle_param,
+	.send_len = sizeof(stop_service_discovery_bredrle_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = stop_service_discovery_bredrle_param,
+	.expect_len = sizeof(stop_service_discovery_bredrle_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+	.expect_hci_param = stop_service_discovery_valid_hci,
+	.expect_hci_len = sizeof(stop_service_discovery_valid_hci),
+	.expect_alt_ev = MGMT_EV_DISCOVERING,
+	.expect_alt_ev_param = stop_service_discovery_evt,
+	.expect_alt_ev_len = sizeof(stop_service_discovery_evt),
+};
+
+static const struct generic_data stop_service_discovery_bredr_success_test_1 = {
+	.setup_settings = settings_powered,
+	.setup_send_opcode = MGMT_OP_START_SERVICE_DISCOVERY,
+	.setup_send_param = start_service_discovery_bredr_param,
+	.setup_send_len = sizeof(start_service_discovery_bredr_param),
+	.send_opcode = MGMT_OP_STOP_SERVICE_DISCOVERY,
+	.send_param = stop_service_discovery_bredr_param,
+	.send_len = sizeof(stop_service_discovery_bredr_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = stop_service_discovery_bredr_param,
+	.expect_len = sizeof(stop_service_discovery_bredr_param),
+	.expect_hci_command = BT_HCI_CMD_INQUIRY_CANCEL,
+	.expect_alt_ev = MGMT_EV_DISCOVERING,
+	.expect_alt_ev_param = stop_service_discovery_bredr_discovering,
+	.expect_alt_ev_len = sizeof(stop_service_discovery_bredr_discovering),
+};
+
+static const struct generic_data stop_service_discovery_rejected_test_1 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_STOP_SERVICE_DISCOVERY,
+	.send_param = stop_service_discovery_bredrle_param,
+	.send_len = sizeof(stop_service_discovery_bredrle_param),
+	.expect_status = MGMT_STATUS_REJECTED,
+	.expect_param = stop_service_discovery_bredrle_param,
+	.expect_len = sizeof(stop_service_discovery_bredrle_param),
+};
+
+static const struct generic_data stop_service_discovery_invalid_param_test_1 = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_START_SERVICE_DISCOVERY,
+	.setup_send_param = start_service_discovery_bredrle_param,
+	.setup_send_len = sizeof(start_service_discovery_bredrle_param),
+	.send_opcode = MGMT_OP_STOP_SERVICE_DISCOVERY,
+	.send_param = stop_service_discovery_bredrle_invalid_param,
+	.send_len = sizeof(stop_service_discovery_bredrle_invalid_param),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+	.expect_param = stop_service_discovery_bredrle_invalid_param,
+	.expect_len = sizeof(stop_service_discovery_bredrle_invalid_param),
+};
+
 static const char set_dev_class_valid_param[] = { 0x01, 0x0c };
 static const char set_dev_class_zero_rsp[] = { 0x00, 0x00, 0x00 };
 static const char set_dev_class_valid_rsp[] = { 0x0c, 0x01, 0x00 };
@@ -4568,6 +4712,38 @@ int main(int argc, char *argv[])
 				&stop_discovery_invalid_param_test_1,
 				setup_start_discovery, test_command_generic);
 
+	test_bredrle("Start Service Discovery - Not powered 1",
+				&start_service_discovery_not_powered_test_1,
+				NULL, test_command_generic);
+	test_bredrle("Start Service Discovery - Invalid parameters 1",
+				&start_service_discovery_invalid_param_test_1,
+				NULL, test_command_generic);
+	test_bredrle("Start Service Discovery - Not supported 1",
+				&start_service_discovery_not_supported_test_1,
+				NULL, test_command_generic);
+	test_bredrle("Start Service Discovery - Success 1",
+				&start_service_discovery_valid_param_test_1,
+				NULL, test_command_generic);
+	test_le("Start Service Discovery - Success 2",
+				&start_service_discovery_valid_param_test_2,
+				NULL, test_command_generic);
+
+	test_bredrle("Stop Service Discovery - Success 1",
+				&stop_service_discovery_success_test_1,
+				setup_start_discovery,
+				test_command_generic);
+	test_bredr("Stop Service Discovery - BR/EDR (Inquiry) Success 1",
+				&stop_service_discovery_bredr_success_test_1,
+				setup_start_discovery,
+				test_command_generic);
+	test_bredrle("Stop Service Discovery - Rejected 1",
+				&stop_service_discovery_rejected_test_1,
+				NULL, test_command_generic);
+	test_bredrle("Stop Service Discovery - Invalid parameters 1",
+				&stop_service_discovery_invalid_param_test_1,
+				setup_start_discovery,
+				test_command_generic);
+
 	test_bredrle("Set Device Class - Success 1",
 				&set_dev_class_valid_param_test_1,
 				NULL, test_command_generic);
-- 
2.1.0.rc2.206.gedb03e5

