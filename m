Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH v7 6/6] proximity: reporter: implement D-Bus API
Date: Mon,  2 Apr 2012 14:17:24 +0300
Message-Id: <1333365444-9029-6-git-send-email-arik@wizery.com>
In-Reply-To: <1333365444-9029-1-git-send-email-arik@wizery.com>
References: <1333365444-9029-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use a device driver to track all GATT supporting devices and register
a D-Bus interface per remote device.

Implement the "GetProperties" method of the D-Bus interface by querying
the alert level of the remote device in the link-loss and
immediate-alert proximity profiles. The default alert level values for
non-connected devices are "none".
---
 proximity/reporter.c |  191 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 183 insertions(+), 8 deletions(-)

diff --git a/proximity/reporter.c b/proximity/reporter.c
index 4768e5f..01649b3 100644
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
 #include "att-database.h"
@@ -42,7 +48,39 @@
 #include "linkloss.h"
 #include "immalert.h"
 
-static DBusConnection *connection;
+#define BLUEZ_SERVICE "org.bluez"
+
+#define GATT_UUID     "00001801-0000-1000-8000-00805f9b34fb"
+
+struct reporter_adapter {
+	DBusConnection *conn;
+	struct btd_adapter *adapter;
+	GSList *devices;
+};
+
+static GSList *reporter_adapters;
+
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
+static struct reporter_adapter *
+find_reporter_adapter(struct btd_adapter *adapter)
+{
+	GSList *l = g_slist_find_custom(reporter_adapters, adapter,
+					radapter_cmp);
+	if (!l)
+		return NULL;
+
+	return l->data;
+}
 
 const char *get_alert_level_string(uint8_t level)
 {
@@ -102,28 +140,165 @@ static void register_tx_power(struct btd_adapter *adapter)
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
+	immalert_level = imm_alert_get_level(device);
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
+	DBG("unregister on device %s", path);
+
+	g_dbus_unregister_interface(radapter->conn, path,
+					PROXIMITY_REPORTER_INTERFACE);
+
+	radapter->devices = g_slist_remove(radapter->devices, device);
+	btd_device_unref(device);
+}
+
+static void register_reporter_device(struct btd_device *device,
+					struct reporter_adapter *radapter)
+{
+	const char *path = device_get_path(device);
+
+	DBG("register on device %s", path);
+
+	g_dbus_register_interface(radapter->conn, path,
+					PROXIMITY_REPORTER_INTERFACE,
+					reporter_methods, reporter_signals,
+					NULL, device, NULL);
+
+	btd_device_ref(device);
+	radapter->devices = g_slist_prepend(radapter->devices, device);
+}
+
+static int reporter_device_probe(struct btd_device *device, GSList *uuids)
+{
+	struct reporter_adapter *radapter;
+	struct btd_adapter *adapter = device_get_adapter(device);
+
+	radapter = find_reporter_adapter(adapter);
+	if (!radapter)
+		return -1;
+
+	register_reporter_device(device, radapter);
+	return 0;
+}
+
+static void reporter_device_remove(struct btd_device *device)
+{
+	struct reporter_adapter *radapter;
+	struct btd_adapter *adapter = device_get_adapter(device);
+
+	radapter = find_reporter_adapter(adapter);
+	if (!radapter)
+		return;
+
+	unregister_reporter_device(device, radapter);
+}
+
+/* device driver for tracking remote GATT client devices */
+static struct btd_device_driver reporter_device_driver = {
+	.name = "Proximity GATT Reporter Device Tracker Driver",
+	.uuids = BTD_UUIDS(GATT_UUID),
+	.probe = reporter_device_probe,
+	.remove = reporter_device_remove,
+};
+
 int reporter_init(struct btd_adapter *adapter)
 {
+	struct reporter_adapter *radapter;
+	DBusConnection *conn;
+
 	if (!main_opts.gatt_enabled) {
 		DBG("GATT is disabled");
 		return -ENOTSUP;
 	}
 
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-	if (connection == NULL)
-		return -EIO;
-	DBG("Proximity Reporter for adapter %p", adapter);
+	conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (!conn)
+		return -1;
 
-	link_loss_register(adapter, connection);
+	radapter = g_new0(struct reporter_adapter, 1);
+	radapter->adapter = adapter;
+	radapter->conn = conn;
+
+	link_loss_register(adapter, radapter->conn);
 	register_tx_power(adapter);
-	imm_alert_register(adapter, connection);
+	imm_alert_register(adapter, radapter->conn);
+
+	btd_register_device_driver(&reporter_device_driver);
+
+	reporter_adapters = g_slist_prepend(reporter_adapters, radapter);
+	DBG("Proximity Reporter for adapter %p", adapter);
 
 	return 0;
 }
 
 void reporter_exit(struct btd_adapter *adapter)
 {
+	struct reporter_adapter *radapter = find_reporter_adapter(adapter);
+	if (!radapter)
+		return;
+
+	btd_unregister_device_driver(&reporter_device_driver);
+
+	g_slist_foreach(radapter->devices, unregister_reporter_device,
+			radapter);
+
 	link_loss_unregister(adapter);
 	imm_alert_unregister(adapter);
-	dbus_connection_unref(connection);
+	dbus_connection_unref(radapter->conn);
+
+	reporter_adapters = g_slist_remove(reporter_adapters, radapter);
+	g_free(radapter);
 }
-- 
1.7.5.4

