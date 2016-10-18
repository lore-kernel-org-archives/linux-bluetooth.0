Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v3 3/3] tools/mgmt-tester: Fix add local name and appearance to scan rsp
Date: Tue, 18 Oct 2016 16:54:29 +0200
Message-Id: <1476802469-23292-3-git-send-email-michal.narajowski@codecoup.pl>
In-Reply-To: <1476802469-23292-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1476802469-23292-1-git-send-email-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Append maximum of 10 + 1 bytes of name to scan response data.
Complete name is appended only if exists and is <= 10 characters.
Else append short name if exists. This makes sure name
is consistent across multiple advertising instances.
---
 tools/mgmt-tester.c | 596 ++++++++++++++++++++++++++--------------------------
 1 file changed, 293 insertions(+), 303 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index e6904e8..999ecc7 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1741,13 +1741,14 @@ static const char set_adv_set_local_name_param[260] = { 'T', 'e', 's', 't', ' ',
 							'n', 'a', 'm', 'e' };
 
 static const uint8_t set_adv_scan_rsp_data_name_1[] = {
-	0x0b, /* Scan rsp data len */
-	0x0a, /* Local name data len */
+	0x0c, /* Scan rsp data len */
+	0x0b, /* Local name data len */
 	0x09, /* Complete name */
 	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "Test name" */
+	0x00, /* null */
 	/* padding */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
 static const struct generic_data set_adv_on_local_name_test_1 = {
@@ -1785,16 +1786,17 @@ static const struct setup_mgmt_cmd set_advertising_mgmt_cmd_arr[] = {
 };
 
 static const uint8_t set_adv_scan_rsp_data_name_and_appearance[] = {
-	0x0f, /* scan rsp data len */
+	0x10, /* scan rsp data len */
 	0x03, /* appearance data len */
 	0x19, /* eir_appearance */
 	0x54, 0x65, /* appearance value */
-	0x0a, /* local name data len */
+	0x0b, /* local name data len */
 	0x09, /* complete name */
 	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "test name" */
+	0x00, /* null */
 	/* padding */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+	0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
 
@@ -1893,6 +1895,20 @@ static const char write_eir_local_name_hci_1[241] = { 0x00,
 		0x0a, 0x09, 'T', 'e', 's', 't', ' ', 'n', 'a', 'm', 'e',
 		0x02, 0x0a, 0x00, };
 
+static const struct mgmt_cp_set_local_name set_local_name_cp = {
+	.name = {'T', 'e', 's', 't', ' ', 'n', 'a', 'm', 'e'},
+	.short_name = {'T', 'e', 's', 't'},
+};
+
+static const struct mgmt_cp_set_local_name set_local_name_longer_cp = {
+	.name = {'T', 'e', 's', 't', ' ', 'n', 'a', 'm', 'e', '1', '2', '3'},
+};
+
+static const struct mgmt_cp_set_local_name set_local_name_longer_rp = {
+	.name = {'T', 'e', 's', 't', ' ', 'n', 'a', 'm', 'e', '1', '2', '3'},
+	.short_name = {'T', 'e', 's', 't', ' ', 'n', 'a', 'm', 'e', '1'},
+};
+
 static const struct generic_data set_local_name_test_1 = {
 	.send_opcode = MGMT_OP_SET_LOCAL_NAME,
 	.send_param = set_local_name_param,
@@ -5106,11 +5122,6 @@ static const struct generic_data read_ext_ctrl_info3 = {
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
@@ -6304,294 +6315,323 @@ static void setup_command_generic(const void *test_data)
 	}
 }
 
-static const uint8_t add_advertising_param_name[] = {
+static const uint8_t add_advertising_param_empty[] = {
 	0x01,			/* adv instance */
-	0x40, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x00, 0x00, 0x00, 0x00,	/* flags: none */
 	0x00, 0x00,		/* duration: default */
 	0x00, 0x00,		/* timeout: none */
 	0x00,			/* adv data len */
 	0x00,			/* scan rsp len */
 };
 
-static const uint8_t set_scan_rsp_data_name[] = {
-	0x0b, /* Scan rsp data len */
-	0x0a, /* Local name data len */
-	0x09, /* Complete name */
-	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "Test name" */
-	/* padding */
+static const uint8_t set_scan_rsp_data_empty[] = {
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00,
 };
 
-static const struct generic_data add_advertising_name_in_scrsp = {
+static const struct generic_data add_advertising_empty_scrsp = {
 	.setup_settings = settings_powered_le,
-	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
-	.setup_expect_hci_param = set_scan_rsp_data_name,
-	.setup_expect_hci_len = sizeof(set_scan_rsp_data_name),
 	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
 	.setup_send_param = set_local_name_param,
 	.setup_send_len = sizeof(set_local_name_param),
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_name,
-	.send_len = sizeof(add_advertising_param_name),
+	.send_param = add_advertising_param_empty,
+	.send_len = sizeof(add_advertising_param_empty),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_param = advertising_instance1_param,
 	.expect_len = sizeof(advertising_instance1_param),
 };
 
-static const uint8_t add_advertising_param_empty[] = {
+static const uint8_t add_advertising_param_scrsp_data_only_ok[] = {
 	0x01,			/* adv instance */
 	0x00, 0x00, 0x00, 0x00,	/* flags: none */
 	0x00, 0x00,		/* duration: default */
 	0x00, 0x00,		/* timeout: none */
 	0x00,			/* adv data len */
-	0x00,			/* scan rsp len */
-};
-
-static const uint8_t set_scan_rsp_data_empty[] = {
+	0x1f,			/* scan rsp len */
+	/* adv data: */
+	/* scan rsp data: */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00,
+	0x00,
 };
 
-static const struct generic_data add_advertising_empty_scrsp = {
+static const struct generic_data add_advertising_scrsp_data_only_ok = {
 	.setup_settings = settings_powered_le,
-	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
-	.setup_expect_hci_param = set_scan_rsp_data_name,
-	.setup_expect_hci_len = sizeof(set_scan_rsp_data_name),
-	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
-	.setup_send_param = set_local_name_param,
-	.setup_send_len = sizeof(set_local_name_param),
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_empty,
-	.send_len = sizeof(add_advertising_param_empty),
+	.send_param = add_advertising_param_scrsp_data_only_ok,
+	.send_len = sizeof(add_advertising_param_scrsp_data_only_ok),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_param = advertising_instance1_param,
 	.expect_len = sizeof(advertising_instance1_param),
-	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
-	.expect_hci_param = set_scan_rsp_data_empty,
-	.expect_hci_len = sizeof(set_scan_rsp_data_empty),
 };
 
-static const uint8_t add_advertising_param_name_data_scrsp[] = {
+static const uint8_t add_advertising_param_scrsp_data_only_too_long[] = {
 	0x01,			/* adv instance */
-	0x40, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x00, 0x00, 0x00, 0x00,	/* flags: none */
 	0x00, 0x00,		/* duration: default */
 	0x00, 0x00,		/* timeout: none */
-	0x09,			/* adv data len */
-	0x14,			/* scan rsp len */
+	0x00,			/* adv data len */
+	0x20,			/* scan rsp len */
 	/* adv data: */
-	0x03,			/* AD len */
-	0x02,			/* AD type: some 16 bit service class UUIDs */
-	0x0d, 0x18,		/* heart rate monitor */
-	0x04,			/* AD len */
-	0xff,			/* AD type: manufacturer specific data */
-	0x01, 0x02, 0x03,	/* custom advertising data */
 	/* scan rsp data: */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00,
 };
 
-static const uint8_t set_scan_rsp_data_name_data[] = {
-	0x1f, /* Scan rsp data len */
+static const struct generic_data add_advertising_scrsp_data_only_too_long = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_scrsp_data_only_too_long,
+	.send_len = sizeof(add_advertising_param_scrsp_data_only_too_long),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+	.expect_param = NULL,
+	.expect_len = 0,
+};
+
+static const uint8_t set_appearance_param[2] = { 0x54, 0x65 };
+
+static const uint8_t add_advertising_param_scrsp_appear_data_ok[] = {
+	0x01,			/* adv instance */
+	0x20, 0x00, 0x00, 0x00,	/* flags: appearance */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x1b,			/* scan rsp len */
+	/* adv data: */
+	/* scan rsp data: */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x0a, /* Local name data len */
-	0x09, /* Complete name */
-	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "Test name" */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
-static const struct generic_data add_advertising_name_data_scrsp = {
+static const struct generic_data add_advertising_scrsp_appear_data_ok = {
 	.setup_settings = settings_powered_le,
-	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
-	.setup_expect_hci_param = set_scan_rsp_data_name,
-	.setup_expect_hci_len = sizeof(set_scan_rsp_data_name),
-	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
-	.setup_send_param = set_local_name_param,
-	.setup_send_len = sizeof(set_local_name_param),
+	.setup_send_opcode = MGMT_OP_SET_APPEARANCE,
+	.setup_send_param = set_appearance_param,
+	.setup_send_len = sizeof(set_appearance_param),
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_name_data_scrsp,
-	.send_len = sizeof(add_advertising_param_name_data_scrsp),
+	.send_param = add_advertising_param_scrsp_appear_data_ok,
+	.send_len = sizeof(add_advertising_param_scrsp_appear_data_ok),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_param = advertising_instance1_param,
 	.expect_len = sizeof(advertising_instance1_param),
-	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
-	.expect_hci_param = set_scan_rsp_data_name_data,
-	.expect_hci_len = sizeof(set_scan_rsp_data_name_data),
 };
 
-static const uint8_t add_advertising_param_data_name_scan_rsp[] = {
+static const uint8_t add_advertising_param_scrsp_appear_data_too_long[] = {
 	0x01,			/* adv instance */
-	0x40, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x20, 0x00, 0x00, 0x00,	/* flags: appearance */
 	0x00, 0x00,		/* duration: default */
 	0x00, 0x00,		/* timeout: none */
-	0x09,			/* adv data len */
-	0x19,			/* scan rsp len */
+	0x00,			/* adv data len */
+	0x1c,			/* scan rsp len */
 	/* adv data: */
-	0x03,			/* AD len */
-	0x02,			/* AD type: some 16 bit service class UUIDs */
-	0x0d, 0x18,		/* heart rate monitor */
-	0x04,			/* AD len */
-	0xff,			/* AD type: manufacturer specific data */
-	0x01, 0x02, 0x03,	/* custom advertising data */
 	/* scan rsp data: */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct generic_data add_advertising_scrsp_appear_data_too_long = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_SET_APPEARANCE,
+	.setup_send_param = set_appearance_param,
+	.setup_send_len = sizeof(set_appearance_param),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_scrsp_appear_data_too_long,
+	.send_len = sizeof(add_advertising_param_scrsp_appear_data_too_long),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+	.expect_param = NULL,
+	.expect_len = 0,
 };
 
-static const uint8_t set_scan_rsp_data_shortened_name[] = {
-	0x1f, /* Scan rsp len */
+static const uint8_t add_advertising_param_scrsp_appear_null[] = {
+	0x01,			/* adv instance */
+	0x20, 0x00, 0x00, 0x00,	/* flags: appearance */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x01,			/* scan rsp len */
+	/* adv data: */
+	/* scan rsp data: */
+	0x00,
+};
+
+static const struct generic_data add_advertising_scrsp_appear_null = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_scrsp_appear_null,
+	.send_len = sizeof(add_advertising_param_scrsp_appear_null),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+};
+
+static const uint8_t add_advertising_empty_param[] = {
+	0x01,			/* adv instance */
+	0x40, 0x00, 0x00, 0x00,	/* flags: local name*/
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x01,			/* scan rsp len */
+	/* scan rsp data: */
+	0x00,
+};
+
+static const uint8_t scan_rsp_data_empty[] = {
+	0x01, /* scan rsp data len */
+	0x00, /* scan rsp data */
+	/* placeholder data */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, /* placeholder data */
-	0x05, /* Local name length */
-	0x08, /* Shortened name */
-	0x54, 0x65, 0x73, 0x74, /* "Test" */
 };
 
-static const struct generic_data add_advertising_dta_name_scrsp = {
+static const struct generic_data add_advertising_no_name_set = {
 	.setup_settings = settings_powered_le,
-	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
-	.setup_expect_hci_param = set_scan_rsp_data_name,
-	.setup_expect_hci_len = sizeof(set_scan_rsp_data_name),
-	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
-	.setup_send_param = set_local_name_param,
-	.setup_send_len = sizeof(set_local_name_param),
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_data_name_scan_rsp,
-	.send_len = sizeof(add_advertising_param_data_name_scan_rsp),
+	.send_param = add_advertising_empty_param,
+	.send_len = sizeof(add_advertising_empty_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_param = advertising_instance1_param,
 	.expect_len = sizeof(advertising_instance1_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
-	.expect_hci_param = set_scan_rsp_data_shortened_name,
-	.expect_hci_len = sizeof(set_scan_rsp_data_shortened_name),
+	.expect_hci_param = scan_rsp_data_empty,
+	.expect_hci_len = sizeof(scan_rsp_data_empty),
 };
 
-static const uint8_t add_advertising_param_appearance1[] = {
+static const uint8_t add_advertising_param_name[] = {
 	0x01,			/* adv instance */
-	0x20, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x40, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
 	0x00, 0x00,		/* duration: default */
 	0x00, 0x00,		/* timeout: none */
 	0x00,			/* adv data len */
 	0x00,			/* scan rsp len */
 };
 
-static const uint8_t set_scan_rsp_data_appearance1[] = {
-	0x04, /* Scan rsp data len */
-	0x03, /* appearance data len */
-	0x19, /* EIR_APPEARANCE */
-	0x054, 0x65, /* appearance value */
-	/* scan rsp data */
+static const uint8_t set_scan_rsp_data_name_fits_in_scrsp[] = {
+	0x0c, /* Scan rsp data len */
+	0x0b, /* Local name data len */
+	0x09, /* Complete name */
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "Test name" */
+	/* padding */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
-static const uint8_t set_appearance_param[2] = { 0x54, 0x65 };
-
-static const struct generic_data set_appearance_not_supported = {
-	.send_opcode = MGMT_OP_SET_APPEARANCE,
-	.send_param = set_appearance_param,
-	.send_len = sizeof(set_appearance_param),
-	.expect_status = MGMT_STATUS_NOT_SUPPORTED,
-	.expect_param = NULL,
-	.expect_len = 0,
+static const struct generic_data add_advertising_name_fits_in_scrsp = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = &set_local_name_cp,
+	.setup_send_len = sizeof(set_local_name_cp),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_name,
+	.send_len = sizeof(add_advertising_param_name),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_data_name_fits_in_scrsp,
+	.expect_hci_len = sizeof(set_scan_rsp_data_name_fits_in_scrsp),
 };
 
-static const struct generic_data set_appearance_success = {
-	.send_opcode = MGMT_OP_SET_APPEARANCE,
-	.send_param = set_appearance_param,
-	.send_len = sizeof(set_appearance_param),
-	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = NULL,
-	.expect_len = 0,
+static const uint8_t set_scan_rsp_data_short_name_fits[] = {
+	0x0d, /* Scan rsp data len */
+	0x0c, /* Local name data len */
+	0x08, /* Complete name */
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x31,
+	/* "Test name1" */
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
-static const struct generic_data add_advertising_appearance_scrsp = {
+static const struct generic_data add_advertising_short_name_in_scrsp = {
 	.setup_settings = settings_powered_le,
-	.setup_send_opcode = MGMT_OP_SET_APPEARANCE,
-	.setup_send_param = set_appearance_param,
-	.setup_send_len = sizeof(set_appearance_param),
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = &set_local_name_longer_cp,
+	.setup_send_len = sizeof(set_local_name_longer_cp),
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_appearance1,
-	.send_len = sizeof(add_advertising_param_appearance1),
+	.send_param = add_advertising_param_name,
+	.send_len = sizeof(add_advertising_param_name),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_param = advertising_instance1_param,
 	.expect_len = sizeof(advertising_instance1_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
-	.expect_hci_param = set_scan_rsp_data_appearance1,
-	.expect_hci_len = sizeof(set_scan_rsp_data_appearance1),
+	.expect_hci_param = set_scan_rsp_data_short_name_fits,
+	.expect_hci_len = sizeof(set_scan_rsp_data_short_name_fits),
 };
 
-static const uint8_t add_advertising_param_appearance2_data[] = {
+static const uint8_t add_advertising_param_name_data_ok[] = {
 	0x01,			/* adv instance */
-	0x20, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x40, 0x00, 0x00, 0x00,	/* flags: local name */
 	0x00, 0x00,		/* duration: default */
 	0x00, 0x00,		/* timeout: none */
 	0x00,			/* adv data len */
-	0x19,			/* scan rsp len */
+	0x12,			/* scan rsp len */
+	/* adv data: */
 	/* scan rsp data: */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00,
-};
-
-static const uint8_t set_scan_rsp_data_only_data[] = {
-	0x19, /* Scan rsp data len */
-	/* scan rsp data */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00,
-	/*padding */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
-static const struct generic_data add_advertising_appear_data_scrsp = {
+static const struct generic_data add_advertising_name_data_ok = {
 	.setup_settings = settings_powered_le,
-	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
-	.setup_expect_hci_param = set_scan_rsp_data_only_data,
-	.setup_expect_hci_len = sizeof(set_scan_rsp_data_only_data),
-	.setup_send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.setup_send_param = add_advertising_param_appearance2_data,
-	.setup_send_len = sizeof(add_advertising_param_appearance2_data),
-	.send_opcode = MGMT_OP_SET_APPEARANCE,
-	.send_param = set_appearance_param,
-	.send_len = sizeof(set_appearance_param),
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = &set_local_name_cp,
+	.setup_send_len = sizeof(set_local_name_cp),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_name_data_ok,
+	.send_len = sizeof(add_advertising_param_name_data_ok),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = NULL,
-	.expect_len = 0,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
 };
 
-static const uint8_t add_advertising_param_appearance_data_too_long[] = {
+static const uint8_t add_advertising_param_name_data_inv[] = {
 	0x01,			/* adv instance */
-	0x20, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x40, 0x00, 0x00, 0x00,	/* flags: local name */
 	0x00, 0x00,		/* duration: default */
 	0x00, 0x00,		/* timeout: none */
 	0x00,			/* adv data len */
-	0x30,			/* scan rsp len */
+	0x13,			/* scan rsp len */
 	/* adv data: */
 	/* scan rsp data: */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
-static const struct generic_data add_advertising_scrsp_too_long = {
+static const struct generic_data add_advertising_name_data_inv = {
 	.setup_settings = settings_powered_le,
-	.setup_send_opcode = MGMT_OP_SET_APPEARANCE,
-	.setup_send_param = set_appearance_param,
-	.setup_send_len = sizeof(set_appearance_param),
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = &set_local_name_cp,
+	.setup_send_len = sizeof(set_local_name_cp),
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_appearance_data_too_long,
-	.send_len = sizeof(add_advertising_param_appearance_data_too_long),
+	.send_param = add_advertising_param_name_data_inv,
+	.send_len = sizeof(add_advertising_param_name_data_inv),
 	.expect_status = MGMT_STATUS_INVALID_PARAMS,
 	.expect_param = NULL,
 	.expect_len = 0,
 };
 
+static const uint8_t add_advertising_param_name_data_appear[] = {
+	0x01,			/* adv instance */
+	0x60, 0x00, 0x00, 0x00,	/* flags: local name + appearance */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x0e,			/* scan rsp len */
+	/* adv data: */
+	/* scan rsp data: */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+};
+
 static const struct setup_mgmt_cmd add_advertising_mgmt_cmd_arr[] = {
 	{
 		.send_opcode = MGMT_OP_SET_APPEARANCE,
@@ -6600,8 +6640,8 @@ static const struct setup_mgmt_cmd add_advertising_mgmt_cmd_arr[] = {
 	},
 	{
 		.send_opcode = MGMT_OP_SET_LOCAL_NAME,
-		.send_param = set_local_name_param,
-		.send_len = sizeof(set_local_name_param),
+		.send_param = &set_local_name_cp,
+		.send_len = sizeof(set_local_name_cp),
 	},
 	{ /* last element should always have opcode 0x00 */
 		.send_opcode = 0x00,
@@ -6610,122 +6650,68 @@ static const struct setup_mgmt_cmd add_advertising_mgmt_cmd_arr[] = {
 	}
 };
 
-static const uint8_t add_advertising_param_local_name_and_appearance[] = {
-	0x01,			/* adv instance */
-	0x60, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
-	0x00, 0x00,		/* duration: default */
-	0x00, 0x00,		/* timeout: none */
-	0x00,			/* adv data len */
-	0x00,			/* scan rsp len */
-};
-
-static const uint8_t set_scan_rsp_data_local_name_and_appearance[] = {
-	0x0f, /* scan rsp data len */
-	0x03, /* appearance data len */
-	0x19, /* eir_appearance */
-	0x54, 0x65, /* appearance value */
-	0x0a, /* local name data len */
-	0x09, /* complete name */
-	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "Test name" */
-	/* padding */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00
-};
-
-static const struct generic_data add_advertising_name_appear_scrsp = {
+static const struct generic_data add_advertising_name_data_appear = {
 	.setup_settings = settings_powered_le,
 	.setup_mgmt_cmd_arr = add_advertising_mgmt_cmd_arr,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_local_name_and_appearance,
-	.send_len = sizeof(add_advertising_param_local_name_and_appearance),
+	.send_param = add_advertising_param_name_data_appear,
+	.send_len = sizeof(add_advertising_param_name_data_appear),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_param = advertising_instance1_param,
 	.expect_len = sizeof(advertising_instance1_param),
-	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
-	.expect_hci_param = set_scan_rsp_data_local_name_and_appearance,
-	.expect_hci_len = sizeof(set_scan_rsp_data_local_name_and_appearance),
 };
 
-static const uint8_t add_advertising_param_local_name_and_appearance_dta[] = {
+static const uint8_t add_advertising_param_appearance1[] = {
 	0x01,			/* adv instance */
-	0x60, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x20, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
 	0x00, 0x00,		/* duration: default */
 	0x00, 0x00,		/* timeout: none */
 	0x00,			/* adv data len */
-	0x15,			/* scan rsp len */
-	/* scan rsp data: */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00,
+	0x00,			/* scan rsp len */
 };
 
-static const uint8_t set_scan_rsp_local_name_and_appearance_dta[] = {
-	0x1f, /* Scan rsp len */
-	0x03, /* Appearance data len */
+static const uint8_t set_scan_rsp_data_appearance1[] = {
+	0x04, /* Scan rsp data len */
+	0x03, /* appearance data len */
 	0x19, /* EIR_APPEARANCE */
-	0x54, 0x65, /* appearance value */
-	/* placeholder data */
+	0x054, 0x65, /* appearance value */
+	/* scan rsp data */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00,
-	0x05, /* Local name length */
-	0x08, /* Shortened name */
-	0x54, 0x65, 0x73, 0x74, /* "Test" */
-};
-
-static const struct generic_data add_advertising_appear_data_name = {
-	.setup_settings = settings_powered_le,
-	.setup_mgmt_cmd_arr = add_advertising_mgmt_cmd_arr,
-	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_local_name_and_appearance_dta,
-	.send_len = sizeof(add_advertising_param_local_name_and_appearance_dta),
-	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = advertising_instance1_param,
-	.expect_len = sizeof(advertising_instance1_param),
-	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
-	.expect_hci_param = set_scan_rsp_local_name_and_appearance_dta,
-	.expect_hci_len = sizeof(set_scan_rsp_local_name_and_appearance_dta),
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
-
-static const uint8_t add_advertising_param_short_name_and_appearance_dta[] = {
-	0x01,			/* adv instance */
-	0x60, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
-	0x00, 0x00,		/* duration: default */
-	0x00, 0x00,		/* timeout: none */
-	0x00,			/* adv data len */
-	0x18,			/* scan rsp len */
-	/* scan rsp data: */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00,
+static const struct generic_data set_appearance_not_supported = {
+	.send_opcode = MGMT_OP_SET_APPEARANCE,
+	.send_param = set_appearance_param,
+	.send_len = sizeof(set_appearance_param),
+	.expect_status = MGMT_STATUS_NOT_SUPPORTED,
+	.expect_param = NULL,
+	.expect_len = 0,
 };
 
-static const uint8_t set_scan_rsp_short_name_and_appearance_dta[] = {
-	0x1f, /* Scan rsp len */
-	0x03, /* Appearance data len */
-	0x19, /* EIR_APPEARANCE */
-	0x54, 0x65, /* appearance value */
-	/* placeholder data */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00,
-	0x02, /* Local name data length */
-	0x08, /* Shortened name */
-	0x54, /* "T" */
+static const struct generic_data set_appearance_success = {
+	.send_opcode = MGMT_OP_SET_APPEARANCE,
+	.send_param = set_appearance_param,
+	.send_len = sizeof(set_appearance_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = NULL,
+	.expect_len = 0,
 };
 
-static const struct generic_data add_advertising_appear_data_short = {
+static const struct generic_data add_advertising_appearance_scrsp = {
 	.setup_settings = settings_powered_le,
-	.setup_mgmt_cmd_arr = add_advertising_mgmt_cmd_arr,
+	.setup_send_opcode = MGMT_OP_SET_APPEARANCE,
+	.setup_send_param = set_appearance_param,
+	.setup_send_len = sizeof(set_appearance_param),
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_short_name_and_appearance_dta,
-	.send_len = sizeof(add_advertising_param_short_name_and_appearance_dta),
+	.send_param = add_advertising_param_appearance1,
+	.send_len = sizeof(add_advertising_param_appearance1),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_param = advertising_instance1_param,
 	.expect_len = sizeof(advertising_instance1_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
-	.expect_hci_param = set_scan_rsp_short_name_and_appearance_dta,
-	.expect_hci_len = sizeof(set_scan_rsp_short_name_and_appearance_dta),
+	.expect_hci_param = set_scan_rsp_data_appearance1,
+	.expect_hci_len = sizeof(set_scan_rsp_data_appearance1),
 };
 
 static bool power_off(uint16_t index)
@@ -7343,16 +7329,16 @@ int main(int argc, char *argv[])
 				NULL, test_command_generic);
 
 	test_bredrle("Set Advertising on - Appearance 1",
-		     &set_adv_on_appearance_test_1,
-		     setup_command_generic, test_command_generic);
+				&set_adv_on_appearance_test_1,
+				setup_command_generic, test_command_generic);
 
 	test_bredrle("Set Advertising on - Local name 1",
-		     &set_adv_on_local_name_test_1,
-		     setup_command_generic, test_command_generic);
+				&set_adv_on_local_name_test_1,
+				setup_command_generic, test_command_generic);
 
 	test_bredrle("Set Advertising on - Name + Appear 1",
-		     &set_adv_on_local_name_appear_test_1,
-		     setup_command_generic, test_command_generic);
+				&set_adv_on_local_name_appear_test_1,
+				setup_command_generic, test_command_generic);
 
 	test_bredrle("Set BR/EDR off - Success 1",
 				&set_bredr_off_success_test_1,
@@ -7936,60 +7922,64 @@ int main(int argc, char *argv[])
 					setup_add_advertising,
 					test_command_generic);
 
-	test_bredrle("Add Advertising - Success 1 (Name in ScRsp)",
-					&add_advertising_name_in_scrsp,
-					setup_command_generic,
-					test_command_generic);
+	test_bredrle("Add Advertising - Success (Empty ScRsp)",
+					 &add_advertising_empty_scrsp,
+					 setup_command_generic,
+					 test_command_generic);
 
-	test_bredrle("Add Advertising - Success 2 (Empty ScRsp)",
-					&add_advertising_empty_scrsp,
-					setup_command_generic,
-					test_command_generic);
+	test_bredrle("Add Advertising - Success (ScRsp only)",
+					&add_advertising_scrsp_data_only_ok,
+						NULL, test_command_generic);
 
-	test_bredrle("Add Advertising - Success 3 (Name + data in ScRsp)",
-					&add_advertising_name_data_scrsp,
-					setup_command_generic,
-					test_command_generic);
+	test_bredrle("Add Advertising - Invalid Params (ScRsp too long)",
+				&add_advertising_scrsp_data_only_too_long,
+						NULL, test_command_generic);
 
-	test_bredrle("Add Advertising - Success 4 (Dta + name in ScRsp)",
-					&add_advertising_dta_name_scrsp,
-					setup_command_generic,
-					test_command_generic);
+	test_bredrle("Add Advertising - Success (ScRsp appear)",
+					&add_advertising_scrsp_appear_data_ok,
+				setup_command_generic, test_command_generic);
 
-	test_bredrle("Add Advertising - Success 5 (Appearance in ScRsp)",
-					&add_advertising_appearance_scrsp,
-					setup_command_generic,
-					test_command_generic);
+	test_bredrle("Add Advertising - Invalid Params (ScRsp appear long)",
+				&add_advertising_scrsp_appear_data_too_long,
+				setup_command_generic, test_command_generic);
 
-	test_bredrle("Add Advertising - Success 6 (Appear + Dta in ScRsp)",
-					&add_advertising_appear_data_scrsp,
-					setup_command_generic,
-					test_command_generic);
+	test_bredrle("Add Advertising - Success (Appear is null)",
+					&add_advertising_scrsp_appear_null,
+						NULL, test_command_generic);
 
-	test_bredrle("Add Advertising - Invalid Params 1 (ScRsp Too long)",
-					&add_advertising_scrsp_too_long,
-					setup_command_generic,
-					test_command_generic);
+	test_bredrle("Add Advertising - Success (Name is null)",
+					 &add_advertising_no_name_set,
+					 NULL, test_command_generic);
 
-	test_bredrle("Add Advertising - Success 1 (Name + appear in ScRsp)",
-					&add_advertising_name_appear_scrsp,
+	test_bredrle("Add Advertising - Success (Complete name)",
+					&add_advertising_name_fits_in_scrsp,
 					setup_command_generic,
 					test_command_generic);
 
-	test_bredrle("Add Advertising - Success 2 (Appear + Dta + name)",
-					&add_advertising_appear_data_name,
-					setup_command_generic,
-					test_command_generic);
+	test_bredrle("Add Advertising - Success (Short name)",
+					 &add_advertising_short_name_in_scrsp,
+					 setup_command_generic,
+					 test_command_generic);
 
-	test_bredrle("Add Advertising - Success 3 (Appear + Dta + short)",
-					&add_advertising_appear_data_short,
-					setup_command_generic,
-					test_command_generic);
+	test_bredrle("Add Advertising - Success (Name + data)",
+					 &add_advertising_name_data_ok,
+					 setup_command_generic,
+					 test_command_generic);
 
+	test_bredrle("Add Advertising - Invalid Params (Name + data)",
+					 &add_advertising_name_data_inv,
+					 setup_command_generic,
+					 test_command_generic);
+
+	test_bredrle("Add Advertising - Success (Name+data+appear)",
+					 &add_advertising_name_data_appear,
+					 setup_command_generic,
+					 test_command_generic);
 
 	test_bredrle("Remove Advertising - Invalid Params 1",
 					&remove_advertising_fail_1,
 					NULL, test_command_generic);
+
 	test_bredrle("Remove Advertising - Success 1",
 						&remove_advertising_success_1,
 						setup_add_advertising,
-- 
2.7.4

