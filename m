Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Subject: [PATCH BlueZ v3 3/5] tools/btpclient: Add device found event
Date: Thu, 28 Dec 2017 14:11:16 +0100
Message-Id: <1514466678-32582-3-git-send-email-kolodziejczyk.grzegorz.wroc@gmail.com>
In-Reply-To: <1514466678-32582-1-git-send-email-kolodziejczyk.grzegorz.wroc@gmail.com>
References: <1514466678-32582-1-git-send-email-kolodziejczyk.grzegorz.wroc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>

This patch adds device found event handler. It's called when rssi
property of device changes and new device interface is added.
---
 tools/btpclient.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 90ba8b6..e9d766d 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -399,6 +399,40 @@ failed:
 	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
 }
 
+static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
+{
+	struct btp_device_found_ev ev;
+	const char *str;
+	int16_t rssi;
+
+	if (!l_dbus_proxy_get_property(proxy, "Address", "s", &str) ||
+						!str2addr(str, ev.address))
+		return;
+
+	if (!l_dbus_proxy_get_property(proxy, "AddressType", "s", &str))
+		return;
+
+	ev.address_type = strcmp(str, "public") ? BTP_GAP_ADDR_RANDOM :
+							BTP_GAP_ADDR_PUBLIC;
+
+	if (!l_dbus_proxy_get_property(proxy, "RSSI", "n", &rssi))
+		return;
+
+	ev.rssi = rssi;
+
+	/* TODO Temporary set all flags */
+	ev.flags = (BTP_EV_GAP_DEVICE_FOUND_FLAG_RSSI |
+					BTP_EV_GAP_DEVICE_FOUND_FLAG_AD |
+					BTP_EV_GAP_DEVICE_FOUND_FLAG_SR);
+
+	/* TODO Add eir to device found event */
+	ev.eir_len = 0;
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND,
+						BTP_INDEX_NON_CONTROLLER,
+						sizeof(ev) + ev.eir_len, &ev);
+}
+
 static void register_gap_service(void)
 {
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_READ_SUPPORTED_COMMANDS,
@@ -661,6 +695,8 @@ static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 
 		l_queue_push_tail(adapter->devices, device);
 
+		btp_gap_device_found_ev(proxy);
+
 		return;
 	}
 
@@ -784,6 +820,15 @@ static void property_changed(struct l_dbus_proxy *proxy, const char *name,
 			update_current_settings(adapter, new_settings);
 
 		return;
+	} else if (!strcmp(interface, "org.bluez.Device1")) {
+		if (!strcmp(name, "RSSI")) {
+			int16_t rssi;
+
+			if (!l_dbus_message_get_arguments(msg, "n", &rssi))
+				return;
+
+			btp_gap_device_found_ev(proxy);
+		}
 	}
 }
 
-- 
2.7.4

