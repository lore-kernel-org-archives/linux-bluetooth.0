Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 5/7] adapter: Remove DevicesFound signal
Date: Thu,  8 Nov 2012 15:30:13 +0100
Message-Id: <1352385015-2127-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1352385015-2127-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352385015-2127-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

ObjectManager reports the D-Bus interfaces of all known devices,
including the ones detected during discovery. Therefore this signal is
not required.
---
 doc/adapter-api.txt |  13 ++-----
 src/adapter.c       | 102 ++--------------------------------------------------
 2 files changed, 4 insertions(+), 111 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 132e60f..13941c9 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -45,8 +45,8 @@ Methods		void RequestSession()
 			resolving. Use StopDiscovery to release the sessions
 			acquired.
 
-			This process will start emitting DevicesFound and
-			PropertyChanged "Discovering" signals.
+			This process will start creating Device objects as
+			new devices are discovered.
 
 			Possible errors: org.bluez.Error.NotReady
 					 org.bluez.Error.Failed
@@ -107,15 +107,6 @@ Methods		void RequestSession()
 
 			Possible errors: org.bluez.Error.DoesNotExist
 
-Signals		DevicesFound(array{object path, dict values})
-
-			This signal will be sent every time devices have
-			been found. In general they only appear during a
-			device discovery.
-
-			The dictionary contains the properties from the
-			org.bluez.Device interface.
-
 Properties	string Address [readonly]
 
 			The Bluetooth device address.
diff --git a/src/adapter.c b/src/adapter.c
index 1f02f0b..9c4765e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -82,7 +82,6 @@
 #define IO_CAPABILITY_INVALID		0xFF
 
 #define REMOVE_TEMP_TIMEOUT (3 * 60)
-#define PENDING_FOUND_MAX 5
 
 #define SETTINGS_PATH STORAGEDIR "/%s/settings"
 #define CACHE_PATH STORAGEDIR "/%s/cache/%s"
@@ -119,9 +118,7 @@ struct service_auth {
 };
 
 struct discovery {
-	guint id;
 	GSList *found;
-	GSList *pending;
 };
 
 struct btd_adapter {
@@ -560,49 +557,6 @@ static uint8_t get_needed_mode(struct btd_adapter *adapter, uint8_t mode)
 	return mode;
 }
 
-static void send_devices_found(struct btd_adapter *adapter)
-{
-	struct discovery *discovery = adapter->discovery;
-	DBusConnection *conn = btd_get_dbus_connection();
-	DBusMessageIter iter, props;
-	DBusMessage *signal;
-
-	if (!discovery || !discovery->pending)
-		return;
-
-	signal = dbus_message_new_signal(adapter->path, ADAPTER_INTERFACE,
-							"DevicesFound");
-	if (!signal) {
-		error("Unable to allocate DevicesFound signal");
-		g_slist_free(discovery->pending);
-		discovery->pending = NULL;
-		return;
-	}
-
-	dbus_message_iter_init_append(signal, &iter);
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "{oa{sv}}",
-								&props);
-
-	while (discovery->pending) {
-		struct btd_device *dev = discovery->pending->data;
-		const char *path = device_get_path(dev);
-		DBusMessageIter entry;
-
-		dbus_message_iter_open_container(&props, DBUS_TYPE_DICT_ENTRY,
-								NULL, &entry);
-		dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH,
-									&path);
-		g_dbus_get_properties(conn, path, DEVICE_INTERFACE, &entry);
-		dbus_message_iter_close_container(&props, &entry);
-
-		discovery->pending = g_slist_remove(discovery->pending, dev);
-	}
-
-	dbus_message_iter_close_container(&iter, &props);
-
-	g_dbus_send_message(conn, signal);
-}
-
 static void invalidate_rssi(gpointer a)
 {
 	struct btd_device *dev = a;
@@ -617,11 +571,6 @@ static void discovery_cleanup(struct btd_adapter *adapter)
 	if (!discovery)
 		return;
 
-	if (discovery->id > 0)
-		g_source_remove(discovery->id);
-
-	send_devices_found(adapter);
-
 	adapter->discovery = NULL;
 
 	g_slist_free_full(discovery->found, invalidate_rssi);
@@ -1057,10 +1006,8 @@ void adapter_remove_device(struct btd_adapter *adapter,
 
 	adapter->devices = g_slist_remove(adapter->devices, dev);
 
-	if (discovery) {
+	if (discovery)
 		discovery->found = g_slist_remove(discovery->found, dev);
-		discovery->pending = g_slist_remove(discovery->pending, dev);
-	}
 
 	adapter->connections = g_slist_remove(adapter->connections, dev);
 
@@ -1673,12 +1620,6 @@ static const GDBusMethodTable adapter_methods[] = {
 	{ }
 };
 
-static const GDBusSignalTable adapter_signals[] = {
-	{ GDBUS_SIGNAL("DevicesFound",
-			GDBUS_ARGS({ "devices", "a{oa{sv}}" })) },
-	{ }
-};
-
 static const GDBusPropertyTable adapter_properties[] = {
 	{ "Address", "s", adapter_property_get_address },
 	{ "Name", "s", adapter_property_get_name, adapter_property_set_name },
@@ -2740,7 +2681,7 @@ struct btd_adapter *adapter_create(int id)
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					path, ADAPTER_INTERFACE,
-					adapter_methods, adapter_signals,
+					adapter_methods, NULL,
 					adapter_properties, adapter,
 					adapter_free)) {
 		error("Adapter interface init failed on path %s", path);
@@ -2803,26 +2744,6 @@ void adapter_set_allow_name_changes(struct btd_adapter *adapter,
 	adapter->allow_name_changes = allow_name_changes;
 }
 
-static gboolean send_found(gpointer user_data)
-{
-	struct btd_adapter *adapter = user_data;
-	struct discovery *discovery = adapter->discovery;
-
-	if (!discovery)
-		return FALSE;
-
-	discovery->id = 0;
-
-	if (!discovery->pending)
-		return FALSE;
-
-	send_devices_found(adapter);
-
-	discovery->id = g_timeout_add_seconds(1, send_found, adapter);
-
-	return FALSE;
-}
-
 static gboolean adapter_remove_temp(gpointer data)
 {
 	struct btd_adapter *adapter = data;
@@ -2847,14 +2768,11 @@ static gboolean adapter_remove_temp(gpointer data)
 void adapter_set_discovering(struct btd_adapter *adapter,
 						gboolean discovering)
 {
-	struct discovery *discovery;
 	guint connect_list_len;
 
 	if (discovering && !adapter->discovery)
 		adapter->discovery = g_new0(struct discovery, 1);
 
-	discovery = adapter->discovery;
-
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), adapter->path,
 					ADAPTER_INTERFACE, "Discovering");
 
@@ -2863,7 +2781,6 @@ void adapter_set_discovering(struct btd_adapter *adapter,
 			g_source_remove(adapter->remove_temp);
 			adapter->remove_temp = 0;
 		}
-		discovery->id = g_timeout_add_seconds(1, send_found, adapter);
 		return;
 	}
 
@@ -3016,21 +2933,6 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 
 	eir_data_free(&eir_data);
 
-	if (!g_slist_find(discovery->pending, dev)) {
-		guint pending_count;
-
-		discovery->pending = g_slist_prepend(discovery->pending, dev);
-
-		pending_count = g_slist_length(discovery->pending);
-
-		if (discovery->id == 0) {
-			discovery->id = g_idle_add(send_found, adapter);
-		} else if (pending_count > PENDING_FOUND_MAX) {
-			g_source_remove(discovery->id);
-			discovery->id = g_idle_add(send_found, adapter);
-		}
-	}
-
 	if (g_slist_find(discovery->found, dev))
 		return;
 
-- 
1.7.11.7

