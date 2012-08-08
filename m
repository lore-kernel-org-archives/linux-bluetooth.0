Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <jprvita@openbossa.org>, Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v3 6/9] Battery: Add Battery D-BUS API
Date: Wed, 8 Aug 2012 17:26:17 +0300
Message-ID: <1344435980-9866-7-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1344435980-9866-1-git-send-email-chen.ganir@ti.com>
References: <1344435980-9866-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add Battery level specific API
---
 doc/battery-api.txt        |   33 +++++++++++++++++
 profiles/battery/battery.c |   87 +++++++++++++++++++++++++++++++++++++++++---
 profiles/battery/battery.h |    2 +-
 profiles/battery/main.c    |   18 ++++++++-
 profiles/battery/manager.c |   19 ++++++++--
 profiles/battery/manager.h |    2 +-
 6 files changed, 147 insertions(+), 14 deletions(-)
 create mode 100644 doc/battery-api.txt

diff --git a/doc/battery-api.txt b/doc/battery-api.txt
new file mode 100644
index 0000000..f8c1e43
--- /dev/null
+++ b/doc/battery-api.txt
@@ -0,0 +1,33 @@
+BlueZ D-Bus Battery API description
+****************************************
+
+	Texas Instruments, Inc. <chen.ganir@ti.com>
+
+Battery Service hierarchy
+=====================================
+
+Service		org.bluez
+Interface	org.bluez.Battery
+Object path	[variable prefix]/{hci0,..}/dev_XX_XX_XX_XX_XX_XX/BATT-NN-DDDD
+
+
+Methods	dict GetProperties()
+
+			Returns all properties for the interface. See the
+			Properties section for the available properties.
+
+Properties	byte Namespace [readonly]
+
+			Namespace value from the battery format characteristic
+			descriptor.Combined with Description provides a unique
+			battery identifyer if multiple batteries are supported.
+
+		uint16 Description [readonly]
+
+			Description value from the battery format characteristic
+			descriptor. Combined with Namespace provides a unique
+			battery identifyer if multiple batteries are supported.
+
+		byte Level [readonly]
+
+			Battery level (0-100).
diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 3f79c1f..2f616e0 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -24,7 +24,9 @@
 #include <config.h>
 #endif
 
-#include <glib.h>
+#include <gdbus.h>
+#include <errno.h>
+#include <dbus/dbus.h>
 #include <bluetooth/uuid.h>
 
 #include "adapter.h"
@@ -34,12 +36,16 @@
 #include "att.h"
 #include "gattrib.h"
 #include "gatt.h"
+#include "dbus-common.h"
 #include "battery.h"
 #include "log.h"
 
+#define BATTERY_INTERFACE	"org.bluez.Battery"
+
 #define BATTERY_LEVEL_UUID	"00002a19-0000-1000-8000-00805f9b34fb"
 
 struct battery {
+	DBusConnection		*conn;		/* The connection to the bus */
 	struct btd_device	*dev;		/* Device reference */
 	GAttrib			*attrib;	/* GATT connection */
 	guint			attioid;	/* Att watcher id */
@@ -64,6 +70,28 @@ struct descriptor {
 	bt_uuid_t		uuid;		/* UUID */
 };
 
+static void char_free(gpointer user_data)
+{
+	struct characteristic *c = user_data;
+
+	g_slist_free_full(c->desc, g_free);
+
+	g_free(c);
+}
+
+static void char_interface_free(gpointer user_data)
+{
+	struct characteristic *c = user_data;
+	device_remove_battery(c->batt->dev, c->path);
+
+	g_dbus_unregister_interface(c->batt->conn,
+			c->path, BATTERY_INTERFACE);
+
+	g_free(c->path);
+
+	char_free(c);
+}
+
 static gint cmp_device(gconstpointer a, gconstpointer b)
 {
 	const struct battery *batt = a;
@@ -80,7 +108,7 @@ static void battery_free(gpointer user_data)
 	struct battery *batt = user_data;
 
 	if (batt->chars != NULL)
-		g_slist_free_full(batt->chars, g_free);
+		g_slist_free_full(batt->chars, char_interface_free);
 
 	if (batt->attioid > 0)
 		btd_device_remove_attio_callback(batt->dev, batt->attioid);
@@ -88,7 +116,10 @@ static void battery_free(gpointer user_data)
 	if (batt->attrib != NULL)
 		g_attrib_unref(batt->attrib);
 
+
+	dbus_connection_unref(batt->conn);
 	btd_device_unref(batt->dev);
+	g_free(batt->svc_range);
 	g_free(batt);
 }
 
@@ -140,6 +171,41 @@ static void process_batterylevel_desc(struct descriptor *desc)
 	DBG("Ignored descriptor %s characteristic %s", uuidstr,	ch->attr.uuid);
 }
 
+static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct characteristic *c = data;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	DBusMessage *reply;
+
+	reply = dbus_message_new_method_return(msg);
+	if (reply == NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	dict_append_entry(&dict, "Namespace", DBUS_TYPE_BYTE, &c->ns);
+
+	dict_append_entry(&dict, "Description", DBUS_TYPE_UINT16,
+							&c->description);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static GDBusMethodTable battery_methods[] = {
+	{ GDBUS_METHOD("GetProperties",
+				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+				get_properties) },
+	{ }
+};
 
 static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
@@ -185,10 +251,17 @@ update_char:
 				ch->ns,
 				ch->description);
 
-	device_add_battery(ch->batt->dev, ch->path);
+	if (!g_dbus_register_interface(ch->batt->conn, ch->path,
+				BATTERY_INTERFACE,
+				battery_methods, NULL, NULL,
+				ch, NULL)) {
+		error("D-Bus register interface %s failed",
+		      BATTERY_INTERFACE);
+	} else {
+		device_add_battery(ch->batt->dev, ch->path);
+	}
 }
 
-
 static void configure_battery_cb(GSList *characteristics, guint8 status,
 
 							gpointer user_data)
@@ -215,6 +288,7 @@ static void configure_battery_cb(GSList *characteristics, guint8 status,
 			ch->attr.value_handle = c->value_handle;
 			memcpy(ch->attr.uuid, c->uuid, MAX_LEN_UUID_STR + 1);
 			ch->batt = batt;
+
 			batt->chars = g_slist_append(batt->chars, ch);
 
 			start = c->value_handle + 1;
@@ -264,7 +338,7 @@ static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
 	return g_strcmp0(prim->uuid, uuid);
 }
 
-int battery_register(struct btd_device *device)
+int battery_register(DBusConnection *connection, struct btd_device *device)
 {
 	struct battery *batt;
 	struct gatt_primary *prim;
@@ -278,7 +352,7 @@ int battery_register(struct btd_device *device)
 
 	batt = g_new0(struct battery, 1);
 	batt->dev = btd_device_ref(device);
-
+	batt->conn = dbus_connection_ref(connection);
 	batt->svc_range = g_new0(struct att_range, 1);
 	batt->svc_range->start = prim->range.start;
 	batt->svc_range->end = prim->range.end;
@@ -288,6 +362,7 @@ int battery_register(struct btd_device *device)
 	batt->attioid = btd_device_add_attio_callback(device,
 				attio_connected_cb, attio_disconnected_cb,
 				batt);
+
 	return 0;
 }
 
diff --git a/profiles/battery/battery.h b/profiles/battery/battery.h
index 801186d..8231949 100644
--- a/profiles/battery/battery.h
+++ b/profiles/battery/battery.h
@@ -21,6 +21,6 @@
  */
 
 #define BATTERY_SERVICE_UUID		"0000180f-0000-1000-8000-00805f9b34fb"
+int battery_register(DBusConnection *conn, struct btd_device *device);
 
-int battery_register(struct btd_device *device);
 void battery_unregister(struct btd_device *device);
diff --git a/profiles/battery/main.c b/profiles/battery/main.c
index 47f4249..49c7249 100644
--- a/profiles/battery/main.c
+++ b/profiles/battery/main.c
@@ -25,7 +25,7 @@
 #endif
 
 #include <stdint.h>
-#include <glib.h>
+#include <gdbus.h>
 #include <errno.h>
 
 #include "hcid.h"
@@ -33,6 +33,8 @@
 #include "manager.h"
 #include "log.h"
 
+static DBusConnection *connection;
+
 static int battery_init(void)
 {
 	if (!main_opts.gatt_enabled) {
@@ -40,12 +42,24 @@ static int battery_init(void)
 		return -ENOTSUP;
 	}
 
-	return battery_manager_init();
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (connection == NULL)
+		return -EIO;
+
+	if (battery_manager_init(connection) < 0) {
+		dbus_connection_unref(connection);
+		return -EIO;
+	}
+
+	return 0;
 }
 
 static void battery_exit(void)
 {
 	battery_manager_exit();
+
+	dbus_connection_unref(connection);
+	connection = NULL;
 }
 
 BLUETOOTH_PLUGIN_DEFINE(battery, VERSION,
diff --git a/profiles/battery/manager.c b/profiles/battery/manager.c
index 22b8b20..13bc806 100644
--- a/profiles/battery/manager.c
+++ b/profiles/battery/manager.c
@@ -20,7 +20,7 @@
  *
  */
 
-#include <glib.h>
+#include <gdbus.h>
 #include <errno.h>
 #include <bluetooth/uuid.h>
 
@@ -32,9 +32,11 @@
 #include "battery.h"
 #include "manager.h"
 
+static DBusConnection *connection;
+
 static int battery_driver_probe(struct btd_device *device, GSList *uuids)
 {
-	return battery_register(device);
+	return battery_register(connection, device);
 }
 
 static void battery_driver_remove(struct btd_device *device)
@@ -49,12 +51,21 @@ static struct btd_device_driver battery_device_driver = {
 	.remove	= battery_driver_remove
 };
 
-int battery_manager_init(void)
+int battery_manager_init(DBusConnection *conn)
 {
-	return btd_register_device_driver(&battery_device_driver);
+	int ret;
+
+	ret = btd_register_device_driver(&battery_device_driver);
+	if (!ret)
+		connection = dbus_connection_ref(conn);
+
+	return ret;
 }
 
 void battery_manager_exit(void)
 {
 	btd_unregister_device_driver(&battery_device_driver);
+
+	dbus_connection_unref(connection);
+	connection = NULL;
 }
diff --git a/profiles/battery/manager.h b/profiles/battery/manager.h
index b2c849f..60acb1d 100644
--- a/profiles/battery/manager.h
+++ b/profiles/battery/manager.h
@@ -20,5 +20,5 @@
  *
  */
 
-int battery_manager_init(void);
+int battery_manager_init(DBusConnection *conn);
 void battery_manager_exit(void);
-- 
1.7.9.5

