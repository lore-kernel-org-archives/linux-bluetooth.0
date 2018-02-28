Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 8/9] tools/btpclient: Add identity resolve event
Date: Wed, 28 Feb 2018 13:41:28 +0100
Message-Id: <20180228124129.25851-8-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180228124129.25851-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180228124129.25851-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds identity resolve event handler.
---
 tools/btpclient.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 3b53b8fc8..d1d64d068 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -66,6 +66,8 @@ struct btp_adapter {
 
 struct btp_device {
 	struct l_dbus_proxy *proxy;
+	uint8_t address_type;
+	bdaddr_t address;
 };
 
 static struct l_queue *adapters;
@@ -2520,6 +2522,34 @@ static void btp_gap_device_connection_ev(struct l_dbus_proxy *proxy,
 	}
 }
 
+static void btp_identity_resolved_ev(struct l_dbus_proxy *proxy)
+{
+	struct btp_device *dev = find_device_by_proxy(proxy);
+	struct btp_adapter *adapter = find_adapter_by_device(dev);
+	struct btp_gap_identity_resolved_ev ev;
+	char *str_addr, *str_addr_type;
+	uint8_t identity_address_type;
+
+	if (!l_dbus_proxy_get_property(proxy, "Address", "s", &str_addr))
+		return;
+
+	if (!l_dbus_proxy_get_property(proxy, "AddressType", "s",
+								&str_addr_type))
+		return;
+
+	identity_address_type = strcmp(str_addr_type, "public") ?
+				BTP_GAP_ADDR_RANDOM : BTP_GAP_ADDR_PUBLIC;
+
+	str2ba(str_addr, &ev.identity_address);
+	ev.identity_address_type = identity_address_type;
+
+	memcpy(&ev.address, &dev->address, sizeof(ev.address));
+	ev.address_type = dev->address_type;
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_IDENTITY_RESOLVED,
+					adapter->index, sizeof(ev), &ev);
+}
+
 static void register_gap_service(void)
 {
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_READ_SUPPORTED_COMMANDS,
@@ -2809,7 +2839,7 @@ static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 	if (!strcmp(interface, "org.bluez.Device1")) {
 		struct btp_adapter *adapter;
 		struct btp_device *device;
-		char *str;
+		char *str, *str_addr, *str_addr_type;
 
 		if (!l_dbus_proxy_get_property(proxy, "Adapter", "o", &str))
 			return;
@@ -2825,6 +2855,20 @@ static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 
 		btp_gap_device_found_ev(proxy);
 
+		if (!l_dbus_proxy_get_property(proxy, "Address", "s",
+								&str_addr))
+			return;
+
+		if (!l_dbus_proxy_get_property(proxy, "AddressType", "s",
+								&str_addr_type))
+			return;
+
+		device->address_type = strcmp(str_addr_type, "public") ?
+							BTP_GAP_ADDR_RANDOM :
+							BTP_GAP_ADDR_PUBLIC;
+		if (!str2ba(str_addr, &device->address))
+			return;
+
 		return;
 	}
 
@@ -2956,6 +3000,11 @@ static void property_changed(struct l_dbus_proxy *proxy, const char *name,
 				return;
 
 			btp_gap_device_connection_ev(proxy, prop);
+		} else if (!strcmp(name, "AddressType")) {
+			/* Addres property change came first along with address
+			 * type.
+			 */
+			btp_identity_resolved_ev(proxy);
 		}
 	}
 }
-- 
2.13.6

