Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH BlueZ v8 5/8] tools: Add Alert Level characteristic to gatt-service
Date: Mon, 24 Mar 2014 10:30:06 -0300
Message-Id: <1395667809-17602-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395667809-17602-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395429403-493-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395667809-17602-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alvaro Silva <alvaro.silva@openbossa.org>

This patch registers the Alert Level characteristic object related to
Immediate Alert Service. It adds the characteristic UUID property only.
---
 tools/gatt-service.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index ef479ed..56d6e86 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -37,13 +37,30 @@
 
 #define GATT_MGR_IFACE			"org.bluez.GattManager1"
 #define GATT_SERVICE_IFACE		"org.bluez.GattService1"
+#define GATT_CHR_IFACE			"org.bluez.GattCharacteristic1"
 
 /* Immediate Alert Service UUID */
 #define IAS_UUID			"00001802-0000-1000-8000-00805f9b34fb"
+#define ALERT_LEVEL_CHR_UUID		"00002a06-0000-1000-8000-00805f9b34fb"
 
 static GMainLoop *main_loop;
 static GSList *services;
 
+static gboolean chr_get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	const char *uuid = user_data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable chr_properties[] = {
+	{ "UUID",	"s",	chr_get_uuid },
+	{ }
+};
+
 static gboolean service_get_uuid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -83,6 +100,27 @@ static const GDBusPropertyTable service_properties[] = {
 	{ }
 };
 
+static gboolean register_characteristic(DBusConnection *conn, const char *uuid,
+						const char *service_path)
+{
+	static int id = 1;
+	char *path;
+	gboolean ret = TRUE;
+
+	path = g_strdup_printf("%s/characteristic%d", service_path, id++);
+
+	if (!g_dbus_register_interface(conn, path, GATT_CHR_IFACE,
+					NULL, NULL, chr_properties,
+					g_strdup(uuid), g_free)) {
+		printf("Couldn't register characteristic interface\n");
+		ret = FALSE;
+	}
+
+	g_free(path);
+
+	return ret;
+}
+
 static char *register_service(DBusConnection *conn, const char *uuid)
 {
 	static int id = 1;
@@ -105,9 +143,20 @@ static void create_services(DBusConnection *conn)
 	char *service_path;
 
 	service_path = register_service(conn, IAS_UUID);
+	if (!service_path)
+		return;
 
-	services = g_slist_prepend(services, service_path);
+	/* Add Alert Level Characteristic to Immediate Alert Service */
+	if (!register_characteristic(conn, ALERT_LEVEL_CHR_UUID,
+							service_path)) {
+		printf("Couldn't register Alert Level characteristic (IAS)\n");
+		g_dbus_unregister_interface(conn, service_path,
+							GATT_SERVICE_IFACE);
+		g_free(service_path);
+		return;
+	}
 
+	services = g_slist_prepend(services, service_path);
 	printf("Registered service: %s\n", service_path);
 }
 
-- 
1.8.3.1

