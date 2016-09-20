Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 3/5] tools/mgmt-tester: Test add appearance in scan rsp data
Date: Tue, 20 Sep 2016 14:02:08 +0200
Message-Id: <1474372930-9706-3-git-send-email-michal.narajowski@codecoup.pl>
In-Reply-To: <1474372930-9706-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1474372930-9706-1-git-send-email-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/mgmt-tester.c | 292 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 290 insertions(+), 2 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 547249e..8d85cd4 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4005,7 +4005,7 @@ static const struct generic_data read_adv_features_invalid_index_test = {
 };
 
 static const uint8_t read_adv_features_rsp_1[] =  {
-	0x5f, 0x00, 0x00, 0x00,	/* supported flags */
+	0x7f, 0x00, 0x00, 0x00,	/* supported flags */
 	0x1f,			/* max_adv_data_len */
 	0x1f,			/* max_scan_rsp_len */
 	0x05,			/* max_instances */
@@ -4020,7 +4020,7 @@ static const struct generic_data read_adv_features_success_1 = {
 };
 
 static const uint8_t read_adv_features_rsp_2[] =  {
-	0x5f, 0x00, 0x00, 0x00,	/* supported flags */
+	0x7f, 0x00, 0x00, 0x00,	/* supported flags */
 	0x1f,			/* max_adv_data_len */
 	0x1f,			/* max_scan_rsp_len */
 	0x05,			/* max_instances */
@@ -6329,6 +6329,264 @@ static const struct generic_data add_advertising_dta_name_scrsp = {
 	.expect_hci_len = sizeof(set_scan_rsp_data_shortened_name),
 };
 
+static const uint8_t add_advertising_param_appearance1[] = {
+	0x01,			/* adv instance */
+	0x20, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x00,			/* scan rsp len */
+};
+
+static const uint8_t set_scan_rsp_data_appearance1[] = {
+	0x04, /* Scan rsp data len */
+	0x03, /* appearance data len */
+	0x19, /* EIR_APPEARANCE */
+	0x054, 0x65, /* appearance value */
+	/* scan rsp data */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const uint8_t set_appearance_param[2] = { 0x54, 0x65 };
+
+static const struct generic_data set_appearance_not_supported = {
+	.send_opcode = MGMT_OP_SET_APPEARANCE,
+	.send_param = set_appearance_param,
+	.send_len = sizeof(set_appearance_param),
+	.expect_status = MGMT_STATUS_NOT_SUPPORTED,
+	.expect_param = NULL,
+	.expect_len = 0,
+};
+
+static const struct generic_data set_appearance_success = {
+	.send_opcode = MGMT_OP_SET_APPEARANCE,
+	.send_param = set_appearance_param,
+	.send_len = sizeof(set_appearance_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = NULL,
+	.expect_len = 0,
+};
+
+static const struct generic_data add_advertising_appearance_scrsp = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_SET_APPEARANCE,
+	.setup_send_param = set_appearance_param,
+	.setup_send_len = sizeof(set_appearance_param),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_appearance1,
+	.send_len = sizeof(add_advertising_param_appearance1),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_data_appearance1,
+	.expect_hci_len = sizeof(set_scan_rsp_data_appearance1),
+};
+
+static const uint8_t add_advertising_param_appearance2_data[] = {
+	0x01,			/* adv instance */
+	0x20, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x19,			/* scan rsp len */
+	/* scan rsp data: */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const uint8_t set_scan_rsp_data_only_data[] = {
+	0x19, /* Scan rsp data len */
+	/* scan rsp data */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00,
+	/*padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct generic_data add_advertising_appear_data_scrsp = {
+	.setup_settings = settings_powered_le,
+	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.setup_expect_hci_param = set_scan_rsp_data_only_data,
+	.setup_expect_hci_len = sizeof(set_scan_rsp_data_only_data),
+	.setup_send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.setup_send_param = add_advertising_param_appearance2_data,
+	.setup_send_len = sizeof(add_advertising_param_appearance2_data),
+	.send_opcode = MGMT_OP_SET_APPEARANCE,
+	.send_param = set_appearance_param,
+	.send_len = sizeof(set_appearance_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = NULL,
+	.expect_len = 0,
+};
+
+static const uint8_t add_advertising_param_appearance_data_too_long[] = {
+	0x01,			/* adv instance */
+	0x20, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x30,			/* scan rsp len */
+	/* adv data: */
+	/* scan rsp data: */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct generic_data add_advertising_scrsp_too_long = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_SET_APPEARANCE,
+	.setup_send_param = set_appearance_param,
+	.setup_send_len = sizeof(set_appearance_param),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_appearance_data_too_long,
+	.send_len = sizeof(add_advertising_param_appearance_data_too_long),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+	.expect_param = NULL,
+	.expect_len = 0,
+};
+
+static const struct setup_mgmt_cmd add_advertising_mgmt_cmd_arr[] = {
+	{
+		.send_opcode = MGMT_OP_SET_APPEARANCE,
+		.send_param = set_appearance_param,
+		.send_len = sizeof(set_appearance_param),
+	},
+	{
+		.send_opcode = MGMT_OP_SET_LOCAL_NAME,
+		.send_param = set_local_name_param,
+		.send_len = sizeof(set_local_name_param),
+	},
+	{ /* last element should always have opcode 0x00 */
+		.send_opcode = 0x00,
+		.send_param = NULL,
+		.send_len = 0,
+	}
+};
+
+static const uint8_t add_advertising_param_local_name_and_appearance[] = {
+	0x01,			/* adv instance */
+	0x60, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x00,			/* scan rsp len */
+};
+
+static const uint8_t set_scan_rsp_data_local_name_and_appearance[] = {
+	0x0F, /* Scan rsp data len */
+	0x03, /* Appearance data len */
+	0x19, /* EIR_APPEARANCE */
+	0x54, 0x65, /* appearance value */
+	0x0A, /* Local name data len */
+	0x09, /* Complete name */
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "Test name" */
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct generic_data add_advertising_name_appear_scrsp = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = add_advertising_mgmt_cmd_arr,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_local_name_and_appearance,
+	.send_len = sizeof(add_advertising_param_local_name_and_appearance),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_data_local_name_and_appearance,
+	.expect_hci_len = sizeof(set_scan_rsp_data_local_name_and_appearance),
+};
+
+static const uint8_t add_advertising_param_local_name_and_appearance_dta[] = {
+	0x01,			/* adv instance */
+	0x60, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x15,			/* scan rsp len */
+	/* scan rsp data: */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00,
+};
+
+static const uint8_t set_scan_rsp_local_name_and_appearance_dta[] = {
+	0x1f, /* Scan rsp len */
+	0x03, /* Appearance data len */
+	0x19, /* EIR_APPEARANCE */
+	0x54, 0x65, /* appearance value */
+	/* placeholder data */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00,
+	0x05, /* Local name length */
+	0x08, /* Shortened name */
+	0x54, 0x65, 0x73, 0x74, /* "Test" */
+};
+
+static const struct generic_data add_advertising_appear_data_name = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = add_advertising_mgmt_cmd_arr,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_local_name_and_appearance_dta,
+	.send_len = sizeof(add_advertising_param_local_name_and_appearance_dta),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_local_name_and_appearance_dta,
+	.expect_hci_len = sizeof(set_scan_rsp_local_name_and_appearance_dta),
+};
+
+static const uint8_t add_advertising_param_short_name_and_appearance_dta[] = {
+	0x01,			/* adv instance */
+	0x60, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x18,			/* scan rsp len */
+	/* scan rsp data: */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+};
+
+static const uint8_t set_scan_rsp_short_name_and_appearance_dta[] = {
+	0x1f, /* Scan rsp len */
+	0x03, /* Appearance data len */
+	0x19, /* EIR_APPEARANCE */
+	0x54, 0x65, /* appearance value */
+	/* placeholder data */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x02, /* Local name data length */
+	0x08, /* Shortened name */
+	0x54, /* "T" */
+};
+
+static const struct generic_data add_advertising_appear_data_short = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = add_advertising_mgmt_cmd_arr,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_short_name_and_appearance_dta,
+	.send_len = sizeof(add_advertising_param_short_name_and_appearance_dta),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_short_name_and_appearance_dta,
+	.expect_hci_len = sizeof(set_scan_rsp_short_name_and_appearance_dta),
+};
+
 static bool power_off(uint16_t index)
 {
 	int sk, err;
@@ -7545,6 +7803,36 @@ int main(int argc, char *argv[])
 					setup_command_generic,
 					test_command_generic);
 
+	test_bredrle("Add Advertising - Success 5 (Appearance in ScRsp)",
+					&add_advertising_appearance_scrsp,
+					setup_command_generic,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Success 6 (Appear + Dta in ScRsp)",
+					&add_advertising_appear_data_scrsp,
+					setup_command_generic,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Invalid Params 1 (ScRsp Too long)",
+					&add_advertising_scrsp_too_long,
+					setup_command_generic,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Success 1 (Name + appear in ScRsp)",
+					&add_advertising_name_appear_scrsp,
+					setup_command_generic,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Success 2 (Appear + Dta + name)",
+					&add_advertising_appear_data_name,
+					setup_command_generic,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Success 3 (Appear + Dta + short)",
+					&add_advertising_appear_data_short,
+					setup_command_generic,
+					test_command_generic);
+
 
 	test_bredrle("Remove Advertising - Invalid Params 1",
 					&remove_advertising_fail_1,
-- 
2.7.4

