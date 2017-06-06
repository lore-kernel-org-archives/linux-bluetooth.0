Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 05/31] monitor: Add LE Set Extended Advertising Data decoding
Date: Tue,  6 Jun 2017 11:40:54 +0200
Message-Id: <20170606094120.14541-8-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Set Extended Advertising Data (0x08|0x0037) plen 9
        Handle: 0x01
        Operation: Complete extended advertising data
        Fragment preference: Fragment all
        Data length: 0x05
        a0 a1 a2 a3 a4                                   .....
---
 monitor/bt.h     |  8 ++++++++
 monitor/packet.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index e903366..ba9ee99 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2205,6 +2205,14 @@ struct bt_hci_rsp_le_set_ext_adv_params {
 	uint8_t  tx_power;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_SET_EXT_ADV_DATA			0x2037
+struct bt_hci_cmd_le_set_ext_adv_data {
+	uint8_t  handle;
+	uint8_t  operation;
+	uint8_t  fragment_preference;
+	uint8_t  data_len;
+	uint8_t  data[0];
+} __attribute__ ((packed));
 
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
diff --git a/monitor/packet.c b/monitor/packet.c
index 35ffde9..5e20002 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7093,6 +7093,51 @@ static void le_set_ext_adv_params_rsp(const void *data, uint8_t size)
 	print_field("Selected Tx power: 0x%2.2x", rsp->tx_power);
 }
 
+static void le_set_ext_adv_data_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_ext_adv_data *cmd = data;
+	const char *str;
+
+	print_field("Handle: 0x%2.2x", cmd->handle);
+
+	switch (cmd->operation) {
+	case 0x00:
+		str = "Immediate fragment";
+		break;
+	case 0x01:
+		str = "First fragment";
+		break;
+	case 0x02:
+		str = "Last fragment";
+		break;
+	case 0x03:
+		str = "Complete extended advertising data";
+		break;
+	case 0x04:
+		str = "Unchanged data";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+	print_field("Operation: %s", str);
+
+	switch (cmd->fragment_preference) {
+	case 0x00:
+		str = "Fragment all";
+		break;
+	case 0x01:
+		str = "Minimize fragmentation";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+	print_field("Fragment preference: %s", str);
+	print_field("Data length: 0x%2.2x", cmd->data_len);
+	packet_print_ad(cmd->data, size - sizeof(*cmd));
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -7808,7 +7853,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2036, 290, "LE Set Extended Advertising Parameters",
 				le_set_ext_adv_params_cmd, 25, true,
 				le_set_ext_adv_params_rsp, 2, true },
-	{ 0x2037, 291, "LE Set Extended Advertising Data" },
+	{ 0x2037, 291, "LE Set Extended Advertising Data",
+				le_set_ext_adv_data_cmd, 4, false,
+				status_rsp, 1, true },
 	{ 0x2038, 292, "LE Set Extended Scan Response Data" },
 	{ 0x2039, 293, "LE Set Extended Advertising Enable" },
 	{ 0x203a, 294, "LE Read Maximum Advertising Data Length" },
-- 
2.9.3

