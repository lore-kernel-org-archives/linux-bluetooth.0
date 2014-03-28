Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 4/5] tools: Add Get/Set descriptor
Date: Fri, 28 Mar 2014 11:19:09 -0300
Message-Id: <1396016350-16943-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1396016350-16943-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1396016350-16943-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds get and set callbacks to allow managing "Value" property
of the user defined descriptor related to IAS Alert Level.
---
 tools/gatt-service.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 5 deletions(-)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index 707b659..c304b60 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -61,6 +61,12 @@ struct characteristic {
 	const char **props;
 };
 
+struct descriptor {
+	char *uuid;
+	uint8_t *value;
+	int vlen;
+};
+
 /*
  * Alert Level support Write Without Response only. Supported
  * properties are defined at doc/gatt-api.txt. See "Flags"
@@ -73,15 +79,57 @@ static const char const *ias_alert_level_props[] = {
 static gboolean desc_get_uuid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
-	const char *uuid = user_data;
+	struct descriptor *desc = user_data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &desc->uuid);
+
+	return TRUE;
+}
+
+static gboolean desc_get_value(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct descriptor *desc = user_data;
+	DBusMessageIter array;
+
+	printf("Descriptor(%s): Get(\"Value\")\n", desc->uuid);
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+
+	if (desc->vlen && desc->value)
+		dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+						&desc->value, desc->vlen);
+
+	dbus_message_iter_close_container(iter, &array);
 
 	return TRUE;
 }
 
+static void desc_set_value(const GDBusPropertyTable *property,
+				DBusMessageIter *iter,
+				GDBusPendingPropertySet id, void *user_data)
+{
+	struct descriptor *desc = user_data;
+	DBusMessageIter array;
+	const uint8_t *value;
+	int vlen;
+
+	printf("Descriptor(%s): Set(\"Value\", ...)\n", desc->uuid);
+
+	dbus_message_iter_recurse(iter, &array);
+	dbus_message_iter_get_fixed_array(&array, &value, &vlen);
+
+	g_free(desc->value);
+	desc->value = g_memdup(value, vlen);
+	desc->vlen = vlen;
+
+	g_dbus_pending_property_success(id);
+}
+
 static const GDBusPropertyTable desc_properties[] = {
 	{ "UUID",		"s",	desc_get_uuid },
+	{ "Value",		"ay",	desc_get_value, desc_set_value, NULL },
 	{ }
 };
 
@@ -101,7 +149,7 @@ static gboolean chr_get_value(const GDBusPropertyTable *property,
 	struct characteristic *chr = user_data;
 	DBusMessageIter array;
 
-	printf("Get(\"Value\")\n");
+	printf("Characteristic(%s): Get(\"Value\")\n", chr->uuid);
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 					DBUS_TYPE_BYTE_AS_STRING, &array);
@@ -142,7 +190,7 @@ static void chr_set_value(const GDBusPropertyTable *property,
 	uint8_t *value;
 	int len;
 
-	printf("Set('Value', ...)\n");
+	printf("Characteristic(%s): Set('Value', ...)\n", chr->uuid);
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY) {
 		printf("Invalid value for Set('Value'...)\n");
@@ -220,6 +268,15 @@ static void chr_iface_destroy(gpointer user_data)
 	g_free(chr);
 }
 
+static void desc_iface_destroy(gpointer user_data)
+{
+	struct descriptor *desc = user_data;
+
+	g_free(desc->uuid);
+	g_free(desc->value);
+	g_free(desc);
+}
+
 static gboolean register_characteristic(const char *chr_uuid,
 						const uint8_t *value, int vlen,
 						const char **props,
@@ -227,6 +284,7 @@ static gboolean register_characteristic(const char *chr_uuid,
 						const char *service_path)
 {
 	struct characteristic *chr;
+	struct descriptor *desc;
 	static int id = 1;
 	char *chr_path, *desc_path;
 	gboolean ret = TRUE;
@@ -251,15 +309,20 @@ static gboolean register_characteristic(const char *chr_uuid,
 	if (!desc_uuid)
 		return ret;
 
+	desc = g_new0(struct descriptor, 1);
+	desc->uuid = g_strdup(desc_uuid);
+
 	desc_path = g_strdup_printf("%s/descriptor%d", chr_path, id++);
 	if (!g_dbus_register_interface(connection, desc_path,
 					GATT_DESCRIPTOR_IFACE,
 					NULL, NULL, desc_properties,
-					g_strdup(desc_uuid), g_free)) {
+					desc, desc_iface_destroy)) {
 		printf("Couldn't register descriptor interface\n");
 		g_dbus_unregister_interface(connection, chr_path,
 							GATT_CHR_IFACE);
 		g_free(desc_path);
+		desc_iface_destroy(desc);
+
 		ret = FALSE;
 	}
 
-- 
1.8.3.1

