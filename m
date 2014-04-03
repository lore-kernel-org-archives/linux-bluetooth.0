Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] gatt: Use attribute's handles instead of btd_attribute in gatt API
Date: Thu,  3 Apr 2014 08:31:55 +0200
Message-Id: <1396506715-21949-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1396506715-21949-1-git-send-email-marcin.kraglak@tieto.com>
References: <1396506715-21949-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Attribute's handle can be used as key in gatt API instead of struct
btd_attribute.
---
 src/gatt-dbus.c | 29 ++++++++++++++++-------------
 src/gatt.c      | 22 +++++++++++-----------
 src/gatt.h      | 42 +++++++++++++++++++++---------------------
 3 files changed, 48 insertions(+), 45 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 1bfa21f..5d7e6e4 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -205,7 +205,7 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 	eapp->proxies = g_slist_remove(eapp->proxies, proxy);
 }
 
-static void proxy_read_cb(struct btd_attribute *attr,
+static void proxy_read_cb(uint16_t attr_handle,
 				btd_attr_read_result_t result, void *user_data)
 {
 	DBusMessageIter iter, array;
@@ -219,7 +219,7 @@ static void proxy_read_cb(struct btd_attribute *attr,
 	 * properties changes automatically, it is not necessary to
 	 * get the value directly from the GATT server.
 	 */
-	proxy = g_hash_table_lookup(proxy_hash, attr);
+	proxy = g_hash_table_lookup(proxy_hash, GINT_TO_POINTER(attr_handle));
 	if (!proxy) {
 		result(-ENOENT, NULL, 0, user_data);
 		return;
@@ -240,7 +240,7 @@ static void proxy_read_cb(struct btd_attribute *attr,
 	dbus_message_iter_recurse(&iter, &array);
 	dbus_message_iter_get_fixed_array(&array, &value, &len);
 
-	DBG("attribute: %p read %d bytes", attr, len);
+	DBG("attribute: %d read %d bytes", attr_handle, len);
 
 	result(0, value, len, user_data);
 }
@@ -275,14 +275,14 @@ done:
 		wdata->result_cb(err, wdata->user_data);
 }
 
-static void proxy_write_cb(struct btd_attribute *attr,
+static void proxy_write_cb(uint16_t attr_handle,
 					const uint8_t *value, size_t len,
 					btd_attr_write_result_t result,
 					void *user_data)
 {
 	GDBusProxy *proxy;
 
-	proxy = g_hash_table_lookup(proxy_hash, attr);
+	proxy = g_hash_table_lookup(proxy_hash, GINT_TO_POINTER(attr_handle));
 	if (!proxy) {
 		result(-ENOENT, user_data);
 		return;
@@ -356,7 +356,7 @@ static int register_external_service(const struct external_app *eapp,
 static int add_char(GDBusProxy *proxy, const bt_uuid_t *uuid)
 {
 	DBusMessageIter iter;
-	struct btd_attribute *attr;
+	uint16_t attr_handle;
 	btd_attr_write_t write_cb;
 	btd_attr_read_t read_cb;
 	uint8_t propmask = 0;
@@ -385,24 +385,27 @@ static int add_char(GDBusProxy *proxy, const bt_uuid_t *uuid)
 	else
 		write_cb = NULL;
 
-	attr = btd_gatt_add_char(uuid, propmask, read_cb, write_cb);
-	if (!attr)
+	attr_handle = btd_gatt_add_char(uuid, propmask, read_cb, write_cb);
+	if (!attr_handle)
 		return -ENOMEM;
 
-	g_hash_table_insert(proxy_hash, attr, g_dbus_proxy_ref(proxy));
+	g_hash_table_insert(proxy_hash, GINT_TO_POINTER(attr_handle),
+						g_dbus_proxy_ref(proxy));
 
 	return 0;
 }
 
 static int add_char_desc(GDBusProxy *proxy, const bt_uuid_t *uuid)
 {
-	struct btd_attribute *attr;
+	uint16_t attr_handle;
 
-	attr = btd_gatt_add_char_desc(uuid, proxy_read_cb, proxy_write_cb);
-	if (!attr)
+	attr_handle = btd_gatt_add_char_desc(uuid, proxy_read_cb,
+								proxy_write_cb);
+	if (!attr_handle)
 		return -ENOMEM;
 
-	g_hash_table_insert(proxy_hash, attr, g_dbus_proxy_ref(proxy));
+	g_hash_table_insert(proxy_hash, GINT_TO_POINTER(attr_handle),
+						g_dbus_proxy_ref(proxy));
 
 	return 0;
 }
diff --git a/src/gatt.c b/src/gatt.c
index f07effa..bfd083a 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -113,7 +113,7 @@ static int local_database_add(uint16_t handle, struct btd_attribute *attr)
 	return 0;
 }
 
-struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
+uint16_t btd_gatt_add_service(const bt_uuid_t *uuid)
 {
 	struct btd_attribute *attr;
 	uint16_t len = bt_uuid_len(uuid);
@@ -136,20 +136,20 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
 
 	attr = new_const_attribute(&primary_uuid, value, len);
 	if (!attr)
-		return NULL;
+		return 0;
 
 	if (local_database_add(next_handle, attr) < 0) {
 		free(attr);
-		return NULL;
+		return 0;
 	}
 
 	/* TODO: missing overflow checking */
 	next_handle = next_handle + 1;
 
-	return attr;
+	return attr->handle;
 }
 
-struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
+uint16_t btd_gatt_add_char(const bt_uuid_t *uuid,
 						uint8_t properties,
 						btd_attr_read_t read_cb,
 						btd_attr_write_t write_cb)
@@ -223,16 +223,16 @@ struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
 	 */
 	put_le16(char_value->handle, &char_decl->value[1]);
 
-	return char_value;
+	return char_value->handle;
 
 fail:
 	free(char_decl);
 	free(char_value);
 
-	return NULL;
+	return 0;
 }
 
-struct btd_attribute *btd_gatt_add_char_desc(const bt_uuid_t *uuid,
+uint16_t btd_gatt_add_char_desc(const bt_uuid_t *uuid,
 						btd_attr_read_t read_cb,
 						btd_attr_write_t write_cb)
 {
@@ -251,16 +251,16 @@ struct btd_attribute *btd_gatt_add_char_desc(const bt_uuid_t *uuid,
 
 	attr = new_attribute(uuid, read_cb, write_cb);
 	if (!attr)
-		return NULL;
+		return 0;
 
 	if (local_database_add(next_handle, attr) < 0) {
 		free(attr);
-		return NULL;
+		return 0;
 	}
 
 	next_handle = next_handle + 1;
 
-	return attr;
+	return attr->handle;
 }
 
 void gatt_init(void)
diff --git a/src/gatt.h b/src/gatt.h
index da7af92..413492d 100644
--- a/src/gatt.h
+++ b/src/gatt.h
@@ -40,12 +40,12 @@ typedef void (*btd_attr_read_result_t) (int err, uint8_t *value, size_t len,
 /*
  * Service implementation callback passed to core (ATT layer). It manages read
  * operations received from remote devices.
- * @attr:	reference of the attribute to be read.
- * @result:	callback called from the service implementation informing the
- *		value of attribute read.
- * @user_data:	user_data passed in btd_attr_read_result_t callback.
+ * @attr_handle:	handle of the attribute to be read.
+ * @result:		callback called from the service implementation
+ * 			informing the value of attribute read.
+ * @user_data:		user_data passed in btd_attr_read_result_t callback.
  */
-typedef void (*btd_attr_read_t) (struct btd_attribute *attr,
+typedef void (*btd_attr_read_t) (uint16_t attr_handle,
 						btd_attr_read_result_t result,
 						void *user_data);
 
@@ -60,14 +60,14 @@ typedef void (*btd_attr_write_result_t) (int err, void *user_data);
 /*
  * Service implementation callback passed to core (ATT layer). It manages write
  * operations received from remote devices.
- * @attr:	reference of the attribute to be changed.
- * @value:	new attribute value.
- * @len:	length of value.
- * @result:	callback called from the service implementation informing the
- *		result of the write operation.
- * @user_data:	user_data passed in btd_attr_write_result_t callback.
+ * @attr_handle:	handle of the attribute to be changed.
+ * @value:		new attribute value.
+ * @len:		length of value.
+ * @result:		callback called from the service implementation
+ * 			informing the result of the write operation.
+ * @user_data:		user_data passed in btd_attr_write_result_t callback.
  */
-typedef void (*btd_attr_write_t) (struct btd_attribute *attr,
+typedef void (*btd_attr_write_t) (uint16_t attr_handle,
 					const uint8_t *value, size_t len,
 					btd_attr_write_result_t result,
 					void *user_data);
@@ -75,10 +75,10 @@ typedef void (*btd_attr_write_t) (struct btd_attribute *attr,
 /* btd_gatt_add_service - Add a service declaration to local attribute database.
  * @uuid:	Service UUID.
  *
- * Returns a reference to service declaration attribute. In case of error,
- * NULL is returned.
+ * Returns handle to service declaration attribute. In case of error,
+ * 0 is returned.
  */
-struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid);
+uint16_t btd_gatt_add_service(const bt_uuid_t *uuid);
 
 /*
  * btd_gatt_add_char - Add a characteristic (declaration and value attributes)
@@ -89,10 +89,10 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid);
  * @write_cb:	Callback called to notify the implementation that a new value
  *              is available.
  *
- * Returns a reference to characteristic value attribute. In case of error,
- * NULL is returned.
+ * Returns handle to characteristic value attribute. In case of error,
+ * 0 is returned.
  */
-struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
+uint16_t btd_gatt_add_char(const bt_uuid_t *uuid,
 						uint8_t properties,
 						btd_attr_read_t read_cb,
 						btd_attr_write_t write_cb);
@@ -106,9 +106,9 @@ struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
  * @write_cb:	Callback that should be called once the characteristic
  *		descriptor attribute is written.
  *
- * Returns a reference to characteristic descriptor attribute. In case of
- * error, NULL is returned.
+ * Returns handle to characteristic descriptor attribute. In case of
+ * error, 0 is returned.
  */
-struct btd_attribute *btd_gatt_add_char_desc(const bt_uuid_t *uuid,
+uint16_t btd_gatt_add_char_desc(const bt_uuid_t *uuid,
 						btd_attr_read_t read_cb,
 						btd_attr_write_t write_cb);
-- 
1.8.3.1

