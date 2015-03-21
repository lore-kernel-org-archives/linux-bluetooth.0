Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 4/6] tools/mgmt-tester: Add Advertising scan response test cases
Date: Fri, 20 Mar 2015 19:52:56 -0700
Message-Id: <1426906378-14804-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1426906378-14804-1-git-send-email-armansito@chromium.org>
References: <1426906378-14804-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds Scan Response Data related test cases for the Add
Advertising command.
---
 tools/mgmt-tester.c | 146 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 144 insertions(+), 2 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 1648dc8..aebcd90 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -3782,8 +3782,16 @@ static const struct generic_data remove_device_success_5 = {
 
 static const uint8_t add_advertising_param_1[] = {
 	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
-	0x03, 0x03, 0x0d, 0x18,
+	0x03, 0x02, 0x0d, 0x18,
+	0x04, 0xff, 0x01, 0x02, 0x03,
+};
+
+static const uint8_t add_advertising_param_2[] = {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x0a,
+	0x03, 0x02, 0x0d, 0x18,
 	0x04, 0xff, 0x01, 0x02, 0x03,
+	0x03, 0x19, 0x40, 0x03,
+	0x05, 0x03, 0x0d, 0x18, 0x0f, 0x18,
 };
 
 static const uint8_t advertising_instance_param[] = {
@@ -3791,7 +3799,7 @@ static const uint8_t advertising_instance_param[] = {
 };
 
 static const uint8_t set_adv_data_1[] = {
-	0x09, 0x03, 0x03, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
+	0x09, 0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00,
@@ -3818,6 +3826,13 @@ static const uint8_t set_adv_data_4[] = {
 	0x00, 0x00,
 };
 
+static const uint8_t set_scan_rsp_1[] = {
+	0x0a, 0x03, 0x19, 0x40, 0x03, 0x05, 0x03, 0x0d, 0x18, 0x0f,
+	0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00,
+};
+
 static const uint8_t add_advertising_invalid_param_1[] = {
 	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00,
 	0x03, 0x03, 0x0d, 0x18,
@@ -3852,6 +3867,40 @@ static const uint8_t add_advertising_invalid_param_5[] = {
 	0x15, 0x16, 0x17, 0x18,
 };
 
+static const uint8_t add_advertising_invalid_param_6[] = {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20,
+	0x03, 0x03, 0x0d, 0x18,
+	0x19, 0xff, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09,
+	0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13, 0x14,
+	0x15, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e,
+};
+
+static const uint8_t add_advertising_invalid_param_7[] = {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09,
+	0x04, 0x03, 0x0d, 0x18,
+	0x04, 0xff, 0x01, 0x02, 0x03,
+};
+
+static const uint8_t add_advertising_invalid_param_8[] = {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09,
+	0x03, 0x03, 0x0d, 0x18,
+	0x02, 0xff, 0x01, 0x02, 0x03,
+};
+
+static const uint8_t add_advertising_invalid_param_9[] = {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09,
+	0x03, 0x03, 0x0d, 0x18,
+	0x05, 0xff, 0x01, 0x02, 0x03,
+};
+
+static const uint8_t add_advertising_invalid_param_10[] = {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1D,
+	0x03, 0x03, 0x0d, 0x18,
+	0x19, 0xff, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09,
+	0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13, 0x14,
+	0x15, 0x16, 0x17, 0x18,
+};
+
 static const struct generic_data add_advertising_fail_1 = {
 	.setup_settings = settings_powered,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
@@ -3900,6 +3949,46 @@ static const struct generic_data add_advertising_fail_6 = {
 	.expect_status = MGMT_STATUS_INVALID_PARAMS,
 };
 
+static const struct generic_data add_advertising_fail_7 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_invalid_param_6,
+	.send_len = sizeof(add_advertising_invalid_param_6),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data add_advertising_fail_8 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_invalid_param_7,
+	.send_len = sizeof(add_advertising_invalid_param_7),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data add_advertising_fail_9 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_invalid_param_8,
+	.send_len = sizeof(add_advertising_invalid_param_8),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data add_advertising_fail_10 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_invalid_param_9,
+	.send_len = sizeof(add_advertising_invalid_param_9),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data add_advertising_fail_11 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_invalid_param_10,
+	.send_len = sizeof(add_advertising_invalid_param_10),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
 static const struct generic_data add_advertising_success_1 = {
 	.setup_settings = settings_powered_le,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
@@ -3970,6 +4059,38 @@ static const struct generic_data add_advertising_success_5 = {
 	.expect_hci_len = sizeof(set_adv_data_3),
 };
 
+static const struct generic_data add_advertising_success_6 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_2,
+	.send_len = sizeof(add_advertising_param_2),
+	.expect_param = advertising_instance_param,
+	.expect_len = sizeof(advertising_instance_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_ADVERTISING_ADDED,
+	.expect_alt_ev_param = advertising_instance_param,
+	.expect_alt_ev_len = sizeof(advertising_instance_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
+	.expect_hci_param = set_adv_data_1,
+	.expect_hci_len = sizeof(set_adv_data_1),
+};
+
+static const struct generic_data add_advertising_success_7 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_2,
+	.send_len = sizeof(add_advertising_param_2),
+	.expect_param = advertising_instance_param,
+	.expect_len = sizeof(advertising_instance_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_ADVERTISING_ADDED,
+	.expect_alt_ev_param = advertising_instance_param,
+	.expect_alt_ev_len = sizeof(advertising_instance_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_1,
+	.expect_hci_len = sizeof(set_scan_rsp_1),
+};
+
 static const uint8_t remove_advertising_param_1[] = {
 	0x01,
 };
@@ -5823,6 +5944,21 @@ int main(int argc, char *argv[])
 	test_le("Add Advertising - Invalid Params 5 (AD too long)",
 					&add_advertising_fail_6,
 					NULL, test_command_generic);
+	test_bredrle("Add Advertising - Invalid Params 6 (ScRsp too long)",
+					&add_advertising_fail_7,
+					NULL, test_command_generic);
+	test_bredrle("Add Advertising - Invalid Params 7 (Malformed len)",
+					&add_advertising_fail_8,
+					NULL, test_command_generic);
+	test_bredrle("Add Advertising - Invalid Params 8 (Malformed len)",
+					&add_advertising_fail_9,
+					NULL, test_command_generic);
+	test_bredrle("Add Advertising - Invalid Params 9 (Malformed len)",
+					&add_advertising_fail_10,
+					NULL, test_command_generic);
+	test_le("Add Advertising - Invalid Params 10 (ScRsp too long)",
+					&add_advertising_fail_11,
+					NULL, test_command_generic);
 	test_bredrle("Add Advertising - Success 1",
 					&add_advertising_success_1,
 					NULL, test_command_generic);
@@ -5842,6 +5978,12 @@ int main(int argc, char *argv[])
 					&add_advertising_success_5,
 					setup_set_and_add_advertising,
 					test_command_generic);
+	test_bredrle("Add Advertising - Success 4",
+					&add_advertising_success_6,
+					NULL, test_command_generic);
+	test_bredrle("Add Advertising - Success 5",
+					&add_advertising_success_7,
+					NULL, test_command_generic);
 
 	test_bredrle("Remove Advertising - Invalid Params 1",
 					&remove_advertising_fail_1,
-- 
2.2.0.rc0.207.ga3a616c

