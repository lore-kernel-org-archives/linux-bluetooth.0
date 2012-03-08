Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH 8/8] proximity: reporter: implement D-Bus API
Date: Thu,  8 Mar 2012 15:57:12 +0200
Message-Id: <1331215032-27695-9-git-send-email-arik@wizery.com>
In-Reply-To: <1331215032-27695-1-git-send-email-arik@wizery.com>
References: <1331215032-27695-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Register a D-Bus interface per remote device. Set a watch on the
"DeviceAdded" signal to add all existing devices. Likewise set watches
on "DeviceCreated" and "DeviceRemoved" to handle dynamic addition and
removal of devices.

Implement the "GetProperties" method of the D-Bus interface by querying
the alert level of the remote device in the link-loss and
immediate-alert proximity profiles. The default values for non-connected
devices are "none".
---
 proximity/reporter.c |  204 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 196 insertions(+), 8 deletions(-)

diff --git a/proximity/reporter.c b/proximity/reporter.c
index 4972aa2..d540233 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -31,8 +31,14 @@
 #include <adapter.h>
 #include <errno.h>
 
+#include <dbus/dbus.h>
+#include <gdbus.h>
+
 #include "log.h"
 
+#include "dbus-common.h"
+#include "error.h"
+#include "device.h"
 #include "hcid.h"
 #include "att.h"
 #include "gattrib.h"
@@ -41,7 +47,18 @@
 #include "linkloss.h"
 #include "immalert.h"
 
-static DBusConnection *connection;
+#define BLUEZ_SERVICE "org.bluez"
+
+struct reporter_adapter {
+	DBusConnection *conn;
+	struct btd_adapter *adapter;
+	guint watch_created;
+	guint watch_added;
+	guint watch_removed;
+	GSList *devices;
+};
+
+static GSList *reporter_adapters;
 
 const char *get_alert_level_string(uint8_t level)
 {
@@ -101,28 +118,199 @@ static void register_tx_power(struct btd_adapter *adapter)
 	g_assert(h - start_handle == svc_size);
 }
 
+static DBusMessage *get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	DBusMessage *reply = NULL;
+	const char *linkloss_level, *immalert_level;
+	struct btd_device *device = data;
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	linkloss_level = link_loss_get_alert_level(device);
+	immalert_level = imm_get_alert_level(device);
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	if (!dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict))
+		goto err;
+
+	dict_append_entry(&dict, "LinkLossAlertLevel",
+			DBUS_TYPE_STRING, &linkloss_level);
+	dict_append_entry(&dict, "ImmediateAlertLevel",
+			DBUS_TYPE_STRING, &immalert_level);
+
+	if (!dbus_message_iter_close_container(&iter, &dict))
+		goto err;
+
+	return reply;
+
+err:
+	if (reply)
+		dbus_message_unref(reply);
+	return btd_error_failed(msg, "not enough memory");
+}
+
+static GDBusMethodTable reporter_methods[] = {
+	{ "GetProperties",	"",	"a{sv}",	get_properties	},
+	{ }
+};
+
+static GDBusSignalTable reporter_signals[] = {
+	{ "PropertyChanged",	"sv"	},
+	{ }
+};
+
+static void unregister_reporter_device(gpointer data, gpointer user_data)
+{
+	struct btd_device *device = data;
+	struct reporter_adapter *radapter = user_data;
+	const char *path = device_get_path(device);
+
+	g_dbus_unregister_interface(radapter->conn, path,
+				    PROXIMITY_REPORTER_INTERFACE);
+
+	radapter->devices = g_slist_remove(radapter->devices, device);
+	btd_device_unref(device);
+}
+
+static void register_reporter_device(struct btd_device *device,
+				     struct reporter_adapter *radapter)
+{
+	const char *path = device_get_path(device);
+
+	DBG("register on device %s", path);
+
+	g_dbus_register_interface(radapter->conn, path,
+				  PROXIMITY_REPORTER_INTERFACE,
+				  reporter_methods, reporter_signals,
+				  NULL, device, NULL);
+
+	btd_device_ref(device);
+	radapter->devices = g_slist_prepend(radapter->devices, device);
+}
+
+static gboolean handle_device_change(DBusConnection *conn,
+				  DBusMessage *msg, void *data)
+{
+	struct reporter_adapter *radapter = data;
+	DBusMessageIter iter;
+	const char *dev_path;
+	struct btd_device *device;
+	gboolean device_removed = FALSE;
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_OBJECT_PATH) {
+		error("Unexpected arg %s.%s DeviceCreated/Added/Removed",
+		      dbus_message_get_interface(msg),
+		      dbus_message_get_member(msg));
+		return TRUE;
+	}
+
+	if (g_strcmp0(dbus_message_get_member(msg), "DeviceRemoved") == 0)
+		device_removed = TRUE;
+
+	dbus_message_iter_get_basic(&iter, &dev_path);
+
+	device = adapter_get_device_by_path(radapter->adapter, dev_path);
+	if (!device)
+		return TRUE;
+
+	if (device_removed)
+		unregister_reporter_device(device, radapter);
+	else
+		register_reporter_device(device, radapter);
+
+	return TRUE;
+}
+
 int reporter_init(struct btd_adapter *adapter)
 {
+	struct reporter_adapter *radapter;
+	DBusConnection *conn;
+
 	if (!main_opts.attrib_server) {
 		DBG("Attribute server is disabled");
 		return -1;
 	}
 
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-	if (connection == NULL)
-		return -EIO;
-	DBG("Proximity Reporter for adapter %p", adapter);
+	conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (!conn)
+		return -1;
 
-	register_link_loss(adapter, connection);
+	radapter = g_new0(struct reporter_adapter, 1);
+	radapter->adapter = adapter;
+	radapter->conn = conn;
+
+	register_link_loss(adapter, radapter->conn);
 	register_tx_power(adapter);
-	register_imm_alert(adapter, connection);
+	register_imm_alert(adapter, radapter->conn);
+
+	/*
+	 * Register watches for getting device change events. We watch
+	 * for existing, new and removed devices.
+	 */
+	radapter->watch_added = g_dbus_add_signal_watch(radapter->conn,
+					BLUEZ_SERVICE, NULL, ADAPTER_INTERFACE,
+					"DeviceAdded", handle_device_change,
+					radapter, NULL);
+
+	radapter->watch_created = g_dbus_add_signal_watch(radapter->conn,
+					BLUEZ_SERVICE, NULL, ADAPTER_INTERFACE,
+					"DeviceCreated", handle_device_change,
+					radapter, NULL);
+
+	radapter->watch_removed = g_dbus_add_signal_watch(radapter->conn,
+					BLUEZ_SERVICE, NULL, ADAPTER_INTERFACE,
+					"DeviceRemoved", handle_device_change,
+					radapter, NULL);
+
+	reporter_adapters = g_slist_prepend(reporter_adapters, radapter);
+	DBG("Proximity Reporter for adapter %p", adapter);
 
 	return 0;
 }
 
+static int radapter_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct reporter_adapter *radapter = a;
+	const struct btd_adapter *adapter = b;
+
+	if (radapter->adapter == adapter)
+		return 0;
+
+	return -1;
+}
+
 void reporter_exit(struct btd_adapter *adapter)
 {
+	struct reporter_adapter *radapter;
+	GSList *l = g_slist_find_custom(reporter_adapters, adapter,
+					radapter_cmp);
+	if (!l)
+		return;
+
+	radapter = l->data;
+
+	g_dbus_remove_watch(radapter->conn, radapter->watch_created);
+	g_dbus_remove_watch(radapter->conn, radapter->watch_added);
+	g_dbus_remove_watch(radapter->conn, radapter->watch_removed);
+
+	g_slist_foreach(radapter->devices, unregister_reporter_device,
+			radapter);
+
 	unregister_link_loss(adapter);
 	unregister_imm_alert(adapter);
-	dbus_connection_unref(connection);
+	dbus_connection_unref(radapter->conn);
+
+	reporter_adapters = g_slist_remove(reporter_adapters, radapter);
+	g_free(radapter);
 }
-- 
1.7.5.4

