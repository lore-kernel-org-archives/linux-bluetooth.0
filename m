Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH V2 09/10] tools/btpclient: Store devices per adapter
Date: Fri,  8 Dec 2017 15:03:48 +0100
Message-Id: <20171208140348.30342-10-szymon.janc@codecoup.pl>
In-Reply-To: <20171208140348.30342-1-szymon.janc@codecoup.pl>
References: <20171208140348.30342-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This make it easier to handle devices from specified adapter.
---
 tools/btpclient.c | 54 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 50112c3a3..89b2d2801 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -39,6 +39,7 @@ struct btp_adapter {
 	uint8_t index;
 	uint32_t supported_settings;
 	uint32_t current_settings;
+	struct l_queue *devices;
 };
 
 struct btp_device {
@@ -46,7 +47,6 @@ struct btp_device {
 };
 
 static struct l_queue *adapters;
-static struct l_queue *devices;
 static char *socket_path;
 static struct btp *btp;
 
@@ -82,6 +82,21 @@ static struct btp_adapter *find_adapter_by_index(uint8_t index)
 	return NULL;
 }
 
+static struct btp_adapter *find_adapter_by_path(const char *path)
+{
+	const struct l_queue_entry *entry;
+
+	for (entry = l_queue_get_entries(adapters); entry;
+							entry = entry->next) {
+		struct btp_adapter *adapter = entry->data;
+
+		if (!strcmp(l_dbus_proxy_get_path(adapter->proxy), path))
+			return adapter;
+	}
+
+	return NULL;
+}
+
 static void btp_gap_read_commands(uint8_t index, const void *param,
 					uint16_t length, void *user_data)
 {
@@ -469,14 +484,16 @@ static void signal_handler(struct l_signal *signal, uint32_t signo,
 	}
 }
 
-static void btp_adapter_free(struct btp_adapter *adapter)
+static void btp_device_free(struct btp_device *device)
 {
-	l_free(adapter);
+	l_free(device);
 }
 
-static void btp_device_free(struct btp_device *device)
+static void btp_adapter_free(struct btp_adapter *adapter)
 {
-	l_free(device);
+	l_queue_destroy(adapter->devices,
+				(l_queue_destroy_func_t)btp_device_free);
+	l_free(adapter);
 }
 
 static void extract_settings(struct l_dbus_proxy *proxy, uint32_t *current,
@@ -535,6 +552,7 @@ static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 		adapter = l_new(struct btp_adapter, 1);
 		adapter->proxy = proxy;
 		adapter->index = l_queue_length(adapters);
+		adapter->devices = l_queue_new();
 
 		extract_settings(proxy, &adapter->current_settings,
 						&adapter->supported_settings);
@@ -544,12 +562,21 @@ static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 	}
 
 	if (!strcmp(interface, "org.bluez.Device1")) {
+		struct btp_adapter *adapter;
 		struct btp_device *device;
+		char *str;
+
+		if (!l_dbus_proxy_get_property(proxy, "Adapter", "o", &str))
+			return;
+
+		adapter = find_adapter_by_path(str);
+		if (!adapter)
+			return;
 
 		device = l_new(struct btp_device, 1);
 		device->proxy = proxy;
 
-		l_queue_push_tail(devices, device);
+		l_queue_push_tail(adapter->devices, device);
 		return;
 	}
 }
@@ -576,7 +603,18 @@ static void proxy_removed(struct l_dbus_proxy *proxy, void *user_data)
 	}
 
 	if (!strcmp(interface, "org.bluez.Device1")) {
-		l_queue_remove_if(devices, device_match_by_proxy, proxy);
+		struct btp_adapter *adapter;
+		char *str;
+
+		if (!l_dbus_proxy_get_property(proxy, "Adapter", "o", &str))
+			return;
+
+		adapter = find_adapter_by_path(str);
+		if (!adapter)
+			return;
+
+		l_queue_remove_if(adapter->devices, device_match_by_proxy,
+									proxy);
 
 		return;
 	}
@@ -742,7 +780,6 @@ int main(int argc, char *argv[])
 
 
 	adapters = l_queue_new();
-	devices = l_queue_new();
 
 	sigemptyset(&mask);
 	sigaddset(&mask, SIGINT);
@@ -768,7 +805,6 @@ int main(int argc, char *argv[])
 	l_signal_remove(signal);
 	btp_cleanup(btp);
 
-	l_queue_destroy(devices, (l_queue_destroy_func_t)btp_device_free);
 	l_queue_destroy(adapters, (l_queue_destroy_func_t)btp_adapter_free);
 
 	l_free(socket_path);
-- 
2.14.3

