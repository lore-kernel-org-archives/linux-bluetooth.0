Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 17/31] monitor: Add LE Extended Create Connection decoding
Date: Tue,  6 Jun 2017 11:41:06 +0200
Message-Id: <20170606094120.14541-20-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Extended Create Connection (0x08|0x0043) plen 24
        Filter policy: White list is used (0x01)
        Own address type: Public (0x02)
        Peer address type: Reserved (0xff)
        Peer address: 00-00-00-00-00-00
        Initiating PHYs: 0x01
          LE 1M
        Scan interval: 1.250 msec (0x0002)
        Scan window: 1601.875 msec (0x0a03)
        Min connection interval: 3212.50 msec (0x0a0a)
        Max connection interval: 3212.50 msec (0x0a0a)
        Connection latency: 0x010a
        Supervision timeout: 7700 msec (0x0302)
        Min connection length: 802.500 msec (0x0504)
        Max connection length: 5123.750 msec (0x2006)
---
 monitor/bt.h     | 19 ++++++++++++++
 monitor/packet.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 8bc19da..d98d4b6 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2294,6 +2294,25 @@ struct bt_hci_cmd_le_set_ext_scan_enable {
 	uint16_t  period;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_EXT_CREATE_CONN		0x2043
+struct bt_hci_cmd_le_ext_create_conn {
+	uint8_t  filter_policy;
+	uint8_t  own_addr_type;
+	uint8_t  peer_addr_type;
+	uint8_t  peer_addr[6];
+	uint8_t  phys;
+} __attribute__ ((packed));
+struct bt_hci_le_ext_create_conn {
+	uint8_t  scan_interval;
+	uint16_t  scan_window;
+	uint16_t  min_interval;
+	uint16_t  max_interval;
+	uint16_t  latency;
+	uint16_t  supv_timeout;
+	uint16_t  min_length;
+	uint16_t  max_length;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 9115395..3278abf 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7480,6 +7480,82 @@ static void le_set_ext_scan_enable_cmd(const void *data, uint8_t size)
 			le16_to_cpu(cmd->period) * 1.28, le16_to_cpu(cmd->period));
 }
 
+static const struct {
+	uint8_t bit;
+	const char *str;
+} ext_conn_phys_table[] = {
+	{  0, "LE 1M"		},
+	{  1, "LE 2M"		},
+	{  2, "LE Coded"		},
+	{ }
+};
+
+static int print_ext_conn_phys(uint8_t flags)
+{
+	uint8_t mask = flags;
+	int bits_set = 0;
+	int i;
+
+	print_field("Initiating PHYs: 0x%2.2x", flags);
+
+	for (i = 0; ext_conn_phys_table[i].str; i++) {
+		if (flags & (1 << ext_conn_phys_table[i].bit)) {
+			print_field("  %s", ext_conn_phys_table[i].str);
+			mask &= ~(1 << ext_conn_phys_table[i].bit);
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
+
+static void le_ext_create_conn_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_ext_create_conn *cmd = data;
+	const struct bt_hci_le_ext_create_conn *entry;
+	const char *str;
+	int num_entries;
+	int i;
+
+	switch (cmd->filter_policy) {
+	case 0x00:
+		str = "White list is not used";
+		break;
+	case 0x01:
+		str = "White list is used";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("Filter policy: %s (0x%2.2x)", str, cmd->filter_policy);
+
+	print_own_addr_type(cmd->own_addr_type);
+	print_peer_addr_type("Peer address type", cmd->peer_addr_type);
+	print_addr("Peer address", cmd->peer_addr, cmd->peer_addr_type);
+	num_entries = print_ext_conn_phys(cmd->phys);
+
+	for (i = 0; i < num_entries; ++i) {
+		entry = data + 10 + i * sizeof(struct bt_hci_le_ext_create_conn);
+
+		print_slot_625("Scan interval", entry->scan_interval);
+		print_slot_625("Scan window", entry->scan_window);
+		print_slot_125("Min connection interval", entry->min_interval);
+		print_slot_125("Max connection interval", entry->max_interval);
+		print_field("Connection latency: 0x%4.4x", le16_to_cpu(entry->latency));
+		print_field("Supervision timeout: %d msec (0x%4.4x)",
+						le16_to_cpu(entry->supv_timeout) * 10,
+						le16_to_cpu(entry->supv_timeout));
+		print_slot_625("Min connection length", entry->min_length);
+		print_slot_625("Max connection length", entry->max_length);
+	}
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8231,7 +8307,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2042, 302, "LE Set Extended Scan Enable",
 				le_set_ext_scan_enable_cmd, 6, true,
 				status_rsp, 1, true },
-	{ 0x2043, 303, "LE Extended Create Connection" },
+	{ 0x2043, 303, "LE Extended Create Connection",
+				le_ext_create_conn_cmd, 10, false,
+				status_rsp, 1, true },
 	{ 0x2044, 304, "LE Periodic Advertising Create Sync" },
 	{ 0x2045, 305, "LE Periodic Advertising Create Sync Cancel" },
 	{ 0x2046, 306, "LE Periodic Advertising Terminate Sync" },
-- 
2.9.3

