Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH 4/5] tools/mgmt-tester: Test add appearance in scan rsp data
Date: Wed,  7 Sep 2016 22:57:46 +0200
Message-Id: <1473281867-8560-4-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1473281867-8560-1-git-send-email-szymon.janc@codecoup.pl>
References: <1473281867-8560-1-git-send-email-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Michał Narajowski <michal.narajowski@codecoup.pl>

---
 tools/mgmt-tester.c | 362 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 360 insertions(+), 2 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 9a06fa3..91b5aa7 100644
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
@@ -6329,6 +6329,324 @@ static const struct generic_data add_advertising_with_local_name4 = {
 	.expect_hci_len = sizeof(set_scan_rsp_data_local_name4),
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
+	0x03,
+	0x02,
+	0x054, 0x65,
+	/* scan rsp data */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const uint8_t set_appearance_param[2] = { 0x54, 0x65 };
+
+static const struct generic_data add_advertising_with_appearance1 = {
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
+static const uint8_t add_advertising_param_appearance2[] = {
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
+static const uint8_t set_scan_rsp_data_appearance2[] = {
+	0x19, /* Scan rsp data len */
+	/* scan rsp data */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00,
+	/*padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct generic_data add_advertising_with_appearance2 = {
+	.setup_settings = settings_powered_le,
+	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.setup_expect_hci_param = set_scan_rsp_data_appearance2,
+	.setup_expect_hci_len = sizeof(set_scan_rsp_data_appearance2),
+	.setup_send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.setup_send_param = add_advertising_param_appearance2,
+	.setup_send_len = sizeof(add_advertising_param_appearance2),
+	.send_opcode = MGMT_OP_SET_APPEARANCE,
+	.send_param = set_appearance_param,
+	.send_len = sizeof(set_appearance_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_appearance_param,
+	.expect_len = sizeof(set_appearance_param),
+};
+
+static const uint8_t add_advertising_param_appearance3[] = {
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
+static const struct generic_data add_advertising_with_appearance3 = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_SET_APPEARANCE,
+	.setup_send_param = set_appearance_param,
+	.setup_send_len = sizeof(set_appearance_param),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_appearance3,
+	.send_len = sizeof(add_advertising_param_appearance3),
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
+static const uint8_t add_advertising_param_local_name_and_appearance1[] = {
+	0x01,			/* adv instance */
+	0x60, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x00,			/* scan rsp len */
+};
+
+static const uint8_t set_scan_rsp_data_local_name_and_appearance1[] = {
+	0x0F, /* Scan rsp data len */
+	0x03, /* Appearance data len */
+	0x02, /* Appearance len */
+	0x54, 0x65,
+	0x0A, /* Local name data len */
+	0x09, /* Complete name */
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "Test name" */
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const struct generic_data add_advertising_local_name_appearance1 = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = add_advertising_mgmt_cmd_arr,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_local_name_and_appearance1,
+	.send_len = sizeof(add_advertising_param_local_name_and_appearance1),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_data_local_name_and_appearance1,
+	.expect_hci_len = sizeof(set_scan_rsp_data_local_name_and_appearance1),
+};
+
+static const uint8_t add_advertising_param_local_name_and_appearance2[] = {
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
+static const uint8_t set_scan_rsp_data_local_name_and_appearance2[] = {
+	0x1f, /* Scan rsp len */
+	0x03, /* Appearance data len */
+	0x02, /* Appearance len */
+	0x54, 0x65,
+	/* placeholder data */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00,
+	0x05, /* Local name length */
+	0x08, /* Shortened name */
+	0x54, 0x65, 0x73, 0x74, /* "Test" */
+};
+
+static const struct generic_data add_advertising_local_name_appearance2 = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = add_advertising_mgmt_cmd_arr,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_local_name_and_appearance2,
+	.send_len = sizeof(add_advertising_param_local_name_and_appearance2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_data_local_name_and_appearance2,
+	.expect_hci_len = sizeof(set_scan_rsp_data_local_name_and_appearance2),
+};
+
+static const uint8_t add_advertising_param_local_name_and_appearance3[] = {
+	0x01,			/* adv instance */
+	0x60, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
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
+static const uint8_t set_scan_rsp_data_local_name_and_appearance3[] = {
+	0x1d, /* Scan rsp len */
+	0x03, /* Appearance data len */
+	0x02, /* Appearance len */
+	0x54, 0x65,
+	/* placeholder data */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00,
+	/* padding */
+	0x00, 0x00,
+};
+
+static const struct generic_data add_advertising_local_name_appearance3 = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = add_advertising_mgmt_cmd_arr,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_local_name_and_appearance3,
+	.send_len = sizeof(add_advertising_param_local_name_and_appearance3),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_data_local_name_and_appearance3,
+	.expect_hci_len = sizeof(set_scan_rsp_data_local_name_and_appearance3),
+};
+
+static const uint8_t add_advertising_param_local_name_and_appearance4[] = {
+	0x01,			/* adv instance */
+	0x60, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x1b,			/* scan rsp len */
+	/* scan rsp data: */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static const uint8_t set_scan_rsp_data_local_name_and_appearance4[] = {
+	0x1f, /* Scan rsp len */
+	0x03, /* Appearance data len */
+	0x02, /* Appearance len */
+	0x54, 0x65,
+	/* placeholder data */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct generic_data add_advertising_local_name_appearance4 = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = add_advertising_mgmt_cmd_arr,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_local_name_and_appearance4,
+	.send_len = sizeof(add_advertising_param_local_name_and_appearance4),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_data_local_name_and_appearance4,
+	.expect_hci_len = sizeof(set_scan_rsp_data_local_name_and_appearance4),
+};
+
+static const uint8_t add_advertising_param_local_name_and_appearance5[] = {
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
+static const uint8_t set_scan_rsp_data_local_name_and_appearance5[] = {
+	0x1f, /* Scan rsp len */
+	0x03, /* Appearance data len */
+	0x02, /* Appearance len */
+	0x54, 0x65,
+	/* placeholder data */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x02, /* Local name data length */
+	0x08, /* Shortened name */
+	0x54, /* "T" */
+};
+
+static const struct generic_data add_advertising_local_name_appearance5 = {
+	.setup_settings = settings_powered_le,
+	.setup_mgmt_cmd_arr = add_advertising_mgmt_cmd_arr,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_local_name_and_appearance5,
+	.send_len = sizeof(add_advertising_param_local_name_and_appearance5),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_data_local_name_and_appearance5,
+	.expect_hci_len = sizeof(set_scan_rsp_data_local_name_and_appearance5),
+};
+
 static bool power_off(uint16_t index)
 {
 	int sk, err;
@@ -7574,6 +7892,46 @@ int main(int argc, char *argv[])
 					setup_set_local_name,
 					test_command_generic);
 
+	test_bredrle("Add Advertising - Scan rsp flags 5",
+					&add_advertising_with_appearance1,
+					setup_set_local_name,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Scan rsp flags 6",
+					&add_advertising_with_appearance2,
+					setup_set_local_name,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Scan rsp flags 7",
+					&add_advertising_with_appearance3,
+					setup_set_local_name,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Scan rsp flags 8",
+					&add_advertising_local_name_appearance1,
+					setup_set_local_name,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Scan rsp flags 9",
+					&add_advertising_local_name_appearance2,
+					setup_set_local_name,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Scan rsp flags 10",
+					&add_advertising_local_name_appearance3,
+					setup_set_local_name,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Scan rsp flags 11",
+					&add_advertising_local_name_appearance4,
+					setup_set_local_name,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Scan rsp flags 12",
+					&add_advertising_local_name_appearance5,
+					setup_set_local_name,
+					test_command_generic);
+
 	test_bredrle("Read Ext Controller Info 1",
 				&read_ext_ctrl_info1,
 				setup_set_local_name, test_command_generic);
-- 
2.7.4

