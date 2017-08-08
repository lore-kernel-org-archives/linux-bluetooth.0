Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v6 04/11] monitor: Add LE Extended Scan commands decoding
Date: Tue,  8 Aug 2017 10:45:26 +0200
Message-Id: <20170808084533.2323-5-michal.narajowski@codecoup.pl>
In-Reply-To: <20170808084533.2323-1-michal.narajowski@codecoup.pl>
References: <20170808084533.2323-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds decoding for following commands:

LE Set Extended Scan Parameters
LE Set Extended Scan Enable
LE Extended Create Connection
LE Extended Advertising Report Event

< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13
        Own address type: Public (0x00)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 30.000 msec (0x0030)
          Window: 30.000 msec (0x0030)
        Entry 1: LE Coded
          Type: Active (0x01)
          Interval: 30.000 msec (0x0030)
          Window: 30.000 msec (0x0030)

< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6
        Extended scan: Enabled (0x01)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)

< HCI Command: LE Extended Create Connection (0x08|0x0043) plen 29
        Filter policy: White list is not used (0x00)
        Own address type: Public (0x00)
        Peer address type: Public (0x00)
        Peer address: 11:22:33:C0:DE:C0 (OUI 11-22-33)
        Initiating PHYs: 0x04
        Entry 0: LE Coded
          Scan interval: 10.000 msec (0x0010)
          Scan window: 10.000 msec (0x0010)
          Min connection interval: 30.00 msec (0x0018)
          Max connection interval: 50.00 msec (0x0028)
          Connection latency: 0 (0x0000)
          Supervision timeout: 2560 msec (0x0100)
          Min connection length: 10.000 msec (0x0010)
          Max connection length: 480.000 msec (0x0300)
---
 monitor/bt.h     |  60 ++++++++
 monitor/packet.c | 406 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 449 insertions(+), 17 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 0160dcc7f..74439b9e5 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2275,6 +2275,47 @@ struct bt_hci_cmd_le_set_periodic_adv_enable {
 	uint8_t  handle;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS		0x2041
+struct bt_hci_cmd_le_set_ext_scan_params {
+	uint8_t  own_addr_type;
+	uint8_t  filter_policy;
+	uint8_t  num_phys;
+	uint8_t  data[0];
+} __attribute__ ((packed));
+struct bt_hci_le_scan_phy {
+	uint8_t  type;
+	uint16_t interval;
+	uint16_t window;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE		0x2042
+struct bt_hci_cmd_le_set_ext_scan_enable {
+	uint8_t  enable;
+	uint8_t  filter_dup;
+	uint16_t duration;
+	uint16_t period;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_EXT_CREATE_CONN		0x2043
+struct bt_hci_cmd_le_ext_create_conn {
+	uint8_t  filter_policy;
+	uint8_t  own_addr_type;
+	uint8_t  peer_addr_type;
+	uint8_t  peer_addr[6];
+	uint8_t  phys;
+	uint8_t  data[0];
+} __attribute__ ((packed));
+struct bt_hci_le_ext_create_conn {
+	uint16_t scan_interval;
+	uint16_t scan_window;
+	uint16_t min_interval;
+	uint16_t max_interval;
+	uint16_t latency;
+	uint16_t supv_timeout;
+	uint16_t min_length;
+	uint16_t max_length;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
@@ -2885,6 +2926,25 @@ struct bt_hci_evt_le_phy_update_complete {
 	uint8_t  rx_phy;
 } __attribute__ ((packed));
 
+#define BT_HCI_EVT_LE_EXT_ADV_REPORT	0x0d
+struct bt_hci_evt_le_ext_adv_report {
+	uint8_t  num_reports;
+} __attribute__ ((packed));
+struct bt_hci_le_ext_adv_report {
+	uint16_t event_type;
+	uint8_t  addr_type;
+	uint8_t  addr[6];
+	uint8_t  primary_phy;
+	uint8_t  secondary_phy;
+	uint8_t  sid;
+	uint8_t  tx_power;
+	int8_t   rssi;
+	uint16_t interval;
+	uint8_t  direct_addr_type;
+	uint8_t  direct_addr[6];
+	uint8_t  data_len;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_LE_ADV_SET_TERM		0x12
 struct bt_hci_evt_le_adv_set_term {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index f43be9adb..0b698853a 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2305,7 +2305,7 @@ static void print_num_reports(uint8_t num_reports)
 	print_field("Num reports: %d", num_reports);
 }
 
-static void print_adv_event_type(uint8_t type)
+static void print_adv_event_type(const char *label, uint8_t type)
 {
 	const char *str;
 
@@ -2330,7 +2330,7 @@ static void print_adv_event_type(uint8_t type)
 		break;
 	}
 
-	print_field("Event type: %s (0x%2.2x)", str, type);
+	print_field("%s: %s (0x%2.2x)", label, str, type);
 }
 
 static void print_adv_channel_map(const char *label, uint8_t value)
@@ -6506,12 +6506,11 @@ static void le_set_adv_enable_cmd(const void *data, uint8_t size)
 	print_field("Advertising: %s (0x%2.2x)", str, cmd->enable);
 }
 
-static void le_set_scan_parameters_cmd(const void *data, uint8_t size)
+static void print_scan_type(const char *label, uint8_t type)
 {
-	const struct bt_hci_cmd_le_set_scan_parameters *cmd = data;
 	const char *str;
 
-	switch (cmd->type) {
+	switch (type) {
 	case 0x00:
 		str = "Passive";
 		break;
@@ -6523,13 +6522,14 @@ static void le_set_scan_parameters_cmd(const void *data, uint8_t size)
 		break;
 	}
 
-	print_field("Type: %s (0x%2.2x)", str, cmd->type);
+	print_field("%s: %s (0x%2.2x)", label, str, type);
+}
 
-	print_interval(cmd->interval);
-	print_window(cmd->window);
-	print_own_addr_type(cmd->own_addr_type);
+static void print_scan_filter_policy(uint8_t policy)
+{
+	const char *str;
 
-	switch (cmd->filter_policy) {
+	switch (policy) {
 	case 0x00:
 		str = "Accept all advertisement";
 		break;
@@ -6547,7 +6547,18 @@ static void le_set_scan_parameters_cmd(const void *data, uint8_t size)
 		break;
 	}
 
-	print_field("Filter policy: %s (0x%2.2x)", str, cmd->filter_policy);
+	print_field("Filter policy: %s (0x%2.2x)", str, policy);
+}
+
+static void le_set_scan_parameters_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_scan_parameters *cmd = data;
+
+	print_scan_type("Type", cmd->type);
+	print_interval(cmd->interval);
+	print_window(cmd->window);
+	print_own_addr_type(cmd->own_addr_type);
+	print_scan_filter_policy(cmd->filter_policy);
 }
 
 static void le_set_scan_enable_cmd(const void *data, uint8_t size)
@@ -7552,6 +7563,183 @@ static void le_set_periodic_adv_enable_cmd(const void *data, uint8_t size)
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
+static void print_ext_scan_phys(const void *data, uint8_t flags)
+{
+	const struct bt_hci_le_scan_phy *scan_phy;
+	uint8_t mask = flags;
+	int bits_set = 0;
+	int i;
+
+	print_field("PHYs: 0x%2.2x", flags);
+
+	for (i = 0; ext_scan_phys_table[i].str; i++) {
+		if (flags & (1 << ext_scan_phys_table[i].bit)) {
+			scan_phy = data + bits_set * sizeof(*scan_phy);
+			mask &= ~(1 << ext_scan_phys_table[i].bit);
+
+			print_field("Entry %d: %s", bits_set,
+						ext_scan_phys_table[i].str);
+			print_scan_type("  Type", scan_phy->type);
+			print_slot_625("  Interval", scan_phy->interval);
+			print_slot_625("  Window", scan_phy->window);
+
+			++bits_set;
+		}
+	}
+
+	if (mask)
+		print_text(COLOR_UNKNOWN_ADV_FLAG, "  Unknown scanning PHYs"
+							" (0x%2.2x)", mask);
+}
+
+static void le_set_ext_scan_params_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_ext_scan_params *cmd = data;
+
+	print_own_addr_type(cmd->own_addr_type);
+	print_scan_filter_policy(cmd->filter_policy);
+	print_ext_scan_phys(cmd->data, cmd->num_phys);
+}
+
+static void print_enable(const char *label, uint8_t enable)
+{
+	const char *str;
+
+	switch (enable) {
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
+	print_field("%s: %s (0x%2.2x)", label, str, enable);
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
+						le16_to_cpu(cmd->duration) * 10,
+						le16_to_cpu(cmd->duration));
+	print_field("Period: %.2f sec (0x%4.4x)",
+						le16_to_cpu(cmd->period) * 1.28,
+						le16_to_cpu(cmd->period));
+}
+
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
+static void print_ext_conn_phys(const void *data, uint8_t flags)
+{
+	const struct bt_hci_le_ext_create_conn *entry;
+	uint8_t mask = flags;
+	int bits_set = 0;
+	int i;
+
+	print_field("Initiating PHYs: 0x%2.2x", flags);
+
+	for (i = 0; ext_conn_phys_table[i].str; i++) {
+		if (flags & (1 << ext_conn_phys_table[i].bit)) {
+			entry = data + bits_set * sizeof(*entry);
+			mask &= ~(1 << ext_conn_phys_table[i].bit);
+
+			print_field("Entry %d: %s", bits_set,
+						ext_conn_phys_table[i].str);
+			print_slot_625("  Scan interval", entry->scan_interval);
+			print_slot_625("  Scan window", entry->scan_window);
+			print_slot_125("  Min connection interval",
+							entry->min_interval);
+			print_slot_125("  Max connection interval",
+							entry->max_interval);
+			print_field("  Connection latency: %u (0x%4.4x)",
+						le16_to_cpu(entry->latency),
+						le16_to_cpu(entry->latency));
+			print_field("  Supervision timeout: %d msec (0x%4.4x)",
+					le16_to_cpu(entry->supv_timeout) * 10,
+					le16_to_cpu(entry->supv_timeout));
+			print_slot_625("  Min connection length",
+							entry->min_length);
+			print_slot_625("  Max connection length",
+							entry->max_length);
+
+			++bits_set;
+		}
+	}
+
+	if (mask)
+		print_text(COLOR_UNKNOWN_ADV_FLAG, "  Unknown scanning PHYs"
+							" (0x%2.2x)", mask);
+}
+
+static void le_ext_create_conn_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_ext_create_conn *cmd = data;
+	const char *str;
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
+	print_ext_conn_phys(cmd->data, cmd->phys);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8297,9 +8485,15 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2040, 300, "LE Set Periodic Advertising Enable",
 				le_set_periodic_adv_enable_cmd, 2, true,
 				status_rsp, 1, true },
-	{ 0x2041, 301, "LE Set Extended Scan Parameters" },
-	{ 0x2042, 302, "LE Set Extended Scan Enable" },
-	{ 0x2043, 303, "LE Extended Create Connection" },
+	{ 0x2041, 301, "LE Set Extended Scan Parameters",
+				le_set_ext_scan_params_cmd, 3, false,
+				status_rsp, 1, true },
+	{ 0x2042, 302, "LE Set Extended Scan Enable",
+				le_set_ext_scan_enable_cmd, 6, true,
+				status_rsp, 1, true },
+	{ 0x2043, 303, "LE Extended Create Connection",
+				le_ext_create_conn_cmd, 10, false,
+				status_rsp, 1, true },
 	{ 0x2044, 304, "LE Periodic Advertising Create Sync" },
 	{ 0x2045, 305, "LE Periodic Advertising Create Sync Cancel" },
 	{ 0x2046, 306, "LE Periodic Advertising Terminate Sync" },
@@ -9275,7 +9469,7 @@ static void le_adv_report_evt(const void *data, uint8_t size)
 	print_num_reports(evt->num_reports);
 
 report:
-	print_adv_event_type(evt->event_type);
+	print_adv_event_type("Event type", evt->event_type);
 	print_peer_addr_type("Address type", evt->addr_type);
 	print_addr("Address", evt->addr, evt->addr_type);
 	print_field("Data length: %d", evt->data_len);
@@ -9393,7 +9587,7 @@ static void le_direct_adv_report_evt(const void *data, uint8_t size)
 
 	print_num_reports(evt->num_reports);
 
-	print_adv_event_type(evt->event_type);
+	print_adv_event_type("Event type", evt->event_type);
 	print_peer_addr_type("Address type", evt->addr_type);
 	print_addr("Address", evt->addr, evt->addr_type);
 	print_addr_type("Direct address type", evt->direct_addr_type);
@@ -9414,6 +9608,183 @@ static void le_phy_update_complete_evt(const void *data, uint8_t size)
 	print_le_phy("RX PHY", evt->rx_phy);
 }
 
+static const struct {
+	uint8_t bit;
+	const char *str;
+} ext_adv_report_evt_type[] = {
+	{  0, "Connectable"		},
+	{  1, "Scannable"		},
+	{  2, "Directed"	},
+	{  3, "Scan response"	},
+	{  4, "Use legacy advertising PDUs"	},
+	{ }
+};
+
+static void print_ext_adv_report_evt_type(const char *indent, uint16_t flags)
+{
+	uint16_t mask = flags;
+	uint16_t props = flags;
+	uint8_t data_status;
+	const char *str;
+	int i;
+
+	print_field("%sEvent type: 0x%4.4x", indent, flags);
+
+	props &= 0x1f;
+	print_field("%s  Props: 0x%4.4x", indent, props);
+	for (i = 0; ext_adv_report_evt_type[i].str; i++) {
+		if (flags & (1 << ext_adv_report_evt_type[i].bit)) {
+			print_field("%s    %s", indent,
+						ext_adv_report_evt_type[i].str);
+			mask &= ~(1 << ext_adv_report_evt_type[i].bit);
+		}
+	}
+
+	data_status = (flags >> 5) & 3;
+	mask &= ~(data_status << 5);
+
+	switch (data_status) {
+	case 0x00:
+		str = "Complete";
+		break;
+	case 0x01:
+		str = "Incomplete, more data to come";
+		break;
+	case 0x02:
+		str = "Incomplete, data truncated, no more to come";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("%s  Data status: %s", indent, str);
+
+	if (mask)
+		print_text(COLOR_UNKNOWN_ADV_FLAG,
+				"%s  Reserved (0x%4.4x)", indent, mask);
+}
+
+static void print_legacy_adv_report_pdu(uint16_t flags)
+{
+	const char *str;
+
+	if (!(flags & (1 << 4)))
+		return;
+
+	switch (flags) {
+	case 0x10:
+		str = "ADV_NONCONN_IND";
+		break;
+	case 0x12:
+		str = "ADV_SCAN_IND";
+		break;
+	case 0x13:
+		str = "ADV_IND";
+		break;
+	case 0x15:
+		str = "ADV_DIRECT_IND";
+		break;
+	case 0x1a:
+		str = "SCAN_RSP to an ADV_IND";
+		break;
+	case 0x1b:
+		str = "SCAN_RSP to an ADV_SCAN_IND";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("  Legacy PDU Type: %s (0x%4.4x)", str, flags);
+}
+
+static void le_ext_adv_report_evt(const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_ext_adv_report *evt = data;
+	const struct bt_hci_le_ext_adv_report *report;
+	const char *str;
+	int i;
+
+	print_num_reports(evt->num_reports);
+
+	data += sizeof(evt->num_reports);
+
+	for (i = 0; i < evt->num_reports; ++i) {
+		report = data;
+		print_field("Entry %d", i);
+		print_ext_adv_report_evt_type("  ", report->event_type);
+		print_legacy_adv_report_pdu(report->event_type);
+		print_peer_addr_type("  Address type", report->addr_type);
+		print_addr("  Address", report->addr, report->addr_type);
+
+		switch (report->primary_phy) {
+		case 0x01:
+			str = "LE 1M";
+			break;
+		case 0x03:
+			str = "LE Coded";
+			break;
+		default:
+			str = "Reserved";
+			break;
+		}
+
+		print_field("  Primary PHY: %s", str);
+
+		switch (report->secondary_phy) {
+		case 0x00:
+			str = "No packets";
+			break;
+		case 0x01:
+			str = "LE 1M";
+			break;
+		case 0x02:
+			str = "LE 2M";
+			break;
+		case 0x03:
+			str = "LE Coded";
+			break;
+		default:
+			str = "Reserved";
+			break;
+		}
+
+		print_field("  Secondary PHY: %s", str);
+
+		if (report->sid == 0xff)
+			print_field("  SID: no ADI field (0x%2.2x)",
+								report->sid);
+		else if (report->sid > 0x0f)
+			print_field("  SID: Reserved (0x%2.2x)", report->sid);
+		else
+			print_field("  SID: 0x%2.2x", report->sid);
+
+		print_field("  TX power: %d dBm", report->tx_power);
+
+		if (report->rssi == 127)
+			print_field("  RSSI: not available (0x%2.2x)",
+							(uint8_t) report->rssi);
+		else if (report->rssi >= -127 && report->rssi <= 20)
+			print_field("  RSSI: %d dBm (0x%2.2x)",
+					report->rssi, (uint8_t) report->rssi);
+		else
+			print_field("  RSSI: reserved (0x%2.2x)",
+							(uint8_t) report->rssi);
+
+		print_slot_125("  Periodic advertising invteral",
+							report->interval);
+		print_peer_addr_type("  Direct address type",
+						report->direct_addr_type);
+		print_addr("  Direct address", report->direct_addr,
+						report->direct_addr_type);
+		print_field("  Data length: 0x%2.2x", report->data_len);
+		data += sizeof(struct bt_hci_le_ext_adv_report);
+		packet_hexdump(data, report->data_len);
+		data += report->data_len;
+	}
+}
+
 static void le_adv_set_term_evt(const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_adv_set_term *evt = data;
@@ -9525,7 +9896,8 @@ static const struct subevent_data le_meta_event_table[] = {
 				le_direct_adv_report_evt, 1, false },
 	{ 0x0c, "LE PHY Update Complete",
 				le_phy_update_complete_evt, 5, true},
-	{ 0x0d, "LE Extended Advertising Report" },
+	{ 0x0d, "LE Extended Advertising Report",
+				le_ext_adv_report_evt, 1, false},
 	{ 0x0e, "LE Periodic Advertising Sync Established" },
 	{ 0x0f, "LE Periodic Advertising Report" },
 	{ 0x10, "LE Periodic Advertising Sync Lost" },
-- 
2.11.0

