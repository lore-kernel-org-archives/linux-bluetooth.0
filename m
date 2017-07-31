Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v5 01/11] monitor: Add LE Enhanced Test commands decoding
Date: Mon, 31 Jul 2017 15:39:00 +0200
Message-Id: <20170731133910.26745-2-michal.narajowski@codecoup.pl>
In-Reply-To: <20170731133910.26745-1-michal.narajowski@codecoup.pl>
References: <20170731133910.26745-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds decoding for following commands:

LE Enhanced Receiver Test
LE Enhanced Transmitter Test

< HCI Command: LE Enhanced Receiver Test (0x08|0x0033) plen 3
        RX channel: 0x01
        PHY: LE 1M (0x01)
        Modulation index: Stable (0x01)

< HCI Command: LE Enhanced Transmitter Test (0x08|0x0034) plen 4
        TX channel frequency: 2402 MHz (0x00)
        Test data length: 255 bytes
        Packet payload: 0x01
        PHY: LE Coded with S=8 (0x03)
---
 monitor/bt.h     | 15 +++++++++++++
 monitor/packet.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index c2045bbf9..a877b2c13 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2161,6 +2161,21 @@ struct bt_hci_cmd_le_set_phy {
 	uint16_t phy_opts;
 } __attribute__((packed));
 
+#define BT_HCI_CMD_LE_ENHANCED_RECEIVER_TEST			0x2033
+struct bt_hci_cmd_le_enhanced_receiver_test {
+	uint8_t rx_channel;
+	uint8_t phy;
+	uint8_t modulation_index;
+} __attribute__((packed));
+
+#define BT_HCI_CMD_LE_ENHANCED_TRANSMITTER_TEST			0x2034
+struct bt_hci_cmd_le_enhanced_transmitter_test {
+	uint8_t tx_channel;
+	uint8_t data_len;
+	uint8_t payload;
+	uint8_t phy;
+} __attribute__((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 39823691f..1f6cd3699 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7086,6 +7086,62 @@ static void le_set_phy_cmd(const void *data, uint8_t size)
 	print_field("PHY options preference: %s (0x%4.4x)", str, cmd->phy_opts);
 }
 
+static void le_enhanced_receiver_test_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_enhanced_receiver_test *cmd = data;
+	const char *str;
+
+	print_field("RX channel frequency: %d MHz (0x%2.2x)",
+				(cmd->rx_channel * 2) + 2402, cmd->rx_channel);
+	print_le_phy("PHY", cmd->phy);
+
+	switch (cmd->modulation_index) {
+	case 0x00:
+		str = "Standard";
+		break;
+	case 0x01:
+		str = "Stable";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("Modulation index: %s (0x%2.2x)", str,
+							cmd->modulation_index);
+}
+
+static void le_enhanced_transmitter_test_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_enhanced_transmitter_test *cmd = data;
+	const char *str;
+
+	print_field("TX channel frequency: %d MHz (0x%2.2x)",
+				(cmd->tx_channel * 2) + 2402, cmd->tx_channel);
+	print_field("Test data length: %d bytes", cmd->data_len);
+	print_field("Packet payload: 0x%2.2x", cmd->payload);
+
+	switch (cmd->phy) {
+	case 0x01:
+		str = "LE 1M";
+		break;
+	case 0x02:
+		str = "LE 2M";
+		break;
+	case 0x03:
+		str = "LE Coded with S=8";
+		break;
+	case 0x04:
+		str = "LE Coded with S=2";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("PHY: %s (0x%2.2x)", str, cmd->phy);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -7789,8 +7845,12 @@ static const struct opcode_data opcode_table[] = {
 				status_rsp, 1, true },
 	{ 0x2032, 286, "LE Set PHY",
 				le_set_phy_cmd, 7, true},
-	{ 0x2033, 287, "LE Enhanced Receiver Test" },
-	{ 0x2034, 288, "LE Enhanced Transmitter Test" },
+	{ 0x2033, 287, "LE Enhanced Receiver Test",
+				le_enhanced_receiver_test_cmd, 3, true,
+				status_rsp, 1, true },
+	{ 0x2034, 288, "LE Enhanced Transmitter Test",
+				le_enhanced_transmitter_test_cmd, 4, true,
+				status_rsp, 1, true },
 	{ 0x2035, 289, "LE Set Advertising Set Random Address" },
 	{ 0x2036, 290, "LE Set Extended Advertising Parameters" },
 	{ 0x2037, 291, "LE Set Extended Advertising Data" },
-- 
2.11.0

