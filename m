Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v4 08/10] Battery: Add Battery D-BUS API
Date: Thu, 16 Aug 2012 12:35:01 +0300
Message-ID: <1345109702-5698-9-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1345109702-5698-1-git-send-email-chen.ganir@ti.com>
References: <1345109702-5698-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add Battery level specific API
---
 profiles/battery/battery.c |   84 ++++++++++++++++++++++++++++++++++++++++----
 profiles/battery/battery.h |    2 +-
 profiles/battery/main.c    |   18 ++++++++--
 profiles/battery/manager.c |   19 +++++++---
 profiles/battery/manager.h |    2 +-
 5 files changed, 111 insertions(+), 14 deletions(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 6baf2db..108813c 100644
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
@@ -65,6 +71,28 @@ struct descriptor {
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
@@ -81,7 +109,7 @@ static void battery_free(gpointer user_data)
 	struct battery *batt = user_data;
 
 	if (batt->chars != NULL)
-		g_slist_free_full(batt->chars, g_free);
+		g_slist_free_full(batt->chars, char_interface_free);
 
 	if (batt->attioid > 0)
 		btd_device_remove_attio_callback(batt->dev, batt->attioid);
@@ -89,7 +117,10 @@ static void battery_free(gpointer user_data)
 	if (batt->attrib != NULL)
 		g_attrib_unref(batt->attrib);
 
+
+	dbus_connection_unref(batt->conn);
 	btd_device_unref(batt->dev);
+	g_free(batt->svc_range);
 	g_free(batt);
 }
 
@@ -175,6 +206,38 @@ static void process_batterylevel_desc(struct descriptor *desc)
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
+	dict_append_entry(&dict, "Level", DBUS_TYPE_BYTE, &c->level);
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
 {
@@ -219,10 +282,17 @@ update_char:
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
 	process_batteryservice_char(ch);
+	}
 }
-
 static void configure_battery_cb(GSList *characteristics, guint8 status,
 
 							gpointer user_data)
@@ -249,6 +319,7 @@ static void configure_battery_cb(GSList *characteristics, guint8 status,
 			ch->attr.value_handle = c->value_handle;
 			memcpy(ch->attr.uuid, c->uuid, MAX_LEN_UUID_STR + 1);
 			ch->batt = batt;
+
 			batt->chars = g_slist_append(batt->chars, ch);
 
 			start = c->value_handle + 1;
@@ -304,7 +375,7 @@ static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
 	return g_strcmp0(prim->uuid, uuid);
 }
 
-int battery_register(struct btd_device *device)
+int battery_register(DBusConnection *connection, struct btd_device *device)
 {
 	struct battery *batt;
 	struct gatt_primary *prim;
@@ -318,7 +389,7 @@ int battery_register(struct btd_device *device)
 
 	batt = g_new0(struct battery, 1);
 	batt->dev = btd_device_ref(device);
-
+	batt->conn = dbus_connection_ref(connection);
 	batt->svc_range = g_new0(struct att_range, 1);
 	batt->svc_range->start = prim->range.start;
 	batt->svc_range->end = prim->range.end;
@@ -328,6 +399,7 @@ int battery_register(struct btd_device *device)
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

