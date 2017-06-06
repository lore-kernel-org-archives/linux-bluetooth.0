Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 13/31] monitor: Add LE Set Periodic Advertising Data decoding
Date: Tue,  6 Jun 2017 11:41:02 +0200
Message-Id: <20170606094120.14541-16-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Set Periodic Advertising Data (0x08|0x003f) plen 7
        Handle: 1
        Handle: 0x01
        Operation: Last fragment
        Data length: 0x04
        ff 00 ff 00                                      ....
---
 monitor/bt.h     |  7 +++++++
 monitor/packet.c | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index c0068ca..d093162 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2261,6 +2261,13 @@ struct bt_hci_cmd_le_set_periodic_adv_params {
 	uint16_t  properties;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_SET_PERIODIC_ADV_DATA			0x203f
+struct bt_hci_cmd_le_set_periodic_adv_data {
+	uint8_t  handle;
+	uint8_t  operation;
+	uint8_t  data_len;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 7a5b62f..0a1d17c 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7282,6 +7282,36 @@ static void le_set_periodic_adv_params_cmd(const void *data, uint8_t size)
 	print_periodic_adv_properties(cmd->properties);
 }
 
+static void le_set_periodic_adv_data_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_periodic_adv_data *cmd = data;
+	const char *str;
+
+	print_handle(cmd->handle);
+
+	print_field("Handle: 0x%2.2x", cmd->handle);
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
+		str = "Complete ext advertising data";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+	print_field("Operation: %s", str);
+	print_field("Data length: 0x%2.2x", cmd->data_len);
+	packet_hexdump(data + 3, size - 3);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8021,7 +8051,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x203e, 298, "LE Set Periodic Advertising Parameters",
 				le_set_periodic_adv_params_cmd, 7, true,
 				status_rsp, 1, true },
-	{ 0x203f, 299, "LE Set Periodic Advertising Data" },
+	{ 0x203f, 299, "LE Set Periodic Advertising Data",
+				le_set_periodic_adv_data_cmd, 3, false,
+				status_rsp, 1, true },
 	{ 0x2040, 300, "LE Set Periodic Advertising Enable" },
 	{ 0x2041, 301, "LE Set Extended Scan Parameters" },
 	{ 0x2042, 302, "LE Set Extended Scan Enable" },
-- 
2.9.3

