Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v2 3/7] monitor: Add LE Set Periodic Advertising commands decoding
Date: Tue, 13 Jun 2017 15:18:13 +0200
Message-Id: <20170613131817.18516-4-michal.narajowski@codecoup.pl>
In-Reply-To: <20170613131817.18516-1-michal.narajowski@codecoup.pl>
References: <20170613131817.18516-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

monitor: Add LE Set Periodic Advertising Parameters decoding

< HCI Command: LE Set Periodic Advertising Parameters (0x08|0x003e) plen 7
        Handle: 1
        Min interval: 2.50 msec (0x0002)
        Max interval: 318.75 msec (0x00ff)
        Properties: 0x00ff
          Include TxPower
          Unknown advertising properties (0x00bf)

monitor: Add LE Set Periodic Advertising Data decoding

< HCI Command: LE Set Periodic Advertising Data (0x08|0x003f) plen 7
        Handle: 1
        Handle: 0x01
        Operation: Last fragment
        Data length: 0x04
        ff 00 ff 00                                      ....

monitor: Add LE Set Periodic Advertising Enable decoding

< HCI Command: LE Set Periodic Advertising Enable (0x08|0x0040) plen 2
        Enable: Enabled
        Handle: 2
---
 monitor/bt.h     |  21 ++++++++++++
 monitor/packet.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index aa55579..5eb07d6 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2253,6 +2253,27 @@ struct bt_hci_cmd_le_remove_adv_set {
 
 #define BT_HCI_CMD_LE_CLEAR_ADV_SETS			0x203d
 
+#define BT_HCI_CMD_LE_SET_PERIODIC_ADV_PARAMS			0x203e
+struct bt_hci_cmd_le_set_periodic_adv_params {
+	uint8_t  handle;
+	uint16_t min_interval;
+	uint16_t max_interval;
+	uint16_t properties;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_SET_PERIODIC_ADV_DATA			0x203f
+struct bt_hci_cmd_le_set_periodic_adv_data {
+	uint8_t  handle;
+	uint8_t  operation;
+	uint8_t  data_len;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_SET_PERIODIC_ADV_ENABLE			0x2040
+struct bt_hci_cmd_le_set_periodic_adv_enable {
+	uint8_t  enable;
+	uint8_t  handle;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 8827f5e..cccc69c 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7280,6 +7280,96 @@ static void le_remove_adv_set_cmd(const void *data, uint8_t size)
 	print_handle(cmd->handle);
 }
 
+static const struct {
+	uint8_t bit;
+	const char *str;
+} periodic_adv_properties_table[] = {
+	{  6, "Include TxPower"		},
+	{ }
+};
+
+static void print_periodic_adv_properties(uint16_t flags)
+{
+	uint16_t mask = flags;
+	int i;
+
+	print_field("Properties: 0x%4.4x", flags);
+
+	for (i = 0; periodic_adv_properties_table[i].str; i++) {
+		if (flags & (1 << periodic_adv_properties_table[i].bit)) {
+			print_field("  %s",
+					periodic_adv_properties_table[i].str);
+			mask &= ~(1 << periodic_adv_properties_table[i].bit);
+		}
+	}
+
+	if (mask)
+		print_text(COLOR_UNKNOWN_ADV_FLAG,
+				"  Unknown advertising properties (0x%4.4x)",
+									mask);
+}
+
+static void le_set_periodic_adv_params_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_periodic_adv_params *cmd = data;
+
+	print_handle(cmd->handle);
+	print_slot_125("Min interval", cmd->min_interval);
+	print_slot_125("Max interval", cmd->max_interval);
+	print_periodic_adv_properties(cmd->properties);
+}
+
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
+static void le_set_periodic_adv_enable_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_periodic_adv_enable *cmd = data;
+	const char *str;
+
+	switch (cmd->enable) {
+	case 0x00:
+		str = "Disable";
+		break;
+	case 0x01:
+		str = "Enabled";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("Enable: %s", str);
+	print_handle(cmd->handle);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8016,9 +8106,15 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x203d, 297, "LE Clear Advertising Sets",
 				null_cmd, 0, true,
 				status_rsp, 1, true },
-	{ 0x203e, 298, "LE Set Periodic Advertising Parameters" },
-	{ 0x203f, 299, "LE Set Periodic Advertising Data" },
-	{ 0x2040, 300, "LE Set Periodic Advertising Enable" },
+	{ 0x203e, 298, "LE Set Periodic Advertising Parameters",
+				le_set_periodic_adv_params_cmd, 7, true,
+				status_rsp, 1, true },
+	{ 0x203f, 299, "LE Set Periodic Advertising Data",
+				le_set_periodic_adv_data_cmd, 3, false,
+				status_rsp, 1, true },
+	{ 0x2040, 300, "LE Set Periodic Advertising Enable",
+				le_set_periodic_adv_enable_cmd, 2, true,
+				status_rsp, 1, true },
 	{ 0x2041, 301, "LE Set Extended Scan Parameters" },
 	{ 0x2042, 302, "LE Set Extended Scan Enable" },
 	{ 0x2043, 303, "LE Extended Create Connection" },
-- 
2.9.3

