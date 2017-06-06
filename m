Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 02/31] monitor: Add LE Enhanced Transmitter Test decoding
Date: Tue,  6 Jun 2017 11:40:50 +0200
Message-Id: <20170606094120.14541-4-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Enhanced Transmitter Test (0x08|0x0034) plen 4
        TX channel frequency: 2402 MHz (0x00)
        Test data length: 255 bytes
        Packet payload: 0x01
        PHY: LE Coded with S=8 (0x03)
---
 monitor/bt.h     |  8 ++++++++
 monitor/packet.c | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 2aed400..a877b2c 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2168,6 +2168,14 @@ struct bt_hci_cmd_le_enhanced_receiver_test {
 	uint8_t modulation_index;
 } __attribute__((packed));
 
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
index e3fcd2f..b77b2cc 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -6900,6 +6900,37 @@ static void le_enhanced_receiver_test_cmd(const void *data, uint8_t size)
 	print_field("Modulation index: %s (0x%2.2x)", str, cmd->modulation_index);
 }
 
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
@@ -7606,7 +7637,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2033, 287, "LE Enhanced Receiver Test",
 				le_enhanced_receiver_test_cmd, 3, true,
 				status_rsp, 1, true },
-	{ 0x2034, 288, "LE Enhanced Transmitter Test" },
+	{ 0x2034, 288, "LE Enhanced Transmitter Test",
+				le_enhanced_transmitter_test_cmd, 4, true,
+				status_rsp, 1, true },
 	{ 0x2035, 289, "LE Set Advertising Set Random Address" },
 	{ 0x2036, 290, "LE Set Extended Advertising Parameters" },
 	{ 0x2037, 291, "LE Set Extended Advertising Data" },
-- 
2.9.3

