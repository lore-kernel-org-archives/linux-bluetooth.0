Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 07/31] monitor: Add LE Set Extended Advertising Enable decoding
Date: Tue,  6 Jun 2017 11:40:56 +0200
Message-Id: <20170606094120.14541-10-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Set Extended Advertising Enable (0x08|0x0039) plen 24
        Ext adv: Enabled
        Number of sets: 2
        Entry 0
          Handle: 0xff
          Duration: 0 ms (0x00)
          Max ext adv events: 0
        Entry 1
          Handle: 0x00
          Duration: 0 ms (0x00)
          Max ext adv events: 1
---
 monitor/bt.h     | 11 +++++++++++
 monitor/packet.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index b3a8816..8dd0d57 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2223,6 +2223,17 @@ struct bt_hci_cmd_le_set_ext_scan_rsp_data {
 	uint8_t  data[0];
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE			0x2039
+struct bt_hci_cmd_le_set_ext_adv_enable {
+	uint8_t  enable;
+	uint8_t  num_of_sets;
+} __attribute__ ((packed));
+struct bt_hci_cmd_ext_adv_set {
+	uint8_t  handle;
+	uint16_t  duration;
+	uint8_t  max_events;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 30b50c3..f109b4f 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7183,6 +7183,44 @@ static void le_set_ext_scan_rsp_data_cmd(const void *data, uint8_t size)
 	packet_print_ad(cmd->data, size - sizeof(*cmd));
 }
 
+static void le_set_ext_adv_enable_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_ext_adv_enable *cmd = data;
+	const struct bt_hci_cmd_ext_adv_set *adv_set;
+	const char *str;
+	int i;
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
+	print_field("Ext adv: %s", str);
+
+	if (cmd->num_of_sets == 0) {
+		print_field("Number of sets: Disable all advertising sets");
+	} else if (cmd->num_of_sets > 0x3f) {
+		print_field("Number of sets: Reserved");
+	} else {
+		print_field("Number of sets: %u", cmd->num_of_sets);
+	}
+
+	for (i = 0; i < cmd->num_of_sets; ++i) {
+		adv_set = data + 2 + i * sizeof(struct bt_hci_cmd_ext_adv_set);
+		print_field("Entry %d", i);
+		print_field("  Handle: 0x%2.2x", adv_set->handle);
+		print_field("  Duration: %d ms (0x%2.2x)", adv_set->duration * 10, adv_set->duration);
+		print_field("  Max ext adv events: %d", adv_set->max_events);
+	}
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -7904,7 +7942,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2038, 292, "LE Set Extended Scan Response Data",
 				le_set_ext_scan_rsp_data_cmd, 4, false,
 				status_rsp, 1, true },
-	{ 0x2039, 293, "LE Set Extended Advertising Enable" },
+	{ 0x2039, 293, "LE Set Extended Advertising Enable",
+				le_set_ext_adv_enable_cmd, 2, false,
+				status_rsp, 1, true },
 	{ 0x203a, 294, "LE Read Maximum Advertising Data Length" },
 	{ 0x203b, 295, "LE Read Number of Supported Advertising Sets" },
 	{ 0x203c, 296, "LE Remove Advertising Set" },
-- 
2.9.3

