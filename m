Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 2/5] tools/mgmt-tester: Test add local name in scan rsp data
Date: Tue, 20 Sep 2016 14:02:07 +0200
Message-Id: <1474372930-9706-2-git-send-email-michal.narajowski@codecoup.pl>
In-Reply-To: <1474372930-9706-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1474372930-9706-1-git-send-email-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Appropriate HCI command is expected in setup section because
as soon as new local name is registered in the kernel the
HCI_OP_LE_SET_SCAN_RSP_DATA is triggered. Then when we pass
Add_local_name_to_Scan_rsp_data flag in Add advertising
command the HCI command is not triggered because
Scan response data has not changed.
---
 tools/mgmt-tester.c | 202 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 194 insertions(+), 8 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 1533cc1..547249e 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4005,7 +4005,7 @@ static const struct generic_data read_adv_features_invalid_index_test = {
 };
 
 static const uint8_t read_adv_features_rsp_1[] =  {
-	0x1f, 0x00, 0x00, 0x00,	/* supported flags */
+	0x5f, 0x00, 0x00, 0x00,	/* supported flags */
 	0x1f,			/* max_adv_data_len */
 	0x1f,			/* max_scan_rsp_len */
 	0x05,			/* max_instances */
@@ -4020,7 +4020,7 @@ static const struct generic_data read_adv_features_success_1 = {
 };
 
 static const uint8_t read_adv_features_rsp_2[] =  {
-	0x1f, 0x00, 0x00, 0x00,	/* supported flags */
+	0x5f, 0x00, 0x00, 0x00,	/* supported flags */
 	0x1f,			/* max_adv_data_len */
 	0x1f,			/* max_scan_rsp_len */
 	0x05,			/* max_instances */
@@ -6115,7 +6115,7 @@ static void setup_mgmt_cmd_callback(uint8_t status, uint16_t length,
 	tester_setup_complete();
 }
 
-static void setup_set_local_name(const void *test_data)
+static void setup_command_generic(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
@@ -6163,6 +6163,172 @@ static void setup_set_local_name(const void *test_data)
 	tester_setup_complete();
 }
 
+static const uint8_t add_advertising_param_name[] = {
+	0x01,			/* adv instance */
+	0x40, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x00,			/* scan rsp len */
+};
+
+static const uint8_t set_scan_rsp_data_name[] = {
+	0x0b, /* Scan rsp data len */
+	0x0a, /* Local name data len */
+	0x09, /* Complete name */
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "Test name" */
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct generic_data add_advertising_name_in_scrsp = {
+	.setup_settings = settings_powered_le,
+	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.setup_expect_hci_param = set_scan_rsp_data_name,
+	.setup_expect_hci_len = sizeof(set_scan_rsp_data_name),
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = set_local_name_param,
+	.setup_send_len = sizeof(set_local_name_param),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_name,
+	.send_len = sizeof(add_advertising_param_name),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+};
+
+static const uint8_t add_advertising_param_empty[] = {
+	0x01,			/* adv instance */
+	0x00, 0x00, 0x00, 0x00,	/* flags: none */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x00,			/* scan rsp len */
+};
+
+static const uint8_t set_scan_rsp_data_empty[] = {
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00,
+};
+
+static const struct generic_data add_advertising_empty_scrsp = {
+	.setup_settings = settings_powered_le,
+	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.setup_expect_hci_param = set_scan_rsp_data_name,
+	.setup_expect_hci_len = sizeof(set_scan_rsp_data_name),
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = set_local_name_param,
+	.setup_send_len = sizeof(set_local_name_param),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_empty,
+	.send_len = sizeof(add_advertising_param_empty),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_data_empty,
+	.expect_hci_len = sizeof(set_scan_rsp_data_empty),
+};
+
+static const uint8_t add_advertising_param_name_data_scrsp[] = {
+	0x01,			/* adv instance */
+	0x40, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x09,			/* adv data len */
+	0x14,			/* scan rsp len */
+	/* adv data: */
+	0x03,			/* AD len */
+	0x02,			/* AD type: some 16 bit service class UUIDs */
+	0x0d, 0x18,		/* heart rate monitor */
+	0x04,			/* AD len */
+	0xff,			/* AD type: manufacturer specific data */
+	0x01, 0x02, 0x03,	/* custom advertising data */
+	/* scan rsp data: */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const uint8_t set_scan_rsp_data_name_data[] = {
+	0x1f, /* Scan rsp data len */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x0a, /* Local name data len */
+	0x09, /* Complete name */
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "Test name" */
+};
+
+static const struct generic_data add_advertising_name_data_scrsp = {
+	.setup_settings = settings_powered_le,
+	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.setup_expect_hci_param = set_scan_rsp_data_name,
+	.setup_expect_hci_len = sizeof(set_scan_rsp_data_name),
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = set_local_name_param,
+	.setup_send_len = sizeof(set_local_name_param),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_name_data_scrsp,
+	.send_len = sizeof(add_advertising_param_name_data_scrsp),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_data_name_data,
+	.expect_hci_len = sizeof(set_scan_rsp_data_name_data),
+};
+
+static const uint8_t add_advertising_param_data_name_scan_rsp[] = {
+	0x01,			/* adv instance */
+	0x40, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x09,			/* adv data len */
+	0x19,			/* scan rsp len */
+	/* adv data: */
+	0x03,			/* AD len */
+	0x02,			/* AD type: some 16 bit service class UUIDs */
+	0x0d, 0x18,		/* heart rate monitor */
+	0x04,			/* AD len */
+	0xff,			/* AD type: manufacturer specific data */
+	0x01, 0x02, 0x03,	/* custom advertising data */
+	/* scan rsp data: */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const uint8_t set_scan_rsp_data_shortened_name[] = {
+	0x1f, /* Scan rsp len */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, /* placeholder data */
+	0x05, /* Local name length */
+	0x08, /* Shortened name */
+	0x54, 0x65, 0x73, 0x74, /* "Test" */
+};
+
+static const struct generic_data add_advertising_dta_name_scrsp = {
+	.setup_settings = settings_powered_le,
+	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.setup_expect_hci_param = set_scan_rsp_data_name,
+	.setup_expect_hci_len = sizeof(set_scan_rsp_data_name),
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = set_local_name_param,
+	.setup_send_len = sizeof(set_local_name_param),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_data_name_scan_rsp,
+	.send_len = sizeof(add_advertising_param_data_name_scan_rsp),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_data_shortened_name,
+	.expect_hci_len = sizeof(set_scan_rsp_data_shortened_name),
+};
+
 static bool power_off(uint16_t index)
 {
 	int sk, err;
@@ -7359,6 +7525,26 @@ int main(int argc, char *argv[])
 					setup_add_advertising,
 					test_command_generic);
 
+	test_bredrle("Add Advertising - Success 1 (Name in ScRsp)",
+					&add_advertising_name_in_scrsp,
+					setup_command_generic,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Success 2 (Empty ScRsp)",
+					&add_advertising_empty_scrsp,
+					setup_command_generic,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Success 3 (Name + data in ScRsp)",
+					&add_advertising_name_data_scrsp,
+					setup_command_generic,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Success 4 (Dta + name in ScRsp)",
+					&add_advertising_dta_name_scrsp,
+					setup_command_generic,
+					test_command_generic);
+
 
 	test_bredrle("Remove Advertising - Invalid Params 1",
 					&remove_advertising_fail_1,
@@ -7390,23 +7576,23 @@ int main(int argc, char *argv[])
 
 	test_bredrle("Read Ext Controller Info 1",
 				&read_ext_ctrl_info1,
-				setup_set_local_name, test_command_generic);
+				setup_command_generic, test_command_generic);
 
 	test_bredrle("Read Ext Controller Info 2",
 				&read_ext_ctrl_info2,
-				setup_set_local_name, test_command_generic);
+				setup_command_generic, test_command_generic);
 
 	test_bredrle("Read Ext Controller Info 3",
 				&read_ext_ctrl_info3,
-				setup_set_local_name, test_command_generic);
+				setup_command_generic, test_command_generic);
 
 	test_bredrle("Read Ext Controller Info 4",
 				&read_ext_ctrl_info4,
-				setup_set_local_name, test_command_generic);
+				setup_command_generic, test_command_generic);
 
 	test_bredrle("Read Ext Controller Info 5",
 				&read_ext_ctrl_info5,
-				setup_set_local_name, test_command_generic);
+				setup_command_generic, test_command_generic);
 
 	test_bredrle("Read Local OOB Data - Not powered",
 				&read_local_oob_not_powered_test,
-- 
2.7.4

