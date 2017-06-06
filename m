Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 1/2] monitor: Add LE Set Extended Scan Parameters decoding
Date: Tue,  6 Jun 2017 11:40:49 +0200
Message-Id: <20170606094120.14541-3-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/bt.h     | 12 +++++++
 monitor/packet.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 660564a..5ec3e5e 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2272,6 +2272,18 @@ struct bt_hci_cmd_le_set_periodic_adv_enable {
 	uint8_t  handle;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS		0x2041
+struct bt_hci_cmd_le_set_ext_scan_params {
+	uint8_t  own_addr_type;
+	uint8_t  filter_policy;
+	uint8_t  phys;
+} __attribute__ ((packed));
+struct bt_hci_le_scan_phy {
+	uint8_t  type;
+	uint16_t  interval;
+	uint16_t  window;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 8ffda90..fb6aee2 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7336,6 +7336,101 @@ static void le_set_periodic_adv_enable_cmd(const void *data, uint8_t size)
 	print_handle(cmd->handle);
 }
 
+static const struct {
+	uint8_t bit;
+	const char *str;
+} ext_scan_phys_table[] = {
+	{  0, "LE 1M"		},
+	{  2, "LE Coded"		},
+	{ }
+};
+
+static int print_ext_scan_phys(uint8_t flags)
+{
+	uint8_t mask = flags;
+	int bits_set = 0;
+	int i;
+
+	print_field("PHYs: 0x%2.2x", flags);
+
+	for (i = 0; ext_scan_phys_table[i].str; i++) {
+		if (flags & (1 << ext_scan_phys_table[i].bit)) {
+			print_field("  %s", ext_scan_phys_table[i].str);
+			mask &= ~(1 << ext_scan_phys_table[i].bit);
+			++bits_set;
+		}
+	}
+
+	if (mask)
+		print_text(COLOR_UNKNOWN_ADV_FLAG, "  Unknown scanning PHYs"
+							" (0x%2.2x)", mask);
+	return bits_set;
+}
+
+static void print_scan_filter_policy(uint8_t policy)
+{
+	const char *str;
+
+	switch (policy) {
+	case 0x00:
+		str = "Accept all advertisement";
+		break;
+	case 0x01:
+		str = "Ignore not in white list";
+		break;
+	case 0x02:
+		str = "Accept all advertisement, inc. directed unresolved RPA";
+		break;
+	case 0x03:
+		str = "Ignore not in white list, exc. directed unresolved RPA";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("Filter policy: %s (0x%2.2x)", str, policy);
+}
+
+static void print_scan_type(uint8_t type)
+{
+	const char *str;
+
+	switch (type) {
+	case 0x00:
+		str = "Passive";
+		break;
+	case 0x01:
+		str = "Active";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("Type: %s (0x%2.2x)", str, type);
+}
+
+static void le_set_ext_scan_params_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_ext_scan_params *cmd = data;
+	const struct bt_hci_le_scan_phy *scan_phy;
+	int num_structs;
+	int i;
+
+	print_own_addr_type(cmd->own_addr_type);
+	print_scan_filter_policy(cmd->filter_policy);
+	num_structs = print_ext_scan_phys(cmd->phys);
+
+	for (i = 0; i < num_structs; ++i) {
+		scan_phy = data + 3 + i * sizeof(struct bt_hci_le_scan_phy);
+
+		print_scan_type(scan_phy->type);
+		print_interval(scan_phy->interval);
+		print_window(scan_phy->window);
+	}
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8070,7 +8165,8 @@ static const struct opcode_data opcode_table[] = {
 				le_set_periodic_adv_data_cmd, 3, false },
 	{ 0x2040, 300, "LE Set Periodic Advertising Enable",
 				le_set_periodic_adv_enable_cmd, 2, true },
-	{ 0x2041, 301, "LE Set Extended Scan Parameters" },
+	{ 0x2041, 301, "LE Set Extended Scan Parameters",
+				le_set_ext_scan_params_cmd, 3, false },
 	{ 0x2042, 302, "LE Set Extended Scan Enable" },
 	{ 0x2043, 303, "LE Extended Create Connection" },
 	{ 0x2044, 304, "LE Periodic Advertising Create Sync" },
-- 
2.9.3

