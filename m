Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] monitor: Add support for decoding LE Channel Selection Algorithm Event
Date: Thu,  6 Apr 2017 15:41:35 +0200
Message-Id: <20170406134135.30944-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> HCI Event: LE Meta Event (0x3e) plen 4                     44.589780
      LE Channel Selection Algorithm (0x14)
        Handle: 1
        LE Channel Selection Algorithm #2 (0x01)
---
 monitor/bt.h     |  6 ++++++
 monitor/packet.c | 30 +++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 1a21592..0b77a10 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2736,6 +2736,12 @@ struct bt_hci_evt_le_direct_adv_report {
 	int8_t   rssi;
 } __attribute__ ((packed));
 
+#define BT_HCI_EVT_LE_CHAN_SELECT_ALG		0x14
+struct bt_hci_evt_le_chan_select_alg {
+	uint16_t handle;
+	uint8_t  algorithm;
+} __attribute__ ((packed));
+
 #define BT_HCI_ERR_SUCCESS			0x00
 #define BT_HCI_ERR_UNKNOWN_COMMAND		0x01
 #define BT_HCI_ERR_UNKNOWN_CONN_ID		0x02
diff --git a/monitor/packet.c b/monitor/packet.c
index 0cae6d7..5d927f5 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3754,6 +3754,25 @@ static void print_3d_broadcast(const void *data, uint8_t size)
 						period, period_frac);
 }
 
+static void print_le_channel_select_alg(uint8_t alg)
+{
+	const char *str;
+
+	switch (alg) {
+	case 0x00:
+		str = "LE Channel Selection Algorithm #1";
+		break;
+	case 0x01:
+		str = "LE Channel Selection Algorithm #2";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("%s (0x%2.2x)", str, alg);
+}
+
 void packet_hexdump(const unsigned char *buf, uint16_t len)
 {
 	static const char hexdigits[] = "0123456789abcdef";
@@ -8531,6 +8550,14 @@ static void le_direct_adv_report_evt(const void *data, uint8_t size)
 		packet_hexdump(data + sizeof(*evt), size - sizeof(*evt));
 }
 
+static void le_chan_select_alg_evt(const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_chan_select_alg *evt = data;
+
+	print_handle(evt->handle);
+	print_le_channel_select_alg(evt->algorithm);
+}
+
 struct subevent_data {
 	uint8_t subevent;
 	const char *str;
@@ -8605,7 +8632,8 @@ static const struct subevent_data le_meta_event_table[] = {
 	{ 0x11, "LE Scan Timeout" },
 	{ 0x12, "LE Advertising Set Terminated" },
 	{ 0x13, "LE Scan Request Received" },
-	{ 0x14, "LE Channel Selection Algorithm" },
+	{ 0x14, "LE Channel Selection Algorithm",
+				le_chan_select_alg_evt, 3, true},
 	{ }
 };
 
-- 
2.9.3

