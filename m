Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH BlueZ v2 4/7] mgmt-tester: Add PHY Configuration test cases
Date: Wed, 25 Jul 2018 15:51:23 +0530
Message-Id: <1532514086-14790-5-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1532514086-14790-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1532514086-14790-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/mgmt-tester.c | 176 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index e18013f..c32f27a 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -8029,6 +8029,161 @@ static const struct generic_data add_ext_advertising_conn_off_1m = {
 	.expect_hci_len = sizeof(set_connectable_off_ext_1m_adv_param),
 };
 
+static const uint8_t get_phy_param[] = {
+	0xff, 0x7f, 0x00, 0x00,	/* All PHYs */
+	0xfe, 0x79,	0x00, 0x00, /* All PHYs except BR 1M 1SLOT, LE 1M TX & LE 1M RX */
+	0xff, 0x07, 0x00, 0x00, /* All BREDR PHYs and LE 1M TX & LE 1M RX */
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
+	0xff, 0x1f,	0x00, 0x00	/* 1mtxrx 2mtxrx */
+};
+
+static const uint8_t set_default_phy_2m_param[] = {
+	0x00, 		/* preference is there for tx and rx */
+	0x03,		/* 1mtx, 2mtx */
+	0x03,		/* 1mrx, 2mrx */
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
+};
+
+static const uint8_t set_phy_coded_param[] = {
+	0xff, 0x67,	0x00, 0x00	/* 1mtx, 1m rx, codedtx codedrx */
+};
+
+static const uint8_t set_default_phy_coded_param[] = {
+	0x00, 		/* preference is there for tx and rx */
+	0x05,		/* 1mtx, codedtx */
+	0x05,		/* 1mrx, codedrx */
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
+};
+
+static const uint8_t set_phy_all_param[] = {
+	0xff, 0x7f,	0x00, 0x00	/* All PHYs */
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
+};
+
+static const uint8_t set_phy_2m_tx_param[] = {
+	0xff, 0x0f,	0x00, 0x00	/* 1mtxrx, 2m tx */
+};
+
+static const uint8_t set_default_phy_2m_tx_param[] = {
+	0x00,
+	0x03,		/* 1m, 2m tx */
+	0x01,		/* 1m rx */
+};
+
+static const uint8_t set_phy_2m_tx_evt_param[] = {
+	0xff, 0x0f,	0x00, 0x00		/*  2m tx  1m rx */
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
+};
+
+static const uint8_t set_phy_2m_rx_param[] = {
+	0xff, 0x17,	0x00, 0x00	/* 1mtxrx, 2m rx */
+};
+
+static const uint8_t set_default_phy_2m_rx_param[] = {
+	0x00,
+	0x01,
+	0x03,		/* 2m rx */
+};
+
+static const uint8_t set_phy_2m_rx_evt_param[] = {
+	0xff, 0x17,	0x00, 0x00		/*  2m rx  1m tx */
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
+};
+
+static const uint8_t set_phy_param_invalid[] = {
+	0x79, 0xfe,	0x00, 0x00	/* Set unconfigurable phy*/
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
@@ -9771,5 +9926,26 @@ int main(int argc, char *argv[])
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
