Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v1 08/10] mgmt-tester: Add PHY Configuration test cases
Date: Thu, 12 Apr 2018 16:50:59 +0530
Message-Id: <1523532061-17192-9-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1523532061-17192-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1523532061-17192-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/btdev.c    |  16 ++++-
 tools/mgmt-tester.c | 180 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index ad4f873..36aa696 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -2244,6 +2244,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_le_set_ext_adv_enable *lseae;
 	const struct bt_hci_cmd_le_set_ext_adv_data *lsead;
 	const struct bt_hci_cmd_le_set_ext_scan_rsp_data *lsesrd;
+	const struct bt_hci_cmd_le_set_default_phy *phys;
 	struct bt_hci_rsp_read_default_link_policy rdlp;
 	struct bt_hci_rsp_read_stored_link_key rslk;
 	struct bt_hci_rsp_write_stored_link_key wslk;
@@ -3501,7 +3502,20 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		status = BT_HCI_ERR_SUCCESS;
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		break;
-
+	case BT_HCI_CMD_LE_SET_DEFAULT_PHY:
+		if (btdev->type == BTDEV_TYPE_BREDR)
+			goto unsupported;
+		phys = data;
+		if (phys->all_phys > 0x03 ||
+			(!(phys->all_phys & 0x01) &&
+				(!phys->tx_phys || phys->tx_phys > 0x07)) ||
+			(!(phys->all_phys & 0x02) &&
+				(!phys->rx_phys || phys->rx_phys > 0x07)))
+			status = BT_HCI_ERR_INVALID_PARAMETERS;
+		else
+			status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
 
 	default:
 		goto unsupported;
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 660a3b4..7485318 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -8216,6 +8216,165 @@ static const struct generic_data add_ext_advertising_conn_off_1m = {
 	.expect_hci_len = sizeof(set_connectable_off_ext_1m_adv_param),
 };
 
+static const uint8_t get_phy_param[] = {
+	0x3f, 0x00,		/* 1mtx 1mrx 2mtx 2mrx codedtx codedrx*/
+	0x03, 0x00,		/* 1mtx 1mtx */
+};
+
+static const struct generic_data get_phy_success = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_GET_PHY_CONFIGURATION,
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = get_phy_param,
+	.expect_len = sizeof(get_phy_param),
+};
+
+static const uint8_t set_phy_2m_param[] = {
+	0x0c, 0x00,		/* 2mtx 2mrx */
+};
+
+static const uint8_t set_default_phy_2m_param[] = {
+	0x00, 		/* preference is there for tx and rx */
+	0x02,		/* 2mtx */
+	0x02,		/* 2mrx */
+};
+
+static const struct generic_data set_phy_2m_success = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_SET_PHY_CONFIGURATION,
+	.send_param = set_phy_2m_param,
+	.send_len = sizeof(set_phy_2m_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_DEFAULT_PHY,
+	.expect_hci_param = set_default_phy_2m_param,
+	.expect_hci_len = sizeof(set_default_phy_2m_param),
+	.expect_alt_ev = MGMT_EV_PHY_CONFIGURATION_CHANGED,
+	.expect_alt_ev_param = set_phy_2m_param,
+	.expect_alt_ev_len = sizeof(set_phy_2m_param),
+	.expect_settings_set = MGMT_SETTING_PHY_CONFIGURATION,
+};
+
+static const uint8_t set_phy_coded_param[] = {
+	0x30, 0x00,		/* codedtx codedrx */
+};
+
+static const uint8_t set_default_phy_coded_param[] = {
+	0x00, 		/* preference is there for tx and rx */
+	0x04,		/* codedtx */
+	0x04,		/* codedrx */
+};
+
+static const struct generic_data set_phy_coded_success = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_SET_PHY_CONFIGURATION,
+	.send_param = set_phy_coded_param,
+	.send_len = sizeof(set_phy_coded_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_DEFAULT_PHY,
+	.expect_hci_param = set_default_phy_coded_param,
+	.expect_hci_len = sizeof(set_default_phy_coded_param),
+	.expect_alt_ev = MGMT_EV_PHY_CONFIGURATION_CHANGED,
+	.expect_alt_ev_param = set_phy_coded_param,
+	.expect_alt_ev_len = sizeof(set_phy_coded_param),
+	.expect_settings_set = MGMT_SETTING_PHY_CONFIGURATION,
+};
+
+static const uint8_t set_phy_all_param[] = {
+	0x3f, 0x00,		/* 1m 2m coded both tx rx */
+};
+
+static const uint8_t set_default_phy_all_param[] = {
+	0x00, 		/* preference is there for tx and rx */
+	0x07,		/* 1m 2m coded tx */
+	0x07,		/* 1m 2m coded rx */
+};
+
+static const struct generic_data set_phy_all_success = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_SET_PHY_CONFIGURATION,
+	.send_param = set_phy_all_param,
+	.send_len = sizeof(set_phy_all_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_DEFAULT_PHY,
+	.expect_hci_param = set_default_phy_all_param,
+	.expect_hci_len = sizeof(set_default_phy_all_param),
+	.expect_alt_ev = MGMT_EV_PHY_CONFIGURATION_CHANGED,
+	.expect_alt_ev_param = set_phy_all_param,
+	.expect_alt_ev_len = sizeof(set_phy_all_param),
+	.expect_settings_set = MGMT_SETTING_PHY_CONFIGURATION,
+};
+
+static const uint8_t set_phy_2m_tx_param[] = {
+	0x04, 0x00,		/* only 2m tx */
+};
+
+static const uint8_t set_default_phy_2m_tx_param[] = {
+	0x02, 		/* no preference for rx */
+	0x02,		/* 2m tx */
+	0x00,
+};
+
+static const uint8_t set_phy_2m_tx_evt_param[] = {
+	0x04, 0x00,		/*  2m tx */
+};
+
+static const struct generic_data set_phy_2m_tx_success = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_SET_PHY_CONFIGURATION,
+	.send_param = set_phy_2m_tx_param,
+	.send_len = sizeof(set_phy_2m_tx_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_DEFAULT_PHY,
+	.expect_hci_param = set_default_phy_2m_tx_param,
+	.expect_hci_len = sizeof(set_default_phy_2m_tx_param),
+	.expect_alt_ev = MGMT_EV_PHY_CONFIGURATION_CHANGED,
+	.expect_alt_ev_param = set_phy_2m_tx_evt_param,
+	.expect_alt_ev_len = sizeof(set_phy_2m_tx_evt_param),
+	.expect_settings_set = MGMT_SETTING_PHY_CONFIGURATION,
+};
+
+static const uint8_t set_phy_2m_rx_param[] = {
+	0x08, 0x00,		/* only 2m rx */
+};
+
+static const uint8_t set_default_phy_2m_rx_param[] = {
+	0x01, 		/* no preference for tx */
+	0x00,
+	0x02,		/* 2m rx */
+};
+
+static const uint8_t set_phy_2m_rx_evt_param[] = {
+	0x08, 0x00,		/*  2m rx */
+};
+
+static const struct generic_data set_phy_2m_rx_success = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_SET_PHY_CONFIGURATION,
+	.send_param = set_phy_2m_rx_param,
+	.send_len = sizeof(set_phy_2m_rx_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_DEFAULT_PHY,
+	.expect_hci_param = set_default_phy_2m_rx_param,
+	.expect_hci_len = sizeof(set_default_phy_2m_rx_param),
+	.expect_alt_ev = MGMT_EV_PHY_CONFIGURATION_CHANGED,
+	.expect_alt_ev_param = set_phy_2m_rx_evt_param,
+	.expect_alt_ev_len = sizeof(set_phy_2m_rx_evt_param),
+	.expect_settings_set = MGMT_SETTING_PHY_CONFIGURATION,
+};
+
+static const uint8_t set_phy_param_invalid[] = {
+	0x7f, 0x00,		/* Invalid phy*/
+};
+
+static const struct generic_data set_phy_invalid_param = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_SET_PHY_CONFIGURATION,
+	.send_param = set_phy_param_invalid,
+	.send_len = sizeof(set_phy_param_invalid),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+
 static bool power_off(uint16_t index)
 {
 	int sk, err;
@@ -9958,5 +10117,26 @@ int main(int argc, char *argv[])
 					setup_add_advertising_duration,
 					test_command_generic, 3);
 
+	test_bredrle50("Get PHY Success", &get_phy_success,
+					NULL, test_command_generic);
+
+	test_bredrle50("Set PHY 2m Success", &set_phy_2m_success,
+					NULL, test_command_generic);
+
+	test_bredrle50("Set PHY coded Succcess", &set_phy_coded_success,
+					NULL, test_command_generic);
+
+	test_bredrle50("Set PHY 1m 2m coded Succcess", &set_phy_all_success,
+                                        NULL, test_command_generic);
+
+	test_bredrle50("Set PHY 2m tx success", &set_phy_2m_tx_success,
+					NULL, test_command_generic);
+
+	test_bredrle50("Set PHY 2m rx success", &set_phy_2m_rx_success,
+					NULL, test_command_generic);
+
+	test_bredrle50("Set PHY Invalid Param", &set_phy_invalid_param,
+					NULL, test_command_generic);
+
 	return tester_run();
 }
-- 
2.7.4

