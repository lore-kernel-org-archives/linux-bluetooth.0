Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 25/31] monitor: Add LE Read Transmit Power decoding
Date: Tue,  6 Jun 2017 11:41:14 +0200
Message-Id: <20170606094120.14541-28-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/bt.h     |  7 +++++++
 monitor/packet.c | 13 ++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index df89ea7..8447868 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2353,6 +2353,13 @@ struct bt_hci_rsp_le_read_dev_periodic_adv_list_size {
 	uint8_t  list_size;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_READ_TX_POWER		0x204b
+struct bt_hci_rsp_le_read_tx_power {
+	uint8_t  status;
+	uint8_t  min_tx_power;
+	uint8_t  max_tx_power;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 64847fa..0d2a012 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7617,6 +7617,15 @@ static void le_read_periodic_adv_list_size_rsp(const void *data, uint8_t size)
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
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8392,7 +8401,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x204a, 310, "LE Read Periodic Advertiser List Size",
 				null_cmd, 0, true,
 				le_read_periodic_adv_list_size_rsp, 2, true },
-	{ 0x204b, 311, "LE Read Transmit Power" },
+	{ 0x204b, 311, "LE Read Transmit Power",
+				null_cmd, 0, true,
+				le_read_tx_power_rsp, 3, true },
 	{ 0x204c, 312, "LE Read RF Path Compensation" },
 	{ 0x204d, 313, "LE Write RF Path Compensation" },
 	{ 0x204e, 314, "LE Set Privacy Mode" },
-- 
2.9.3

