Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH BlueZ v0 4/5] test: Add permissions for Alert Level of gatt-service
Date: Thu, 27 Mar 2014 10:21:14 -0300
Message-Id: <1395926475-8841-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395926475-8841-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395926475-8841-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alvaro Silva <alvaro.silva@openbossa.org>

This patch adds properties to Alert Level characteristic of the
Immediate Alert Service. IAS specification defines Write Without
Response as mandatory.
---
 tools/gatt-service.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index 624b835..e319163 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -54,8 +54,18 @@ struct characteristic {
 	char *path;
 	uint8_t *value;
 	int vlen;
+	const char **props;
 };
 
+/*
+ * Alert Level support Write Without Response only. Supported
+ * properties are defined at doc/gatt-api.txt. See "Flags"
+ * property of the GattCharacteristic1.
+ */
+static const char const *ias_alert_level_props[] = {
+						"write-without-response",
+						NULL };
+
 static gboolean chr_get_uuid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -85,6 +95,25 @@ static gboolean chr_get_value(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean chr_get_props(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct characteristic *chr = data;
+	DBusMessageIter array;
+	int i;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &array);
+
+	for (i = 0; chr->props[i]; i++)
+		dbus_message_iter_append_basic(&array,
+					DBUS_TYPE_STRING, &chr->props[i]);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
 static void chr_set_value(const GDBusPropertyTable *property,
 				DBusMessageIter *iter,
 				GDBusPendingPropertySet id, void *user_data)
@@ -119,6 +148,7 @@ static void chr_set_value(const GDBusPropertyTable *property,
 static const GDBusPropertyTable chr_properties[] = {
 	{ "UUID",	"s",	chr_get_uuid },
 	{ "Value", "ay", chr_get_value, chr_set_value, NULL },
+	{ "Flags", "as", chr_get_props, NULL, NULL },
 	{ }
 };
 
@@ -173,6 +203,7 @@ static void chr_iface_destroy(gpointer user_data)
 
 static gboolean register_characteristic(DBusConnection *conn, const char *uuid,
 						const uint8_t *value, int vlen,
+						const char **props,
 						const char *service_path)
 {
 	struct characteristic *chr;
@@ -188,6 +219,7 @@ static gboolean register_characteristic(DBusConnection *conn, const char *uuid,
 	chr->value = g_memdup(value, vlen);
 	chr->vlen = vlen;
 	chr->path = path;
+	chr->props = props;
 
 	if (!g_dbus_register_interface(conn, path, GATT_CHR_IFACE,
 					NULL, NULL, chr_properties,
@@ -225,12 +257,11 @@ static void create_services()
 	if (!service_path)
 		return;
 
-	/* Add Alert Level Characteristic to Immediate Alert Service
-	 * According to the IAS SPEC, reading <<Alert level>> is not allowed.
-	 * "Value" is readable for testing purpose only.
-	 */
-	if (!register_characteristic(connection, ALERT_LEVEL_CHR_UUID, &level,
-						sizeof(level), service_path)) {
+	/* Add Alert Level Characteristic to Immediate Alert Service */
+	if (!register_characteristic(connection, ALERT_LEVEL_CHR_UUID,
+						&level, sizeof(level),
+						ias_alert_level_props,
+						service_path)) {
 		printf("Couldn't register Alert Level characteristic (IAS)\n");
 		g_dbus_unregister_interface(connection, service_path,
 							GATT_SERVICE_IFACE);
-- 
1.8.3.1

