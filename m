Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v2 2/4] tools/mgmt-tester: Test appearance in default scan rsp data
Date: Tue, 18 Oct 2016 15:12:06 +0200
Message-Id: <1476796328-14808-2-git-send-email-michal.narajowski@codecoup.pl>
In-Reply-To: <1476796328-14808-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1476796328-14808-1-git-send-email-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/mgmt-tester.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 121 insertions(+), 5 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 8929e09..e6904e8 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1708,6 +1708,110 @@ static const struct generic_data set_adv_on_rejected_test_1 = {
 	.expect_status = MGMT_STATUS_REJECTED,
 };
 
+static const uint8_t set_adv_set_appearance_param[2] = { 0x54, 0x65 };
+
+static const uint8_t set_adv_scan_rsp_data_appear_1[] = {
+	0x04, /* Scan rsp data len */
+	0x03, /* Local name data len */
+	0x19, /* Complete name */
+	0x54, 0x65,
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct generic_data set_adv_on_appearance_test_1 = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_SET_APPEARANCE,
+	.setup_send_param = set_adv_set_appearance_param,
+	.setup_send_len = sizeof(set_adv_set_appearance_param),
+	.send_opcode = MGMT_OP_SET_ADVERTISING,
+	.send_param = set_adv_on_param,
+	.expect_param = set_adv_settings_param_2,
+	.expect_len = sizeof(set_adv_settings_param_2),
+	.send_len = sizeof(set_adv_on_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_adv_scan_rsp_data_appear_1,
+	.expect_hci_len = sizeof(set_adv_scan_rsp_data_appear_1),
+};
+
+static const char set_adv_set_local_name_param[260] = { 'T', 'e', 's', 't', ' ',
+							'n', 'a', 'm', 'e' };
+
+static const uint8_t set_adv_scan_rsp_data_name_1[] = {
+	0x0b, /* Scan rsp data len */
+	0x0a, /* Local name data len */
+	0x09, /* Complete name */
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "Test name" */
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct generic_data set_adv_on_local_name_test_1 = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = set_adv_set_local_name_param,
+	.setup_send_len = sizeof(set_adv_set_local_name_param),
+	.send_opcode = MGMT_OP_SET_ADVERTISING,
+	.send_param = set_adv_on_param,
+	.expect_param = set_adv_settings_param_2,
+	.expect_len = sizeof(set_adv_settings_param_2),
+	.send_len = sizeof(set_adv_on_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_adv_scan_rsp_data_name_1,
+	.expect_hci_len = sizeof(set_adv_scan_rsp_data_name_1),
+};
+
+static const struct setup_mgmt_cmd set_advertising_mgmt_cmd_arr[] = {
+	{
+		.send_opcode = MGMT_OP_SET_APPEARANCE,
+		.send_param = set_adv_set_appearance_param,
+		.send_len = sizeof(set_adv_set_appearance_param),
+	},
+	{
+		.send_opcode = MGMT_OP_SET_LOCAL_NAME,
+		.send_param = set_adv_set_local_name_param,
+		.send_len = sizeof(set_adv_set_local_name_param),
+	},
+	{ /* last element should always have opcode 0x00 */
+		.send_opcode = 0x00,
+		.send_param = NULL,
+		.send_len = 0,
+	}
+};
+
+static const uint8_t set_adv_scan_rsp_data_name_and_appearance[] = {
+	0x0f, /* scan rsp data len */
+	0x03, /* appearance data len */
+	0x19, /* eir_appearance */
+	0x54, 0x65, /* appearance value */
+	0x0a, /* local name data len */
+	0x09, /* complete name */
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "test name" */
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+
+static const struct generic_data set_adv_on_local_name_appear_test_1 = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = set_advertising_mgmt_cmd_arr,
+	.send_opcode = MGMT_OP_SET_ADVERTISING,
+	.send_param = set_adv_on_param,
+	.expect_param = set_adv_settings_param_2,
+	.expect_len = sizeof(set_adv_settings_param_2),
+	.send_len = sizeof(set_adv_on_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_adv_scan_rsp_data_name_and_appearance,
+	.expect_hci_len = sizeof(set_adv_scan_rsp_data_name_and_appearance),
+};
+
 static const char set_bredr_off_param[] = { 0x00 };
 static const char set_bredr_on_param[] = { 0x01 };
 static const char set_bredr_invalid_param[] = { 0x02 };
@@ -6516,12 +6620,12 @@ static const uint8_t add_advertising_param_local_name_and_appearance[] = {
 };
 
 static const uint8_t set_scan_rsp_data_local_name_and_appearance[] = {
-	0x0F, /* Scan rsp data len */
-	0x03, /* Appearance data len */
-	0x19, /* EIR_APPEARANCE */
+	0x0f, /* scan rsp data len */
+	0x03, /* appearance data len */
+	0x19, /* eir_appearance */
 	0x54, 0x65, /* appearance value */
-	0x0A, /* Local name data len */
-	0x09, /* Complete name */
+	0x0a, /* local name data len */
+	0x09, /* complete name */
 	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "Test name" */
 	/* padding */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -7238,6 +7342,18 @@ int main(int argc, char *argv[])
 				&set_adv_on_rejected_test_1,
 				NULL, test_command_generic);
 
+	test_bredrle("Set Advertising on - Appearance 1",
+		     &set_adv_on_appearance_test_1,
+		     setup_command_generic, test_command_generic);
+
+	test_bredrle("Set Advertising on - Local name 1",
+		     &set_adv_on_local_name_test_1,
+		     setup_command_generic, test_command_generic);
+
+	test_bredrle("Set Advertising on - Name + Appear 1",
+		     &set_adv_on_local_name_appear_test_1,
+		     setup_command_generic, test_command_generic);
+
 	test_bredrle("Set BR/EDR off - Success 1",
 				&set_bredr_off_success_test_1,
 				NULL, test_command_generic);
-- 
2.7.4

