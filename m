Return-Path: <cyrus@holtmann.org>
From: Chen Ganir <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v2 6/9] Battery: Add Battery D-BUS API
Date: Wed, 25 Jul 2012 08:42:24 +0300
Message-ID: <1343194947-13659-7-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1343194947-13659-1-git-send-email-chen.ganir@ti.com>
References: <1343194947-13659-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add Battery level specific API
---
 doc/battery-api.txt                  |   33 +++++++++++++
 profiles/batterystate/batterystate.c |   89 ++++++++++++++++++++++++++++++++--
 profiles/batterystate/batterystate.h |    3 +-
 profiles/batterystate/main.c         |   18 ++++++-
 profiles/batterystate/manager.c      |   19 ++++++--
 profiles/batterystate/manager.h      |    2 +-
 6 files changed, 151 insertions(+), 13 deletions(-)
 create mode 100644 doc/battery-api.txt

diff --git a/doc/battery-api.txt b/doc/battery-api.txt
new file mode 100644
index 0000000..5d7510d
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
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/BATTYYYY
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
diff --git a/profiles/batterystate/batterystate.c b/profiles/batterystate/batterystate.c
index 23dfab5..a9b2414 100644
--- a/profiles/batterystate/batterystate.c
+++ b/profiles/batterystate/batterystate.c
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
 #include "batterystate.h"
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
@@ -81,7 +109,7 @@ static void batterystate_free(gpointer user_data)
 	struct battery *batt = user_data;
 
 	if (batt->chars != NULL)
-		g_slist_free_full(batt->chars, g_free);
+		g_slist_free_full(batt->chars, char_interface_free);
 
 	if (batt->attioid > 0)
 		btd_device_remove_attio_callback(batt->dev, batt->attioid);
@@ -89,7 +117,10 @@ static void batterystate_free(gpointer user_data)
 	if (batt->attrib != NULL)
 		g_attrib_unref(batt->attrib);
 
+
+	dbus_connection_unref(batt->conn);
 	btd_device_unref(batt->dev);
+	g_free(batt->svc_range);
 	g_free(batt);
 }
 
@@ -181,6 +212,44 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 	att_data_list_free(list);
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
+
 
 static void configure_batterystate_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
@@ -213,6 +282,15 @@ static void configure_batterystate_cb(GSList *characteristics, guint8 status,
 
 			device_add_battery(batt->dev, ch->path);
 
+			if (!g_dbus_register_interface(batt->conn, ch->path,
+						BATTERY_INTERFACE,
+						battery_methods, NULL, NULL,
+						ch, NULL)) {
+				error("D-Bus register interface %s failed",
+							BATTERY_INTERFACE);
+				continue;
+			}
+
 			batt->chars = g_slist_append(batt->chars, ch);
 
 			start = c->value_handle + 1;
@@ -254,14 +332,14 @@ static void attio_disconnected_cb(gpointer user_data)
 	batt->attrib = NULL;
 }
 
-int batterystate_register(struct btd_device *device,
-				struct gatt_primary *prim)
+int batterystate_register(DBusConnection *connection, struct btd_device *device,
+						struct gatt_primary *prim)
 {
 	struct battery *batt;
 
 	batt = g_new0(struct battery, 1);
 	batt->dev = btd_device_ref(device);
-
+	batt->conn = dbus_connection_ref(connection);
 	batt->svc_range = g_new0(struct att_range, 1);
 	batt->svc_range->start = prim->range.start;
 	batt->svc_range->end = prim->range.end;
@@ -271,6 +349,7 @@ int batterystate_register(struct btd_device *device,
 	batt->attioid = btd_device_add_attio_callback(device,
 				attio_connected_cb, attio_disconnected_cb,
 				batt);
+
 	return 0;
 }
 
diff --git a/profiles/batterystate/batterystate.h b/profiles/batterystate/batterystate.h
index 2d30028..63b55bc 100644
--- a/profiles/batterystate/batterystate.h
+++ b/profiles/batterystate/batterystate.h
@@ -19,5 +19,6 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
  */
-int batterystate_register(struct btd_device *device, struct gatt_primary *prim);
+int batterystate_register(DBusConnection *conn, struct btd_device *device,
+						struct gatt_primary *prim);
 void batterystate_unregister(struct btd_device *device);
diff --git a/profiles/batterystate/main.c b/profiles/batterystate/main.c
index 360254b..a41952d 100644
--- a/profiles/batterystate/main.c
+++ b/profiles/batterystate/main.c
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
 static int batterystate_init(void)
 {
 	if (!main_opts.gatt_enabled) {
@@ -40,12 +42,24 @@ static int batterystate_init(void)
 		return -ENOTSUP;
 	}
 
-	return batterystate_manager_init();
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (connection == NULL)
+		return -EIO;
+
+	if (batterystate_manager_init(connection) < 0) {
+		dbus_connection_unref(connection);
+		return -EIO;
+	}
+
+	return 0;
 }
 
 static void batterystate_exit(void)
 {
 	batterystate_manager_exit();
+
+	dbus_connection_unref(connection);
+	connection = NULL;
 }
 
 BLUETOOTH_PLUGIN_DEFINE(batterystate, VERSION,
diff --git a/profiles/batterystate/manager.c b/profiles/batterystate/manager.c
index 62076ac..5e52b16 100644
--- a/profiles/batterystate/manager.c
+++ b/profiles/batterystate/manager.c
@@ -20,7 +20,7 @@
  *
  */
 
-#include <glib.h>
+#include <gdbus.h>
 #include <errno.h>
 #include <bluetooth/uuid.h>
 
@@ -34,6 +34,8 @@
 
 #define BATTERY_SERVICE_UUID		"0000180f-0000-1000-8000-00805f9b34fb"
 
+static DBusConnection *connection;
+
 static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct gatt_primary *prim = a;
@@ -56,7 +58,7 @@ static int batterystate_driver_probe(struct btd_device *device, GSList *uuids)
 
 	prim = l->data;
 
-	return batterystate_register(device, prim);
+	return batterystate_register(connection, device, prim);
 }
 
 static void batterystate_driver_remove(struct btd_device *device)
@@ -71,12 +73,21 @@ static struct btd_device_driver battery_device_driver = {
 	.remove	= batterystate_driver_remove
 };
 
-int batterystate_manager_init(void)
+int batterystate_manager_init(DBusConnection *conn)
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
 
 void batterystate_manager_exit(void)
 {
 	btd_unregister_device_driver(&battery_device_driver);
+
+	dbus_connection_unref(connection);
+	connection = NULL;
 }
diff --git a/profiles/batterystate/manager.h b/profiles/batterystate/manager.h
index 7f0bf15..9f99e70 100644
--- a/profiles/batterystate/manager.h
+++ b/profiles/batterystate/manager.h
@@ -20,5 +20,5 @@
  *
  */
 
-int batterystate_manager_init(void);
+int batterystate_manager_init(DBusConnection *conn);
 void batterystate_manager_exit(void);
-- 
1.7.9.5

