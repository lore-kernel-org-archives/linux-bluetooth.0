Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/4] tools/btpclient: Add connected, disconnected event
Date: Fri, 12 Jan 2018 15:10:12 +0100
Message-Id: <20180112141012.28113-4-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180112141012.28113-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180112141012.28113-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds conntected, disconnected events for btp client.
---
 tools/btpclient.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 7492872c0..c0ecb3f06 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -212,6 +212,26 @@ static struct btp_device *find_device_by_address(struct btp_adapter *adapter,
 	return NULL;
 }
 
+static bool match_proxies(const void *proxy_a, const void *proxy_b)
+{
+	return proxy_a == proxy_b;
+}
+
+static struct btp_adapter *find_adapter_by_dev_proxy(struct l_dbus_proxy *proxy)
+{
+	const struct l_queue_entry *entry;
+
+	for (entry = l_queue_get_entries(adapters); entry;
+							entry = entry->next) {
+		struct btp_adapter *adapter = entry->data;
+
+		if (l_queue_find(adapter->devices, match_proxies, proxy))
+			return adapter;
+	}
+
+	return NULL;
+}
+
 static void btp_gap_read_commands(uint8_t index, const void *param,
 					uint16_t length, void *user_data)
 {
@@ -1507,6 +1527,49 @@ static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 						sizeof(ev) + ev.eir_len, &ev);
 }
 
+static void btp_gap_device_connection_ev(struct l_dbus_proxy *proxy,
+								bool connected)
+{
+	struct btp_adapter *adapter;
+	const char *str_addr, *str_addr_type;
+	uint8_t address_type;
+
+
+	adapter = find_adapter_by_dev_proxy(proxy);
+
+	if (!adapter)
+		return;
+
+	if (!l_dbus_proxy_get_property(proxy, "Address", "s", &str_addr))
+		return;
+
+
+	if (!l_dbus_proxy_get_property(proxy, "AddressType", "s",
+								&str_addr_type))
+		return;
+
+	address_type = strcmp(str_addr_type, "public") ? BTP_GAP_ADDR_RANDOM :
+							BTP_GAP_ADDR_PUBLIC;
+
+	if (connected) {
+		struct btp_gap_device_connected_ev ev;
+
+		str2addr(str_addr, ev.address);
+		ev.address_type = address_type;
+
+		btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_CONNECTED,
+					adapter->index, sizeof(ev), &ev);
+	} else {
+		struct btp_gap_device_disconnected_ev ev;
+
+		str2addr(str_addr, ev.address);
+		ev.address_type = address_type;
+
+		btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_DISCONNECTED,
+					adapter->index, sizeof(ev), &ev);
+	}
+}
+
 static void register_gap_service(void)
 {
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_READ_SUPPORTED_COMMANDS,
@@ -1910,6 +1973,13 @@ static void property_changed(struct l_dbus_proxy *proxy, const char *name,
 				return;
 
 			btp_gap_device_found_ev(proxy);
+		} else if (!strcmp(name, "Connected")) {
+			bool prop;
+
+			if (!l_dbus_message_get_arguments(msg, "b", &prop))
+				return;
+
+			btp_gap_device_connection_ev(proxy, prop);
 		}
 	}
 }
-- 
2.13.6

