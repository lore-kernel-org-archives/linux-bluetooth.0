Return-Path: <cyrus@holtmann.org>
From: Steven Walter <stevenrwalter@gmail.com>
To: linux-bluetooth@vger.kernel.org, armansito@chromium.org
Cc: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH BlueZ 1/5] src/gatt-dbus.c: convert to shared/gatt-db implementation
Date: Wed,  3 Dec 2014 10:54:30 -0500
Message-Id: <1417622074-20023-1-git-send-email-stevenrwalter@gmail.com>
In-Reply-To: <CAK8d-aLtkB1RKm+HP92x45D7csVpPNHj--4SsOPG3aAcx9sj0Q@mail.gmail.com>
References: <CAK8d-aLtkB1RKm+HP92x45D7csVpPNHj--4SsOPG3aAcx9sj0Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/gatt-dbus.c | 182 ++++++++++++++++++++++++++------------------------------
 src/gatt-dbus.h |   3 +-
 src/gatt.c      |   2 +-
 3 files changed, 86 insertions(+), 101 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index c22e8af..a04c38f 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -27,6 +27,7 @@
 
 #include <stdint.h>
 #include <errno.h>
+#include <assert.h>
 
 #include <glib.h>
 #include <dbus/dbus.h>
@@ -39,6 +40,9 @@
 #include "log.h"
 
 #include "error.h"
+#include "shared/queue.h"
+#include "shared/gatt-db.h"
+#include "shared/att-types.h"
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
 #include "attrib/gatt.h"
@@ -56,22 +60,18 @@ struct external_service {
 	DBusMessage *reg;
 	GDBusClient *client;
 	GSList *proxies;
-	struct btd_attribute *service;
+	struct gatt_db_attribute *service;
 };
 
 struct proxy_write_data {
-	btd_attr_write_result_t result_cb;
-	void *user_data;
+	struct gatt_db_attribute *attrib;
+	unsigned int id;
 };
 
-/*
- * Attribute to Proxy hash table. Used to map incoming
- * ATT operations to its external characteristic proxy.
- */
-static GHashTable *proxy_hash;
-
 static GSList *external_services;
 
+static struct gatt_db *gatt_db;
+
 static int external_service_path_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct external_service *esvc = a;
@@ -116,7 +116,7 @@ static void remove_service(DBusConnection *conn, void *user_data)
 	external_services = g_slist_remove(external_services, esvc);
 
 	if (esvc->service)
-		btd_gatt_remove_service(esvc->service);
+		gatt_db_remove_service(gatt_db, esvc->service);
 
 	/*
 	 * Do not run in the same loop, this may be a disconnect
@@ -141,19 +141,19 @@ static uint8_t flags_string2int(const char *proper)
 
 	/* Regular Properties: See core spec 4.1 page 2183 */
 	if (!strcmp("broadcast", proper))
-		value = GATT_CHR_PROP_BROADCAST;
+		value = BT_GATT_CHRC_PROP_BROADCAST;
 	else if (!strcmp("read", proper))
-		value = GATT_CHR_PROP_READ;
+		value = BT_GATT_CHRC_PROP_READ;
 	else if (!strcmp("write-without-response", proper))
-		value = GATT_CHR_PROP_WRITE_WITHOUT_RESP;
+		value = BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP;
 	else if (!strcmp("write", proper))
-		value = GATT_CHR_PROP_WRITE;
+		value = BT_GATT_CHRC_PROP_WRITE;
 	else if (!strcmp("notify", proper))
-		value = GATT_CHR_PROP_NOTIFY;
+		value = BT_GATT_CHRC_PROP_NOTIFY;
 	else if (!strcmp("indicate", proper))
-		value = GATT_CHR_PROP_INDICATE;
+		value = BT_GATT_CHRC_PROP_INDICATE;
 	else if (!strcmp("authenticated-signed-writes", proper))
-		value = GATT_CHR_PROP_AUTH;
+		value = BT_GATT_CHRC_PROP_AUTH;
 	else
 		value = 0;
 
@@ -233,11 +233,13 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 	esvc->proxies = g_slist_remove(esvc->proxies, proxy);
 }
 
-static void proxy_read_cb(struct btd_attribute *attr,
-				btd_attr_read_result_t result, void *user_data)
+static void proxy_read_cb(struct gatt_db_attribute *attr,
+			  unsigned int id, uint16_t offset,
+			  uint8_t opcode, bdaddr_t *bdaddr,
+			  void *user_data)
 {
 	DBusMessageIter iter, array;
-	GDBusProxy *proxy;
+	GDBusProxy *proxy = (GDBusProxy *)user_data;
 	uint8_t *value;
 	int len;
 
@@ -247,21 +249,15 @@ static void proxy_read_cb(struct btd_attribute *attr,
 	 * properties changes automatically, it is not necessary to
 	 * get the value directly from the GATT server.
 	 */
-	proxy = g_hash_table_lookup(proxy_hash, attr);
-	if (!proxy) {
-		result(-ENOENT, NULL, 0, user_data);
-		return;
-	}
-
 	if (!g_dbus_proxy_get_property(proxy, "Value", &iter)) {
 		/* Unusual situation, read property will checked earlier */
-		result(-EPERM, NULL, 0, user_data);
+		gatt_db_attribute_read_result(attr, id, -EPERM, NULL, 0);
 		return;
 	}
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
-		DBG("External service inconsistent!");
-		result(-EPERM, NULL, 0, user_data);
+		//DBG("External service inconsistent!");
+		gatt_db_attribute_read_result(attr, id, -EPERM, NULL, 0);
 		return;
 	}
 
@@ -270,13 +266,13 @@ static void proxy_read_cb(struct btd_attribute *attr,
 
 	DBG("attribute: %p read %d bytes", attr, len);
 
-	result(0, value, len, user_data);
+	gatt_db_attribute_read_result(attr, id, 0, value, len);
 }
 
 static void proxy_write_reply(const DBusError *derr, void *user_data)
 {
 	struct proxy_write_data *wdata = user_data;
-	int err;
+	uint8_t ecode = 0;
 
 	/*
 	 * Security requirements shall be handled by the core. If external
@@ -285,39 +281,29 @@ static void proxy_write_reply(const DBusError *derr, void *user_data)
 	 */
 
 	if (!dbus_error_is_set(derr)) {
-		err = 0;
+		ecode = 0;
 		goto done;
 	}
 
 	DBG("Write reply: %s", derr->message);
 
-	if (dbus_error_has_name(derr, DBUS_ERROR_NO_REPLY))
-		err = -ETIMEDOUT;
-	else if (dbus_error_has_name(derr, ERROR_INTERFACE ".InvalidArguments"))
-		err = -EINVAL;
-	else
-		err = -EPROTO;
+	ecode = BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
 
 done:
-	if (wdata && wdata->result_cb)
-		wdata->result_cb(err, wdata->user_data);
+	if (wdata && wdata->attrib)
+		gatt_db_attribute_write_result(wdata->attrib, wdata->id, ecode);
 }
 
-static void proxy_write_cb(struct btd_attribute *attr,
-					const uint8_t *value, size_t len,
-					btd_attr_write_result_t result,
-					void *user_data)
+static void proxy_write_cb(struct gatt_db_attribute *attrib,
+			   unsigned int id, uint16_t offset,
+			   const uint8_t *value, size_t len,
+			   uint8_t opcode, bdaddr_t *bdaddr,
+			   void *user_data)
 {
-	GDBusProxy *proxy;
-
-	proxy = g_hash_table_lookup(proxy_hash, attr);
-	if (!proxy) {
-		result(-ENOENT, user_data);
-		return;
-	}
+	GDBusProxy *proxy = (GDBusProxy *)user_data;
 
 	/*
-	 * "result" callback defines if the core wants to receive the
+	 * opcode defines if the core wants to receive the
 	 * operation result, allowing to select ATT Write Request or Write
 	 * Command. Descriptors requires Write Request operation. For
 	 * Characteristics, the implementation will define which operations
@@ -325,19 +311,20 @@ static void proxy_write_cb(struct btd_attribute *attr,
 	 * TODO: Write Long Characteristics/Descriptors.
 	 */
 
-	if (result) {
+	if (opcode != BT_ATT_OP_WRITE_CMD) {
 		struct proxy_write_data *wdata;
 
 		wdata = g_new0(struct proxy_write_data, 1);
-		wdata->result_cb = result;
-		wdata->user_data = user_data;
+		wdata->attrib = attrib;
+		wdata->id = id;
 
 		if (!g_dbus_proxy_set_property_array(proxy, "Value",
 						DBUS_TYPE_BYTE, value, len,
 						proxy_write_reply,
 						wdata, g_free)) {
 			g_free(wdata);
-			result(-ENOENT, user_data);
+			gatt_db_attribute_write_result(attrib, id, BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND);
+
 		}
 	} else {
 		/*
@@ -356,7 +343,8 @@ static void proxy_write_cb(struct btd_attribute *attr,
 }
 
 static int register_external_service(struct external_service *esvc,
-							GDBusProxy *proxy)
+							GDBusProxy *proxy,
+							int num_handles)
 {
 	DBusMessageIter iter;
 	const char *str, *path, *iface;
@@ -379,20 +367,23 @@ static int register_external_service(struct external_service *esvc,
 	if (bt_string_to_uuid(&uuid, str) < 0)
 		return -EINVAL;
 
-	esvc->service = btd_gatt_add_service(&uuid);
+	esvc->service = gatt_db_add_service(gatt_db, &uuid, true, num_handles);
 	if (!esvc->service)
 		return -EINVAL;
 
 	return 0;
 }
 
-static int add_char(GDBusProxy *proxy, const bt_uuid_t *uuid)
+static int add_char(struct gatt_db_attribute *service,
+		    GDBusProxy *proxy, const bt_uuid_t *uuid)
 {
 	DBusMessageIter iter;
 	struct btd_attribute *attr;
-	btd_attr_write_t write_cb;
-	btd_attr_read_t read_cb;
+	gatt_db_write_t write_cb;
+	gatt_db_read_t read_cb;
 	uint8_t propmask = 0;
+	uint32_t permissions = 0;
+	struct gatt_db_attribute *res;
 
 	/*
 	 * Optional property. If is not informed, read and write
@@ -402,45 +393,46 @@ static int add_char(GDBusProxy *proxy, const bt_uuid_t *uuid)
 	if (g_dbus_proxy_get_property(proxy, "Flags", &iter))
 		propmask = flags_get_bitmask(&iter);
 	else
-		propmask = GATT_CHR_PROP_WRITE_WITHOUT_RESP
-						| GATT_CHR_PROP_WRITE
-						| GATT_CHR_PROP_READ;
+		propmask = BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP
+						| BT_GATT_CHRC_PROP_WRITE
+						| BT_GATT_CHRC_PROP_READ;
 	if (!propmask)
 		return -EINVAL;
 
-	if (propmask & GATT_CHR_PROP_READ)
+	if (propmask & BT_GATT_CHRC_PROP_READ) {
 		read_cb = proxy_read_cb;
-	else
+		permissions |= BT_ATT_PERM_READ;
+	} else {
 		read_cb = NULL;
+	}
 
-	if (propmask & (GATT_CHR_PROP_WRITE | GATT_CHR_PROP_WRITE_WITHOUT_RESP))
+	if (propmask & (BT_GATT_CHRC_PROP_WRITE | BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP)) {
 		write_cb = proxy_write_cb;
-	else
+		permissions |= BT_ATT_PERM_WRITE;
+	} else {
 		write_cb = NULL;
+	}
 
-	attr = btd_gatt_add_char(uuid, propmask, read_cb, write_cb);
-	if (!attr)
-		return -ENOMEM;
-
-	g_hash_table_insert(proxy_hash, attr, g_dbus_proxy_ref(proxy));
+	res = gatt_db_service_add_characteristic(service, uuid, permissions, propmask,
+					   read_cb, write_cb, proxy);
+	assert(res);
 
 	return 0;
 }
 
-static int add_char_desc(GDBusProxy *proxy, const bt_uuid_t *uuid)
+static int add_char_desc(struct gatt_db_attribute *service,
+			 GDBusProxy *proxy, const bt_uuid_t *uuid)
 {
-	struct btd_attribute *attr;
-
-	attr = btd_gatt_add_char_desc(uuid, proxy_read_cb, proxy_write_cb);
-	if (!attr)
-		return -ENOMEM;
-
-	g_hash_table_insert(proxy_hash, attr, g_dbus_proxy_ref(proxy));
+	struct gatt_db_attribute *attr;
 
+	attr = gatt_db_service_add_descriptor(service, uuid, BT_ATT_PERM_READ,
+				       proxy_read_cb, proxy_write_cb, proxy);
+	assert(attr);
 	return 0;
 }
 
-static int register_external_characteristics(GSList *proxies)
+static int register_external_characteristics(struct gatt_db_attribute *service,
+					     GSList *proxies)
 
 {
 	GSList *list;
@@ -468,9 +460,9 @@ static int register_external_characteristics(GSList *proxies)
 		path = g_dbus_proxy_get_path(proxy);
 
 		if (!strcmp(GATT_CHR_IFACE, iface))
-			ret = add_char(proxy, &uuid);
+			ret = add_char(service, proxy, &uuid);
 		else
-			ret = add_char_desc(proxy, &uuid);
+			ret = add_char_desc(service, proxy, &uuid);
 
 		if (ret < 0)
 			return ret;
@@ -492,13 +484,15 @@ static void client_ready(GDBusClient *client, void *user_data)
 		goto fail;
 
 	proxy = esvc->proxies->data;
-	if (register_external_service(esvc, proxy) < 0)
+	int num_handles = g_slist_length(esvc->proxies) + 1;
+	if (register_external_service(esvc, proxy, num_handles) < 0)
 		goto fail;
 
-	if (register_external_characteristics(g_slist_next(esvc->proxies)) < 0)
+	if (register_external_characteristics(esvc->service, g_slist_next(esvc->proxies)) < 0)
 		goto fail;
 
 	DBG("Added GATT service %s", esvc->path);
+	gatt_db_service_set_active(esvc->service, true);
 
 	reply = dbus_message_new_method_return(esvc->reg);
 	g_dbus_send_message(conn, reply);
@@ -627,32 +621,22 @@ static const GDBusMethodTable methods[] = {
 	{ }
 };
 
-gboolean gatt_dbus_manager_register(void)
+gboolean gatt_dbus_manager_register(struct gatt_db *db)
 {
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 				"/org/bluez", GATT_MGR_IFACE,
 				methods, NULL, NULL, NULL, NULL))
 		return FALSE;
 
-	proxy_hash = g_hash_table_new_full(g_direct_hash, g_direct_equal,
-				NULL, (GDestroyNotify) g_dbus_proxy_unref);
-
+	gatt_db = db;
 	return TRUE;
 }
 
 void gatt_dbus_manager_unregister(void)
 {
-	/* We might not have initialized if experimental features are
-	 * not enabled.
-	 */
-	if (!proxy_hash)
-		return;
-
-	g_hash_table_destroy(proxy_hash);
-	proxy_hash = NULL;
-
 	g_slist_free_full(external_services, external_service_free);
 
 	g_dbus_unregister_interface(btd_get_dbus_connection(), "/org/bluez",
 							GATT_MGR_IFACE);
+	gatt_db = NULL;
 }
diff --git a/src/gatt-dbus.h b/src/gatt-dbus.h
index 310cfa9..7716648 100644
--- a/src/gatt-dbus.h
+++ b/src/gatt-dbus.h
@@ -21,5 +21,6 @@
  *
  */
 
-gboolean gatt_dbus_manager_register(void);
+struct gatt_db;
+gboolean gatt_dbus_manager_register(struct gatt_db *db);
 void gatt_dbus_manager_unregister(void);
diff --git a/src/gatt.c b/src/gatt.c
index 3060462..4028919 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -309,7 +309,7 @@ void gatt_init(void)
 {
 	DBG("Starting GATT server");
 
-	gatt_dbus_manager_register();
+	gatt_dbus_manager_register(NULL);
 }
 
 void gatt_cleanup(void)
-- 
1.9.1

