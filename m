Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 27/31] monitor: Add LE Write RF Path Compensation decoding
Date: Tue,  6 Jun 2017 11:41:16 +0200
Message-Id: <20170606094120.14541-30-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Write RF Path Compensation (0x08|0x004d) plen 4
        RF Tx Path Compensation Value: 0x0201
        RF Rx Path Compensation Value: 0x0403
---
 monitor/bt.h     |  6 ++++++
 monitor/packet.c | 12 +++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index f7969cc..8b58795 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2367,6 +2367,12 @@ struct bt_hci_rsp_le_read_rf_path_comp {
 	uint16_t  rf_rx_path_comp;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_WRITE_RF_PATH_COMPENSATION		0x204d
+struct bt_hci_cmd_le_write_rf_path_comp {
+	uint16_t  rf_tx_path_comp;
+	uint16_t  rf_rx_path_comp;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 31a6c76..4b0c5df 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7635,6 +7635,14 @@ static void le_read_rf_path_comp_rsp(const void *data, uint8_t size)
 	print_field("RF Rx Path Compensation Value: 0x%4.4x", rsp->rf_rx_path_comp);
 }
 
+static void le_write_rf_path_comp_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_write_rf_path_comp *cmd = data;
+
+	print_field("RF Tx Path Compensation Value: 0x%4.4x", cmd->rf_tx_path_comp);
+	print_field("RF Rx Path Compensation Value: 0x%4.4x", cmd->rf_rx_path_comp);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8416,7 +8424,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x204c, 312, "LE Read RF Path Compensation",
 				null_cmd, 0, true,
 				le_read_rf_path_comp_rsp, 5, true },
-	{ 0x204d, 313, "LE Write RF Path Compensation" },
+	{ 0x204d, 313, "LE Write RF Path Compensation",
+				le_write_rf_path_comp_cmd, 4, true,
+				status_rsp, 1, true },
 	{ 0x204e, 314, "LE Set Privacy Mode" },
 	{ }
 };
-- 
2.9.3

