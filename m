Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/9] tools/btpclient: Check if dev is connected in device found ev routine
Date: Wed, 28 Feb 2018 13:41:26 +0100
Message-Id: <20180228124129.25851-6-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180228124129.25851-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180228124129.25851-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Device may be connected while device found event is generated thus thus
btp should generate additional device connected event also.
---
 tools/btpclient.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 92fa742ce..006d8acbe 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -2396,24 +2396,30 @@ failed:
 
 static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 {
+	struct btp_device *device = find_device_by_proxy(proxy);
+	struct btp_adapter *adapter = find_adapter_by_device(device);
 	struct btp_device_found_ev ev;
-	const char *str;
+	struct btp_gap_device_connected_ev ev_conn;
+	const char *str, *addr_str;
 	int16_t rssi;
+	uint8_t address_type;
+	bool connected;
 
-	if (!l_dbus_proxy_get_property(proxy, "Address", "s", &str) ||
-						str2ba(str, &ev.address) < 0)
+	if (!l_dbus_proxy_get_property(proxy, "Address", "s", &addr_str) ||
+					str2ba(addr_str, &ev.address) < 0)
 		return;
 
 	if (!l_dbus_proxy_get_property(proxy, "AddressType", "s", &str))
 		return;
 
-	ev.address_type = strcmp(str, "public") ? BTP_GAP_ADDR_RANDOM :
+	address_type = strcmp(str, "public") ? BTP_GAP_ADDR_RANDOM :
 							BTP_GAP_ADDR_PUBLIC;
+	ev.address_type = address_type;
 
 	if (!l_dbus_proxy_get_property(proxy, "RSSI", "n", &rssi))
-		return;
-
-	ev.rssi = rssi;
+		ev.rssi = 0x81;
+	else
+		ev.rssi = rssi;
 
 	/* TODO Temporary set all flags */
 	ev.flags = (BTP_EV_GAP_DEVICE_FOUND_FLAG_RSSI |
@@ -2423,9 +2429,17 @@ static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 	/* TODO Add eir to device found event */
 	ev.eir_len = 0;
 
-	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND,
-						BTP_INDEX_NON_CONTROLLER,
+	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND, adapter->index,
 						sizeof(ev) + ev.eir_len, &ev);
+
+	if (l_dbus_proxy_get_property(proxy, "Connected", "b", &connected) &&
+								connected) {
+		ev_conn.address_type = address_type;
+		str2ba(addr_str, &ev_conn.address);
+
+		btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_CONNECTED,
+				adapter->index, sizeof(ev_conn), &ev_conn);
+	}
 }
 
 static void btp_gap_device_connection_ev(struct l_dbus_proxy *proxy,
-- 
2.13.6

