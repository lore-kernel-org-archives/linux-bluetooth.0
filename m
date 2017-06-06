Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 16/31] monitor: Add LE Set Extended Scan Enable decoding
Date: Tue,  6 Jun 2017 11:41:05 +0200
Message-Id: <20170606094120.14541-19-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6
        Extended scan: Enabled
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
---
 monitor/bt.h     |  8 ++++++++
 monitor/packet.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index fd61c53..8bc19da 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2286,6 +2286,14 @@ struct bt_hci_le_scan_phy {
 	uint16_t  window;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE		0x2042
+struct bt_hci_cmd_le_set_ext_scan_enable {
+	uint8_t  enable;
+	uint8_t  filter_dup;
+	uint16_t  duration;
+	uint16_t  period;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 78b780f..9115395 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7429,6 +7429,57 @@ static void le_set_ext_scan_params_cmd(const void *data, uint8_t size)
 	}
 }
 
+static void print_enable(const char *label, uint8_t enable)
+{
+	const char *str;
+
+	switch (enable) {
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
+	print_field("%s: %s", label, str);
+}
+
+static void print_filter_dup(uint8_t filter_dup)
+{
+	const char *str;
+
+	switch (filter_dup) {
+	case 0x00:
+		str = "Disabled";
+		break;
+	case 0x01:
+		str = "Enabled";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("Filter duplicates: %s (0x%2.2x)", str, filter_dup);
+}
+
+static void le_set_ext_scan_enable_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_ext_scan_enable *cmd = data;
+
+	print_enable("Extended scan", cmd->enable);
+	print_filter_dup(cmd->filter_dup);
+
+	print_field("Duration: %d msec (0x%4.4x)",
+			le16_to_cpu(cmd->duration) * 10, le16_to_cpu(cmd->duration));
+	print_field("Period: %.2f sec (0x%4.4x)",
+			le16_to_cpu(cmd->period) * 1.28, le16_to_cpu(cmd->period));
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8177,7 +8228,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2041, 301, "LE Set Extended Scan Parameters",
 				le_set_ext_scan_params_cmd, 3, false,
 				status_rsp, 1, true },
-	{ 0x2042, 302, "LE Set Extended Scan Enable" },
+	{ 0x2042, 302, "LE Set Extended Scan Enable",
+				le_set_ext_scan_enable_cmd, 6, true,
+				status_rsp, 1, true },
 	{ 0x2043, 303, "LE Extended Create Connection" },
 	{ 0x2044, 304, "LE Periodic Advertising Create Sync" },
 	{ 0x2045, 305, "LE Periodic Advertising Create Sync Cancel" },
-- 
2.9.3

