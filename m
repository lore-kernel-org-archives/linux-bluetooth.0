Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v5 03/11] monitor: Add LE Set Periodic Advertising commands decoding
Date: Mon, 31 Jul 2017 15:39:02 +0200
Message-Id: <20170731133910.26745-4-michal.narajowski@codecoup.pl>
In-Reply-To: <20170731133910.26745-1-michal.narajowski@codecoup.pl>
References: <20170731133910.26745-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds decoding for following commands:

LE Set Periodic Advertising Parameters
LE Set Periodic Advertising Data
LE Set Periodic Advertising Enable

< HCI Command: LE Set Periodic Advertising Parameters (0x08|0x003e) plen 7
        Handle: 1
        Min interval: 2.50 msec (0x0002)
        Max interval: 318.75 msec (0x00ff)
        Properties: 0x00ff
          Include TxPower
          Unknown advertising properties (0x00bf)

< HCI Command: LE Set Periodic Advertising Data (0x08|0x003f) plen 7
        Handle: 1
        Operation: Last fragment (0x02)
        Data length: 0x04
        ff 00 ff 00                                      ....

< HCI Command: LE Set Periodic Advertising Enable (0x08|0x0040) plen 2
        Periodic advertising: Enabled (0x01)
        Handle: 2
---
 monitor/bt.h     |  22 ++++++++++++
 monitor/packet.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 121 insertions(+), 3 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index aa55579bf..0160dcc7f 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2253,6 +2253,28 @@ struct bt_hci_cmd_le_remove_adv_set {
 
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
+	uint8_t  data[0];
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
index 4c1ba1cbe..f43be9adb 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7462,6 +7462,96 @@ static void le_remove_adv_set_cmd(const void *data, uint8_t size)
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
+
+	print_field("Operation: %s (0x%2.2x)", str, cmd->operation);
+	print_field("Data length: 0x%2.2x", cmd->data_len);
+	print_eir(cmd->data, cmd->data_len, true);
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
+	print_field("Periodic advertising: %s (0x%2.2x)", str, cmd->enable);
+	print_handle(cmd->handle);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8198,9 +8288,15 @@ static const struct opcode_data opcode_table[] = {
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
2.11.0

