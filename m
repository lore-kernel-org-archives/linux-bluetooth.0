Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v1 09/10] mgmt-tester: Add tests for extended scanning and device found
Date: Thu, 12 Apr 2018 16:51:00 +0530
Message-Id: <1523532061-17192-10-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1523532061-17192-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1523532061-17192-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/btdev.c    |  86 ++++++++++++++++++
 emulator/bthost.c   |  44 ++++++++++
 emulator/bthost.h   |   4 +
 tools/mgmt-tester.c | 244 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 378 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 36aa696..c3d2b8a 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -2073,6 +2073,44 @@ static void le_set_scan_enable_complete(struct btdev *btdev)
 	}
 }
 
+static void le_set_ext_scan_enable_complete(struct btdev *btdev)
+{
+	int i;
+
+	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
+		uint16_t report_type;
+
+		if (!btdev_list[i] || btdev_list[i] == btdev)
+			continue;
+
+		if (!btdev_list[i]->le_adv_enable)
+			continue;
+
+		if (!ext_adv_match(btdev, btdev_list[i]))
+			continue;
+
+		report_type = get_ext_adv_report_type(btdev_list[i]->le_ext_adv_type);
+		le_send_ext_adv_report(btdev, btdev_list[i], report_type, false);
+
+		if (btdev->le_scan_type != 0x01)
+			continue;
+
+				/* if scannable bit is set the send scan response */
+		if (btdev_list[i]->le_ext_adv_type & 0x02) {
+			if (btdev_list[i]->le_ext_adv_type == 0x13)
+				report_type = 0x1b;
+			else if (btdev_list[i]->le_ext_adv_type == 0x12)
+				report_type = 0x1a;
+			else if (!(btdev_list[i]->le_ext_adv_type & 0x10))
+				report_type &= 0x08;
+			else
+				continue;
+
+			le_send_ext_adv_report(btdev, btdev_list[i], report_type, true);
+		}
+	}
+}
+
 static void le_read_remote_features_complete(struct btdev *btdev)
 {
 	char buf[1 + sizeof(struct bt_hci_evt_le_remote_features_complete)];
@@ -2245,6 +2283,9 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_le_set_ext_adv_data *lsead;
 	const struct bt_hci_cmd_le_set_ext_scan_rsp_data *lsesrd;
 	const struct bt_hci_cmd_le_set_default_phy *phys;
+	const struct bt_hci_cmd_le_set_ext_scan_params *lsesp;
+	const struct bt_hci_le_scan_phy *lsp;
+	const struct bt_hci_cmd_le_set_ext_scan_enable *lsese;
 	struct bt_hci_rsp_read_default_link_policy rdlp;
 	struct bt_hci_rsp_read_stored_link_key rslk;
 	struct bt_hci_rsp_write_stored_link_key wslk;
@@ -3516,6 +3557,42 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 			status = BT_HCI_ERR_SUCCESS;
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		break;
+	case BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS:
+		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+			goto unsupported;
+
+		lsesp = data;
+		lsp = (void *)lsesp->data;
+
+		if (btdev->le_scan_enable)
+			status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		else if (lsesp->num_phys == 0)
+			status = BT_HCI_ERR_INVALID_PARAMETERS;
+		else {
+			status = BT_HCI_ERR_SUCCESS;
+			/* Currently we dont support multiple types in single command
+			 * So just take the first one will do.
+			 */
+			btdev->le_scan_type = lsp->type;
+			btdev->le_scan_own_addr_type = lsesp->own_addr_type;
+		}
+
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+	case BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE:
+		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+			goto unsupported;
+
+		lsese = data;
+		if (btdev->le_scan_enable == lsese->enable)
+			status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		else {
+			btdev->le_scan_enable = lsese->enable;
+			btdev->le_filter_dup = lsese->filter_dup;
+			status = BT_HCI_ERR_SUCCESS;
+		}
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
 
 	default:
 		goto unsupported;
@@ -3554,6 +3631,7 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_le_conn_param_req_reply *lcprr;
 	const struct bt_hci_cmd_le_conn_param_req_neg_reply *lcprnr;
 	const struct bt_hci_cmd_le_set_scan_enable *lsse;
+	const struct bt_hci_cmd_le_set_ext_scan_enable *lsese;
 
 	switch (opcode) {
 	case BT_HCI_CMD_INQUIRY:
@@ -3748,6 +3826,14 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 		lsse = data;
 		if (btdev->le_scan_enable && lsse->enable)
 			le_set_scan_enable_complete(btdev);
+		break;
+	case BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE:
+		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+			return;
+		lsese = data;
+		if (btdev->le_scan_enable && lsese->enable)
+			le_set_ext_scan_enable_complete(btdev);
+		break;
 
 	}
 }
diff --git a/emulator/bthost.c b/emulator/bthost.c
index 2bcdc31..45b9bd6 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -839,6 +839,12 @@ static void evt_cmd_complete(struct bthost *bthost, const void *data,
 		break;
 	case BT_HCI_CMD_LE_SET_ADV_DATA:
 		break;
+	case BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS:
+		break;
+	case BT_HCI_CMD_LE_SET_EXT_ADV_DATA:
+		break;
+	case BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE:
+		break;
 	default:
 		printf("Unhandled cmd_complete opcode 0x%04x\n", opcode);
 		break;
@@ -2301,6 +2307,29 @@ void bthost_set_adv_data(struct bthost *bthost, const uint8_t *data,
 							sizeof(adv_cp));
 }
 
+void bthost_set_ext_adv_data(struct bthost *bthost, const uint8_t *data,
+								uint8_t len)
+{
+	struct bt_hci_cmd_le_set_ext_adv_data *adv_cp;
+	uint8_t buf[sizeof(*adv_cp) + 31];
+
+	adv_cp = (void *)buf;
+
+	memset(adv_cp, 0, sizeof(*adv_cp));
+	memset(adv_cp->data, 0, 31);
+
+	adv_cp->operation = 0x03;
+	adv_cp->fragment_preference = 0x01;
+
+	if (len) {
+		adv_cp->data_len = len;
+		memcpy(adv_cp->data, data, len);
+	}
+
+	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_DATA, buf,
+							sizeof(buf));
+}
+
 void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable)
 {
 	struct bt_hci_cmd_le_set_adv_parameters cp;
@@ -2312,6 +2341,21 @@ void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable)
 	send_command(bthost, BT_HCI_CMD_LE_SET_ADV_ENABLE, &enable, 1);
 }
 
+void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable)
+{
+	struct bt_hci_cmd_le_set_ext_adv_params cp;
+	struct bt_hci_cmd_le_set_ext_adv_enable cp_enable;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.evt_properties = cpu_to_le16(0x0013);
+	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
+							&cp, sizeof(cp));
+
+	cp_enable.enable = enable;
+	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE, &cp_enable,
+					sizeof(cp_enable));
+}
+
 void bthost_write_ssp_mode(struct bthost *bthost, uint8_t mode)
 {
 	send_command(bthost, BT_HCI_CMD_WRITE_SIMPLE_PAIRING_MODE, &mode, 1);
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 553865a..752c14b 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -83,6 +83,10 @@ void bthost_set_adv_data(struct bthost *bthost, const uint8_t *data,
 								uint8_t len);
 void bthost_set_adv_enable(struct bthost *bthost, uint8_t enable);
 
+void bthost_set_ext_adv_data(struct bthost *bthost, const uint8_t *data,
+								uint8_t len);
+void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable);
+
 void bthost_write_ssp_mode(struct bthost *bthost, uint8_t mode);
 
 void bthost_write_le_host_supported(struct bthost *bthost, uint8_t mode);
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 7485318..e5076b5 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -8374,6 +8374,205 @@ static const struct generic_data set_phy_invalid_param = {
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
+	0x04,			/*Phys - coded */
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
+static const char set_phy_1m_2m_coded_param[] = { 0x3f, 0x00 };
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
+	.setup_send_param = set_phy_1m_2m_coded_param,
+	.setup_send_len = sizeof(set_phy_1m_2m_coded_param),
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
@@ -8501,6 +8700,12 @@ static void trigger_device_found(void *user_data)
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
@@ -10138,5 +10343,44 @@ int main(int argc, char *argv[])
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

