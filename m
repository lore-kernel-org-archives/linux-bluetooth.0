Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH BlueZ 7/8] mgmt-tester: Add tests for extended scanning and device found
Date: Fri,  6 Jul 2018 16:58:04 +0530
Message-Id: <1530876485-17218-8-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1530876485-17218-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1530876485-17218-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/mgmt-tester.c | 245 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 245 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 20d939f..d4ebdb6 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -8375,6 +8375,206 @@ static const struct generic_data set_phy_invalid_param = {
 	.expect_status = MGMT_STATUS_INVALID_PARAMS,
 };
 
+static const char start_discovery_valid_ext_scan_enable[] = {
+	0x01,
+	0x01,
+	0x00, 0x00,
+	0x00, 0x00
+};
+
+static const struct generic_data start_discovery_bredrle_ext_scan_enable = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_START_DISCOVERY,
+	.send_param = start_discovery_bredrle_param,
+	.send_len = sizeof(start_discovery_bredrle_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = start_discovery_bredrle_param,
+	.expect_len = sizeof(start_discovery_bredrle_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE,
+	.expect_hci_param = start_discovery_valid_ext_scan_enable,
+	.expect_hci_len = sizeof(start_discovery_valid_ext_scan_enable),
+	.expect_alt_ev = MGMT_EV_DISCOVERING,
+	.expect_alt_ev_param = start_discovery_evt,
+	.expect_alt_ev_len = sizeof(start_discovery_evt),
+};
+
+static const struct generic_data start_discovery_le_ext_scan_enable = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_START_DISCOVERY,
+	.send_param = start_discovery_le_param,
+	.send_len = sizeof(start_discovery_le_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = start_discovery_le_param,
+	.expect_len = sizeof(start_discovery_le_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE,
+	.expect_hci_param = start_discovery_valid_ext_scan_enable,
+	.expect_hci_len = sizeof(start_discovery_valid_ext_scan_enable),
+	.expect_alt_ev = MGMT_EV_DISCOVERING,
+	.expect_alt_ev_param = start_discovery_le_evt,
+	.expect_alt_ev_len = sizeof(start_discovery_le_evt),
+};
+
+static const char start_discovery_valid_ext_scan_param[] = {
+	0x01,			/* Own Addr type*/
+	0x00,			/* Scan filter policy*/
+	0x01,			/*Phys - 1m */
+	0x01,			/* Type */
+	0x12, 0x00,		/* Interval */
+	0x12, 0x00,		/* Window */
+};
+
+static const struct generic_data start_discovery_le_ext_scan_param = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_START_DISCOVERY,
+	.send_param = start_discovery_le_param,
+	.send_len = sizeof(start_discovery_le_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = start_discovery_le_param,
+	.expect_len = sizeof(start_discovery_le_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS,
+	.expect_hci_param = start_discovery_valid_ext_scan_param,
+	.expect_hci_len = sizeof(start_discovery_valid_ext_scan_param),
+	.expect_alt_ev = MGMT_EV_DISCOVERING,
+	.expect_alt_ev_param = start_discovery_le_evt,
+	.expect_alt_ev_len = sizeof(start_discovery_le_evt),
+};
+
+static const char stop_discovery_valid_ext_scan_disable[] = {
+	0x00,
+	0x00,
+	0x00, 0x00,
+	0x00, 0x00
+};
+
+static const struct generic_data stop_discovery_le_ext_scan_disable = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_START_DISCOVERY,
+	.setup_send_param = start_discovery_bredrle_param,
+	.setup_send_len = sizeof(start_discovery_bredrle_param),
+	.send_opcode = MGMT_OP_STOP_DISCOVERY,
+	.send_param = stop_discovery_bredrle_param,
+	.send_len = sizeof(stop_discovery_bredrle_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = stop_discovery_bredrle_param,
+	.expect_len = sizeof(stop_discovery_bredrle_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE,
+	.expect_hci_param = stop_discovery_valid_ext_scan_disable,
+	.expect_hci_len = sizeof(stop_discovery_valid_ext_scan_disable),
+	.expect_alt_ev = MGMT_EV_DISCOVERING,
+	.expect_alt_ev_param = stop_discovery_evt,
+	.expect_alt_ev_len = sizeof(stop_discovery_evt),
+};
+
+static const struct generic_data start_discovery_le_2m_scan_param = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_SET_PHY_CONFIGURATION,
+	.setup_send_param = set_phy_2m_param,
+	.setup_send_len = sizeof(set_phy_2m_param),
+	.send_opcode = MGMT_OP_START_DISCOVERY,
+	.send_param = start_discovery_bredrle_param,
+	.send_len = sizeof(start_discovery_bredrle_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = start_discovery_bredrle_param,
+	.expect_len = sizeof(start_discovery_bredrle_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS,
+	.expect_hci_param = start_discovery_valid_ext_scan_param,
+	.expect_hci_len = sizeof(start_discovery_valid_ext_scan_param),
+	.expect_alt_ev = MGMT_EV_DISCOVERING,
+	.expect_alt_ev_param = start_discovery_evt,
+	.expect_alt_ev_len = sizeof(start_discovery_evt),
+};
+
+static const char start_discovery_valid_coded_scan_param[] = {
+	0x01,			/* Own Addr type*/
+	0x00,			/* Scan filter policy*/
+	0x05,			/*Phys - 1m & coded */
+	0x01,			/* Type */
+	0x12, 0x00,		/* Interval */
+	0x12, 0x00,		/* Window */
+	0x01,			/* Type */
+	0x12, 0x00,		/* Interval */
+	0x12, 0x00,		/* Window */
+};
+
+static const struct generic_data start_discovery_le_coded_scan_param = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_SET_PHY_CONFIGURATION,
+	.setup_send_param = set_phy_coded_param,
+	.setup_send_len = sizeof(set_phy_coded_param),
+	.send_opcode = MGMT_OP_START_DISCOVERY,
+	.send_param = start_discovery_bredrle_param,
+	.send_len = sizeof(start_discovery_bredrle_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = start_discovery_bredrle_param,
+	.expect_len = sizeof(start_discovery_bredrle_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS,
+	.expect_hci_param = start_discovery_valid_coded_scan_param,
+	.expect_hci_len = sizeof(start_discovery_valid_coded_scan_param),
+	.expect_alt_ev = MGMT_EV_DISCOVERING,
+	.expect_alt_ev_param = start_discovery_evt,
+	.expect_alt_ev_len = sizeof(start_discovery_evt),
+};
+
+static const char start_discovery_valid_1m_2m_coded_scan_param[] = {
+	0x01,			/* Own Addr type*/
+	0x00,			/* Scan filter policy*/
+	0x05,			/*Phys - 1m, coded */
+	0x01,			/* Type */
+	0x12, 0x00,		/* Interval */
+	0x12, 0x00,		/* Window */
+	0x01,			/* Type */
+	0x12, 0x00,		/* Interval */
+	0x12, 0x00,		/* Window */
+};
+
+static const struct generic_data start_discovery_le_1m_coded_scan_param = {
+	.setup_settings = settings_powered_le,
+	.setup_send_opcode = MGMT_OP_SET_PHY_CONFIGURATION,
+	.setup_send_param = set_phy_all_param,
+	.setup_send_len = sizeof(set_phy_all_param),
+	.send_opcode = MGMT_OP_START_DISCOVERY,
+	.send_param = start_discovery_bredrle_param,
+	.send_len = sizeof(start_discovery_bredrle_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = start_discovery_bredrle_param,
+	.expect_len = sizeof(start_discovery_bredrle_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS,
+	.expect_hci_param = start_discovery_valid_1m_2m_coded_scan_param,
+	.expect_hci_len = sizeof(start_discovery_valid_1m_2m_coded_scan_param),
+	.expect_alt_ev = MGMT_EV_DISCOVERING,
+	.expect_alt_ev_param = start_discovery_evt,
+	.expect_alt_ev_len = sizeof(start_discovery_evt),
+};
+
+static void set_phy_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("Set PHY Success");
+
+	tester_setup_complete();
+}
+
+static void setup_phy_configuration(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const void *send_param = test->setup_send_param;
+	uint16_t send_len = test->setup_send_len;
+	unsigned int id;
+
+	id = mgmt_register(data->mgmt, MGMT_EV_DISCOVERING, data->mgmt_index,
+			   discovering_event, NULL, NULL);
+	data->mgmt_discov_ev_id = id;
+
+	mgmt_send(data->mgmt, test->setup_send_opcode, data->mgmt_index,
+				send_len, send_param, set_phy_callback,
+				NULL, NULL);
+}
 
 static bool power_off(uint16_t index)
 {
@@ -8502,6 +8702,12 @@ static void trigger_device_found(void *user_data)
 							test->adv_data_len);
 
 		bthost_set_adv_enable(bthost, 0x01);
+	} else if (data->hciemu_type == HCIEMU_TYPE_BREDRLE50) {
+		if (test->set_adv)
+			bthost_set_ext_adv_data(bthost, test->adv_data,
+							test->adv_data_len);
+
+		bthost_set_ext_adv_enable(bthost, 0x01);
 	}
 
 	if (data->hciemu_type != HCIEMU_TYPE_LE)
@@ -10139,5 +10345,44 @@ int main(int argc, char *argv[])
 	test_bredrle50("Set PHY Invalid Param", &set_phy_invalid_param,
 					NULL, test_command_generic);
 
+	test_bredrle50("Start Discovery BREDR LE - (Ext Scan Enable)",
+					&start_discovery_bredrle_ext_scan_enable,
+					NULL,
+					test_command_generic);
+
+	test_bredrle50("Start Discovery LE - (Ext Scan Enable)",
+					&start_discovery_le_ext_scan_enable,
+					NULL,
+					test_command_generic);
+
+	test_bredrle50("Start Discovery LE - (Ext Scan Param)",
+					&start_discovery_le_ext_scan_param,
+					NULL,
+					test_command_generic);
+
+	test_bredrle50("Stop Discovery - (Ext Scan Disable)",
+				&stop_discovery_le_ext_scan_disable,
+				setup_start_discovery, test_command_generic);
+
+	test_bredrle50("Start Discovery - (2m, Scan Param)",
+				&start_discovery_le_2m_scan_param,
+				setup_phy_configuration, test_command_generic);
+
+	test_bredrle50("Start Discovery - (coded, Scan Param)",
+				&start_discovery_le_coded_scan_param,
+				setup_phy_configuration, test_command_generic);
+
+	test_bredrle50("Start Discovery - (1m, 2m, coded, Scan Param)",
+				&start_discovery_le_1m_coded_scan_param,
+				setup_phy_configuration, test_command_generic);
+
+	test_bredrle50("Ext Device Found - Advertising data - Zero padded",
+				&device_found_gtag,
+				NULL, test_device_found);
+
+	test_bredrle50("Ext Device Found - Advertising data - Invalid field",
+				&device_found_invalid_field,
+				NULL, test_device_found);
+
 	return tester_run();
 }
-- 
2.7.4
