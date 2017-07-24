Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] advertising: Add AdvertisementInstances
Date: Mon, 24 Jul 2017 17:45:38 +0300
Message-Id: <20170724144539.27704-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This indicated to clients the number of advertisement instances left.
---
 doc/advertising-api.txt |  4 ++++
 src/advertising.c       | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index 8207b5934..7a29b7095 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -112,3 +112,7 @@ Methods		RegisterAdvertisement(object advertisement, dict options)
 
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.DoesNotExist
+
+Properties	byte AdvertisementInstaces
+
+			Number of available advertisement instances.
diff --git a/src/advertising.c b/src/advertising.c
index 1bea0d177..10d8d0119 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -160,11 +160,16 @@ static void client_remove(void *data)
 	queue_remove(client->manager->clients, client);
 
 	g_idle_add(client_free_idle_cb, client);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				adapter_get_path(client->manager->adapter),
+				LE_ADVERTISING_MGR_IFACE,
+				"AdvertisementInstances");
 }
 
 static void client_disconnect_cb(DBusConnection *conn, void *user_data)
 {
-	DBG("Client disconnected");
+	DBG("Client dis:b connected");
 
 	client_remove(user_data);
 }
@@ -446,6 +451,11 @@ static void add_adv_callback(uint8_t status, uint16_t length,
 									client);
 	DBG("Advertisement registered: %s", client->path);
 
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				adapter_get_path(client->manager->adapter),
+				LE_ADVERTISING_MGR_IFACE,
+				"AdvertisementInstances");
+
 done:
 	add_client_complete(client, status);
 }
@@ -715,6 +725,23 @@ static DBusMessage *unregister_advertisement(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static gboolean get_instances(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_adv_manager *manager = data;
+	uint8_t instances;
+
+	instances = manager->max_ads - queue_length(manager->clients);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &instances);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable properties[] = {
+	{ "AdvertisementInstances", "y", get_instances },
+};
+
 static const GDBusMethodTable methods[] = {
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterAdvertisement",
 					GDBUS_ARGS({ "advertisement", "o" },
@@ -763,8 +790,8 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					adapter_get_path(manager->adapter),
-					LE_ADVERTISING_MGR_IFACE,
-					methods, NULL, NULL, manager, NULL))
+					LE_ADVERTISING_MGR_IFACE, methods,
+					NULL, properties, manager, NULL))
 		error("Failed to register " LE_ADVERTISING_MGR_IFACE);
 }
 
-- 
2.13.3

