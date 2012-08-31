Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 3/7] proximity: Simplify DBusConnection object usage
Date: Fri, 31 Aug 2012 14:48:29 +0200
Message-ID: <1346417314-25109-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1346417314-25109-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1346417314-25109-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

DBusConnection object can be obtained at any time by get_dbus_connection() call
so there is no need to pass and store it across profile code. Also there's no
need to ref/unref this object as by design it will live for entire lifetime of
plugin.
---
 profiles/proximity/immalert.c |  9 ++-------
 profiles/proximity/immalert.h |  2 +-
 profiles/proximity/linkloss.c |  8 ++------
 profiles/proximity/linkloss.h |  2 +-
 profiles/proximity/main.c     | 10 +---------
 profiles/proximity/manager.c  | 13 +++----------
 profiles/proximity/manager.h  |  2 +-
 profiles/proximity/monitor.c  | 20 +++++++++-----------
 profiles/proximity/monitor.h  |  8 ++++----
 profiles/proximity/reporter.c | 16 ++++------------
 10 files changed, 28 insertions(+), 62 deletions(-)

diff --git a/profiles/proximity/immalert.c b/profiles/proximity/immalert.c
index 1540b61..f4061bc 100644
--- a/profiles/proximity/immalert.c
+++ b/profiles/proximity/immalert.c
@@ -46,7 +46,6 @@
 
 struct imm_alert_adapter {
 	struct btd_adapter *adapter;
-	DBusConnection *conn;
 	GSList *connected_devices;
 };
 
@@ -125,19 +124,17 @@ const char *imm_alert_get_level(struct btd_device *device)
 static void imm_alert_emit_alert_signal(struct connected_device *condev,
 							uint8_t alert_level)
 {
-	struct imm_alert_adapter *adapter;
 	const char *path, *alert_level_str;
 
 	if (!condev)
 		return;
 
-	adapter = condev->adapter;
 	path = device_get_path(condev->device);
 	alert_level_str = get_alert_level_string(alert_level);
 
 	DBG("alert %s remote %s", alert_level_str, path);
 
-	emit_property_changed(adapter->conn, path,
+	emit_property_changed(get_dbus_connection(), path,
 			PROXIMITY_REPORTER_INTERFACE, "ImmediateAlertLevel",
 			DBUS_TYPE_STRING, &alert_level_str);
 }
@@ -233,7 +230,7 @@ set_error:
 	return ATT_ECODE_IO;
 }
 
-void imm_alert_register(struct btd_adapter *adapter, DBusConnection *conn)
+void imm_alert_register(struct btd_adapter *adapter)
 {
 	gboolean svc_added;
 	bt_uuid_t uuid;
@@ -243,7 +240,6 @@ void imm_alert_register(struct btd_adapter *adapter, DBusConnection *conn)
 
 	imadapter = g_new0(struct imm_alert_adapter, 1);
 	imadapter->adapter = adapter;
-	imadapter->conn = dbus_connection_ref(conn);
 
 	imm_alert_adapters = g_slist_append(imm_alert_adapters, imadapter);
 
@@ -283,7 +279,6 @@ void imm_alert_unregister(struct btd_adapter *adapter)
 
 	g_slist_foreach(imadapter->connected_devices, remove_condev_list_item,
 									NULL);
-	dbus_connection_unref(imadapter->conn);
 
 	imm_alert_adapters = g_slist_remove(imm_alert_adapters, imadapter);
 	g_free(imadapter);
diff --git a/profiles/proximity/immalert.h b/profiles/proximity/immalert.h
index dd28eaa..1a09fa9 100644
--- a/profiles/proximity/immalert.h
+++ b/profiles/proximity/immalert.h
@@ -21,6 +21,6 @@
  *
  */
 
-void imm_alert_register(struct btd_adapter *adapter, DBusConnection *conn);
+void imm_alert_register(struct btd_adapter *adapter);
 void imm_alert_unregister(struct btd_adapter *adapter);
 const char *imm_alert_get_level(struct btd_device *device);
diff --git a/profiles/proximity/linkloss.c b/profiles/proximity/linkloss.c
index 6ed568c..b6d01a6 100644
--- a/profiles/proximity/linkloss.c
+++ b/profiles/proximity/linkloss.c
@@ -47,7 +47,6 @@
 struct link_loss_adapter {
 	struct btd_adapter *adapter;
 	uint16_t alert_lvl_value_handle;
-	DBusConnection *conn;
 	GSList *connected_devices;
 };
 
@@ -126,7 +125,6 @@ const char *link_loss_get_alert_level(struct btd_device *device)
 
 static void link_loss_emit_alert_signal(struct connected_device *condev)
 {
-	struct link_loss_adapter *adapter = condev->adapter;
 	const char *alert_level_str, *path;
 
 	if (!condev->device)
@@ -137,7 +135,7 @@ static void link_loss_emit_alert_signal(struct connected_device *condev)
 
 	DBG("alert %s remote %s", alert_level_str, path);
 
-	emit_property_changed(adapter->conn, path,
+	emit_property_changed(get_dbus_connection(), path,
 			PROXIMITY_REPORTER_INTERFACE, "LinkLossAlertLevel",
 			DBUS_TYPE_STRING, &alert_level_str);
 }
@@ -273,7 +271,7 @@ set_error:
 	return ATT_ECODE_IO;
 }
 
-void link_loss_register(struct btd_adapter *adapter, DBusConnection *conn)
+void link_loss_register(struct btd_adapter *adapter)
 {
 	gboolean svc_added;
 	bt_uuid_t uuid;
@@ -283,7 +281,6 @@ void link_loss_register(struct btd_adapter *adapter, DBusConnection *conn)
 
 	lladapter = g_new0(struct link_loss_adapter, 1);
 	lladapter->adapter = adapter;
-	lladapter->conn = dbus_connection_ref(conn);
 
 	link_loss_adapters = g_slist_append(link_loss_adapters, lladapter);
 
@@ -329,7 +326,6 @@ void link_loss_unregister(struct btd_adapter *adapter)
 
 	g_slist_foreach(lladapter->connected_devices, remove_condev_list_item,
 			NULL);
-	dbus_connection_unref(lladapter->conn);
 
 	link_loss_adapters = g_slist_remove(link_loss_adapters, lladapter);
 	g_free(lladapter);
diff --git a/profiles/proximity/linkloss.h b/profiles/proximity/linkloss.h
index a7d83d0..0447def 100644
--- a/profiles/proximity/linkloss.h
+++ b/profiles/proximity/linkloss.h
@@ -21,6 +21,6 @@
  *
  */
 
-void link_loss_register(struct btd_adapter *adapter, DBusConnection *conn);
+void link_loss_register(struct btd_adapter *adapter);
 void link_loss_unregister(struct btd_adapter *adapter);
 const char *link_loss_get_alert_level(struct btd_device *device);
diff --git a/profiles/proximity/main.c b/profiles/proximity/main.c
index 3d5d9b2..0f57511 100644
--- a/profiles/proximity/main.c
+++ b/profiles/proximity/main.c
@@ -36,7 +36,6 @@
 #include "manager.h"
 #include "hcid.h"
 
-static DBusConnection *connection = NULL;
 static GKeyFile *config = NULL;
 
 static GKeyFile *open_config_file(const char *file)
@@ -65,16 +64,10 @@ static int proximity_init(void)
 		return -ENOTSUP;
 	}
 
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-	if (connection == NULL)
-		return -EIO;
-
 	config = open_config_file(CONFIGDIR "/proximity.conf");
 
-	if (proximity_manager_init(connection, config) < 0) {
-		dbus_connection_unref(connection);
+	if (proximity_manager_init(config) < 0)
 		return -EIO;
-	}
 
 	return 0;
 }
@@ -88,7 +81,6 @@ static void proximity_exit(void)
 		g_key_file_free(config);
 
 	proximity_manager_exit();
-	dbus_connection_unref(connection);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(proximity, VERSION,
diff --git a/profiles/proximity/manager.c b/profiles/proximity/manager.c
index e382be1..97e9795 100644
--- a/profiles/proximity/manager.c
+++ b/profiles/proximity/manager.c
@@ -39,8 +39,6 @@
 #include "reporter.h"
 #include "manager.h"
 
-static DBusConnection *connection = NULL;
-
 static struct enabled enabled  = {
 	.linkloss = TRUE,
 	.pathloss = TRUE,
@@ -72,13 +70,12 @@ static int attio_device_probe(struct btd_device *device, GSList *uuids)
 	l = g_slist_find_custom(primaries, LINK_LOSS_UUID, primary_uuid_cmp);
 	linkloss = (l ? l->data : NULL);
 
-	return monitor_register(connection, device, linkloss, txpower,
-							immediate, &enabled);
+	return monitor_register(device, linkloss, txpower, immediate, &enabled);
 }
 
 static void attio_device_remove(struct btd_device *device)
 {
-	monitor_unregister(connection, device);
+	monitor_unregister(device);
 }
 
 static struct btd_device_driver monitor_driver = {
@@ -116,14 +113,12 @@ static void load_config_file(GKeyFile *config)
 	g_strfreev(list);
 }
 
-int proximity_manager_init(DBusConnection *conn, GKeyFile *config)
+int proximity_manager_init(GKeyFile *config)
 {
 	int ret;
 
 	load_config_file(config);
 
-	connection = dbus_connection_ref(conn);
-
 	ret = btd_register_device_driver(&monitor_driver);
 	if (ret < 0)
 		goto fail_monitor;
@@ -138,7 +133,6 @@ fail_reporter:
 	btd_unregister_device_driver(&monitor_driver);
 
 fail_monitor:
-	dbus_connection_unref(connection);
 	return ret;
 }
 
@@ -146,5 +140,4 @@ void proximity_manager_exit(void)
 {
 	btd_unregister_device_driver(&monitor_driver);
 	btd_unregister_adapter_driver(&reporter_server_driver);
-	dbus_connection_unref(connection);
 }
diff --git a/profiles/proximity/manager.h b/profiles/proximity/manager.h
index b0fe7c8..e65c31d 100644
--- a/profiles/proximity/manager.h
+++ b/profiles/proximity/manager.h
@@ -22,5 +22,5 @@
  *
  */
 
-int proximity_manager_init(DBusConnection *conn, GKeyFile *conf);
+int proximity_manager_init(GKeyFile *conf);
 void proximity_manager_exit(void);
diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index f22d6f4..ac9dae7 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -66,7 +66,6 @@ enum {
 struct monitor {
 	struct btd_device *device;
 	GAttrib *attrib;
-	DBusConnection *conn;
 	struct att_range *linkloss;
 	struct att_range *txpower;
 	struct att_range *immediate;
@@ -160,7 +159,7 @@ static void linkloss_written(guint8 status, const guint8 *pdu, guint16 plen,
 
 	DBG("Link Loss Alert Level written");
 
-	emit_property_changed(monitor->conn, path,
+	emit_property_changed(get_dbus_connection(), path,
 				PROXIMITY_INTERFACE, "LinkLossAlertLevel",
 				DBUS_TYPE_STRING, &monitor->linklosslevel);
 }
@@ -289,7 +288,7 @@ static gboolean immediate_timeout(gpointer user_data)
 
 	g_free(monitor->immediatelevel);
 	monitor->immediatelevel = g_strdup("none");
-	emit_property_changed(monitor->conn, path, PROXIMITY_INTERFACE,
+	emit_property_changed(get_dbus_connection(), path, PROXIMITY_INTERFACE,
 					"ImmediateAlertLevel", DBUS_TYPE_STRING,
 					&monitor->immediatelevel);
 
@@ -304,7 +303,7 @@ static void immediate_written(gpointer user_data)
 	g_free(monitor->fallbacklevel);
 	monitor->fallbacklevel = NULL;
 
-	emit_property_changed(monitor->conn, path, PROXIMITY_INTERFACE,
+	emit_property_changed(get_dbus_connection(), path, PROXIMITY_INTERFACE,
 				"ImmediateAlertLevel",
 				DBUS_TYPE_STRING, &monitor->immediatelevel);
 
@@ -390,7 +389,7 @@ static void attio_disconnected_cb(gpointer user_data)
 
 	g_free(monitor->immediatelevel);
 	monitor->immediatelevel = g_strdup("none");
-	emit_property_changed(monitor->conn, path, PROXIMITY_INTERFACE,
+	emit_property_changed(get_dbus_connection(), path, PROXIMITY_INTERFACE,
 					"ImmediateAlertLevel", DBUS_TYPE_STRING,
 					&monitor->immediatelevel);
 }
@@ -577,7 +576,6 @@ static void monitor_destroy(gpointer user_data)
 	if (monitor->attrib)
 		g_attrib_unref(monitor->attrib);
 
-	dbus_connection_unref(monitor->conn);
 	btd_device_unref(monitor->device);
 	g_free(monitor->linkloss);
 	g_free(monitor->immediate);
@@ -588,7 +586,7 @@ static void monitor_destroy(gpointer user_data)
 	g_free(monitor);
 }
 
-int monitor_register(DBusConnection *conn, struct btd_device *device,
+int monitor_register(struct btd_device *device,
 		struct gatt_primary *linkloss, struct gatt_primary *txpower,
 		struct gatt_primary *immediate, struct enabled *enabled)
 {
@@ -604,12 +602,11 @@ int monitor_register(DBusConnection *conn, struct btd_device *device,
 
 	monitor = g_new0(struct monitor, 1);
 	monitor->device = btd_device_ref(device);
-	monitor->conn = dbus_connection_ref(conn);
 	monitor->linklosslevel = (level ? : g_strdup("high"));
 	monitor->signallevel = g_strdup("unknown");
 	monitor->immediatelevel = g_strdup("none");
 
-	if (g_dbus_register_interface(conn, path,
+	if (g_dbus_register_interface(get_dbus_connection(), path,
 				PROXIMITY_INTERFACE,
 				monitor_methods, monitor_signals,
 				NULL, monitor, monitor_destroy) == FALSE) {
@@ -661,9 +658,10 @@ int monitor_register(DBusConnection *conn, struct btd_device *device,
 	return 0;
 }
 
-void monitor_unregister(DBusConnection *conn, struct btd_device *device)
+void monitor_unregister(struct btd_device *device)
 {
 	const char *path = device_get_path(device);
 
-	g_dbus_unregister_interface(conn, path, PROXIMITY_INTERFACE);
+	g_dbus_unregister_interface(get_dbus_connection(), path,
+							PROXIMITY_INTERFACE);
 }
diff --git a/profiles/proximity/monitor.h b/profiles/proximity/monitor.h
index b71363d..191b562 100644
--- a/profiles/proximity/monitor.h
+++ b/profiles/proximity/monitor.h
@@ -28,7 +28,7 @@ struct enabled {
 	gboolean findme;
 };
 
-int monitor_register(DBusConnection *conn, struct btd_device *device,
-		struct gatt_primary *linkloss, struct gatt_primary *txpower,
-		struct gatt_primary *immediate, struct enabled *enabled);
-void monitor_unregister(DBusConnection *conn, struct btd_device *device);
+int monitor_register(struct btd_device *device, struct gatt_primary *linkloss,
+		struct gatt_primary *txpower, struct gatt_primary *immediate,
+		struct enabled *enabled);
+void monitor_unregister(struct btd_device *device);
diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index de3770a..ff9fd0c 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -50,7 +50,6 @@
 #include "immalert.h"
 
 struct reporter_adapter {
-	DBusConnection *conn;
 	struct btd_adapter *adapter;
 	GSList *devices;
 };
@@ -198,7 +197,7 @@ static void unregister_reporter_device(gpointer data, gpointer user_data)
 
 	DBG("unregister on device %s", path);
 
-	g_dbus_unregister_interface(radapter->conn, path,
+	g_dbus_unregister_interface(get_dbus_connection(), path,
 					PROXIMITY_REPORTER_INTERFACE);
 
 	radapter->devices = g_slist_remove(radapter->devices, device);
@@ -212,7 +211,7 @@ static void register_reporter_device(struct btd_device *device,
 
 	DBG("register on device %s", path);
 
-	g_dbus_register_interface(radapter->conn, path,
+	g_dbus_register_interface(get_dbus_connection(), path,
 					PROXIMITY_REPORTER_INTERFACE,
 					reporter_methods, reporter_signals,
 					NULL, device, NULL);
@@ -257,24 +256,18 @@ static struct btd_device_driver reporter_device_driver = {
 int reporter_adapter_probe(struct btd_adapter *adapter)
 {
 	struct reporter_adapter *radapter;
-	DBusConnection *conn;
 
 	if (!main_opts.gatt_enabled) {
 		DBG("GATT is disabled");
 		return -ENOTSUP;
 	}
 
-	conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-	if (!conn)
-		return -1;
-
 	radapter = g_new0(struct reporter_adapter, 1);
 	radapter->adapter = adapter;
-	radapter->conn = conn;
 
-	link_loss_register(adapter, radapter->conn);
+	link_loss_register(adapter);
 	register_tx_power(adapter);
-	imm_alert_register(adapter, radapter->conn);
+	imm_alert_register(adapter);
 
 	btd_register_device_driver(&reporter_device_driver);
 
@@ -297,7 +290,6 @@ void reporter_adapter_remove(struct btd_adapter *adapter)
 
 	link_loss_unregister(adapter);
 	imm_alert_unregister(adapter);
-	dbus_connection_unref(radapter->conn);
 
 	reporter_adapters = g_slist_remove(reporter_adapters, radapter);
 	g_free(radapter);
-- 
1.7.11.3

