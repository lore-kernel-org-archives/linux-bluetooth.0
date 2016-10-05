Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 2/4] tools/mgmt-tester: Fix add local name to scan rsp
Date: Wed,  5 Oct 2016 12:27:15 +0200
Message-Id: <1475663237-3070-2-git-send-email-michal.narajowski@codecoup.pl>
In-Reply-To: <1475663237-3070-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1475663237-3070-1-git-send-email-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use complete name if it fits. If not and there is short name
check if it fits. If not then use shortened name as prefix
of complete name.
---
 tools/mgmt-tester.c | 134 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 127 insertions(+), 7 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 8929e09..bc770b7 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1789,6 +1789,11 @@ static const char write_eir_local_name_hci_1[241] = { 0x00,
 		0x0a, 0x09, 'T', 'e', 's', 't', ' ', 'n', 'a', 'm', 'e',
 		0x02, 0x0a, 0x00, };
 
+static const struct mgmt_cp_set_local_name set_local_name_cp = {
+	.name = {'T', 'e', 's', 't', ' ', 'n', 'a', 'm', 'e'},
+	.short_name = {'T', 'e', 's', 't'},
+};
+
 static const struct generic_data set_local_name_test_1 = {
 	.send_opcode = MGMT_OP_SET_LOCAL_NAME,
 	.send_param = set_local_name_param,
@@ -5002,11 +5007,6 @@ static const struct generic_data read_ext_ctrl_info3 = {
 	.expect_len = sizeof(ext_ctrl_info3),
 };
 
-static const struct mgmt_cp_set_local_name set_local_name_cp = {
-	.name = {'T', 'e', 's', 't', ' ', 'n', 'a', 'm', 'e'},
-	.short_name = {'T', 'e', 's', 't'},
-};
-
 static const char ext_ctrl_info4[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x08, /* version */
@@ -6366,6 +6366,111 @@ static const struct generic_data add_advertising_dta_name_scrsp = {
 	.expect_hci_len = sizeof(set_scan_rsp_data_shortened_name),
 };
 
+static const uint8_t add_advertising_param_data_short_name_scan_rsp[] = {
+	0x01,			/* adv instance */
+	0x40, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x17,			/* scan rsp len */
+	/* scan rsp data: */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00,
+};
+
+static const uint8_t set_scan_rsp_data_short_name[] = {
+	0x1d, /* Scan rsp len */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, /* placeholder data */
+	0x05, /* Local name length */
+	0x08, /* Short name */
+	0x54, 0x65, 0x73, 0x74, /* "Test" */
+	0x00, 0x00, /* padding */
+};
+
+static const struct generic_data add_advertising_dta_short_name_scrsp = {
+	.setup_settings = settings_powered_le,
+	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.setup_expect_hci_param = set_scan_rsp_data_name,
+	.setup_expect_hci_len = sizeof(set_scan_rsp_data_name),
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = &set_local_name_cp,
+	.setup_send_len = sizeof(set_local_name_cp),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_data_short_name_scan_rsp,
+	.send_len = sizeof(add_advertising_param_data_short_name_scan_rsp),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_data_short_name,
+	.expect_hci_len = sizeof(set_scan_rsp_data_short_name),
+};
+
+static const uint8_t set_scan_rsp_data_too_long_name[] = {
+	0x06, /* Scan rsp len */
+	0x05, /* Local name length */
+	0x08, /* Short name */
+	0x54, 0x65, 0x73, 0x74, /* "Test" */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, /* padding */
+};
+
+static const struct mgmt_cp_set_local_name set_long_local_name_cp = {
+	.name = {'T', 'e', 's', 't', ' ', 'n', 'a', 'm', 'e', '1', '2'},
+	.short_name = {'T', 'e', 's', 't'},
+};
+
+static const struct generic_data add_advertising_too_long_name_scrsp = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = &set_long_local_name_cp,
+	.setup_send_len = sizeof(set_long_local_name_cp),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_name,
+	.send_len = sizeof(add_advertising_param_name),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_data_too_long_name,
+	.expect_hci_len = sizeof(set_scan_rsp_data_too_long_name),
+};
+
+static const uint8_t set_scan_rsp_data_name_fits[] = {
+	0x0c, /* Scan rsp len */
+	0x0b, /* Local name length */
+	0x09, /* Complete name */
+	0x54, 0x65, 0x73, 0x74, 0x20,
+	0x6e, 0x61, 0x6d, 0x65, 0x31, /* "Test name1" */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* padding */
+};
+
+static const struct mgmt_cp_set_local_name set_local_name_fits_cp = {
+	.name = {'T', 'e', 's', 't', ' ', 'n', 'a', 'm', 'e', '1'},
+	.short_name = {'T', 'e', 's', 't'},
+};
+
+static const struct generic_data add_advertising_name_fits_scrsp = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = &set_local_name_fits_cp,
+	.setup_send_len = sizeof(set_local_name_fits_cp),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_name,
+	.send_len = sizeof(add_advertising_param_name),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_data_name_fits,
+	.expect_hci_len = sizeof(set_scan_rsp_data_name_fits),
+};
+
 static const uint8_t add_advertising_param_appearance1[] = {
 	0x01,			/* adv instance */
 	0x20, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
@@ -7840,12 +7945,27 @@ int main(int argc, char *argv[])
 					setup_command_generic,
 					test_command_generic);
 
-	test_bredrle("Add Advertising - Success 5 (Appearance in ScRsp)",
+	test_bredrle("Add Advertising - Success 5 (name too long in ScRsp)",
+					&add_advertising_too_long_name_scrsp,
+					setup_command_generic,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Success 6 (name fits in ScRsp)",
+					&add_advertising_name_fits_scrsp,
+					setup_command_generic,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Success 7 (Dta + short in ScRsp)",
+					&add_advertising_dta_short_name_scrsp,
+					setup_command_generic,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Success 8 (Appearance in ScRsp)",
 					&add_advertising_appearance_scrsp,
 					setup_command_generic,
 					test_command_generic);
 
-	test_bredrle("Add Advertising - Success 6 (Appear + Dta in ScRsp)",
+	test_bredrle("Add Advertising - Success 9 (Appear + Dta in ScRsp)",
 					&add_advertising_appear_data_scrsp,
 					setup_command_generic,
 					test_command_generic);
-- 
2.7.4

