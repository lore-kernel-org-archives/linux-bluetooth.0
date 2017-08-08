Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v6 06/11] monitor: Add LE RF commands decoding
Date: Tue,  8 Aug 2017 10:45:28 +0200
Message-Id: <20170808084533.2323-7-michal.narajowski@codecoup.pl>
In-Reply-To: <20170808084533.2323-1-michal.narajowski@codecoup.pl>
References: <20170808084533.2323-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds decoding for following commands:

LE Read Transmit Power
LE Read RF Path Compensation
LE Write RF Path Compensation

< HCI Command: LE Write RF Path Compensation (0x08|0x004d) plen 4
        RF Tx Path Compensation Value: 0x0201
        RF Rx Path Compensation Value: 0x0403
---
 monitor/bt.h     | 20 ++++++++++++++++++++
 monitor/packet.c | 42 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 757adfa18..481b82a5a 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2356,6 +2356,26 @@ struct bt_hci_rsp_le_read_dev_periodic_adv_list_size {
 	uint8_t  list_size;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_READ_TX_POWER		0x204b
+struct bt_hci_rsp_le_read_tx_power {
+	uint8_t  status;
+	uint8_t  min_tx_power;
+	uint8_t  max_tx_power;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_READ_RF_PATH_COMPENSATION		0x204c
+struct bt_hci_rsp_le_read_rf_path_comp {
+	uint8_t  status;
+	uint16_t rf_tx_path_comp;
+	uint16_t rf_rx_path_comp;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_WRITE_RF_PATH_COMPENSATION		0x204d
+struct bt_hci_cmd_le_write_rf_path_comp {
+	uint16_t rf_tx_path_comp;
+	uint16_t rf_rx_path_comp;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index d64221c2c..a4b471320 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7801,6 +7801,36 @@ static void le_read_periodic_adv_list_size_rsp(const void *data, uint8_t size)
 	print_field("List size: 0x%2.2x", rsp->list_size);
 }
 
+static void le_read_tx_power_rsp(const void *data, uint8_t size)
+{
+	const struct bt_hci_rsp_le_read_tx_power *rsp = data;
+
+	print_status(rsp->status);
+	print_field("Min Tx power: %d dBm", rsp->min_tx_power);
+	print_field("Max Tx power: %d dBm", rsp->max_tx_power);
+}
+
+static void le_read_rf_path_comp_rsp(const void *data, uint8_t size)
+{
+	const struct bt_hci_rsp_le_read_rf_path_comp *rsp = data;
+
+	print_status(rsp->status);
+	print_field("RF Tx Path Compensation Value: 0x%4.4x",
+							rsp->rf_tx_path_comp);
+	print_field("RF Rx Path Compensation Value: 0x%4.4x",
+							rsp->rf_rx_path_comp);
+}
+
+static void le_write_rf_path_comp_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_write_rf_path_comp *cmd = data;
+
+	print_field("RF Tx Path Compensation Value: 0x%4.4x",
+							cmd->rf_tx_path_comp);
+	print_field("RF Rx Path Compensation Value: 0x%4.4x",
+							cmd->rf_rx_path_comp);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8576,9 +8606,15 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x204a, 310, "LE Read Periodic Advertiser List Size",
 				null_cmd, 0, true,
 				le_read_periodic_adv_list_size_rsp, 2, true },
-	{ 0x204b, 311, "LE Read Transmit Power" },
-	{ 0x204c, 312, "LE Read RF Path Compensation" },
-	{ 0x204d, 313, "LE Write RF Path Compensation" },
+	{ 0x204b, 311, "LE Read Transmit Power",
+				null_cmd, 0, true,
+				le_read_tx_power_rsp, 3, true },
+	{ 0x204c, 312, "LE Read RF Path Compensation",
+				null_cmd, 0, true,
+				le_read_rf_path_comp_rsp, 5, true },
+	{ 0x204d, 313, "LE Write RF Path Compensation",
+				le_write_rf_path_comp_cmd, 4, true,
+				status_rsp, 1, true },
 	{ 0x204e, 314, "LE Set Privacy Mode" },
 	{ }
 };
-- 
2.11.0

