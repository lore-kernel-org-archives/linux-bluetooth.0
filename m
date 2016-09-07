Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH 3/5] tools/mgmt-tester: Test add local name in scan rsp data
Date: Wed,  7 Sep 2016 22:57:45 +0200
Message-Id: <1473281867-8560-3-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1473281867-8560-1-git-send-email-szymon.janc@codecoup.pl>
References: <1473281867-8560-1-git-send-email-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Michał Narajowski <michal.narajowski@codecoup.pl>

Appropriate HCI command is expected in setup section because as soon as
new local name is registered in the kernel the
HCI_OP_LE_SET_SCAN_RSP_DATA is triggered. Then when we pass
Add_local_name_to_Scan_rsp_data flag in Add advertising command the HCI
command is not triggered because Scan response data has not changed.
---
 tools/mgmt-tester.c | 190 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 188 insertions(+), 2 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 1533cc1..9a06fa3 100644
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
@@ -6163,6 +6163,172 @@ static void setup_set_local_name(const void *test_data)
 	tester_setup_complete();
 }
 
+static const uint8_t add_advertising_param_local_name1[] = {
+	0x01,			/* adv instance */
+	0x40, 0x00, 0x00, 0x00,	/* flags: Add local name to scan_rsp */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x00,			/* scan rsp len */
+};
+
+static const uint8_t set_scan_rsp_data_local_name1[] = {
+	0x0b, /* Scan rsp data len */
+	0x0a, /* Local name data len */
+	0x09, /* Complete name */
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "Test name" */
+	/* padding */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const struct generic_data add_advertising_with_local_name1 = {
+	.setup_settings = settings_powered_le,
+	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.setup_expect_hci_param = set_scan_rsp_data_local_name1,
+	.setup_expect_hci_len = sizeof(set_scan_rsp_data_local_name1),
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = set_local_name_param,
+	.setup_send_len = sizeof(set_local_name_param),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_local_name1,
+	.send_len = sizeof(add_advertising_param_local_name1),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+};
+
+static const uint8_t add_advertising_param_local_name2[] = {
+	0x01,			/* adv instance */
+	0x00, 0x00, 0x00, 0x00,	/* flags: none */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x00,			/* adv data len */
+	0x00,			/* scan rsp len */
+};
+
+static const uint8_t set_scan_rsp_data_local_name2[] = {
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00,
+};
+
+static const struct generic_data add_advertising_with_local_name2 = {
+	.setup_settings = settings_powered_le,
+	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.setup_expect_hci_param = set_scan_rsp_data_local_name1,
+	.setup_expect_hci_len = sizeof(set_scan_rsp_data_local_name1),
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = set_local_name_param,
+	.setup_send_len = sizeof(set_local_name_param),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_local_name2,
+	.send_len = sizeof(add_advertising_param_local_name2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_data_local_name2,
+	.expect_hci_len = sizeof(set_scan_rsp_data_local_name2),
+};
+
+static const uint8_t add_advertising_param_local_name3[] = {
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
+static const uint8_t set_scan_rsp_data_local_name3[] = {
+	0x1f, /* Scan rsp data len */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x0a, /* Local name data len */
+	0x09, /* Complete name */
+	0x54, 0x65, 0x73, 0x74, 0x20, 0x6e, 0x61, 0x6d, 0x65, /* "Test name" */
+};
+
+static const struct generic_data add_advertising_with_local_name3 = {
+	.setup_settings = settings_powered_le,
+	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.setup_expect_hci_param = set_scan_rsp_data_local_name1,
+	.setup_expect_hci_len = sizeof(set_scan_rsp_data_local_name1),
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = set_local_name_param,
+	.setup_send_len = sizeof(set_local_name_param),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_local_name3,
+	.send_len = sizeof(add_advertising_param_local_name3),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_data_local_name3,
+	.expect_hci_len = sizeof(set_scan_rsp_data_local_name3),
+};
+
+static const uint8_t add_advertising_param_local_name4[] = {
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
+static const uint8_t set_scan_rsp_data_local_name4[] = {
+	0x1f, /* Scan rsp len */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, /* placeholder data */
+	0x05, /* Local name length */
+	0x08, /* Shortened name */
+	0x54, 0x65, 0x73, 0x74, /* "Test" */
+};
+
+static const struct generic_data add_advertising_with_local_name4 = {
+	.setup_settings = settings_powered_le,
+	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.setup_expect_hci_param = set_scan_rsp_data_local_name1,
+	.setup_expect_hci_len = sizeof(set_scan_rsp_data_local_name1),
+	.setup_send_opcode = MGMT_OP_SET_LOCAL_NAME,
+	.setup_send_param = set_local_name_param,
+	.setup_send_len = sizeof(set_local_name_param),
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_local_name4,
+	.send_len = sizeof(add_advertising_param_local_name4),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
+	.expect_hci_param = set_scan_rsp_data_local_name4,
+	.expect_hci_len = sizeof(set_scan_rsp_data_local_name4),
+};
+
 static bool power_off(uint16_t index)
 {
 	int sk, err;
@@ -7388,6 +7554,26 @@ int main(int argc, char *argv[])
 					setup_add_advertising_duration,
 					test_command_generic, 3);
 
+	test_bredrle("Add Advertising - Scan rsp flags 1",
+					&add_advertising_with_local_name1,
+					setup_set_local_name,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Scan rsp flags 2",
+					&add_advertising_with_local_name2,
+					setup_set_local_name,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Scan rsp flags 3",
+					&add_advertising_with_local_name3,
+					setup_set_local_name,
+					test_command_generic);
+
+	test_bredrle("Add Advertising - Scan rsp flags 4",
+					&add_advertising_with_local_name4,
+					setup_set_local_name,
+					test_command_generic);
+
 	test_bredrle("Read Ext Controller Info 1",
 				&read_ext_ctrl_info1,
 				setup_set_local_name, test_command_generic);
-- 
2.7.4

