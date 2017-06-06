Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 26/31] monitor: Add LE Read RF Path Compensation decoding
Date: Tue,  6 Jun 2017 11:41:15 +0200
Message-Id: <20170606094120.14541-29-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/bt.h     |  7 +++++++
 monitor/packet.c | 13 ++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 8447868..f7969cc 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2360,6 +2360,13 @@ struct bt_hci_rsp_le_read_tx_power {
 	uint8_t  max_tx_power;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_READ_RF_PATH_COMPENSATION		0x204c
+struct bt_hci_rsp_le_read_rf_path_comp {
+	uint8_t  status;
+	uint16_t  rf_tx_path_comp;
+	uint16_t  rf_rx_path_comp;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 0d2a012..31a6c76 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7626,6 +7626,15 @@ static void le_read_tx_power_rsp(const void *data, uint8_t size)
 	print_field("Max Tx power: %d dBm", rsp->max_tx_power);
 }
 
+static void le_read_rf_path_comp_rsp(const void *data, uint8_t size)
+{
+	const struct bt_hci_rsp_le_read_rf_path_comp *rsp = data;
+
+	print_status(rsp->status);
+	print_field("RF Tx Path Compensation Value: 0x%4.4x", rsp->rf_tx_path_comp);
+	print_field("RF Rx Path Compensation Value: 0x%4.4x", rsp->rf_rx_path_comp);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8404,7 +8413,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x204b, 311, "LE Read Transmit Power",
 				null_cmd, 0, true,
 				le_read_tx_power_rsp, 3, true },
-	{ 0x204c, 312, "LE Read RF Path Compensation" },
+	{ 0x204c, 312, "LE Read RF Path Compensation",
+				null_cmd, 0, true,
+				le_read_rf_path_comp_rsp, 5, true },
 	{ 0x204d, 313, "LE Write RF Path Compensation" },
 	{ 0x204e, 314, "LE Set Privacy Mode" },
 	{ }
-- 
2.9.3

