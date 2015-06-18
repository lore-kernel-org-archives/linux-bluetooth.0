Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v9 06/16] tools/mgmt-tester: comment add adv test setup
Date: Thu, 18 Jun 2015 03:17:36 +0200
Message-Id: <1434590266-26744-7-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434590266-26744-1-git-send-email-fgrandel@gmail.com>
References: <1434590266-26744-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
References: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The add advertising test setup data was just a number of arrays with
undocumented hex data. This sometimes made it difficult to understand
the test intent.

Comments have been added to the add advertising mgmt and hci parameter
data arrays to make them more readable and better document the test
intent.
---
 tools/mgmt-tester.c | 454 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 268 insertions(+), 186 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index be0f09a..eda69f7 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -3865,7 +3865,11 @@ static const struct generic_data read_adv_features_invalid_index_test = {
 };
 
 static const uint8_t read_adv_features_rsp_1[] =  {
-			0x1f, 0x00, 0x00, 0x00, 0x1f, 0x1f, 0x01, 0x00,
+	0x1f, 0x00, 0x00, 0x00,	/* supported flags */
+	0x1f,			/* max_adv_data_len */
+	0x1f,			/* max_scan_rsp_len */
+	0x01,			/* max_instances */
+	0x00,			/* num_instances */
 };
 
 static const struct generic_data read_adv_features_success_1 = {
@@ -3876,7 +3880,12 @@ static const struct generic_data read_adv_features_success_1 = {
 };
 
 static const uint8_t read_adv_features_rsp_2[] =  {
-			0x1f, 0x00, 0x00, 0x00, 0x1f, 0x1f, 0x01, 0x01, 0x01
+	0x1f, 0x00, 0x00, 0x00,	/* supported flags */
+	0x1f,			/* max_adv_data_len */
+	0x1f,			/* max_scan_rsp_len */
+	0x01,			/* max_instances */
+	0x01,			/* num_instances */
+	0x01,			/* instance identifiers */
 };
 
 static const struct generic_data read_adv_features_success_2 = {
@@ -3886,114 +3895,187 @@ static const struct generic_data read_adv_features_success_2 = {
 	.expect_status = MGMT_STATUS_SUCCESS,
 };
 
-static const uint8_t add_advertising_param_1[] = {
-	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
-	0x03, 0x02, 0x0d, 0x18,
-	0x04, 0xff, 0x01, 0x02, 0x03,
-};
-
-static const uint8_t add_advertising_param_2[] = {
-	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x0a,
-	0x03, 0x02, 0x0d, 0x18,
-	0x04, 0xff, 0x01, 0x02, 0x03,
-	0x03, 0x19, 0x40, 0x03,
-	0x05, 0x03, 0x0d, 0x18, 0x0f, 0x18,
-};
-
-static const uint8_t add_advertising_param_3[] = {
-	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x00, 0x09, 0x00,
-	0x03, 0x02, 0x0d, 0x18,
-	0x04, 0xff, 0x01, 0x02, 0x03,
-};
-
-static const uint8_t add_advertising_param_4[] = {
-	0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
-	0x03, 0x02, 0x0d, 0x18,
-	0x04, 0xff, 0x01, 0x02, 0x03,
-};
-
-static const uint8_t add_advertising_param_5[] = {
-	0x01, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
-	0x03, 0x02, 0x0d, 0x18,
-	0x04, 0xff, 0x01, 0x02, 0x03,
-};
-
-static const uint8_t add_advertising_param_6[] = {
-	0x01, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
-	0x03, 0x02, 0x0d, 0x18,
-	0x04, 0xff, 0x01, 0x02, 0x03,
-};
-
-static const uint8_t add_advertising_param_7[] = {
-	0x01, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
-	0x03, 0x02, 0x0d, 0x18,
-	0x04, 0xff, 0x01, 0x02, 0x03,
-};
-
-static const uint8_t add_advertising_param_8[] = {
-	0x01, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
-	0x03, 0x02, 0x0d, 0x18,
-	0x04, 0xff, 0x01, 0x02, 0x03,
-};
-
-static const uint8_t advertising_instance_param[] = {
+/* simple add advertising command */
+static const uint8_t add_advertising_param_uuid[] = {
+	0x01,			/* adv instance */
+	0x00, 0x00, 0x00, 0x00,	/* flags: none */
+	0x00, 0x00,		/* duration: default */
+	0x00, 0x00,		/* timeout: none */
+	0x09,			/* adv data len */
+	0x00,			/* scan rsp len */
+	/* adv data: */
+	0x03,			/* AD len */
+	0x02,			/* AD type: some 16 bit service class UUIDs */
+	0x0d, 0x18,		/* heart rate monitor */
+	0x04,			/* AD len */
+	0xff,			/* AD type: manufacturer specific data */
+	0x01, 0x02, 0x03,	/* custom advertising data */
+};
+
+/* add advertising with scan response data */
+static const uint8_t add_advertising_param_scanrsp[] = {
+	/* instance, flags, duration, timeout, adv data len: same as before */
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09,
+	0x0a,			/* scan rsp len */
+	/* adv data: same as before */
+	0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
+	/* scan rsp data: */
+	0x03,			/* AD len */
+	0x19,			/* AD type: external appearance */
+	0x40, 0x03,		/* some custom appearance */
+	0x05,			/* AD len */
+	0x03,			/* AD type: all 16 bit service class UUIDs */
+	0x0d, 0x18,		/* heart rate monitor */
+	0x0f, 0x18,		/* battery service */
+};
+
+/* add advertising with timeout */
+static const uint8_t add_advertising_param_timeout[] = {
+	/* instance, flags, duration: same as before */
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x05, 0x00,		/* timeout: 5 seconds */
+	/* adv data: same as before */
+	0x09, 0x00, 0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
+};
+
+/* add advertising with connectable flag */
+static const uint8_t add_advertising_param_connectable[] = {
+	0x01,			/* adv instance */
+	0x01, 0x00, 0x00, 0x00,	/* flags: connectable*/
+	/* duration, timeout, adv/scan data: same as before */
+	0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
+	0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
+};
+
+/* add advertising with general discoverable flag */
+static const uint8_t add_advertising_param_general_discov[] = {
+	0x01,			/* adv instance */
+	0x02, 0x00, 0x00, 0x00,	/* flags: general discoverable*/
+	/* duration, timeout, adv/scan data: same as before */
+	0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
+	0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
+};
+
+/* add advertising with limited discoverable flag */
+static const uint8_t add_advertising_param_limited_discov[] = {
+	0x01,			/* adv instance */
+	0x04, 0x00, 0x00, 0x00,	/* flags: limited discoverable */
+	/* duration, timeout, adv/scan data: same as before */
+	0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
+	0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
+};
+
+/* add advertising with managed flags */
+static const uint8_t add_advertising_param_managed[] = {
+	0x01,			/* adv instance */
+	0x08, 0x00, 0x00, 0x00,	/* flags: managed flags */
+	/* duration, timeout, adv/scan data: same as before */
+	0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
+	0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
+};
+
+/* add advertising with tx power flag */
+static const uint8_t add_advertising_param_txpwr[] = {
+	0x01,			/* adv instance */
+	0x10, 0x00, 0x00, 0x00,	/* flags: tx power */
+	/* duration, timeout, adv/scan data: same as before */
+	0x00, 0x00, 0x00, 0x00, 0x09, 0x00,
+	0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
+};
+
+static const uint8_t advertising_instance1_param[] = {
 	0x01,
 };
 
-static const uint8_t set_adv_data_1[] = {
-	0x09, 0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
+static const uint8_t set_adv_data_uuid[] = {
+	/* adv data len */
+	0x09,
+	/* advertise heart rate monitor and manufacturer specific data */
+	0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
+	/* padding */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00,
 };
 
-static const uint8_t set_adv_data_2[] = {
-	0x06, 0x05, 0x08, 0x74, 0x65, 0x73, 0x74, 0x00, 0x00, 0x00,
+static const uint8_t set_adv_data_test[] = {
+	0x06,			/* adv data len */
+	0x05,			/* AD len */
+	0x08,			/* AD type: shortened local name */
+	0x74, 0x65, 0x73, 0x74,	/* "test" */
+	/* padding */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
-static const uint8_t set_adv_data_3[] = {
-	0x03, 0x02, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+static const uint8_t set_adv_data_txpwr[] = {
+	0x03,			/* adv data len */
+	0x02, 			/* AD len */
+	0x0a,			/* AD type: tx power */
+	0x00,			/* tx power */
+	/* padding */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00,
-};
-
-static const uint8_t set_adv_data_4[] = {
-	0x0c, 0x02, 0x01, 0x02, 0x03, 0x02, 0x0d, 0x18, 0x04, 0xff,
-	0x01, 0x02, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const uint8_t set_adv_data_general_discov[] = {
+	0x0c,			/* adv data len */
+	0x02,			/* AD len */
+	0x01,			/* AD type: flags */
+	0x02,			/* general discoverable */
+	0x03,			/* AD len */
+	0x02,			/* AD type: some 16bit service class UUIDs */
+	0x0d, 0x18,		/* heart rate monitor */
+	0x04,			/* AD len */
+	0xff,			/* AD type: manufacturer specific data */
+	0x01, 0x02, 0x03,	/* custom advertising data */
+	/* padding */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
-static const uint8_t set_adv_data_5[] = {
-	0x0c, 0x02, 0x01, 0x01, 0x03, 0x02, 0x0d, 0x18, 0x04, 0xff,
-	0x01, 0x02, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+static const uint8_t set_adv_data_limited_discov[] = {
+	0x0c,			/* adv data len */
+	0x02,			/* AD len */
+	0x01,			/* AD type: flags */
+	0x01,			/* limited discoverable */
+	/* rest: same as before */
+	0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
+	/* padding */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00,
-};
-
-static const uint8_t set_adv_data_6[] = {
-	0x0c, 0x02, 0x01, 0x02, 0x03, 0x02, 0x0d, 0x18, 0x04, 0xff,
-	0x01, 0x02, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const uint8_t set_adv_data_uuid_txpwr[] = {
+	0x0c,			/* adv data len */
+	0x03,			/* AD len */
+	0x02,			/* AD type: some 16bit service class UUIDs */
+	0x0d, 0x18,		/* heart rate monitor */
+	0x04,			/* AD len */
+	0xff,			/* AD type: manufacturer specific data */
+	0x01, 0x02, 0x03,	/* custom advertising data */
+	0x02,			/* AD len */
+	0x0a,			/* AD type: tx power */
+	0x00,			/* tx power */
+	/* padding */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00,
-};
-
-static const uint8_t set_adv_data_7[] = {
-	0x0c, 0x03, 0x02, 0x0d, 0x18, 0x04, 0xff, 0x01, 0x02, 0x03,
-	0x02, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static const uint8_t set_scan_rsp_uuid[] = {
+	0x0a,			/* scan rsp data len */
+	0x03,			/* AD len */
+	0x19,			/* AD type: external appearance */
+	0x40, 0x03,		/* some custom appearance */
+	0x05,			/* AD len */
+	0x03,			/* AD type: all 16 bit service class UUIDs */
+	0x0d, 0x18, 0x0f, 0x18,	/* heart rate monitor, battery service */
+	/* padding */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00,
-};
-
-static const uint8_t set_scan_rsp_1[] = {
-	0x0a, 0x03, 0x19, 0x40, 0x03, 0x05, 0x03, 0x0d, 0x18, 0x0f,
-	0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00,
+	0x00,
 };
 
 static const uint8_t add_advertising_invalid_param_1[] = {
@@ -4067,8 +4149,8 @@ static const uint8_t add_advertising_invalid_param_10[] = {
 static const struct generic_data add_advertising_fail_1 = {
 	.setup_settings = settings_powered,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_1,
-	.send_len = sizeof(add_advertising_param_1),
+	.send_param = add_advertising_param_uuid,
+	.send_len = sizeof(add_advertising_param_uuid),
 	.expect_status = MGMT_STATUS_REJECTED,
 };
 
@@ -4155,25 +4237,25 @@ static const struct generic_data add_advertising_fail_11 = {
 static const struct generic_data add_advertising_fail_12 = {
 	.setup_settings = settings_le,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_3,
-	.send_len = sizeof(add_advertising_param_3),
+	.send_param = add_advertising_param_timeout,
+	.send_len = sizeof(add_advertising_param_timeout),
 	.expect_status = MGMT_STATUS_REJECTED,
 };
 
 static const struct generic_data add_advertising_success_1 = {
 	.setup_settings = settings_powered_le,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_1,
-	.send_len = sizeof(add_advertising_param_1),
-	.expect_param = advertising_instance_param,
-	.expect_len = sizeof(advertising_instance_param),
+	.send_param = add_advertising_param_uuid,
+	.send_len = sizeof(add_advertising_param_uuid),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_alt_ev = MGMT_EV_ADVERTISING_ADDED,
-	.expect_alt_ev_param = advertising_instance_param,
-	.expect_alt_ev_len = sizeof(advertising_instance_param),
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
-	.expect_hci_param = set_adv_data_1,
-	.expect_hci_len = sizeof(set_adv_data_1),
+	.expect_hci_param = set_adv_data_uuid,
+	.expect_hci_len = sizeof(set_adv_data_uuid),
 };
 
 static const char set_powered_adv_instance_settings_param[] = {
@@ -4188,8 +4270,8 @@ static const struct generic_data add_advertising_success_2 = {
 	.expect_param = set_powered_adv_instance_settings_param,
 	.expect_len = sizeof(set_powered_adv_instance_settings_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
-	.expect_hci_param = set_adv_data_2,
-	.expect_hci_len = sizeof(set_adv_data_2),
+	.expect_hci_param = set_adv_data_test,
+	.expect_hci_len = sizeof(set_adv_data_test),
 };
 
 static const struct generic_data add_advertising_success_3 = {
@@ -4212,8 +4294,8 @@ static const struct generic_data add_advertising_success_4 = {
 	.expect_param = set_adv_settings_param_2,
 	.expect_len = sizeof(set_adv_settings_param_2),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
-	.expect_hci_param = set_adv_data_3,
-	.expect_hci_len = sizeof(set_adv_data_3),
+	.expect_hci_param = set_adv_data_txpwr,
+	.expect_hci_len = sizeof(set_adv_data_txpwr),
 };
 
 static const char set_adv_off_param[] = { 0x00 };
@@ -4226,49 +4308,49 @@ static const struct generic_data add_advertising_success_5 = {
 	.expect_param = set_powered_adv_instance_settings_param,
 	.expect_len = sizeof(set_powered_adv_instance_settings_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
-	.expect_hci_param = set_adv_data_2,
-	.expect_hci_len = sizeof(set_adv_data_2),
+	.expect_hci_param = set_adv_data_test,
+	.expect_hci_len = sizeof(set_adv_data_test),
 };
 
 static const struct generic_data add_advertising_success_6 = {
 	.setup_settings = settings_powered_le,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_2,
-	.send_len = sizeof(add_advertising_param_2),
-	.expect_param = advertising_instance_param,
-	.expect_len = sizeof(advertising_instance_param),
+	.send_param = add_advertising_param_scanrsp,
+	.send_len = sizeof(add_advertising_param_scanrsp),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_alt_ev = MGMT_EV_ADVERTISING_ADDED,
-	.expect_alt_ev_param = advertising_instance_param,
-	.expect_alt_ev_len = sizeof(advertising_instance_param),
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
-	.expect_hci_param = set_adv_data_1,
-	.expect_hci_len = sizeof(set_adv_data_1),
+	.expect_hci_param = set_adv_data_uuid,
+	.expect_hci_len = sizeof(set_adv_data_uuid),
 };
 
 static const struct generic_data add_advertising_success_7 = {
 	.setup_settings = settings_powered_le,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_2,
-	.send_len = sizeof(add_advertising_param_2),
-	.expect_param = advertising_instance_param,
-	.expect_len = sizeof(advertising_instance_param),
+	.send_param = add_advertising_param_scanrsp,
+	.send_len = sizeof(add_advertising_param_scanrsp),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_alt_ev = MGMT_EV_ADVERTISING_ADDED,
-	.expect_alt_ev_param = advertising_instance_param,
-	.expect_alt_ev_len = sizeof(advertising_instance_param),
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_SCAN_RSP_DATA,
-	.expect_hci_param = set_scan_rsp_1,
-	.expect_hci_len = sizeof(set_scan_rsp_1),
+	.expect_hci_param = set_scan_rsp_uuid,
+	.expect_hci_len = sizeof(set_scan_rsp_uuid),
 };
 
 static const struct generic_data add_advertising_success_8 = {
 	.setup_settings = settings_powered_le,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_4,
-	.send_len = sizeof(add_advertising_param_4),
-	.expect_param = advertising_instance_param,
-	.expect_len = sizeof(advertising_instance_param),
+	.send_param = add_advertising_param_connectable,
+	.send_len = sizeof(add_advertising_param_connectable),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
 	.expect_hci_param = set_connectable_on_adv_param,
@@ -4278,53 +4360,53 @@ static const struct generic_data add_advertising_success_8 = {
 static const struct generic_data add_advertising_success_9 = {
 	.setup_settings = settings_powered_le,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_5,
-	.send_len = sizeof(add_advertising_param_5),
-	.expect_param = advertising_instance_param,
-	.expect_len = sizeof(advertising_instance_param),
+	.send_param = add_advertising_param_general_discov,
+	.send_len = sizeof(add_advertising_param_general_discov),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
-	.expect_hci_param = set_adv_data_4,
-	.expect_hci_len = sizeof(set_adv_data_4),
+	.expect_hci_param = set_adv_data_general_discov,
+	.expect_hci_len = sizeof(set_adv_data_general_discov),
 };
 
 static const struct generic_data add_advertising_success_10 = {
 	.setup_settings = settings_powered_le,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_6,
-	.send_len = sizeof(add_advertising_param_6),
-	.expect_param = advertising_instance_param,
-	.expect_len = sizeof(advertising_instance_param),
+	.send_param = add_advertising_param_limited_discov,
+	.send_len = sizeof(add_advertising_param_limited_discov),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
-	.expect_hci_param = set_adv_data_5,
-	.expect_hci_len = sizeof(set_adv_data_5),
+	.expect_hci_param = set_adv_data_limited_discov,
+	.expect_hci_len = sizeof(set_adv_data_limited_discov),
 };
 
 static const struct generic_data add_advertising_success_11 = {
 	.setup_settings = settings_powered_le_discoverable,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_7,
-	.send_len = sizeof(add_advertising_param_7),
-	.expect_param = advertising_instance_param,
-	.expect_len = sizeof(advertising_instance_param),
+	.send_param = add_advertising_param_managed,
+	.send_len = sizeof(add_advertising_param_managed),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
-	.expect_hci_param = set_adv_data_6,
-	.expect_hci_len = sizeof(set_adv_data_6),
+	.expect_hci_param = set_adv_data_general_discov,
+	.expect_hci_len = sizeof(set_adv_data_general_discov),
 };
 
 static const struct generic_data add_advertising_success_12 = {
 	.setup_settings = settings_powered_le_discoverable,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_8,
-	.send_len = sizeof(add_advertising_param_8),
-	.expect_param = advertising_instance_param,
-	.expect_len = sizeof(advertising_instance_param),
+	.send_param = add_advertising_param_txpwr,
+	.send_len = sizeof(add_advertising_param_txpwr),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_DATA,
-	.expect_hci_param = set_adv_data_7,
-	.expect_hci_len = sizeof(set_adv_data_7),
+	.expect_hci_param = set_adv_data_uuid_txpwr,
+	.expect_hci_len = sizeof(set_adv_data_uuid_txpwr),
 };
 
 static uint16_t settings_powered_le_connectable[] = {
@@ -4346,10 +4428,10 @@ static uint8_t set_connectable_off_scan_adv_param[] = {
 static const struct generic_data add_advertising_success_13 = {
 	.setup_settings = settings_powered_le,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_2,
-	.send_len = sizeof(add_advertising_param_2),
-	.expect_param = advertising_instance_param,
-	.expect_len = sizeof(advertising_instance_param),
+	.send_param = add_advertising_param_scanrsp,
+	.send_len = sizeof(add_advertising_param_scanrsp),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
 	.expect_hci_param = set_connectable_off_scan_adv_param,
@@ -4359,10 +4441,10 @@ static const struct generic_data add_advertising_success_13 = {
 static const struct generic_data add_advertising_success_14 = {
 	.setup_settings = settings_powered_le,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_1,
-	.send_len = sizeof(add_advertising_param_1),
-	.expect_param = advertising_instance_param,
-	.expect_len = sizeof(advertising_instance_param),
+	.send_param = add_advertising_param_uuid,
+	.send_len = sizeof(add_advertising_param_uuid),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
 	.expect_hci_param = set_connectable_off_adv_param,
@@ -4372,10 +4454,10 @@ static const struct generic_data add_advertising_success_14 = {
 static const struct generic_data add_advertising_success_15 = {
 	.setup_settings = settings_powered_le_connectable,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
-	.send_param = add_advertising_param_1,
-	.send_len = sizeof(add_advertising_param_1),
-	.expect_param = advertising_instance_param,
-	.expect_len = sizeof(advertising_instance_param),
+	.send_param = add_advertising_param_uuid,
+	.send_len = sizeof(add_advertising_param_uuid),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
 	.expect_hci_param = set_connectable_on_adv_param,
@@ -4413,7 +4495,7 @@ static const char set_powered_off_le_settings_param[] = {
 	0x80, 0x02, 0x00, 0x00
 };
 
-static const struct generic_data add_advertising_timeout_power_off = {
+static const struct generic_data add_advertising_power_off = {
 	.send_opcode = MGMT_OP_SET_POWERED,
 	.send_param = set_powered_off_param,
 	.send_len = sizeof(set_powered_off_param),
@@ -4421,8 +4503,8 @@ static const struct generic_data add_advertising_timeout_power_off = {
 	.expect_param = set_powered_off_le_settings_param,
 	.expect_len = sizeof(set_powered_off_le_settings_param),
 	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
-	.expect_alt_ev_param = advertising_instance_param,
-	.expect_alt_ev_len = sizeof(advertising_instance_param),
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
 };
 
 static const uint8_t remove_advertising_param_1[] = {
@@ -4448,8 +4530,8 @@ static const struct generic_data remove_advertising_success_1 = {
 	.expect_param = remove_advertising_param_1,
 	.expect_len = sizeof(remove_advertising_param_1),
 	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
-	.expect_alt_ev_param = advertising_instance_param,
-	.expect_alt_ev_len = sizeof(advertising_instance_param),
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_ENABLE,
 	.expect_hci_param = set_adv_off_param,
 	.expect_hci_len = sizeof(set_adv_off_param),
@@ -4463,8 +4545,8 @@ static const struct generic_data remove_advertising_success_2 = {
 	.expect_param = remove_advertising_param_2,
 	.expect_len = sizeof(remove_advertising_param_2),
 	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
-	.expect_alt_ev_param = advertising_instance_param,
-	.expect_alt_ev_len = sizeof(advertising_instance_param),
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_ENABLE,
 	.expect_hci_param = set_adv_off_param,
 	.expect_hci_len = sizeof(set_adv_off_param),
@@ -4914,9 +4996,9 @@ static void setup_add_advertising_not_powered(const void *test_data)
 
 	cp->instance = 1;
 	cp->adv_data_len = 6;
-	cp->data[0] = 0x05;
-	cp->data[1] = 0x08;
-	cp->data[2] = 't';
+	cp->data[0] = 0x05; /* AD len */
+	cp->data[1] = 0x08; /* AD type: shortened local name */
+	cp->data[2] = 't';  /* adv data ... */
 	cp->data[3] = 'e';
 	cp->data[4] = 's';
 	cp->data[5] = 't';
@@ -4945,9 +5027,9 @@ static void setup_add_advertising(const void *test_data)
 
 	cp->instance = 1;
 	cp->adv_data_len = 6;
-	cp->data[0] = 0x05;
-	cp->data[1] = 0x08;
-	cp->data[2] = 't';
+	cp->data[0] = 0x05; /* AD len */
+	cp->data[1] = 0x08; /* AD type: shortened local name */
+	cp->data[2] = 't';  /* adv data ... */
 	cp->data[3] = 'e';
 	cp->data[4] = 's';
 	cp->data[5] = 't';
@@ -4980,9 +5062,9 @@ static void setup_add_advertising_connectable(const void *test_data)
 
 	cp->instance = 1;
 	cp->adv_data_len = 6;
-	cp->data[0] = 0x05;
-	cp->data[1] = 0x08;
-	cp->data[2] = 't';
+	cp->data[0] = 0x05; /* AD len */
+	cp->data[1] = 0x08; /* AD type: shortened local name */
+	cp->data[2] = 't';  /* adv data ... */
 	cp->data[3] = 'e';
 	cp->data[4] = 's';
 	cp->data[5] = 't';
@@ -5020,9 +5102,9 @@ static void setup_add_advertising_timeout(const void *test_data)
 	cp->instance = 1;
 	cp->timeout = 5;
 	cp->adv_data_len = 6;
-	cp->data[0] = 0x05;
-	cp->data[1] = 0x08;
-	cp->data[2] = 't';
+	cp->data[0] = 0x05; /* AD len */
+	cp->data[1] = 0x08; /* AD type: shortened local name */
+	cp->data[2] = 't';  /* adv data ... */
 	cp->data[3] = 'e';
 	cp->data[4] = 's';
 	cp->data[5] = 't';
@@ -5055,9 +5137,9 @@ static void setup_set_and_add_advertising(const void *test_data)
 
 	cp->instance = 1;
 	cp->adv_data_len = 6;
-	cp->data[0] = 0x05;
-	cp->data[1] = 0x08;
-	cp->data[2] = 't';
+	cp->data[0] = 0x05; /* AD len */
+	cp->data[1] = 0x08; /* AD type: shortened local name */
+	cp->data[2] = 't';  /* adv data ... */
 	cp->data[3] = 'e';
 	cp->data[4] = 's';
 	cp->data[5] = 't';
@@ -6498,7 +6580,7 @@ int main(int argc, char *argv[])
 					&add_advertising_fail_12,
 					NULL, test_command_generic);
 	test_bredrle("Add Advertising - Timeout Power off",
-					&add_advertising_timeout_power_off,
+					&add_advertising_power_off,
 					setup_add_advertising_timeout,
 					test_command_generic);
 	test_bredrle("Add Advertising - Success 1",
-- 
1.9.1

