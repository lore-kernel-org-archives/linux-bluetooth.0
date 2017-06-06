Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 29/31] monitor: Add LE Extended Advertising Report Event decoding
Date: Tue,  6 Jun 2017 11:41:18 +0200
Message-Id: <20170606094120.14541-32-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/bt.h     | 19 ++++++++++++
 monitor/packet.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 3e88d36..f9bdf44 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2990,6 +2990,25 @@ struct bt_hci_evt_le_phy_update_complete {
 	uint8_t  rx_phy;
 } __attribute__ ((packed));
 
+#define BT_HCI_EVT_LE_EXT_ADV_REPORT	0x0d
+struct bt_hci_evt_le_ext_adv_report {
+	uint8_t  num_reports;
+} __attribute__ ((packed));
+struct bt_hci_le_ext_adv_report {
+	uint8_t  event_type;
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
 #define BT_HCI_EVT_LE_CHAN_SELECT_ALG		0x14
 struct bt_hci_evt_le_chan_select_alg {
 	uint16_t handle;
diff --git a/monitor/packet.c b/monitor/packet.c
index dbb920f..5e4f081 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2304,7 +2304,7 @@ static void print_num_reports(uint8_t num_reports)
 	print_field("Num reports: %d", num_reports);
 }
 
-static void print_adv_event_type(uint8_t type)
+static void print_adv_event_type(const char *label, uint8_t type)
 {
 	const char *str;
 
@@ -2329,7 +2329,7 @@ static void print_adv_event_type(uint8_t type)
 		break;
 	}
 
-	print_field("Event type: %s (0x%2.2x)", str, type);
+	print_field("%s: %s (0x%2.2x)", label, str, type);
 }
 
 static void print_rssi(int8_t rssi)
@@ -9417,7 +9417,7 @@ static void le_adv_report_evt(const void *data, uint8_t size)
 	print_num_reports(evt->num_reports);
 
 report:
-	print_adv_event_type(evt->event_type);
+	print_adv_event_type("Event type", evt->event_type);
 	print_peer_addr_type("Address type", evt->addr_type);
 	print_addr("Address", evt->addr, evt->addr_type);
 	print_field("Data length: %d", evt->data_len);
@@ -9535,7 +9535,7 @@ static void le_direct_adv_report_evt(const void *data, uint8_t size)
 
 	print_num_reports(evt->num_reports);
 
-	print_adv_event_type(evt->event_type);
+	print_adv_event_type("Event type", evt->event_type);
 	print_peer_addr_type("Address type", evt->addr_type);
 	print_addr("Address", evt->addr, evt->addr_type);
 	print_addr_type("Direct address type", evt->direct_addr_type);
@@ -9556,6 +9556,84 @@ static void le_phy_update_complete_evt(const void *data, uint8_t size)
 	print_le_phy("RX PHY", evt->rx_phy);
 }
 
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
+		print_adv_event_type("  Event type", report->event_type);
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
+			print_field("  SID: no ADI field (0x%2.2x)", report->sid);
+		else if (report->sid > 0x0f)
+			print_field("  SID: Reserved (0x%2.2x)", report->sid);
+		else
+			print_field("  SID: 0x%2.2x", report->sid);
+
+		print_field("  TX power: %d dBm", report->tx_power);
+
+		if (report->rssi == 127)
+			print_field("  RSSI: not available (0x%2.2x)", (uint8_t) report->rssi);
+		else if (report->rssi >= -127 && report->rssi <= 20)
+			print_field("  RSSI: %d dBm (0x%2.2x)", report->rssi, (uint8_t) report->rssi);
+		else
+			print_field("  RSSI: reserved (0x%2.2x)", (uint8_t) report->rssi);
+
+		print_slot_125("  Periodic advertising invteral", report->interval);
+		print_peer_addr_type("  Direct address type", report->direct_addr_type);
+		print_addr("  Direct address", report->direct_addr, report->direct_addr_type);
+		print_field("  Data length: 0x%2.2x", report->data_len);
+		data += sizeof(struct bt_hci_le_ext_adv_report);
+		packet_hexdump(data, report->data_len);
+		data += report->data_len;
+	}
+}
+
 static void le_chan_select_alg_evt(const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_chan_select_alg *evt = data;
@@ -9646,7 +9724,8 @@ static const struct subevent_data le_meta_event_table[] = {
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
2.9.3

