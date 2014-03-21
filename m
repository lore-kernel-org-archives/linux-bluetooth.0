Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v6 10/10] tools: Emit property changed when Value changes
Date: Fri, 21 Mar 2014 11:58:50 -0300
Message-Id: <1395413930-18292-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395413930-18292-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395174391-27251-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395413930-18292-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch extends gatt-service tool, emitting PropertiesChanged for
"Value" when a new value is set. This flow represents the handling of
ATT Write Command or Write Request which is translated to a GDBusProxy
set property. PropertiesChanged will be tracked by the characteristic
GDBusProxy in order to detect "Value" changes.
---
 tools/gatt-service.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index ad5399b..8dbecce 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -47,9 +47,11 @@
 
 static GMainLoop *main_loop;
 static GSList *services;
+static DBusConnection *connection;
 
 struct characteristic {
 	char *uuid;
+	char *path;
 	uint8_t *value;
 	int vlen;
 };
@@ -110,6 +112,8 @@ static void chr_set_value(const GDBusPropertyTable *property,
 	chr->vlen = len;
 
 	g_dbus_pending_property_success(id);
+	g_dbus_emit_property_changed(connection, chr->path,
+						GATT_CHR_IFACE, "Value");
 }
 
 static const GDBusPropertyTable chr_properties[] = {
@@ -163,6 +167,7 @@ static void chr_iface_destroy(gpointer user_data)
 
 	g_free(chr->uuid);
 	g_free(chr->value);
+	g_free(chr->path);
 	g_free(chr);
 }
 
@@ -182,6 +187,7 @@ static int register_characteristic(DBusConnection *conn, const char *uuid,
 	chr->uuid = g_strdup(uuid);
 	chr->value = g_memdup(value, vlen);
 	chr->vlen = vlen;
+	chr->path = path;
 
 	if (g_dbus_register_interface(conn, path, GATT_CHR_IFACE,
 					NULL, NULL, chr_properties,
@@ -190,18 +196,16 @@ static int register_characteristic(DBusConnection *conn, const char *uuid,
 		ret = -EIO;
 	}
 
-	g_free(path);
-
 	return ret;
 }
 
-static char *register_service(DBusConnection *conn, const char *uuid)
+static char *register_service(const char *uuid)
 {
 	static int id = 1;
 	char *path;
 
 	path = g_strdup_printf("/service%d", id++);
-	if (g_dbus_register_interface(conn, path, GATT_SERVICE_IFACE,
+	if (g_dbus_register_interface(connection, path, GATT_SERVICE_IFACE,
 				NULL, NULL, service_properties,
 				g_strdup(uuid), g_free) == FALSE) {
 		printf("Couldn't register service interface\n");
@@ -212,13 +216,13 @@ static char *register_service(DBusConnection *conn, const char *uuid)
 	return path;
 }
 
-static void create_services(DBusConnection *conn)
+static void create_services()
 {
 	char *service_path;
 	uint8_t level = 0;
 	int ret;
 
-	service_path = register_service(conn, IAS_UUID);
+	service_path = register_service(IAS_UUID);
 	if (service_path == NULL)
 		return;
 
@@ -226,11 +230,11 @@ static void create_services(DBusConnection *conn)
 	 * According to the IAS SPEC, reading <<Alert level>> is not alloweed.
 	 * "Value" is readable for testing purpose only.
 	 */
-	ret = register_characteristic(conn, ALERT_LEVEL_CHR_UUID, &level,
+	ret = register_characteristic(connection, ALERT_LEVEL_CHR_UUID, &level,
 						sizeof(level), service_path);
 	if (ret < 0) {
 		printf("Couldn't register Alert Level characteristic (IAS)\n");
-		g_dbus_unregister_interface(conn, service_path,
+		g_dbus_unregister_interface(connection, service_path,
 							GATT_SERVICE_IFACE);
 		g_free(service_path);
 		return;
@@ -371,25 +375,24 @@ static guint setup_signalfd(void)
 int main(int argc, char *argv[])
 {
 	GDBusClient *client;
-	DBusConnection *dbus_conn;
 	guint signal;
 
 	signal = setup_signalfd();
 	if (signal == 0)
 		return -errno;
 
-	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
+	connection = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
 
 	main_loop = g_main_loop_new(NULL, FALSE);
 
-	g_dbus_attach_object_manager(dbus_conn);
+	g_dbus_attach_object_manager(connection);
 
 	printf("gatt-service unique name: %s\n",
-				dbus_bus_get_unique_name(dbus_conn));
+				dbus_bus_get_unique_name(connection));
 
-	create_services(dbus_conn);
+	create_services();
 
-	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
+	client = g_dbus_client_new(connection, "org.bluez", "/org/bluez");
 
 	g_dbus_client_set_connect_watch(client, connect_handler, NULL);
 
@@ -400,7 +403,7 @@ int main(int argc, char *argv[])
 	g_source_remove(signal);
 
 	g_slist_free_full(services, g_free);
-	dbus_connection_unref(dbus_conn);
+	dbus_connection_unref(connection);
 
 	return 0;
 }
-- 
1.8.3.1

