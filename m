Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH BlueZ 5/5] Use device object path on Proximity Monitor
Date: Tue, 26 Jul 2011 13:53:16 -0300
Message-Id: <1311699196-16472-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1311699196-16472-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1311699196-16472-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sheldon Demario <sheldon.demario@openbossa.org>

---
 proximity/manager.c |   11 ++---------
 proximity/monitor.c |   48 +++++++++++++++++++++++++++---------------------
 proximity/monitor.h |    4 ++--
 3 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/proximity/manager.c b/proximity/manager.c
index f49d066..8d0aee1 100644
--- a/proximity/manager.c
+++ b/proximity/manager.c
@@ -41,11 +41,12 @@ static DBusConnection *connection = NULL;
 
 static int attio_device_probe(struct btd_device *device, GSList *uuids)
 {
-	return 0;
+	return monitor_register(connection, device);
 }
 
 static void attio_device_remove(struct btd_device *device)
 {
+	monitor_unregister(connection, device);
 }
 
 static struct btd_device_driver monitor_driver = {
@@ -67,20 +68,12 @@ int proximity_manager_init(DBusConnection *conn)
 
 	connection = dbus_connection_ref(conn);
 
-	ret = monitor_register(connection);
-
-	if (ret < 0) {
-		dbus_connection_unref(connection);
-		return ret;
-	}
-
 	return reporter_init();
 }
 
 void proximity_manager_exit(void)
 {
 	reporter_exit();
-	monitor_unregister(connection);
 	btd_unregister_device_driver(&monitor_driver);
 	dbus_connection_unref(connection);
 }
diff --git a/proximity/monitor.c b/proximity/monitor.c
index 8bcd4a3..8465f92 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -37,16 +37,17 @@
 #include <bluetooth/bluetooth.h>
 
 #include "dbus-common.h"
+#include "adapter.h"
+#include "device.h"
 #include "error.h"
 #include "log.h"
-
 #include "monitor.h"
 #include "textfile.h"
 
 #define PROXIMITY_INTERFACE "org.bluez.Proximity"
-#define PROXIMITY_PATH "/org/bluez/proximity"
 
 struct monitor {
+	struct btd_device *device;
 	char *linklosslevel;		/* Link Loss Alert Level */
 };
 
@@ -93,6 +94,8 @@ static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 						const char *level, void *data)
 {
 	struct monitor *monitor = data;
+	struct btd_device *device = monitor->device;
+	const char *path = device_get_path(device);
 	bdaddr_t sba, dba;
 
 	if (!g_str_equal("none", level) && !g_str_equal("mild", level) &&
@@ -105,12 +108,12 @@ static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 	g_free(monitor->linklosslevel);
 	monitor->linklosslevel = g_strdup(level);
 
-	/* FIXME: using hardcoded values */
-	bacpy(&sba, BDADDR_ANY);
-	bacpy(&dba, BDADDR_ALL);
+	adapter_get_address(device_get_adapter(device), &sba);
+	device_get_address(device, &dba);
+
 	write_proximity_config(&sba, &dba, "LinkLossAlertLevel", level);
 
-	emit_property_changed(conn, PROXIMITY_PATH,
+	emit_property_changed(conn, path,
 				PROXIMITY_INTERFACE, "LinkLossAlertLevel",
 				DBUS_TYPE_STRING, &monitor->linklosslevel);
 
@@ -193,42 +196,45 @@ static void monitor_destroy(gpointer user_data)
 {
 	struct monitor *monitor = user_data;
 
+	btd_device_unref(monitor->device);
 	g_free(monitor->linklosslevel);
 	g_free(monitor);
 }
 
-int monitor_register(DBusConnection *conn)
+int monitor_register(DBusConnection *conn, struct btd_device *device)
 {
+	const char *path = device_get_path(device);
 	struct monitor *monitor;
 	bdaddr_t sba, dba;
 	char *level;
-	int ret = -1;
 
-	/* FIXME: using hardcoded values */
-	bacpy(&sba, BDADDR_ANY);
-	bacpy(&dba, BDADDR_ALL);
+	adapter_get_address(device_get_adapter(device), &sba);
+	device_get_address(device, &dba);
 
 	level = read_proximity_config(&sba, &dba, "LinkLossAlertLevel");
 
 	monitor = g_new0(struct monitor, 1);
+	monitor->device = btd_device_ref(device);
 	monitor->linklosslevel = (level ? : g_strdup("none"));
 
-	if (g_dbus_register_interface(conn, PROXIMITY_PATH,
+	if (g_dbus_register_interface(conn, path,
 				PROXIMITY_INTERFACE,
 				monitor_methods, monitor_signals,
-				NULL, monitor, monitor_destroy) == TRUE) {
-		DBG("Registered interface %s on path %s", PROXIMITY_INTERFACE,
-							PROXIMITY_PATH);
-		ret = 0;
-
+				NULL, monitor, monitor_destroy) == FALSE) {
+		error("D-Bus failed to register %s interface",
+						PROXIMITY_INTERFACE);
+		monitor_destroy(monitor);
+		return -1;
 	}
 
-	error("D-Bus failed to register %s interface", PROXIMITY_INTERFACE);
+	DBG("Registered interface %s on path %s", PROXIMITY_INTERFACE, path);
 
-	return ret;
+	return 0;
 }
 
-void monitor_unregister(DBusConnection *conn)
+void monitor_unregister(DBusConnection *conn, struct btd_device *device)
 {
-	g_dbus_unregister_interface(conn, PROXIMITY_PATH, PROXIMITY_INTERFACE);
+	const char *path = device_get_path(device);
+
+	g_dbus_unregister_interface(conn, path, PROXIMITY_INTERFACE);
 }
diff --git a/proximity/monitor.h b/proximity/monitor.h
index d4913ac..5c6ebf6 100644
--- a/proximity/monitor.h
+++ b/proximity/monitor.h
@@ -22,5 +22,5 @@
  *
  */
 
-int monitor_register(DBusConnection *conn);
-void monitor_unregister(DBusConnection *conn);
+int monitor_register(DBusConnection *conn, struct btd_device *device);
+void monitor_unregister(DBusConnection *conn, struct btd_device *device);
-- 
1.7.6

