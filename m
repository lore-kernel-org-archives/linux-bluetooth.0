Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 2/6] tools/mgmt-tester: Add Advertising test cases
Date: Fri, 20 Mar 2015 19:52:54 -0700
Message-Id: <1426906378-14804-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1426906378-14804-1-git-send-email-armansito@chromium.org>
References: <1426906378-14804-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added test cases for the Add Advertising command.
---
 tools/mgmt-tester.c | 346 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 346 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index e2549d4..6d334c6 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -3780,6 +3780,196 @@ static const struct generic_data remove_device_success_5 = {
 	.expect_hci_len = sizeof(set_le_scan_off),
 };
 
+static const uint8_t add_advertising_param_1[] = {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
+	0x03, 0x03, 0x0d, 0x18,
+	0x04, 0xff, 0x01, 0x02, 0x03,
+};
+
+static const uint8_t advertising_instance_param[] = {
+	0x01,
+};
+
+static const uint8_t set_adv_data_1[] = {
+	0x09, 0x03, 0x03, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00,
+};
+
+static const uint8_t set_adv_data_2[] = {
+	0x0c, 0x02, 0x01, 0x04, 0x03, 0x03, 0x0d, 0x18, 0x04, 0xff,
+	0x01, 0x02, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00,
+};
+
+static const uint8_t set_adv_data_3[] = {
+	0x06, 0x05, 0x08, 0x74, 0x65, 0x73, 0x74, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00,
+};
+
+static const uint8_t set_adv_data_4[] = {
+	0x03, 0x02, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00,
+};
+
+static const uint8_t add_advertising_invalid_param_1[] = {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00,
+	0x03, 0x03, 0x0d, 0x18,
+	0x19, 0xff, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09,
+	0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13, 0x14,
+	0x15, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e,
+};
+
+static const uint8_t add_advertising_invalid_param_2[] = {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
+	0x04, 0x03, 0x0d, 0x18,
+	0x04, 0xff, 0x01, 0x02, 0x03,
+};
+
+static const uint8_t add_advertising_invalid_param_3[] = {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
+	0x03, 0x03, 0x0d, 0x18,
+	0x02, 0xff, 0x01, 0x02, 0x03,
+};
+
+static const uint8_t add_advertising_invalid_param_4[] = {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
+	0x03, 0x03, 0x0d, 0x18,
+	0x05, 0xff, 0x01, 0x02, 0x03,
+};
+
+static const uint8_t add_advertising_invalid_param_5[] = {
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1D, 0x00,
+	0x03, 0x03, 0x0d, 0x18,
+	0x19, 0xff, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09,
+	0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13, 0x14,
+	0x15, 0x16, 0x17, 0x18,
+};
+
+static const struct generic_data add_advertising_fail_1 = {
+	.setup_settings = settings_powered,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_1,
+	.send_len = sizeof(add_advertising_param_1),
+	.expect_status = MGMT_STATUS_REJECTED,
+};
+
+static const struct generic_data add_advertising_fail_2 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_invalid_param_1,
+	.send_len = sizeof(add_advertising_invalid_param_1),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data add_advertising_fail_3 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_invalid_param_2,
+	.send_len = sizeof(add_advertising_invalid_param_2),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data add_advertising_fail_4 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_invalid_param_3,
+	.send_len = sizeof(add_advertising_invalid_param_3),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data add_advertising_fail_5 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_invalid_param_4,
+	.send_len = sizeof(add_advertising_invalid_param_4),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data add_advertising_fail_6 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_invalid_param_5,
+	.send_len = sizeof(add_advertising_invalid_param_5),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data add_advertising_success_1 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_1,
+	.send_len = sizeof(add_advertising_param_1),
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
+static const char set_powered_adv_instance_settings_param[] = {
+	0x81, 0x02, 0x00, 0x00,
+};
+
+static const struct generic_data add_advertising_success_2 = {
+	.send_opcode = MGMT_OP_SET_POWERED,
+	.send_param = set_powered_on_param,
+	.send_len = sizeof(set_powered_on_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_powered_adv_instance_settings_param,
+	.expect_len = sizeof(set_powered_adv_instance_settings_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
+	.expect_hci_param = set_adv_data_3,
+	.expect_hci_len = sizeof(set_adv_data_3),
+};
+
+static const struct generic_data add_advertising_success_3 = {
+	.send_opcode = MGMT_OP_SET_POWERED,
+	.send_param = set_powered_on_param,
+	.send_len = sizeof(set_powered_on_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_powered_adv_instance_settings_param,
+	.expect_len = sizeof(set_powered_adv_instance_settings_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_ENABLE,
+	.expect_hci_param = set_adv_on_set_adv_enable_param,
+	.expect_hci_len = sizeof(set_adv_on_set_adv_enable_param),
+};
+
+static const struct generic_data add_advertising_success_4 = {
+	.send_opcode = MGMT_OP_SET_ADVERTISING,
+	.send_param = set_adv_on_param,
+	.send_len = sizeof(set_adv_on_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_adv_settings_param_2,
+	.expect_len = sizeof(set_adv_settings_param_2),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
+	.expect_hci_param = set_adv_data_4,
+	.expect_hci_len = sizeof(set_adv_data_4),
+};
+
+static const char set_adv_off_param[] = { 0x00 };
+
+static const struct generic_data add_advertising_success_5 = {
+	.send_opcode = MGMT_OP_SET_ADVERTISING,
+	.send_param = set_adv_off_param,
+	.send_len = sizeof(set_adv_off_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_powered_adv_instance_settings_param,
+	.expect_len = sizeof(set_powered_adv_instance_settings_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
+	.expect_hci_param = set_adv_data_3,
+	.expect_hci_len = sizeof(set_adv_data_3),
+};
+
 static void client_cmd_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -4130,6 +4320,124 @@ static void setup_add_device(const void *test_data)
 					setup_powered_callback, NULL, NULL);
 }
 
+static void setup_add_advertising_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("Add Advertising setup complete");
+
+	setup_bthost();
+}
+
+static void setup_add_advertising_not_powered(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char adv_param[sizeof(*cp) + 6];
+	unsigned char param[] = { 0x01 };
+
+	tester_print("Adding advertising instance while unpowered");
+
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	memset(cp, 0, sizeof(*cp));
+
+	cp->instance = 1;
+	cp->adv_data_len = 6;
+	cp->data[0] = 0x05;
+	cp->data[1] = 0x08;
+	cp->data[2] = 't';
+	cp->data[3] = 'e';
+	cp->data[4] = 's';
+	cp->data[5] = 't';
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+						sizeof(param), &param,
+						NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
+						sizeof(adv_param), adv_param,
+						setup_add_advertising_callback,
+						NULL, NULL);
+}
+
+static void setup_add_advertising(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char adv_param[sizeof(*cp) + 6];
+	unsigned char param[] = { 0x01 };
+
+	tester_print("Adding advertising instance while unpowered");
+
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	memset(cp, 0, sizeof(*cp));
+
+	cp->instance = 1;
+	cp->adv_data_len = 6;
+	cp->data[0] = 0x05;
+	cp->data[1] = 0x08;
+	cp->data[2] = 't';
+	cp->data[3] = 'e';
+	cp->data[4] = 's';
+	cp->data[5] = 't';
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+						sizeof(param), &param,
+						NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+						sizeof(param), &param,
+						NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
+						sizeof(adv_param), adv_param,
+						setup_add_advertising_callback,
+						NULL, NULL);
+}
+
+static void setup_set_and_add_advertising(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char adv_param[sizeof(*cp) + 6];
+	unsigned char param[] = { 0x01 };
+
+	tester_print("Adding advertising instance while unpowered");
+
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	memset(cp, 0, sizeof(*cp));
+
+	cp->instance = 1;
+	cp->adv_data_len = 6;
+	cp->data[0] = 0x05;
+	cp->data[1] = 0x08;
+	cp->data[2] = 't';
+	cp->data[3] = 'e';
+	cp->data[4] = 's';
+	cp->data[5] = 't';
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+						sizeof(param), &param,
+						NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+						sizeof(param), &param,
+						NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_ADVERTISING, data->mgmt_index,
+						sizeof(param), &param,
+						NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
+						sizeof(adv_param), adv_param,
+						setup_add_advertising_callback,
+						NULL, NULL);
+}
+
 static void setup_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -5452,5 +5760,43 @@ int main(int argc, char *argv[])
 				&remove_device_success_5,
 				setup_add_device, test_command_generic);
 
+	test_bredrle("Add Advertising - Failure: LE off",
+					&add_advertising_fail_1,
+					NULL, test_command_generic);
+	test_bredrle("Add Advertising - Invalid Params 1 (AD too long)",
+					&add_advertising_fail_2,
+					NULL, test_command_generic);
+	test_bredrle("Add Advertising - Invalid Params 2 (Malformed len)",
+					&add_advertising_fail_3,
+					NULL, test_command_generic);
+	test_bredrle("Add Advertising - Invalid Params 3 (Malformed len)",
+					&add_advertising_fail_4,
+					NULL, test_command_generic);
+	test_bredrle("Add Advertising - Invalid Params 4 (Malformed len)",
+					&add_advertising_fail_5,
+					NULL, test_command_generic);
+	test_le("Add Advertising - Invalid Params 5 (AD too long)",
+					&add_advertising_fail_6,
+					NULL, test_command_generic);
+	test_bredrle("Add Advertising - Success 1",
+					&add_advertising_success_1,
+					NULL, test_command_generic);
+	test_bredrle("Add Advertising - Success 2",
+					&add_advertising_success_2,
+					setup_add_advertising_not_powered,
+					test_command_generic);
+	test_bredrle("Add Advertising - Success 3",
+					&add_advertising_success_3,
+					setup_add_advertising_not_powered,
+					test_command_generic);
+	test_bredrle("Add Advertising - Set Advertising on override 1",
+					&add_advertising_success_4,
+					setup_add_advertising,
+					test_command_generic);
+	test_bredrle("Add Advertising - Set Advertising off override 2",
+					&add_advertising_success_5,
+					setup_set_and_add_advertising,
+					test_command_generic);
+
 	return tester_run();
 }
-- 
2.2.0.rc0.207.ga3a616c

