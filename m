Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 1/4] gatt: Fix coding style when testing pointers
Date: Fri, 21 Mar 2014 16:20:30 -0300
Message-Id: <1395429633-656-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use !ptr instead of ptr == NULL
---
 src/gatt-dbus.c | 10 +++++-----
 src/gatt.c      |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 3c3b54c..896accf 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -284,7 +284,7 @@ static int register_external_service(const struct external_app *eapp,
 	if (bt_string_to_uuid(&uuid, str) < 0)
 		return -EINVAL;
 
-	if (btd_gatt_add_service(&uuid) == NULL)
+	if (!btd_gatt_add_service(&uuid))
 		return -EINVAL;
 
 	return 0;
@@ -321,7 +321,7 @@ static int register_external_characteristics(GSList *proxies)
 
 		attr = btd_gatt_add_char(&uuid, 0x00, proxy_read_cb,
 							proxy_write_cb);
-		if (attr == NULL)
+		if (!attr)
 			return -EINVAL;
 
 		path = g_dbus_proxy_get_path(proxy);
@@ -340,7 +340,7 @@ static void client_ready(GDBusClient *client, void *user_data)
 	DBusConnection *conn = btd_get_dbus_connection();
 	DBusMessage *reply;
 
-	if (eapp->proxies == NULL)
+	if (!eapp->proxies)
 		goto fail;
 
 	proxy = eapp->proxies->data;
@@ -376,7 +376,7 @@ static struct external_app *new_external_app(DBusConnection *conn,
 	const char *sender = dbus_message_get_sender(msg);
 
 	client = g_dbus_client_new(conn, sender, "/");
-	if (client == NULL)
+	if (!client)
 		return NULL;
 
 	eapp = g_new0(struct external_app, 1);
@@ -421,7 +421,7 @@ static DBusMessage *register_service(DBusConnection *conn,
 		return btd_error_already_exists(msg);
 
 	eapp = new_external_app(conn, msg, path);
-	if (eapp == NULL)
+	if (!eapp)
 		return btd_error_failed(msg, "Not enough resources");
 
 	external_apps = g_slist_prepend(external_apps, eapp);
diff --git a/src/gatt.c b/src/gatt.c
index 45b5e26..92092d3 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -77,7 +77,7 @@ static struct btd_attribute *new_const_attribute(const bt_uuid_t *type,
 	struct btd_attribute *attr;
 
 	attr = malloc0(sizeof(struct btd_attribute) + len);
-	if (attr == NULL)
+	if (!attr)
 		return NULL;
 
 	attr->type = *type;
@@ -118,7 +118,7 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
 	put_uuid_le(uuid, value);
 
 	attr = new_const_attribute(&primary_uuid, value, len);
-	if (attr == NULL)
+	if (!attr)
 		return NULL;
 
 	if (local_database_add(next_handle, attr) < 0) {
@@ -167,11 +167,11 @@ struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
 	put_uuid_le(uuid, &value[3]);
 
 	char_decl = new_const_attribute(&chr_uuid, value, len);
-	if (char_decl == NULL)
+	if (!char_decl)
 		goto fail;
 
 	char_value = new0(struct btd_attribute, 1);
-	if (char_value == NULL)
+	if (!char_value)
 		goto fail;
 
 	if (local_database_add(next_handle, char_decl) < 0)
-- 
1.8.3.1

