Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 3/5] tools: Add testing descriptor for IAS Alert Level
Date: Fri, 28 Mar 2014 11:19:08 -0300
Message-Id: <1396016350-16943-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1396016350-16943-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1396016350-16943-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a testing purpose only characteristic descriptor to
allow reading and writing descriptors "Value" property.
---
 tools/gatt-service.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index e319163..707b659 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -40,11 +40,15 @@
 #define GATT_MGR_IFACE			"org.bluez.GattManager1"
 #define GATT_SERVICE_IFACE		"org.bluez.GattService1"
 #define GATT_CHR_IFACE			"org.bluez.GattCharacteristic1"
+#define GATT_DESCRIPTOR_IFACE		"org.bluez.GattDescriptor1"
 
 /* Immediate Alert Service UUID */
 #define IAS_UUID			"00001802-0000-1000-8000-00805f9b34fb"
 #define ALERT_LEVEL_CHR_UUID		"00002a06-0000-1000-8000-00805f9b34fb"
 
+/* Random UUID for testing purpose */
+#define READ_WRITE_DESCRIPTOR_UUID	"8260c653-1a54-426b-9e36-e84c238bc669"
+
 static GMainLoop *main_loop;
 static GSList *services;
 static DBusConnection *connection;
@@ -66,6 +70,21 @@ static const char const *ias_alert_level_props[] = {
 						"write-without-response",
 						NULL };
 
+static gboolean desc_get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	const char *uuid = user_data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable desc_properties[] = {
+	{ "UUID",		"s",	desc_get_uuid },
+	{ }
+};
+
 static gboolean chr_get_uuid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -201,30 +220,46 @@ static void chr_iface_destroy(gpointer user_data)
 	g_free(chr);
 }
 
-static gboolean register_characteristic(DBusConnection *conn, const char *uuid,
+static gboolean register_characteristic(const char *chr_uuid,
 						const uint8_t *value, int vlen,
 						const char **props,
+						const char *desc_uuid,
 						const char *service_path)
 {
 	struct characteristic *chr;
 	static int id = 1;
-	char *path;
+	char *chr_path, *desc_path;
 	gboolean ret = TRUE;
 
-	path = g_strdup_printf("%s/characteristic%d", service_path, id++);
+	chr_path = g_strdup_printf("%s/characteristic%d", service_path, id++);
 
 	chr = g_new0(struct characteristic, 1);
 
-	chr->uuid = g_strdup(uuid);
+	chr->uuid = g_strdup(chr_uuid);
 	chr->value = g_memdup(value, vlen);
 	chr->vlen = vlen;
-	chr->path = path;
+	chr->path = chr_path;
 	chr->props = props;
 
-	if (!g_dbus_register_interface(conn, path, GATT_CHR_IFACE,
+	if (!g_dbus_register_interface(connection, chr_path, GATT_CHR_IFACE,
 					NULL, NULL, chr_properties,
 					chr, chr_iface_destroy)) {
 		printf("Couldn't register characteristic interface\n");
+		return FALSE;
+	}
+
+	if (!desc_uuid)
+		return ret;
+
+	desc_path = g_strdup_printf("%s/descriptor%d", chr_path, id++);
+	if (!g_dbus_register_interface(connection, desc_path,
+					GATT_DESCRIPTOR_IFACE,
+					NULL, NULL, desc_properties,
+					g_strdup(desc_uuid), g_free)) {
+		printf("Couldn't register descriptor interface\n");
+		g_dbus_unregister_interface(connection, chr_path,
+							GATT_CHR_IFACE);
+		g_free(desc_path);
 		ret = FALSE;
 	}
 
@@ -258,9 +293,10 @@ static void create_services()
 		return;
 
 	/* Add Alert Level Characteristic to Immediate Alert Service */
-	if (!register_characteristic(connection, ALERT_LEVEL_CHR_UUID,
+	if (!register_characteristic(ALERT_LEVEL_CHR_UUID,
 						&level, sizeof(level),
 						ias_alert_level_props,
+						READ_WRITE_DESCRIPTOR_UUID,
 						service_path)) {
 		printf("Couldn't register Alert Level characteristic (IAS)\n");
 		g_dbus_unregister_interface(connection, service_path,
-- 
1.8.3.1

