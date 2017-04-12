Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ 2/5] monitor: Add LE Read PHY decoding
Date: Wed, 12 Apr 2017 14:13:33 +0200
Message-Id: <20170412121336.783-2-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <20170412121336.783-1-lukasz.rymanowski@codecoup.pl>
References: <20170412121336.783-1-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/bt.h     | 11 +++++++++++
 monitor/packet.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 0b77a10..a6c12a3 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2134,6 +2134,17 @@ struct bt_hci_rsp_le_read_max_data_length {
 	uint16_t max_rx_time;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_READ_PHY			0x2030
+struct bt_hci_cmd_le_read_phy {
+	uint16_t handle;
+} __attribute__((packed));
+struct bt_hci_rsp_le_read_phy {
+	uint8_t status;
+	uint16_t handle;
+	uint8_t tx_phy;
+	uint8_t rx_phy;
+} __attribute__((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 219542e..673b571 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -6737,6 +6737,45 @@ static void le_read_max_data_length_rsp(const void *data, uint8_t size)
 	print_field("Max RX time: %d", le16_to_cpu(rsp->max_rx_time));
 }
 
+static void le_read_phy_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_read_phy *cmd = data;
+
+	print_handle(cmd->handle);
+}
+
+static void print_le_phy(const char *prefix, uint8_t phy)
+{
+	const char *str;
+
+	switch (phy) {
+	case 0x01:
+		str = "LE 1M";
+		break;
+	case 0x02:
+		str = "LE 2M";
+		break;
+	case 0x03:
+		str = "LE Coded";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("%s: %s (0x%2.2x)", prefix, str, phy);
+}
+
+static void le_read_phy_rsp(const void *data, uint8_t size)
+{
+	const struct bt_hci_rsp_le_read_phy *rsp = data;
+
+	print_status(rsp->status);
+	print_handle(rsp->handle);
+	print_le_phy("TX PHY", rsp->tx_phy);
+	print_le_phy("RX PHY", rsp->rx_phy);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -7432,7 +7471,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x202f, 283, "LE Read Maximum Data Length",
 				null_cmd, 0, true,
 				le_read_max_data_length_rsp, 9, true },
-	{ 0x2030, 284, "LE Read PHY" },
+	{ 0x2030, 284, "LE Read PHY",
+				le_read_phy_cmd, 2, true,
+				le_read_phy_rsp, 5, true},
 	{ 0x2031, 285, "LE Set Default PHY" },
 	{ 0x2032, 286, "LE Set PHY" },
 	{ 0x2033, 287, "LE Enhanced Receiver Test" },
-- 
2.9.3

