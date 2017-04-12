Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ v2 5/5] monitor: Add LE PHY update complete event decoding
Date: Wed, 12 Apr 2017 14:41:27 +0200
Message-Id: <20170412124127.31486-5-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <20170412124127.31486-1-lukasz.rymanowski@codecoup.pl>
References: <20170412124127.31486-1-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/bt.h     |  8 ++++++++
 monitor/packet.c | 13 ++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index d6e0046..b3de08c 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2763,6 +2763,14 @@ struct bt_hci_evt_le_direct_adv_report {
 	int8_t   rssi;
 } __attribute__ ((packed));
 
+#define BT_HCI_EVT_LE_PHY_UPDATE_COMPLETE	0x0c
+struct bt_hci_evt_le_phy_update_complete {
+	uint8_t  status;
+	uint16_t handle;
+	uint8_t  tx_phy;
+	uint8_t  rx_phy;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_LE_CHAN_SELECT_ALG		0x14
 struct bt_hci_evt_le_chan_select_alg {
 	uint16_t handle;
diff --git a/monitor/packet.c b/monitor/packet.c
index 61bc92d..3c43356 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8695,6 +8695,16 @@ static void le_direct_adv_report_evt(const void *data, uint8_t size)
 		packet_hexdump(data + sizeof(*evt), size - sizeof(*evt));
 }
 
+static void le_phy_update_complete_evt(const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_phy_update_complete *evt = data;
+
+	print_status(evt->status);
+	print_handle(evt->handle);
+	print_le_phy("TX PHY", evt->tx_phy);
+	print_le_phy("RX PHY", evt->rx_phy);
+}
+
 static void le_chan_select_alg_evt(const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_chan_select_alg *evt = data;
@@ -8769,7 +8779,8 @@ static const struct subevent_data le_meta_event_table[] = {
 				le_enhanced_conn_complete_evt, 30, true },
 	{ 0x0b, "LE Direct Advertising Report",
 				le_direct_adv_report_evt, 1, false },
-	{ 0x0c, "LE PHY Update Complete" },
+	{ 0x0c, "LE PHY Update Complete",
+				le_phy_update_complete_evt, 5, true},
 	{ 0x0d, "LE Extended Advertising Report" },
 	{ 0x0e, "LE Periodic Advertising Sync Established" },
 	{ 0x0f, "LE Periodic Advertising Report" },
-- 
2.9.3

