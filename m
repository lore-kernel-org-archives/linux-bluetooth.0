Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 05/17] core/gatt: Add GattManager1 stubs
Date: Wed, 25 Feb 2015 21:13:18 -0800
Message-Id: <1424927610-26226-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1424927610-26226-1-git-send-email-armansito@chromium.org>
References: <1424927610-26226-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces src/gatt-manager, which will implement the
org.bluez.GattManager1 API outlined in doc/gatt-api.txt. The old
src/gatt-dbus code has been removed to start from a clean slate.
---
 Makefile.am        |   3 +-
 src/adapter.c      |  18 +-
 src/gatt-dbus.c    | 658 -----------------------------------------------------
 src/gatt-dbus.h    |  25 --
 src/gatt-manager.c | 121 ++++++++++
 src/gatt-manager.h |  23 ++
 src/gatt.c         | 321 --------------------------
 src/gatt.h         | 121 ----------
 src/main.c         |   5 -
 9 files changed, 162 insertions(+), 1133 deletions(-)
 delete mode 100644 src/gatt-dbus.c
 delete mode 100644 src/gatt-dbus.h
 create mode 100644 src/gatt-manager.c
 create mode 100644 src/gatt-manager.h
 delete mode 100644 src/gatt.c
 delete mode 100644 src/gatt.h

diff --git a/Makefile.am b/Makefile.am
index dd8cda2..20c0ab6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -168,6 +168,7 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/sdpd-service.c src/sdpd-database.c \
 			src/attrib-server.h src/attrib-server.c \
 			src/gatt-database.h src/gatt-database.c \
+			src/gatt-manager.h src/gatt-manager.c \
 			src/sdp-xml.h src/sdp-xml.c \
 			src/sdp-client.h src/sdp-client.c \
 			src/textfile.h src/textfile.c \
@@ -180,8 +181,6 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/adapter.h src/adapter.c \
 			src/profile.h src/profile.c \
 			src/service.h src/service.c \
-			src/gatt-dbus.h src/gatt-dbus.c \
-			src/gatt.h src/gatt.c \
 			src/gatt-client.h src/gatt-client.c \
 			src/device.h src/device.c src/attio.h \
 			src/dbus-common.c src/dbus-common.h \
diff --git a/src/adapter.c b/src/adapter.c
index 3353297..b9ec0a9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -72,6 +72,7 @@
 #include "attrib/gatt.h"
 #include "attrib-server.h"
 #include "gatt-database.h"
+#include "gatt-manager.h"
 #include "eir.h"
 
 #define ADAPTER_INTERFACE	"org.bluez.Adapter1"
@@ -208,6 +209,7 @@ struct btd_adapter {
 	sdp_list_t *services;		/* Services associated to adapter */
 
 	struct btd_gatt_database *database;
+	struct btd_gatt_manager *manager;
 
 	gboolean initialized;
 
@@ -4591,6 +4593,10 @@ static void adapter_remove(struct btd_adapter *adapter)
 	adapter->db_id = 0;
 
 	btd_gatt_database_destroy(adapter->database);
+	adapter->database = NULL;
+
+	btd_gatt_manager_destroy(adapter->manager);
+	adapter->manager = NULL;
 
 	g_slist_free(adapter->pin_callbacks);
 	adapter->pin_callbacks = NULL;
@@ -6642,8 +6648,18 @@ static int adapter_register(struct btd_adapter *adapter)
 	}
 
 	adapter->database = btd_gatt_database_new(adapter);
-	if (!adapter->database)
+	if (!adapter->database) {
 		error("Failed to create GATT database for adapter");
+		return -EINVAL;
+	}
+
+	adapter->manager = btd_gatt_manager_new(adapter);
+	if (!adapter->manager) {
+		error("Failed to register GattManager1 interface for adapter");
+		btd_gatt_database_destroy(adapter->database);
+		adapter->database = NULL;
+		return -EINVAL;
+	}
 
 	db = btd_gatt_database_get_db(adapter->database);
 	adapter->db_id = gatt_db_register(db, services_modified,
diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
deleted file mode 100644
index c22e8af..0000000
--- a/src/gatt-dbus.c
+++ /dev/null
@@ -1,658 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2014  Instituto Nokia de Tecnologia - INdT
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdint.h>
-#include <errno.h>
-
-#include <glib.h>
-#include <dbus/dbus.h>
-#include <gdbus/gdbus.h>
-
-#include "adapter.h"
-#include "device.h"
-#include "lib/uuid.h"
-#include "dbus-common.h"
-#include "log.h"
-
-#include "error.h"
-#include "attrib/gattrib.h"
-#include "attrib/att.h"
-#include "attrib/gatt.h"
-#include "gatt.h"
-#include "gatt-dbus.h"
-
-#define GATT_MGR_IFACE			"org.bluez.GattManager1"
-#define GATT_SERVICE_IFACE		"org.bluez.GattService1"
-#define GATT_CHR_IFACE			"org.bluez.GattCharacteristic1"
-#define GATT_DESCRIPTOR_IFACE		"org.bluez.GattDescriptor1"
-
-struct external_service {
-	char *owner;
-	char *path;
-	DBusMessage *reg;
-	GDBusClient *client;
-	GSList *proxies;
-	struct btd_attribute *service;
-};
-
-struct proxy_write_data {
-	btd_attr_write_result_t result_cb;
-	void *user_data;
-};
-
-/*
- * Attribute to Proxy hash table. Used to map incoming
- * ATT operations to its external characteristic proxy.
- */
-static GHashTable *proxy_hash;
-
-static GSList *external_services;
-
-static int external_service_path_cmp(gconstpointer a, gconstpointer b)
-{
-	const struct external_service *esvc = a;
-	const char *path = b;
-
-	return g_strcmp0(esvc->path, path);
-}
-
-static gboolean external_service_destroy(void *user_data)
-{
-	struct external_service *esvc = user_data;
-
-	g_dbus_client_unref(esvc->client);
-
-	if (esvc->reg)
-		dbus_message_unref(esvc->reg);
-
-	g_free(esvc->owner);
-	g_free(esvc->path);
-	g_free(esvc);
-
-	return FALSE;
-}
-
-static void external_service_free(void *user_data)
-{
-	struct external_service *esvc = user_data;
-
-	/*
-	 * Set callback to NULL to avoid potential race condition
-	 * when calling remove_service and GDBusClient unref.
-	 */
-	g_dbus_client_set_disconnect_watch(esvc->client, NULL, NULL);
-
-	external_service_destroy(user_data);
-}
-
-static void remove_service(DBusConnection *conn, void *user_data)
-{
-	struct external_service *esvc = user_data;
-
-	external_services = g_slist_remove(external_services, esvc);
-
-	if (esvc->service)
-		btd_gatt_remove_service(esvc->service);
-
-	/*
-	 * Do not run in the same loop, this may be a disconnect
-	 * watch call and GDBusClient should not be destroyed.
-	 */
-	g_idle_add(external_service_destroy, esvc);
-}
-
-static int proxy_path_cmp(gconstpointer a, gconstpointer b)
-{
-	GDBusProxy *proxy1 = (GDBusProxy *) a;
-	GDBusProxy *proxy2 = (GDBusProxy *) b;
-	const char *path1 = g_dbus_proxy_get_path(proxy1);
-	const char *path2 = g_dbus_proxy_get_path(proxy2);
-
-	return g_strcmp0(path1, path2);
-}
-
-static uint8_t flags_string2int(const char *proper)
-{
-	uint8_t value;
-
-	/* Regular Properties: See core spec 4.1 page 2183 */
-	if (!strcmp("broadcast", proper))
-		value = GATT_CHR_PROP_BROADCAST;
-	else if (!strcmp("read", proper))
-		value = GATT_CHR_PROP_READ;
-	else if (!strcmp("write-without-response", proper))
-		value = GATT_CHR_PROP_WRITE_WITHOUT_RESP;
-	else if (!strcmp("write", proper))
-		value = GATT_CHR_PROP_WRITE;
-	else if (!strcmp("notify", proper))
-		value = GATT_CHR_PROP_NOTIFY;
-	else if (!strcmp("indicate", proper))
-		value = GATT_CHR_PROP_INDICATE;
-	else if (!strcmp("authenticated-signed-writes", proper))
-		value = GATT_CHR_PROP_AUTH;
-	else
-		value = 0;
-
-	/* TODO: Extended properties. Ref core spec 4.1 page 2185  */
-
-	return value;
-}
-
-static uint8_t flags_get_bitmask(DBusMessageIter *iter)
-{
-	DBusMessageIter istr;
-	uint8_t propmask = 0, prop;
-	const char *str;
-
-	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
-		goto fail;
-
-	dbus_message_iter_recurse(iter, &istr);
-
-	do {
-		if (dbus_message_iter_get_arg_type(&istr) != DBUS_TYPE_STRING)
-			goto fail;
-
-		dbus_message_iter_get_basic(&istr, &str);
-		prop = flags_string2int(str);
-		if (!prop)
-			goto fail;
-
-		propmask |= prop;
-	} while (dbus_message_iter_next(&istr));
-
-	return propmask;
-
-fail:
-	error("Characteristic Flags: Invalid argument!");
-
-	return 0;
-}
-
-static void proxy_added(GDBusProxy *proxy, void *user_data)
-{
-	struct external_service *esvc = user_data;
-	const char *interface, *path;
-
-	interface = g_dbus_proxy_get_interface(proxy);
-	path = g_dbus_proxy_get_path(proxy);
-
-	if (!g_str_has_prefix(path, esvc->path))
-		return;
-
-	if (g_strcmp0(interface, GATT_CHR_IFACE) != 0 &&
-			g_strcmp0(interface, GATT_SERVICE_IFACE) != 0 &&
-			g_strcmp0(interface, GATT_DESCRIPTOR_IFACE) != 0)
-		return;
-
-	DBG("path %s iface %s", path, interface);
-
-	/*
-	 * Object path follows a hierarchical organization. Add the
-	 * proxies sorted by path helps the logic to register the
-	 * object path later.
-	 */
-	esvc->proxies = g_slist_insert_sorted(esvc->proxies, proxy,
-							proxy_path_cmp);
-}
-
-static void proxy_removed(GDBusProxy *proxy, void *user_data)
-{
-	struct external_service *esvc = user_data;
-	const char *interface, *path;
-
-	interface = g_dbus_proxy_get_interface(proxy);
-	path = g_dbus_proxy_get_path(proxy);
-
-	DBG("path %s iface %s", path, interface);
-
-	esvc->proxies = g_slist_remove(esvc->proxies, proxy);
-}
-
-static void proxy_read_cb(struct btd_attribute *attr,
-				btd_attr_read_result_t result, void *user_data)
-{
-	DBusMessageIter iter, array;
-	GDBusProxy *proxy;
-	uint8_t *value;
-	int len;
-
-	/*
-	 * Remote device is trying to read the informed attribute,
-	 * "Value" should be read from the proxy. GDBusProxy tracks
-	 * properties changes automatically, it is not necessary to
-	 * get the value directly from the GATT server.
-	 */
-	proxy = g_hash_table_lookup(proxy_hash, attr);
-	if (!proxy) {
-		result(-ENOENT, NULL, 0, user_data);
-		return;
-	}
-
-	if (!g_dbus_proxy_get_property(proxy, "Value", &iter)) {
-		/* Unusual situation, read property will checked earlier */
-		result(-EPERM, NULL, 0, user_data);
-		return;
-	}
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
-		DBG("External service inconsistent!");
-		result(-EPERM, NULL, 0, user_data);
-		return;
-	}
-
-	dbus_message_iter_recurse(&iter, &array);
-	dbus_message_iter_get_fixed_array(&array, &value, &len);
-
-	DBG("attribute: %p read %d bytes", attr, len);
-
-	result(0, value, len, user_data);
-}
-
-static void proxy_write_reply(const DBusError *derr, void *user_data)
-{
-	struct proxy_write_data *wdata = user_data;
-	int err;
-
-	/*
-	 * Security requirements shall be handled by the core. If external
-	 * applications returns an error, the reasons will be restricted to
-	 * invalid argument or application specific errors.
-	 */
-
-	if (!dbus_error_is_set(derr)) {
-		err = 0;
-		goto done;
-	}
-
-	DBG("Write reply: %s", derr->message);
-
-	if (dbus_error_has_name(derr, DBUS_ERROR_NO_REPLY))
-		err = -ETIMEDOUT;
-	else if (dbus_error_has_name(derr, ERROR_INTERFACE ".InvalidArguments"))
-		err = -EINVAL;
-	else
-		err = -EPROTO;
-
-done:
-	if (wdata && wdata->result_cb)
-		wdata->result_cb(err, wdata->user_data);
-}
-
-static void proxy_write_cb(struct btd_attribute *attr,
-					const uint8_t *value, size_t len,
-					btd_attr_write_result_t result,
-					void *user_data)
-{
-	GDBusProxy *proxy;
-
-	proxy = g_hash_table_lookup(proxy_hash, attr);
-	if (!proxy) {
-		result(-ENOENT, user_data);
-		return;
-	}
-
-	/*
-	 * "result" callback defines if the core wants to receive the
-	 * operation result, allowing to select ATT Write Request or Write
-	 * Command. Descriptors requires Write Request operation. For
-	 * Characteristics, the implementation will define which operations
-	 * are allowed based on the properties/flags.
-	 * TODO: Write Long Characteristics/Descriptors.
-	 */
-
-	if (result) {
-		struct proxy_write_data *wdata;
-
-		wdata = g_new0(struct proxy_write_data, 1);
-		wdata->result_cb = result;
-		wdata->user_data = user_data;
-
-		if (!g_dbus_proxy_set_property_array(proxy, "Value",
-						DBUS_TYPE_BYTE, value, len,
-						proxy_write_reply,
-						wdata, g_free)) {
-			g_free(wdata);
-			result(-ENOENT, user_data);
-		}
-	} else {
-		/*
-		 * Caller is not interested in the Set method call result.
-		 * This flow implements the ATT Write Command scenario, where
-		 * the remote doesn't receive ATT response.
-		 */
-		g_dbus_proxy_set_property_array(proxy, "Value", DBUS_TYPE_BYTE,
-						value, len, proxy_write_reply,
-						NULL, NULL);
-	}
-
-	DBG("Server: Write attribute callback %s",
-					g_dbus_proxy_get_path(proxy));
-
-}
-
-static int register_external_service(struct external_service *esvc,
-							GDBusProxy *proxy)
-{
-	DBusMessageIter iter;
-	const char *str, *path, *iface;
-	bt_uuid_t uuid;
-
-	path = g_dbus_proxy_get_path(proxy);
-	iface = g_dbus_proxy_get_interface(proxy);
-	if (g_strcmp0(esvc->path, path) != 0 ||
-			g_strcmp0(iface, GATT_SERVICE_IFACE) != 0)
-		return -EINVAL;
-
-	if (!g_dbus_proxy_get_property(proxy, "UUID", &iter))
-		return -EINVAL;
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-		return -EINVAL;
-
-	dbus_message_iter_get_basic(&iter, &str);
-
-	if (bt_string_to_uuid(&uuid, str) < 0)
-		return -EINVAL;
-
-	esvc->service = btd_gatt_add_service(&uuid);
-	if (!esvc->service)
-		return -EINVAL;
-
-	return 0;
-}
-
-static int add_char(GDBusProxy *proxy, const bt_uuid_t *uuid)
-{
-	DBusMessageIter iter;
-	struct btd_attribute *attr;
-	btd_attr_write_t write_cb;
-	btd_attr_read_t read_cb;
-	uint8_t propmask = 0;
-
-	/*
-	 * Optional property. If is not informed, read and write
-	 * procedures will be allowed. Upper-layer should handle
-	 * characteristic requirements.
-	 */
-	if (g_dbus_proxy_get_property(proxy, "Flags", &iter))
-		propmask = flags_get_bitmask(&iter);
-	else
-		propmask = GATT_CHR_PROP_WRITE_WITHOUT_RESP
-						| GATT_CHR_PROP_WRITE
-						| GATT_CHR_PROP_READ;
-	if (!propmask)
-		return -EINVAL;
-
-	if (propmask & GATT_CHR_PROP_READ)
-		read_cb = proxy_read_cb;
-	else
-		read_cb = NULL;
-
-	if (propmask & (GATT_CHR_PROP_WRITE | GATT_CHR_PROP_WRITE_WITHOUT_RESP))
-		write_cb = proxy_write_cb;
-	else
-		write_cb = NULL;
-
-	attr = btd_gatt_add_char(uuid, propmask, read_cb, write_cb);
-	if (!attr)
-		return -ENOMEM;
-
-	g_hash_table_insert(proxy_hash, attr, g_dbus_proxy_ref(proxy));
-
-	return 0;
-}
-
-static int add_char_desc(GDBusProxy *proxy, const bt_uuid_t *uuid)
-{
-	struct btd_attribute *attr;
-
-	attr = btd_gatt_add_char_desc(uuid, proxy_read_cb, proxy_write_cb);
-	if (!attr)
-		return -ENOMEM;
-
-	g_hash_table_insert(proxy_hash, attr, g_dbus_proxy_ref(proxy));
-
-	return 0;
-}
-
-static int register_external_characteristics(GSList *proxies)
-
-{
-	GSList *list;
-
-	for (list = proxies; list; list = g_slist_next(list)) {
-		GDBusProxy *proxy = list->data;
-		DBusMessageIter iter;
-		bt_uuid_t uuid;
-		const char *path, *iface, *str;
-		int ret;
-
-		/* Mandatory property */
-		if (!g_dbus_proxy_get_property(proxy, "UUID", &iter))
-			return -EINVAL;
-
-		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-			return -EINVAL;
-
-		dbus_message_iter_get_basic(&iter, &str);
-
-		if (bt_string_to_uuid(&uuid, str) < 0)
-			return -EINVAL;
-
-		iface = g_dbus_proxy_get_interface(proxy);
-		path = g_dbus_proxy_get_path(proxy);
-
-		if (!strcmp(GATT_CHR_IFACE, iface))
-			ret = add_char(proxy, &uuid);
-		else
-			ret = add_char_desc(proxy, &uuid);
-
-		if (ret < 0)
-			return ret;
-
-		DBG("Added GATT: %s (%s)", path, str);
-	}
-
-	return 0;
-}
-
-static void client_ready(GDBusClient *client, void *user_data)
-{
-	struct external_service *esvc = user_data;
-	GDBusProxy *proxy;
-	DBusConnection *conn = btd_get_dbus_connection();
-	DBusMessage *reply;
-
-	if (!esvc->proxies)
-		goto fail;
-
-	proxy = esvc->proxies->data;
-	if (register_external_service(esvc, proxy) < 0)
-		goto fail;
-
-	if (register_external_characteristics(g_slist_next(esvc->proxies)) < 0)
-		goto fail;
-
-	DBG("Added GATT service %s", esvc->path);
-
-	reply = dbus_message_new_method_return(esvc->reg);
-	g_dbus_send_message(conn, reply);
-
-	dbus_message_unref(esvc->reg);
-	esvc->reg = NULL;
-
-	return;
-
-fail:
-	error("Could not register external service: %s", esvc->path);
-
-	/*
-	 * Set callback to NULL to avoid potential race condition
-	 * when calling remove_service and GDBusClient unref.
-	 */
-	g_dbus_client_set_disconnect_watch(esvc->client, NULL, NULL);
-
-	remove_service(conn, esvc);
-
-	reply = btd_error_invalid_args(esvc->reg);
-	g_dbus_send_message(conn, reply);
-}
-
-static struct external_service *external_service_new(DBusConnection *conn,
-					DBusMessage *msg, const char *path)
-{
-	struct external_service *esvc;
-	GDBusClient *client;
-	const char *sender = dbus_message_get_sender(msg);
-
-	client = g_dbus_client_new(conn, sender, "/");
-	if (!client)
-		return NULL;
-
-	esvc = g_new0(struct external_service, 1);
-	esvc->owner = g_strdup(sender);
-	esvc->reg = dbus_message_ref(msg);
-	esvc->client = client;
-	esvc->path = g_strdup(path);
-
-	g_dbus_client_set_disconnect_watch(client, remove_service, esvc);
-
-	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
-								NULL, esvc);
-
-	g_dbus_client_set_ready_watch(client, client_ready, esvc);
-
-	return esvc;
-}
-
-static DBusMessage *register_service(DBusConnection *conn,
-					DBusMessage *msg, void *user_data)
-{
-	struct external_service *esvc;
-	DBusMessageIter iter;
-	const char *path;
-
-	if (!dbus_message_iter_init(msg, &iter))
-		return btd_error_invalid_args(msg);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_OBJECT_PATH)
-		return btd_error_invalid_args(msg);
-
-	dbus_message_iter_get_basic(&iter, &path);
-
-	if (g_slist_find_custom(external_services, path,
-						external_service_path_cmp))
-		return btd_error_already_exists(msg);
-
-	esvc = external_service_new(conn, msg, path);
-	if (!esvc)
-		return btd_error_failed(msg, "Not enough resources");
-
-	external_services = g_slist_prepend(external_services, esvc);
-
-	DBG("New service %p: %s", esvc, path);
-
-	return NULL;
-}
-
-static DBusMessage *unregister_service(DBusConnection *conn,
-					DBusMessage *msg, void *user_data)
-{
-	struct external_service *esvc;
-	DBusMessageIter iter;
-	const char *path;
-	GSList *list;
-
-	if (!dbus_message_iter_init(msg, &iter))
-		return btd_error_invalid_args(msg);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_OBJECT_PATH)
-		return btd_error_invalid_args(msg);
-
-	dbus_message_iter_get_basic(&iter, &path);
-
-	list = g_slist_find_custom(external_services, path,
-						external_service_path_cmp);
-	if (!list)
-		return btd_error_does_not_exist(msg);
-
-	esvc = list->data;
-	if (!strcmp(dbus_message_get_sender(msg), esvc->owner))
-		return btd_error_does_not_exist(msg);
-
-	/*
-	 * Set callback to NULL to avoid potential race condition
-	 * when calling remove_service and GDBusClient unref.
-	 */
-	g_dbus_client_set_disconnect_watch(esvc->client, NULL, NULL);
-
-	remove_service(conn, esvc);
-
-	return dbus_message_new_method_return(msg);
-}
-
-static const GDBusMethodTable methods[] = {
-	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterService",
-				GDBUS_ARGS({ "service", "o"},
-						{ "options", "a{sv}"}),
-				NULL, register_service) },
-	{ GDBUS_EXPERIMENTAL_METHOD("UnregisterService",
-				GDBUS_ARGS({"service", "o"}),
-				NULL, unregister_service) },
-	{ }
-};
-
-gboolean gatt_dbus_manager_register(void)
-{
-	if (!g_dbus_register_interface(btd_get_dbus_connection(),
-				"/org/bluez", GATT_MGR_IFACE,
-				methods, NULL, NULL, NULL, NULL))
-		return FALSE;
-
-	proxy_hash = g_hash_table_new_full(g_direct_hash, g_direct_equal,
-				NULL, (GDestroyNotify) g_dbus_proxy_unref);
-
-	return TRUE;
-}
-
-void gatt_dbus_manager_unregister(void)
-{
-	/* We might not have initialized if experimental features are
-	 * not enabled.
-	 */
-	if (!proxy_hash)
-		return;
-
-	g_hash_table_destroy(proxy_hash);
-	proxy_hash = NULL;
-
-	g_slist_free_full(external_services, external_service_free);
-
-	g_dbus_unregister_interface(btd_get_dbus_connection(), "/org/bluez",
-							GATT_MGR_IFACE);
-}
diff --git a/src/gatt-dbus.h b/src/gatt-dbus.h
deleted file mode 100644
index 310cfa9..0000000
--- a/src/gatt-dbus.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2014  Instituto Nokia de Tecnologia - INdT
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-gboolean gatt_dbus_manager_register(void);
-void gatt_dbus_manager_unregister(void);
diff --git a/src/gatt-manager.c b/src/gatt-manager.c
new file mode 100644
index 0000000..296eabc
--- /dev/null
+++ b/src/gatt-manager.c
@@ -0,0 +1,121 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Instituto Nokia de Tecnologia - INdT
+ *  Copyright (C) 2015  Google Inc.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdint.h>
+
+#include <dbus/dbus.h>
+#include <gdbus/gdbus.h>
+
+#include "adapter.h"
+#include "gatt-manager.h"
+#include "dbus-common.h"
+#include "log.h"
+#include "error.h"
+#include "src/shared/queue.h"
+#include "src/shared/util.h"
+
+#define GATT_MANAGER_IFACE	"org.bluez.GattManager1"
+
+struct btd_gatt_manager {
+	struct btd_adapter *adapter;
+};
+
+static DBusMessage *manager_register_service(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	DBG("RegisterService");
+
+	/* TODO */
+	return NULL;
+}
+
+static DBusMessage *manager_unregister_service(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	DBG("UnregisterService");
+
+	/* TODO */
+	return NULL;
+}
+
+static const GDBusMethodTable manager_methods[] = {
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterService",
+			GDBUS_ARGS({ "service", "o" }, { "options", "a{sv}" }),
+			NULL, manager_register_service) },
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("UnregisterService",
+					GDBUS_ARGS({ "service", "o" }),
+					NULL, manager_unregister_service) },
+	{ }
+};
+
+static struct btd_gatt_manager *manager_create(struct btd_adapter *adapter)
+{
+	struct btd_gatt_manager *manager;
+
+	manager = new0(struct btd_gatt_manager, 1);
+	if (!manager)
+		return NULL;
+
+	manager->adapter = adapter;
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+						adapter_get_path(adapter),
+						GATT_MANAGER_IFACE,
+						manager_methods, NULL, NULL,
+						manager, NULL)) {
+		error("Failed to register " GATT_MANAGER_IFACE);
+		free(manager);
+		return NULL;
+	}
+
+	return manager;
+}
+
+struct btd_gatt_manager *btd_gatt_manager_new(struct btd_adapter *adapter)
+{
+	struct btd_gatt_manager *manager;
+
+	if (!adapter)
+		return NULL;
+
+	manager = manager_create(adapter);
+	if (!manager)
+		return NULL;
+
+	DBG("GATT Manager registered for adapter: %s",
+						adapter_get_path(adapter));
+
+	return manager;
+}
+
+void btd_gatt_manager_destroy(struct btd_gatt_manager *manager)
+{
+	if (!manager)
+		return;
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+					adapter_get_path(manager->adapter),
+					GATT_MANAGER_IFACE);
+	free(manager);
+}
diff --git a/src/gatt-manager.h b/src/gatt-manager.h
new file mode 100644
index 0000000..9573341
--- /dev/null
+++ b/src/gatt-manager.h
@@ -0,0 +1,23 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015  Google Inc.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ */
+
+struct btd_gatt_manager;
+
+struct btd_gatt_manager *btd_gatt_manager_new(struct btd_adapter *adapter);
+void btd_gatt_manager_destroy(struct btd_gatt_manager *manager);
diff --git a/src/gatt.c b/src/gatt.c
deleted file mode 100644
index df5ea1d..0000000
--- a/src/gatt.c
+++ /dev/null
@@ -1,321 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2014  Instituto Nokia de Tecnologia - INdT
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <glib.h>
-#include <stdbool.h>
-
-#include "log.h"
-#include "lib/bluetooth.h"
-#include "lib/uuid.h"
-#include "attrib/att.h"
-#include "src/shared/util.h"
-
-#include "gatt-dbus.h"
-#include "gatt.h"
-
-/* Common GATT UUIDs */
-static const bt_uuid_t primary_uuid  = { .type = BT_UUID16,
-					.value.u16 = GATT_PRIM_SVC_UUID };
-
-static const bt_uuid_t chr_uuid = { .type = BT_UUID16,
-					.value.u16 = GATT_CHARAC_UUID };
-
-struct btd_attribute {
-	uint16_t handle;
-	bt_uuid_t type;
-	btd_attr_read_t read_cb;
-	btd_attr_write_t write_cb;
-	uint16_t value_len;
-	uint8_t value[0];
-};
-
-static GList *local_attribute_db;
-static uint16_t next_handle = 0x0001;
-
-static inline void put_uuid_le(const bt_uuid_t *src, void *dst)
-{
-	if (src->type == BT_UUID16)
-		put_le16(src->value.u16, dst);
-	else if (src->type == BT_UUID32)
-		put_le32(src->value.u32, dst);
-	else
-		/* Convert from 128-bit BE to LE */
-		bswap_128(&src->value.u128, dst);
-}
-
-/*
- * Helper function to create new attributes containing constant/static values.
- * eg: declaration of services/characteristics, and characteristics with
- * fixed values.
- */
-static struct btd_attribute *new_const_attribute(const bt_uuid_t *type,
-							const uint8_t *value,
-							uint16_t len)
-{
-	struct btd_attribute *attr;
-
-	attr = malloc0(sizeof(struct btd_attribute) + len);
-	if (!attr)
-		return NULL;
-
-	attr->type = *type;
-	memcpy(&attr->value, value, len);
-	attr->value_len = len;
-
-	return attr;
-}
-
-static struct btd_attribute *new_attribute(const bt_uuid_t *type,
-						btd_attr_read_t read_cb,
-						btd_attr_write_t write_cb)
-{
-	struct btd_attribute *attr;
-
-	attr = new0(struct btd_attribute, 1);
-	if (!attr)
-		return NULL;
-
-	attr->type = *type;
-	attr->read_cb = read_cb;
-	attr->write_cb = write_cb;
-
-	return attr;
-}
-
-static bool is_service(const struct btd_attribute *attr)
-{
-	if (attr->type.type != BT_UUID16)
-		return false;
-
-	if (attr->type.value.u16 == GATT_PRIM_SVC_UUID ||
-			attr->type.value.u16 == GATT_SND_SVC_UUID)
-		return true;
-
-	return false;
-}
-
-static int local_database_add(uint16_t handle, struct btd_attribute *attr)
-{
-	attr->handle = handle;
-
-	local_attribute_db = g_list_append(local_attribute_db, attr);
-
-	return 0;
-}
-
-struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
-{
-	struct btd_attribute *attr;
-	uint16_t len = bt_uuid_len(uuid);
-	uint8_t value[len];
-
-	/*
-	 * Service DECLARATION
-	 *
-	 *   TYPE         ATTRIBUTE VALUE
-	 * +-------+---------------------------------+
-	 * |0x2800 | 0xYYYY...                       |
-	 * | (1)   | (2)                             |
-	 * +------+----------------------------------+
-	 * (1) - 2 octets: Primary/Secondary Service UUID
-	 * (2) - 2 or 16 octets: Service UUID
-	 */
-
-	/* Set attribute value */
-	put_uuid_le(uuid, value);
-
-	attr = new_const_attribute(&primary_uuid, value, len);
-	if (!attr)
-		return NULL;
-
-	if (local_database_add(next_handle, attr) < 0) {
-		free(attr);
-		return NULL;
-	}
-
-	/* TODO: missing overflow checking */
-	next_handle = next_handle + 1;
-
-	return attr;
-}
-
-void btd_gatt_remove_service(struct btd_attribute *service)
-{
-	GList *list = g_list_find(local_attribute_db, service);
-	bool first_node;
-
-	if (!list)
-		return;
-
-	first_node = local_attribute_db == list;
-
-	/* Remove service declaration attribute */
-	free(list->data);
-	list = g_list_delete_link(list, list);
-
-	/* Remove all characteristics until next service declaration */
-	while (list && !is_service(list->data)) {
-		free(list->data);
-		list = g_list_delete_link(list, list);
-	}
-
-	/*
-	 * When removing the first node, local attribute database head
-	 * needs to be updated. Node removed from middle doesn't change
-	 * the list head address.
-	 */
-	if (first_node)
-		local_attribute_db = list;
-}
-
-struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
-						uint8_t properties,
-						btd_attr_read_t read_cb,
-						btd_attr_write_t write_cb)
-{
-	struct btd_attribute *char_decl, *char_value = NULL;
-
-	/* Attribute value length */
-	uint16_t len = 1 + 2 + bt_uuid_len(uuid);
-	uint8_t value[len];
-
-	/*
-	 * Characteristic DECLARATION
-	 *
-	 *   TYPE         ATTRIBUTE VALUE
-	 * +-------+---------------------------------+
-	 * |0x2803 | 0xXX 0xYYYY 0xZZZZ...           |
-	 * | (1)   |  (2)   (3)   (4)                |
-	 * +------+----------------------------------+
-	 * (1) - 2 octets: Characteristic declaration UUID
-	 * (2) - 1 octet : Properties
-	 * (3) - 2 octets: Handle of the characteristic Value
-	 * (4) - 2 or 16 octets: Characteristic UUID
-	 */
-
-	value[0] = properties;
-
-	/*
-	 * Since we don't know yet the characteristic value attribute
-	 * handle, we skip and set it later.
-	 */
-
-	put_uuid_le(uuid, &value[3]);
-
-	char_decl = new_const_attribute(&chr_uuid, value, len);
-	if (!char_decl)
-		goto fail;
-
-	char_value = new_attribute(uuid, read_cb, write_cb);
-	if (!char_value)
-		goto fail;
-
-	if (local_database_add(next_handle, char_decl) < 0)
-		goto fail;
-
-	next_handle = next_handle + 1;
-
-	/*
-	 * Characteristic VALUE
-	 *
-	 *   TYPE         ATTRIBUTE VALUE
-	 * +----------+---------------------------------+
-	 * |0xZZZZ... | 0x...                           |
-	 * |  (1)     |  (2)                            |
-	 * +----------+---------------------------------+
-	 * (1) - 2 or 16 octets: Characteristic UUID
-	 * (2) - N octets: Value is read dynamically from the service
-	 * implementation (external entity).
-	 */
-
-	if (local_database_add(next_handle, char_value) < 0)
-		/* TODO: remove declaration */
-		goto fail;
-
-	next_handle = next_handle + 1;
-
-	/*
-	 * Update characteristic value handle in characteristic declaration
-	 * attribute. For local attributes, we can assume that the handle
-	 * representing the characteristic value will get the next available
-	 * handle. However, for remote attribute this assumption is not valid.
-	 */
-	put_le16(char_value->handle, &char_decl->value[1]);
-
-	return char_value;
-
-fail:
-	free(char_decl);
-	free(char_value);
-
-	return NULL;
-}
-
-struct btd_attribute *btd_gatt_add_char_desc(const bt_uuid_t *uuid,
-						btd_attr_read_t read_cb,
-						btd_attr_write_t write_cb)
-{
-	struct btd_attribute *attr;
-
-	/*
-	 * From Core SPEC 4.1 page 2184:
-	 * "Characteristic descriptor declaration permissions are defined by a
-	 * higher layer profile or are implementation specific. A client shall
-	 * not assume all characteristic descriptor declarations are readable."
-	 *
-	 * The read/write callbacks presence will define the descriptor
-	 * permissions managed directly by the core. The upper layer can define
-	 * additional permissions constraints.
-	 */
-
-	attr = new_attribute(uuid, read_cb, write_cb);
-	if (!attr)
-		return NULL;
-
-	if (local_database_add(next_handle, attr) < 0) {
-		free(attr);
-		return NULL;
-	}
-
-	next_handle = next_handle + 1;
-
-	return attr;
-}
-
-void gatt_init(void)
-{
-	DBG("Starting GATT server");
-
-	gatt_dbus_manager_register();
-}
-
-void gatt_cleanup(void)
-{
-	DBG("Stopping GATT server");
-
-	gatt_dbus_manager_unregister();
-}
diff --git a/src/gatt.h b/src/gatt.h
deleted file mode 100644
index f16541e..0000000
--- a/src/gatt.h
+++ /dev/null
@@ -1,121 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2014  Instituto Nokia de Tecnologia - INdT
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-struct btd_attribute;
-
-void gatt_init(void);
-
-void gatt_cleanup(void);
-
-/*
- * Read operation result callback. Called from the service implementation
- * informing the core (ATT layer) the result of read operation.
- * @err:	error in -errno format.
- * @value:	value of the attribute read.
- * @len:	length of value.
- * @user_data:	user_data passed in btd_attr_read_t callback.
- */
-typedef void (*btd_attr_read_result_t) (int err, uint8_t *value, size_t len,
-							void *user_data);
-/*
- * Service implementation callback passed to core (ATT layer). It manages read
- * operations received from remote devices.
- * @attr:	reference of the attribute to be read.
- * @result:	callback called from the service implementation informing the
- *		value of attribute read.
- * @user_data:	user_data passed in btd_attr_read_result_t callback.
- */
-typedef void (*btd_attr_read_t) (struct btd_attribute *attr,
-						btd_attr_read_result_t result,
-						void *user_data);
-
-/*
- * Write operation result callback. Called from the service implementation
- * informing the core (ATT layer) the result of the write operation. It is used
- * to manage Write Request operations.
- * @err:	error in -errno format.
- * @user_data:	user_data passed in btd_attr_write_t callback.
- */
-typedef void (*btd_attr_write_result_t) (int err, void *user_data);
-/*
- * Service implementation callback passed to core (ATT layer). It manages write
- * operations received from remote devices.
- * @attr:	reference of the attribute to be changed.
- * @value:	new attribute value.
- * @len:	length of value.
- * @result:	callback called from the service implementation informing the
- *		result of the write operation.
- * @user_data:	user_data passed in btd_attr_write_result_t callback.
- */
-typedef void (*btd_attr_write_t) (struct btd_attribute *attr,
-					const uint8_t *value, size_t len,
-					btd_attr_write_result_t result,
-					void *user_data);
-
-/* btd_gatt_add_service - Add a service declaration to local attribute database.
- * @uuid:	Service UUID.
- *
- * Returns a reference to service declaration attribute. In case of error,
- * NULL is returned.
- */
-struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid);
-
-/*
- * btd_gatt_remove_service - Remove a service (along with all its
- * characteristics) from the local attribute database.
- * @service:	Service declaration attribute.
- */
-void btd_gatt_remove_service(struct btd_attribute *service);
-
-/*
- * btd_gatt_add_char - Add a characteristic (declaration and value attributes)
- * to local attribute database.
- * @uuid:	Characteristic UUID (16-bits or 128-bits).
- * @properties:	Characteristic properties. See Core SPEC 4.1 page 2183.
- * @read_cb:	Callback used to provide the characteristic value.
- * @write_cb:	Callback called to notify the implementation that a new value
- *              is available.
- *
- * Returns a reference to characteristic value attribute. In case of error,
- * NULL is returned.
- */
-struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
-						uint8_t properties,
-						btd_attr_read_t read_cb,
-						btd_attr_write_t write_cb);
-
-/*
- * btd_gatt_add_char_desc - Add a characteristic descriptor to the local
- * attribute database.
- * @uuid:	Characteristic Descriptor UUID (16-bits or 128-bits).
- * @read_cb:	Callback that should be called once the characteristic
- *		descriptor attribute is read.
- * @write_cb:	Callback that should be called once the characteristic
- *		descriptor attribute is written.
- *
- * Returns a reference to characteristic descriptor attribute. In case of
- * error, NULL is returned.
- */
-struct btd_attribute *btd_gatt_add_char_desc(const bt_uuid_t *uuid,
-						btd_attr_read_t read_cb,
-						btd_attr_write_t write_cb);
diff --git a/src/main.c b/src/main.c
index 05eb13d..679ee78 100644
--- a/src/main.c
+++ b/src/main.c
@@ -56,7 +56,6 @@
 #include "dbus-common.h"
 #include "agent.h"
 #include "profile.h"
-#include "gatt.h"
 #include "systemd.h"
 
 #define BLUEZ_NAME "org.bluez"
@@ -600,8 +599,6 @@ int main(int argc, char *argv[])
 
 	g_dbus_set_flags(gdbus_flags);
 
-	gatt_init();
-
 	if (adapter_init() < 0) {
 		error("Adapter handling initialization failed");
 		exit(1);
@@ -667,8 +664,6 @@ int main(int argc, char *argv[])
 
 	adapter_cleanup();
 
-	gatt_cleanup();
-
 	rfkill_exit();
 
 	stop_sdp_server();
-- 
2.2.0.rc0.207.ga3a616c

