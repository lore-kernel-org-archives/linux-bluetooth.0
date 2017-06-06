Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 30/31] monitor: Add LE Advertising Set Terminated Event decoding
Date: Tue,  6 Jun 2017 11:41:19 +0200
Message-Id: <20170606094120.14541-33-michal.narajowski@codecoup.pl>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/bt.h     |  8 ++++++++
 monitor/packet.c | 14 +++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index f9bdf44..251b793 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3009,6 +3009,14 @@ struct bt_hci_le_ext_adv_report {
 	uint8_t  data_len;
 } __attribute__ ((packed));
 
+#define BT_HCI_EVT_LE_ADV_SET_TERM		0x12
+struct bt_hci_evt_le_adv_set_term {
+	uint8_t  status;
+	uint8_t  handle;
+	uint16_t conn_handle;
+	uint8_t  num_evts;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_LE_CHAN_SELECT_ALG		0x14
 struct bt_hci_evt_le_chan_select_alg {
 	uint16_t handle;
diff --git a/monitor/packet.c b/monitor/packet.c
index 5e4f081..114d101 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -9634,6 +9634,17 @@ static void le_ext_adv_report_evt(const void *data, uint8_t size)
 	}
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
 static void le_chan_select_alg_evt(const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_chan_select_alg *evt = data;
@@ -9730,7 +9741,8 @@ static const struct subevent_data le_meta_event_table[] = {
 	{ 0x0f, "LE Periodic Advertising Report" },
 	{ 0x10, "LE Periodic Advertising Sync Lost" },
 	{ 0x11, "LE Scan Timeout" },
-	{ 0x12, "LE Advertising Set Terminated" },
+	{ 0x12, "LE Advertising Set Terminated",
+				le_adv_set_term_evt, 5, true},
 	{ 0x13, "LE Scan Request Received" },
 	{ 0x14, "LE Channel Selection Algorithm",
 				le_chan_select_alg_evt, 3, true},
-- 
2.9.3

