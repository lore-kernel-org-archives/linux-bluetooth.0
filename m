Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 31/31] monitor: Add LE Scan Request Received Event decoding
Date: Tue,  6 Jun 2017 11:41:20 +0200
Message-Id: <20170606094120.14541-34-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/bt.h     |  7 +++++++
 monitor/packet.c | 12 +++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 251b793..2e4ded7 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3017,6 +3017,13 @@ struct bt_hci_evt_le_adv_set_term {
 	uint8_t  num_evts;
 } __attribute__ ((packed));
 
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
index 114d101..6a5ea02 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -9645,6 +9645,15 @@ static void le_adv_set_term_evt(const void *data, uint8_t size)
 			evt->num_evts);
 }
 
+static void le_scan_req_received_evt(const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_scan_req_received *evt = data;
+
+	print_field("Handle: %d", evt->handle);
+	print_peer_addr_type("Scanner ddress type", evt->scanner_addr_type);
+	print_addr("Scanner address", evt->scanner_addr, evt->scanner_addr_type);
+}
+
 static void le_chan_select_alg_evt(const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_chan_select_alg *evt = data;
@@ -9743,7 +9752,8 @@ static const struct subevent_data le_meta_event_table[] = {
 	{ 0x11, "LE Scan Timeout" },
 	{ 0x12, "LE Advertising Set Terminated",
 				le_adv_set_term_evt, 5, true},
-	{ 0x13, "LE Scan Request Received" },
+	{ 0x13, "LE Scan Request Received",
+				le_scan_req_received_evt, 8, true},
 	{ 0x14, "LE Channel Selection Algorithm",
 				le_chan_select_alg_evt, 3, true},
 	{ }
-- 
2.9.3

