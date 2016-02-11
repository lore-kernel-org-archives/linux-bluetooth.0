Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] tools/gatt-service: Add missing properties
Date: Thu, 11 Feb 2016 13:44:40 +0200
Message-Id: <1455191081-24550-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1455191081-24550-1-git-send-email-luiz.dentz@gmail.com>
References: <1455191081-24550-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the missing properties necessary to be able to register.
---
 tools/gatt-service.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 5 deletions(-)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index 74f934e..80980f7 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -55,6 +55,7 @@ static GSList *services;
 static DBusConnection *connection;
 
 struct characteristic {
+	char *service;
 	char *uuid;
 	char *path;
 	uint8_t *value;
@@ -63,10 +64,12 @@ struct characteristic {
 };
 
 struct descriptor {
+	struct characteristic *chr;
 	char *uuid;
 	char *path;
 	uint8_t *value;
 	int vlen;
+	const char **props;
 };
 
 /*
@@ -75,6 +78,7 @@ struct descriptor {
  * property of the GattCharacteristic1.
  */
 static const char *ias_alert_level_props[] = { "write-without-response", NULL };
+static const char *desc_props[] = { "read", "write", NULL };
 
 static gboolean desc_get_uuid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
@@ -86,6 +90,17 @@ static gboolean desc_get_uuid(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean desc_get_characteristic(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct descriptor *desc = user_data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH,
+						&desc->chr->path);
+
+	return TRUE;
+}
+
 static gboolean desc_get_value(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -131,9 +146,30 @@ static void desc_set_value(const GDBusPropertyTable *property,
 
 }
 
+static gboolean desc_get_props(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct descriptor *desc = data;
+	DBusMessageIter array;
+	int i;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &array);
+
+	for (i = 0; desc->props[i]; i++)
+		dbus_message_iter_append_basic(&array,
+					DBUS_TYPE_STRING, &desc->props[i]);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable desc_properties[] = {
-	{ "UUID",		"s",	desc_get_uuid },
-	{ "Value",		"ay",	desc_get_value, desc_set_value, NULL },
+	{ "UUID",		"s", desc_get_uuid },
+	{ "Characteristic",	"o", desc_get_characteristic },
+	{ "Value",		"ay", desc_get_value, desc_set_value, NULL },
+	{ "Flags",		"as", desc_get_props, NULL, NULL },
 	{ }
 };
 
@@ -147,6 +183,17 @@ static gboolean chr_get_uuid(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean chr_get_service(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct characteristic *chr = user_data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH,
+							&chr->service);
+
+	return TRUE;
+}
+
 static gboolean chr_get_value(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -217,12 +264,25 @@ static void chr_set_value(const GDBusPropertyTable *property,
 }
 
 static const GDBusPropertyTable chr_properties[] = {
-	{ "UUID",	"s",	chr_get_uuid },
-	{ "Value", "ay", chr_get_value, chr_set_value, NULL },
-	{ "Flags", "as", chr_get_props, NULL, NULL },
+	{ "UUID",	"s", chr_get_uuid },
+	{ "Service",	"o", chr_get_service },
+	{ "Value",	"ay", chr_get_value, chr_set_value, NULL },
+	{ "Flags",	"as", chr_get_props, NULL, NULL },
 	{ }
 };
 
+static gboolean service_get_primary(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	dbus_bool_t primary = TRUE;
+
+	printf("Get Primary: %s\n", primary ? "True" : "False");
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &primary);
+
+	return TRUE;
+}
+
 static gboolean service_get_uuid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -256,6 +316,7 @@ static gboolean service_exist_includes(const GDBusPropertyTable *property,
 }
 
 static const GDBusPropertyTable service_properties[] = {
+	{ "Primary", "b", service_get_primary },
 	{ "UUID", "s", service_get_uuid },
 	{ "Includes", "ao", service_get_includes, NULL,
 					service_exist_includes },
@@ -267,6 +328,7 @@ static void chr_iface_destroy(gpointer user_data)
 	struct characteristic *chr = user_data;
 
 	g_free(chr->uuid);
+	g_free(chr->service);
 	g_free(chr->value);
 	g_free(chr->path);
 	g_free(chr);
@@ -286,6 +348,7 @@ static gboolean register_characteristic(const char *chr_uuid,
 						const uint8_t *value, int vlen,
 						const char **props,
 						const char *desc_uuid,
+						const char **desc_props,
 						const char *service_path)
 {
 	struct characteristic *chr;
@@ -297,6 +360,7 @@ static gboolean register_characteristic(const char *chr_uuid,
 	chr->value = g_memdup(value, vlen);
 	chr->vlen = vlen;
 	chr->props = props;
+	chr->service = g_strdup(service_path);
 	chr->path = g_strdup_printf("%s/characteristic%d", service_path, id++);
 
 	if (!g_dbus_register_interface(connection, chr->path, GATT_CHR_IFACE,
@@ -312,6 +376,8 @@ static gboolean register_characteristic(const char *chr_uuid,
 
 	desc = g_new0(struct descriptor, 1);
 	desc->uuid = g_strdup(desc_uuid);
+	desc->chr = chr;
+	desc->props = desc_props;
 	desc->path = g_strdup_printf("%s/descriptor%d", chr->path, id++);
 
 	if (!g_dbus_register_interface(connection, desc->path,
@@ -360,6 +426,7 @@ static void create_services()
 						&level, sizeof(level),
 						ias_alert_level_props,
 						READ_WRITE_DESCRIPTOR_UUID,
+						desc_props,
 						service_path)) {
 		printf("Couldn't register Alert Level characteristic (IAS)\n");
 		g_dbus_unregister_interface(connection, service_path,
-- 
2.5.0

