Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 04/31] monitor: Add LE Set Extended Advertising Parameters decoding
Date: Tue,  6 Jun 2017 11:40:53 +0200
Message-Id: <20170606094120.14541-7-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen 25
        Handle: 0x01
        Properties: 0x0000
        Min advertising interval: 20.000 msec (0x0020)
        Max advertising interval: 159.375 msec (0x00ff)
        Channel map: 37, 38, 39 (0x07)
        Own address type: Random (0x01)
        Peer address type: Public (0x00)
        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
        Tx power: 0xff
        Primary PHY: LE 1M
        Secondary max skip: 0x00
        Secondary PHY: LE Coded (0x03)
        SID: 0x06
        Scan request notifications: Disabled
---
 monitor/bt.h     |  24 +++++++++
 monitor/packet.c | 158 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 181 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index d2e3e16..e903366 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2182,6 +2182,30 @@ struct bt_hci_cmd_le_set_adv_set_rand_addr {
 	uint8_t  bdaddr[6];
 } __attribute__ ((packed));
 
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
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
diff --git a/monitor/packet.c b/monitor/packet.c
index 771b7bb..35ffde9 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -6939,6 +6939,160 @@ static void le_set_adv_set_rand_addr(const void *data, uint8_t size)
 	print_addr("Advertising random address", cmd->bdaddr, 0x00);
 }
 
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
+static void print_ext_adv_properties(uint16_t flags)
+{
+	uint16_t mask = flags;
+	int i;
+
+	print_field("Properties: 0x%4.4x", flags);
+
+	for (i = 0; ext_adv_properties_table[i].str; i++) {
+		if (flags & (1 << ext_adv_properties_table[i].bit)) {
+			print_field("  %s", ext_adv_properties_table[i].str);
+			mask &= ~(1 << ext_adv_properties_table[i].bit);
+		}
+	}
+
+	if (mask)
+		print_text(COLOR_UNKNOWN_ADV_FLAG, "  Unknown advertising properties"
+							" (0x%4.4x)", mask);
+}
+
+static void print_ext_slot_625(const char *label, const uint8_t value[3])
+{
+	uint32_t value_cpu = value[0];
+
+	value_cpu |= value[1] << 8;
+	value_cpu |= value[2] << 16;
+
+	 print_field("%s: %.3f msec (0x%4.4x)", label,
+				 value_cpu * 0.625, value_cpu);
+}
+
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
+
+	switch (cmd->channel_map) {
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
+	print_field("Channel map: %s (0x%2.2x)", str, cmd->channel_map);
+
+	print_own_addr_type(cmd->own_addr_type);
+	print_peer_addr_type("Peer address type", cmd->peer_addr_type);
+	print_addr("Peer address", cmd->peer_addr, cmd->peer_addr_type);
+
+	switch (cmd->filter_policy) {
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
+	print_field("Filter policy: %s (0x%2.2x)", str, cmd->filter_policy);
+	print_field("Tx power: 0x%2.2x", cmd->tx_power);
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
+	print_field("Primary PHY: %s", str);
+	print_field("Secondary max skip: 0x%2.2x", cmd->secondary_max_skip);
+	print_le_phy("Secondary PHY", cmd->secondary_phy);
+	print_field("SID: 0x%2.2x", cmd->sid);
+
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
+	print_field("Scan request notifications: %s", str);
+}
+
+static void le_set_ext_adv_params_rsp(const void *data, uint8_t size)
+{
+	const struct bt_hci_rsp_le_set_ext_adv_params *rsp = data;
+
+	print_status(rsp->status);
+	print_field("Selected Tx power: 0x%2.2x", rsp->tx_power);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -7651,7 +7805,9 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2035, 289, "LE Set Advertising Set Random Address",
 				le_set_adv_set_rand_addr, 7, true,
 				status_rsp, 1, true },
-	{ 0x2036, 290, "LE Set Extended Advertising Parameters" },
+	{ 0x2036, 290, "LE Set Extended Advertising Parameters",
+				le_set_ext_adv_params_cmd, 25, true,
+				le_set_ext_adv_params_rsp, 2, true },
 	{ 0x2037, 291, "LE Set Extended Advertising Data" },
 	{ 0x2038, 292, "LE Set Extended Scan Response Data" },
 	{ 0x2039, 293, "LE Set Extended Advertising Enable" },
-- 
2.9.3

