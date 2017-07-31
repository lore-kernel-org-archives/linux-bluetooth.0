Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v5 02/11] monitor: Add LE Extended Advertising commands decoding
Date: Mon, 31 Jul 2017 15:39:01 +0200
Message-Id: <20170731133910.26745-3-michal.narajowski@codecoup.pl>
In-Reply-To: <20170731133910.26745-1-michal.narajowski@codecoup.pl>
References: <20170731133910.26745-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds decoding for following commands:

LE Set Advertising Set Random Address
LE Set Extended Advertising Parameters
LE Set Extended Advertising Data
LE Set Extended Scan Response Data
LE Set Extended Advertising Enable
LE Read Maximum Advertising Data Length
LE Read Number of Supported Advertising Sets
LE Remove Advertising Set
LE Clear Advertising Sets
LE Advertising Set Terminated Event
LE Scan Request Received Event

< HCI Command: LE Set Advertising Set Random Address (0x08|0x0035) plen 7
        Advertising handle: 0x00
        Advertising random address: 0A:0B:0C:0D:0E:0F (OUI 0A-0B-0C)

< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen 25
        Handle: 0x00
        Properties: 0x0005
          Connectable
          Directed
        Min advertising interval: 30.000 msec (0x0030)
        Max advertising interval: 60.000 msec (0x0060)
        Channel map: 37, 38, 39 (0x07)
        Own address type: Public (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:11:22:33:44:55 (CIMSYS Inc)
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
        TX power: 127 dbm (0x7f)
        Primary PHY: LE Coded (0x03)
        Secondary max skip: 0x00
        Secondary PHY: LE Coded (0x03)
        SID: 0x00
        Scan request notifications: Disabled (0x00)

< HCI Command: LE Set Extended Advertising Data (0x08|0x0037) plen 39
        Handle: 0x00
        Operation: Complete extended advertising data (0x03)
        Fragment preference: Fragment all (0x00)
        Data length: 0x23
        16-bit Service UUIDs (partial): 1 entry
          Unknown (0x1234)
        128-bit Service UUIDs (partial): 1 entry
          Vendor specific (0f0e0d0c-0b0a-0908-0706-050403020100)
        Name (short): device-name

< HCI Command: LE Set Extended Scan Response Data (0x08|0x0037) plen 39
        Handle: 0x00
        Operation: Complete extended advertising data (0x03)
        Fragment preference: Fragment all (0x00)
        Data length: 0x23
        16-bit Service UUIDs (partial): 1 entry
          Unknown (0x1234)
        128-bit Service UUIDs (partial): 1 entry
          Vendor specific (0f0e0d0c-0b0a-0908-0706-050403020100)
        Name (short): device-name

< HCI Command: LE Set Extended Advertising Enable (0x08|0x0039) plen 24
        Extended advertising: Enabled (0x01)
        Number of sets: 2 (0x02)
        Entry 0
          Handle: 0xff
          Duration: 0 ms (0x00)
          Max ext adv events: 0
        Entry 1
          Handle: 0x00
          Duration: 0 ms (0x00)
          Max ext adv events: 1

< HCI Command: LE Remove Advertising Set (0x08|0x003c) plen 1
        Handle: 1
---
 monitor/bt.h     |  92 +++++++++++
 monitor/packet.c | 493 +++++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 519 insertions(+), 66 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index a877b2c13..aa55579bf 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2176,6 +2176,83 @@ struct bt_hci_cmd_le_enhanced_transmitter_test {
 	uint8_t phy;
 } __attribute__((packed));
 
+#define BT_HCI_CMD_LE_SET_ADV_SET_RAND_ADDR			0x2035
+struct bt_hci_cmd_le_set_adv_set_rand_addr {
+	uint8_t  handle;
+	uint8_t  bdaddr[6];
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS			0x2036
+struct bt_hci_cmd_le_set_ext_adv_params {
+	uint8_t  handle;
+	uint16_t evt_properties;
+	uint8_t  min_interval[3];
+	uint8_t  max_interval[3];
+	uint8_t  channel_map;
+	uint8_t  own_addr_type;
+	uint8_t  peer_addr_type;
+	uint8_t  peer_addr[6];
+	uint8_t  filter_policy;
+	uint8_t  tx_power;
+	uint8_t  primary_phy;
+	uint8_t  secondary_max_skip;
+	uint8_t  secondary_phy;
+	uint8_t  sid;
+	uint8_t  notif_enable;
+} __attribute__ ((packed));
+struct bt_hci_rsp_le_set_ext_adv_params {
+	uint8_t  status;
+	uint8_t  tx_power;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_SET_EXT_ADV_DATA			0x2037
+struct bt_hci_cmd_le_set_ext_adv_data {
+	uint8_t  handle;
+	uint8_t  operation;
+	uint8_t  fragment_preference;
+	uint8_t  data_len;
+	uint8_t  data[0];
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_SET_EXT_SCAN_RSP_DATA			0x2038
+struct bt_hci_cmd_le_set_ext_scan_rsp_data {
+	uint8_t  handle;
+	uint8_t  operation;
+	uint8_t  fragment_preference;
+	uint8_t  data_len;
+	uint8_t  data[0];
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE			0x2039
+struct bt_hci_cmd_le_set_ext_adv_enable {
+	uint8_t  enable;
+	uint8_t  num_of_sets;
+} __attribute__ ((packed));
+struct bt_hci_cmd_ext_adv_set {
+	uint8_t  handle;
+	uint16_t duration;
+	uint8_t  max_events;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_READ_MAX_ADV_DATA_LEN			0x203a
+struct bt_hci_rsp_le_read_max_adv_data_len {
+	uint8_t  status;
+	uint16_t max_len;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_READ_NUM_SUPPORTED_ADV_SETS			0x203b
+struct bt_hci_rsp_le_read_num_supported_adv_sets {
+	uint8_t  status;
+	uint8_t  num_of_sets;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_REMOVE_ADV_SET			0x203c
+struct bt_hci_cmd_le_remove_adv_set {
+	uint8_t  handle;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_CLEAR_ADV_SETS			0x203d
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
@@ -2786,6 +2863,21 @@ struct bt_hci_evt_le_phy_update_complete {
 	uint8_t  rx_phy;
 } __attribute__ ((packed));
 
+#define BT_HCI_EVT_LE_ADV_SET_TERM		0x12
+struct bt_hci_evt_le_adv_set_term {
+	uint8_t  status;
+	uint8_t  handle;
+	uint16_t conn_handle;
+	uint8_t  num_evts;
+} __attribute__ ((packed));
+
+#define BT_HCI_EVT_LE_SCAN_REQ_RECEIVED		0x13
+struct bt_hci_evt_le_scan_req_received {
+	uint8_t  handle;
+	uint8_t  scanner_addr_type;
+	uint8_t  scanner_addr[6];
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_LE_CHAN_SELECT_ALG		0x14
 struct bt_hci_evt_le_chan_select_alg {
 	uint16_t handle;
diff --git a/monitor/packet.c b/monitor/packet.c
index 1f6cd3699..4c1ba1cbe 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -1187,8 +1187,9 @@ static void print_power_type(uint8_t type)
 
 static void print_power_level(int8_t level, const char *type)
 {
-	print_field("TX power%s%s%s: %d dBm",
-		type ? " (" : "", type ? type : "", type ? ")" : "", level);
+	print_field("TX power%s%s%s: %d dbm (0x%2.2x)",
+		type ? " (" : "", type ? type : "", type ? ")" : "",
+								level, level);
 }
 
 static void print_sync_flow_control(uint8_t enable)
@@ -2332,6 +2333,69 @@ static void print_adv_event_type(uint8_t type)
 	print_field("Event type: %s (0x%2.2x)", str, type);
 }
 
+static void print_adv_channel_map(const char *label, uint8_t value)
+{
+	const char *str;
+
+	switch (value) {
+	case 0x01:
+		str = "37";
+		break;
+	case 0x02:
+		str = "38";
+		break;
+	case 0x03:
+		str = "37, 38";
+		break;
+	case 0x04:
+		str = "39";
+		break;
+	case 0x05:
+		str = "37, 39";
+		break;
+	case 0x06:
+		str = "38, 39";
+		break;
+	case 0x07:
+		str = "37, 38, 39";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("%s: %s (0x%2.2x)", label, str, value);
+}
+
+static void print_adv_filter_policy(const char *label, uint8_t value)
+{
+	const char *str;
+
+	switch (value) {
+	case 0x00:
+		str = "Allow Scan Request from Any, "
+			"Allow Connect Request from Any";
+		break;
+	case 0x01:
+		str = "Allow Scan Request from White List Only, "
+			"Allow Connect Request from Any";
+		break;
+	case 0x02:
+		str = "Allow Scan Request from Any, "
+			"Allow Connect Request from White List Only";
+		break;
+	case 0x03:
+		str = "Allow Scan Request from White List Only, "
+			"Allow Connect Request from White List Only";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("%s: %s (0x%2.2x)", label, str, value);
+}
+
 static void print_rssi(int8_t rssi)
 {
 	if ((uint8_t) rssi == 0x99 || rssi == 127)
@@ -6394,59 +6458,8 @@ static void le_set_adv_parameters_cmd(const void *data, uint8_t size)
 	print_own_addr_type(cmd->own_addr_type);
 	print_addr_type("Direct address type", cmd->direct_addr_type);
 	print_addr("Direct address", cmd->direct_addr, cmd->direct_addr_type);
-
-	switch (cmd->channel_map) {
-	case 0x01:
-		str = "37";
-		break;
-	case 0x02:
-		str = "38";
-		break;
-	case 0x03:
-		str = "37, 38";
-		break;
-	case 0x04:
-		str = "39";
-		break;
-	case 0x05:
-		str = "37, 39";
-		break;
-	case 0x06:
-		str = "38, 39";
-		break;
-	case 0x07:
-		str = "37, 38, 39";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("Channel map: %s (0x%2.2x)", str, cmd->channel_map);
-
-	switch (cmd->filter_policy) {
-	case 0x00:
-		str = "Allow Scan Request from Any, "
-			"Allow Connect Request from Any";
-		break;
-	case 0x01:
-		str = "Allow Scan Request from White List Only, "
-			"Allow Connect Request from Any";
-		break;
-	case 0x02:
-		str = "Allow Scan Request from Any, "
-			"Allow Connect Request from White List Only";
-		break;
-	case 0x03:
-		str = "Allow Scan Request from White List Only, "
-			"Allow Connect Request from White List Only";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("Filter policy: %s (0x%2.2x)", str, cmd->filter_policy);
+	print_adv_channel_map("Channel map", cmd->channel_map);
+	print_adv_filter_policy("Filter policy", cmd->filter_policy);
 }
 
 static void le_read_adv_tx_power_rsp(const void *data, uint8_t size)
@@ -7142,6 +7155,313 @@ static void le_enhanced_transmitter_test_cmd(const void *data, uint8_t size)
 	print_field("PHY: %s (0x%2.2x)", str, cmd->phy);
 }
 
+static void le_set_adv_set_rand_addr(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_adv_set_rand_addr *cmd = data;
+
+	print_field("Advertising handle: 0x%2.2x", cmd->handle);
+	print_addr("Advertising random address", cmd->bdaddr, 0x00);
+}
+
+static const struct {
+	uint8_t bit;
+	const char *str;
+} ext_adv_properties_table[] = {
+	{  0, "Connectable"		},
+	{  1, "Scannable"		},
+	{  2, "Directed"	},
+	{  3, "High Duty Cycle Directed Connectable"	},
+	{  4, "Use legacy advertising PDUs"	},
+	{  5, "Anonymous advertising"	},
+	{  6, "Include TxPower"		},
+	{ }
+};
+
+static const char *get_adv_pdu_desc(uint16_t flags)
+{
+	const char *str;
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
+		str = "ADV_DIRECT_IND (low duty cycle)";
+		break;
+	case 0x1d:
+		str = "ADV_DIRECT_IND (high duty cycle)";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	return str;
+}
+
+static void print_ext_adv_properties(uint16_t flags)
+{
+	uint16_t mask = flags;
+	const char *property;
+	int i;
+
+	print_field("Properties: 0x%4.4x", flags);
+
+	for (i = 0; ext_adv_properties_table[i].str; i++) {
+		if (flags & (1 << ext_adv_properties_table[i].bit)) {
+			property = ext_adv_properties_table[i].str;
+
+			if (ext_adv_properties_table[i].bit == 4) {
+				print_field("  %s: %s", property,
+						get_adv_pdu_desc(flags));
+			} else {
+				print_field("  %s", property);
+			}
+			mask &= ~(1 << ext_adv_properties_table[i].bit);
+		}
+	}
+
+	if (mask)
+		print_text(COLOR_UNKNOWN_ADV_FLAG,
+				"  Unknown advertising properties (0x%4.4x)",
+									mask);
+}
+
+static void print_ext_slot_625(const char *label, const uint8_t value[3])
+{
+	uint32_t value_cpu = value[0];
+
+	value_cpu |= value[1] << 8;
+	value_cpu |= value[2] << 16;
+
+	print_field("%s: %.3f msec (0x%4.4x)", label,
+						value_cpu * 0.625, value_cpu);
+}
+
+static void le_set_ext_adv_params_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_ext_adv_params *cmd = data;
+	const char *str;
+
+	print_field("Handle: 0x%2.2x", cmd->handle);
+	print_ext_adv_properties(le16_to_cpu(cmd->evt_properties));
+
+	print_ext_slot_625("Min advertising interval", cmd->min_interval);
+	print_ext_slot_625("Max advertising interval", cmd->max_interval);
+	print_adv_channel_map("Channel map", cmd->channel_map);
+	print_own_addr_type(cmd->own_addr_type);
+	print_peer_addr_type("Peer address type", cmd->peer_addr_type);
+	print_addr("Peer address", cmd->peer_addr, cmd->peer_addr_type);
+	print_adv_filter_policy("Filter policy", cmd->filter_policy);
+	print_power_level(cmd->tx_power, NULL);
+
+	switch (cmd->primary_phy) {
+	case 0x01:
+		str = "LE 1M";
+		break;
+	case 0x03:
+		str = "LE Coded";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("Primary PHY: %s (0x%2.2x)", str, cmd->primary_phy);
+	print_field("Secondary max skip: 0x%2.2x", cmd->secondary_max_skip);
+	print_le_phy("Secondary PHY", cmd->secondary_phy);
+	print_field("SID: 0x%2.2x", cmd->sid);
+
+	switch (cmd->notif_enable) {
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
+	print_field("Scan request notifications: %s (0x%2.2x)",
+							str, cmd->notif_enable);
+}
+
+static void le_set_ext_adv_params_rsp(const void *data, uint8_t size)
+{
+	const struct bt_hci_rsp_le_set_ext_adv_params *rsp = data;
+
+	print_status(rsp->status);
+	print_power_level(rsp->tx_power, "selected");
+}
+
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
+
+	print_field("Operation: %s (0x%2.2x)", str, cmd->operation);
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
+
+	print_field("Fragment preference: %s (0x%2.2x)", str,
+						cmd->fragment_preference);
+	print_field("Data length: 0x%2.2x", cmd->data_len);
+	packet_print_ad(cmd->data, size - sizeof(*cmd));
+}
+
+static void le_set_ext_scan_rsp_data_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_ext_scan_rsp_data *cmd = data;
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
+		str = "Complete scan response data";
+		break;
+	case 0x04:
+		str = "Unchanged data";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("Operation: %s (0x%2.2x)", str, cmd->operation);
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
+
+	print_field("Fragment preference: %s (0x%2.2x)", str,
+						cmd->fragment_preference);
+	print_field("Data length: 0x%2.2x", cmd->data_len);
+	packet_print_ad(cmd->data, size - sizeof(*cmd));
+}
+
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
+	print_field("Extended advertising: %s (0x%2.2x)", str, cmd->enable);
+
+	if (cmd->num_of_sets == 0)
+		print_field("Number of sets: Disable all sets (0x%2.2x)",
+							cmd->num_of_sets);
+	else if (cmd->num_of_sets > 0x3f)
+		print_field("Number of sets: Reserved (0x%2.2x)",
+							cmd->num_of_sets);
+	else
+		print_field("Number of sets: %u (0x%2.2x)", cmd->num_of_sets,
+							cmd->num_of_sets);
+
+	for (i = 0; i < cmd->num_of_sets; ++i) {
+		adv_set = data + 2 + i * sizeof(struct bt_hci_cmd_ext_adv_set);
+		print_field("Entry %d", i);
+		print_field("  Handle: 0x%2.2x", adv_set->handle);
+		print_field("  Duration: %d ms (0x%2.2x)",
+				adv_set->duration * 10, adv_set->duration);
+		print_field("  Max ext adv events: %d", adv_set->max_events);
+	}
+}
+
+static void le_read_max_adv_data_len_rsp(const void *data, uint8_t size)
+{
+	const struct bt_hci_rsp_le_read_max_adv_data_len *rsp = data;
+
+	print_status(rsp->status);
+	print_field("Max length: %d", rsp->max_len);
+}
+
+static void le_read_num_supported_adv_sets_rsp(const void *data, uint8_t size)
+{
+	const struct bt_hci_rsp_le_read_num_supported_adv_sets *rsp = data;
+
+	print_status(rsp->status);
+	print_field("Num supported adv sets: %d", rsp->num_of_sets);
+}
+
+static void le_remove_adv_set_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_remove_adv_set *cmd = data;
+
+	print_handle(cmd->handle);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -7851,15 +8171,33 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2034, 288, "LE Enhanced Transmitter Test",
 				le_enhanced_transmitter_test_cmd, 4, true,
 				status_rsp, 1, true },
-	{ 0x2035, 289, "LE Set Advertising Set Random Address" },
-	{ 0x2036, 290, "LE Set Extended Advertising Parameters" },
-	{ 0x2037, 291, "LE Set Extended Advertising Data" },
-	{ 0x2038, 292, "LE Set Extended Scan Response Data" },
-	{ 0x2039, 293, "LE Set Extended Advertising Enable" },
-	{ 0x203a, 294, "LE Read Maximum Advertising Data Length" },
-	{ 0x203b, 295, "LE Read Number of Supported Advertising Sets" },
-	{ 0x203c, 296, "LE Remove Advertising Set" },
-	{ 0x203d, 297, "LE Clear Advertising Sets" },
+	{ 0x2035, 289, "LE Set Advertising Set Random Address",
+				le_set_adv_set_rand_addr, 7, true,
+				status_rsp, 1, true },
+	{ 0x2036, 290, "LE Set Extended Advertising Parameters",
+				le_set_ext_adv_params_cmd, 25, true,
+				le_set_ext_adv_params_rsp, 2, true },
+	{ 0x2037, 291, "LE Set Extended Advertising Data",
+				le_set_ext_adv_data_cmd, 4, false,
+				status_rsp, 1, true },
+	{ 0x2038, 292, "LE Set Extended Scan Response Data",
+				le_set_ext_scan_rsp_data_cmd, 4, false,
+				status_rsp, 1, true },
+	{ 0x2039, 293, "LE Set Extended Advertising Enable",
+				le_set_ext_adv_enable_cmd, 2, false,
+				status_rsp, 1, true },
+	{ 0x203a, 294, "LE Read Maximum Advertising Data Length",
+				null_cmd, 0, true,
+				le_read_max_adv_data_len_rsp, 3, true },
+	{ 0x203b, 295, "LE Read Number of Supported Advertising Sets",
+				null_cmd, 0, true,
+				le_read_num_supported_adv_sets_rsp, 2, true },
+	{ 0x203c, 296, "LE Remove Advertising Set",
+				le_remove_adv_set_cmd, 1, true,
+				status_rsp, 1, true },
+	{ 0x203d, 297, "LE Clear Advertising Sets",
+				null_cmd, 0, true,
+				status_rsp, 1, true },
 	{ 0x203e, 298, "LE Set Periodic Advertising Parameters" },
 	{ 0x203f, 299, "LE Set Periodic Advertising Data" },
 	{ 0x2040, 300, "LE Set Periodic Advertising Enable" },
@@ -8980,6 +9318,27 @@ static void le_phy_update_complete_evt(const void *data, uint8_t size)
 	print_le_phy("RX PHY", evt->rx_phy);
 }
 
+static void le_adv_set_term_evt(const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_adv_set_term *evt = data;
+
+	print_status(evt->status);
+	print_field("Handle: %d", evt->handle);
+	print_field("Connection handle: %d", evt->conn_handle);
+	print_field("Number of completed extended advertising events: %d",
+			evt->num_evts);
+}
+
+static void le_scan_req_received_evt(const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_scan_req_received *evt = data;
+
+	print_field("Handle: %d", evt->handle);
+	print_peer_addr_type("Scanner address type", evt->scanner_addr_type);
+	print_addr("Scanner address", evt->scanner_addr,
+							evt->scanner_addr_type);
+}
+
 static void le_chan_select_alg_evt(const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_chan_select_alg *evt = data;
@@ -9075,8 +9434,10 @@ static const struct subevent_data le_meta_event_table[] = {
 	{ 0x0f, "LE Periodic Advertising Report" },
 	{ 0x10, "LE Periodic Advertising Sync Lost" },
 	{ 0x11, "LE Scan Timeout" },
-	{ 0x12, "LE Advertising Set Terminated" },
-	{ 0x13, "LE Scan Request Received" },
+	{ 0x12, "LE Advertising Set Terminated",
+				le_adv_set_term_evt, 5, true},
+	{ 0x13, "LE Scan Request Received",
+				le_scan_req_received_evt, 8, true},
 	{ 0x14, "LE Channel Selection Algorithm",
 				le_chan_select_alg_evt, 3, true},
 	{ }
-- 
2.11.0

