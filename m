Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/3] tools/btpclient: Add connected, disconnected event
Date: Wed, 17 Jan 2018 11:44:11 +0100
Message-Id: <20180117104411.13628-3-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180117104411.13628-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180117104411.13628-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds conntected, disconnected events for btp client.
---
 tools/btpclient.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 374101312..af0e75290 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -198,6 +198,52 @@ static struct btp_device *find_device_by_address(struct btp_adapter *adapter,
 	return NULL;
 }
 
+static bool match_adapter_dev_proxy(const void *device, const void *proxy)
+{
+	const struct btp_device *d = device;
+
+	return d->proxy == proxy;
+}
+
+static bool match_adapter_dev(const void *device_a, const void *device_b)
+{
+	return device_a == device_b;
+}
+
+static struct btp_adapter *find_adapter_by_device(struct btp_device *device)
+{
+	const struct l_queue_entry *entry;
+
+	for (entry = l_queue_get_entries(adapters); entry;
+							entry = entry->next) {
+		struct btp_adapter *adapter = entry->data;
+
+		if (l_queue_find(adapter->devices, match_adapter_dev, device))
+			return adapter;
+	}
+
+	return NULL;
+}
+
+static struct btp_device *find_device_by_proxy(struct l_dbus_proxy *proxy)
+{
+	const struct l_queue_entry *entry;
+	struct btp_device *device;
+
+	for (entry = l_queue_get_entries(adapters); entry;
+							entry = entry->next) {
+		struct btp_adapter *adapter = entry->data;
+
+		device = l_queue_find(adapter->devices, match_adapter_dev_proxy,
+									proxy);
+
+		if (device)
+			return device;
+	}
+
+	return NULL;
+}
+
 static void btp_gap_read_commands(uint8_t index, const void *param,
 					uint16_t length, void *user_data)
 {
@@ -1505,6 +1551,49 @@ static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 						sizeof(ev) + ev.eir_len, &ev);
 }
 
+static void btp_gap_device_connection_ev(struct l_dbus_proxy *proxy,
+								bool connected)
+{
+	struct btp_adapter *adapter;
+	struct btp_device *device;
+	const char *str_addr, *str_addr_type;
+	uint8_t address_type;
+
+	device = find_device_by_proxy(proxy);
+	adapter = find_adapter_by_device(device);
+
+	if (!device || !adapter)
+		return;
+
+	if (!l_dbus_proxy_get_property(proxy, "Address", "s", &str_addr))
+		return;
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
+		str2ba(str_addr, &ev.address);
+		ev.address_type = address_type;
+
+		btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_CONNECTED,
+					adapter->index, sizeof(ev), &ev);
+	} else {
+		struct btp_gap_device_disconnected_ev ev;
+
+		str2ba(str_addr, &ev.address);
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
@@ -1908,6 +1997,13 @@ static void property_changed(struct l_dbus_proxy *proxy, const char *name,
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

