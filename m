Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH BlueZ v7 08/10] tools: Add reading Value property of gatt-service
Date: Fri, 21 Mar 2014 16:16:41 -0300
Message-Id: <1395429403-493-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395429403-493-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395413930-18292-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395429403-493-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alvaro Silva <alvaro.silva@openbossa.org>

This patch extends the gatt-service.c example adding the callback to
allow reading the Value property. At the moment, it is a generic
callback and it doesn't consider characteristic value property
restrictions.
---
 tools/gatt-service.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index 6ae642c..aef1291 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -46,18 +46,44 @@
 static GMainLoop *main_loop;
 static GSList *services;
 
+struct characteristic {
+	char *uuid;
+	uint8_t *value;
+	int vlen;
+};
+
 static gboolean chr_get_uuid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
-	const char *uuid = user_data;
+	struct characteristic *chr = user_data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &chr->uuid);
+
+	return TRUE;
+}
+
+static gboolean chr_get_value(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct characteristic *chr = user_data;
+	DBusMessageIter array;
+
+	printf("Get(\"Value\")\n");
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+						&chr->value, chr->vlen);
+
+	dbus_message_iter_close_container(iter, &array);
 
 	return TRUE;
 }
 
 static const GDBusPropertyTable chr_properties[] = {
 	{ "UUID",	"s",	chr_get_uuid },
+	{ "Value", "ay", chr_get_value, NULL, NULL },
 	{ }
 };
 
@@ -100,18 +126,35 @@ static const GDBusPropertyTable service_properties[] = {
 	{ }
 };
 
+static void chr_iface_destroy(gpointer user_data)
+{
+	struct characteristic *chr = user_data;
+
+	g_free(chr->uuid);
+	g_free(chr->value);
+	g_free(chr);
+}
+
 static int register_characteristic(DBusConnection *conn, const char *uuid,
+						const uint8_t *value, int vlen,
 						const char *service_path)
 {
+	struct characteristic *chr;
 	static int id = 1;
 	char *path;
 	int ret = 0;
 
 	path = g_strdup_printf("%s/characteristic%d", service_path, id++);
 
+	chr = g_new0(struct characteristic, 1);
+
+	chr->uuid = g_strdup(uuid);
+	chr->value = g_memdup(value, vlen);
+	chr->vlen = vlen;
+
 	if (!g_dbus_register_interface(conn, path, GATT_CHR_IFACE,
 					NULL, NULL, chr_properties,
-					g_strdup(uuid), g_free)) {
+					chr, chr_iface_destroy)) {
 		printf("Couldn't register characteristic interface\n");
 		ret = -EIO;
 	}
@@ -141,15 +184,19 @@ static char *register_service(DBusConnection *conn, const char *uuid)
 static void create_services(DBusConnection *conn)
 {
 	char *service_path;
+	uint8_t level = 0;
 	int ret;
 
 	service_path = register_service(conn, IAS_UUID);
 	if (!service_path)
 		return;
 
-	/* Add Alert Level Characteristic to Immediate Alert Service */
-	ret = register_characteristic(conn, ALERT_LEVEL_CHR_UUID,
-							service_path);
+	/* Add Alert Level Characteristic to Immediate Alert Service
+	 * According to the IAS SPEC, reading <<Alert level>> is not alloweed.
+	 * "Value" is readable for testing purpose only.
+	 */
+	ret = register_characteristic(conn, ALERT_LEVEL_CHR_UUID, &level,
+						sizeof(level), service_path);
 	if (ret < 0) {
 		printf("Couldn't register Alert Level characteristic (IAS)\n");
 		g_dbus_unregister_interface(conn, service_path,
-- 
1.8.3.1

