Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 3/7] gatt: Rename external_app to external_service
Date: Wed,  2 Apr 2014 15:30:22 -0300
Message-Id: <1396463426-7268-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1396463426-7268-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1396463426-7268-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Even for external applications providing multiple services, each
external service should have its own instance of GDBusClient. This
approach allows a more dynamic management of the registered services.
Based on this assumption, rename the external_app to external_service
is more logical.
---
 src/gatt-dbus.c | 107 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 54 insertions(+), 53 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 1bfa21f..b29371d 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -50,7 +50,7 @@
 #define GATT_CHR_IFACE			"org.bluez.GattCharacteristic1"
 #define GATT_DESCRIPTOR_IFACE		"org.bluez.GattDescriptor1"
 
-struct external_app {
+struct external_service {
 	char *owner;
 	char *path;
 	DBusMessage *reg;
@@ -70,31 +70,31 @@ struct proxy_write_data {
  */
 static GHashTable *proxy_hash;
 
-static GSList *external_apps;
+static GSList *external_services;
 
-static int external_app_path_cmp(gconstpointer a, gconstpointer b)
+static int external_service_path_cmp(gconstpointer a, gconstpointer b)
 {
-	const struct external_app *eapp = a;
+	const struct external_service *esvc = a;
 	const char *path = b;
 
-	return g_strcmp0(eapp->path, path);
+	return g_strcmp0(esvc->path, path);
 }
 
-static void external_app_watch_destroy(gpointer user_data)
+static void external_service_watch_destroy(gpointer user_data)
 {
-	struct external_app *eapp = user_data;
+	struct external_service *esvc = user_data;
 
 	/* TODO: Remove from the database */
 
-	external_apps = g_slist_remove(external_apps, eapp);
+	external_services = g_slist_remove(external_services, esvc);
 
-	g_dbus_client_unref(eapp->client);
-	if (eapp->reg)
-		dbus_message_unref(eapp->reg);
+	g_dbus_client_unref(esvc->client);
+	if (esvc->reg)
+		dbus_message_unref(esvc->reg);
 
-	g_free(eapp->owner);
-	g_free(eapp->path);
-	g_free(eapp);
+	g_free(esvc->owner);
+	g_free(esvc->path);
+	g_free(esvc);
 }
 
 static int proxy_path_cmp(gconstpointer a, gconstpointer b)
@@ -167,13 +167,13 @@ fail:
 
 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
-	struct external_app *eapp = user_data;
+	struct external_service *esvc = user_data;
 	const char *interface, *path;
 
 	interface = g_dbus_proxy_get_interface(proxy);
 	path = g_dbus_proxy_get_path(proxy);
 
-	if (!g_str_has_prefix(path, eapp->path))
+	if (!g_str_has_prefix(path, esvc->path))
 		return;
 
 	if (g_strcmp0(interface, GATT_CHR_IFACE) != 0 &&
@@ -188,13 +188,13 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 	 * proxies sorted by path helps the logic to register the
 	 * object path later.
 	 */
-	eapp->proxies = g_slist_insert_sorted(eapp->proxies, proxy,
+	esvc->proxies = g_slist_insert_sorted(esvc->proxies, proxy,
 							proxy_path_cmp);
 }
 
 static void proxy_removed(GDBusProxy *proxy, void *user_data)
 {
-	struct external_app *eapp = user_data;
+	struct external_service *esvc = user_data;
 	const char *interface, *path;
 
 	interface = g_dbus_proxy_get_interface(proxy);
@@ -202,7 +202,7 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 
 	DBG("path %s iface %s", path, interface);
 
-	eapp->proxies = g_slist_remove(eapp->proxies, proxy);
+	esvc->proxies = g_slist_remove(esvc->proxies, proxy);
 }
 
 static void proxy_read_cb(struct btd_attribute *attr,
@@ -323,7 +323,7 @@ static void proxy_write_cb(struct btd_attribute *attr,
 
 }
 
-static int register_external_service(const struct external_app *eapp,
+static int register_external_service(const struct external_service *esvc,
 							GDBusProxy *proxy)
 {
 	DBusMessageIter iter;
@@ -332,7 +332,7 @@ static int register_external_service(const struct external_app *eapp,
 
 	path = g_dbus_proxy_get_path(proxy);
 	iface = g_dbus_proxy_get_interface(proxy);
-	if (g_strcmp0(eapp->path, path) != 0 ||
+	if (g_strcmp0(esvc->path, path) != 0 ||
 			g_strcmp0(iface, GATT_SERVICE_IFACE) != 0)
 		return -EINVAL;
 
@@ -450,43 +450,43 @@ static int register_external_characteristics(GSList *proxies)
 
 static void client_ready(GDBusClient *client, void *user_data)
 {
-	struct external_app *eapp = user_data;
+	struct external_service *esvc = user_data;
 	GDBusProxy *proxy;
 	DBusConnection *conn = btd_get_dbus_connection();
 	DBusMessage *reply;
 
-	if (!eapp->proxies)
+	if (!esvc->proxies)
 		goto fail;
 
-	proxy = eapp->proxies->data;
-	if (register_external_service(eapp, proxy) < 0)
+	proxy = esvc->proxies->data;
+	if (register_external_service(esvc, proxy) < 0)
 		goto fail;
 
-	if (register_external_characteristics(g_slist_next(eapp->proxies)) < 0)
+	if (register_external_characteristics(g_slist_next(esvc->proxies)) < 0)
 		goto fail;
 
-	DBG("Added GATT service %s", eapp->path);
+	DBG("Added GATT service %s", esvc->path);
 
-	reply = dbus_message_new_method_return(eapp->reg);
+	reply = dbus_message_new_method_return(esvc->reg);
 	goto reply;
 
 fail:
-	error("Could not register external service: %s", eapp->path);
+	error("Could not register external service: %s", esvc->path);
 
-	reply = btd_error_invalid_args(eapp->reg);
-	/* TODO: missing eapp/database cleanup */
+	reply = btd_error_invalid_args(esvc->reg);
+	/* TODO: missing esvc/database cleanup */
 
 reply:
-	dbus_message_unref(eapp->reg);
-	eapp->reg = NULL;
+	dbus_message_unref(esvc->reg);
+	esvc->reg = NULL;
 
 	g_dbus_send_message(conn, reply);
 }
 
-static struct external_app *new_external_app(DBusConnection *conn,
+static struct external_service *new_external_service(DBusConnection *conn,
 					DBusMessage *msg, const char *path)
 {
-	struct external_app *eapp;
+	struct external_service *esvc;
 	GDBusClient *client;
 	const char *sender = dbus_message_get_sender(msg);
 
@@ -494,33 +494,33 @@ static struct external_app *new_external_app(DBusConnection *conn,
 	if (!client)
 		return NULL;
 
-	eapp = g_new0(struct external_app, 1);
+	esvc = g_new0(struct external_service, 1);
 
-	eapp->watch = g_dbus_add_disconnect_watch(btd_get_dbus_connection(),
-			sender, NULL, eapp, external_app_watch_destroy);
-	if (eapp->watch == 0) {
+	esvc->watch = g_dbus_add_disconnect_watch(btd_get_dbus_connection(),
+			sender, NULL, esvc, external_service_watch_destroy);
+	if (esvc->watch == 0) {
 		g_dbus_client_unref(client);
-		g_free(eapp);
+		g_free(esvc);
 		return NULL;
 	}
 
-	eapp->owner = g_strdup(sender);
-	eapp->reg = dbus_message_ref(msg);
-	eapp->client = client;
-	eapp->path = g_strdup(path);
+	esvc->owner = g_strdup(sender);
+	esvc->reg = dbus_message_ref(msg);
+	esvc->client = client;
+	esvc->path = g_strdup(path);
 
 	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
-								NULL, eapp);
+								NULL, esvc);
 
-	g_dbus_client_set_ready_watch(client, client_ready, eapp);
+	g_dbus_client_set_ready_watch(client, client_ready, esvc);
 
-	return eapp;
+	return esvc;
 }
 
 static DBusMessage *register_service(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	struct external_app *eapp;
+	struct external_service *esvc;
 	DBusMessageIter iter;
 	const char *path;
 
@@ -532,16 +532,17 @@ static DBusMessage *register_service(DBusConnection *conn,
 
 	dbus_message_iter_get_basic(&iter, &path);
 
-	if (g_slist_find_custom(external_apps, path, external_app_path_cmp))
+	if (g_slist_find_custom(external_services, path,
+						external_service_path_cmp))
 		return btd_error_already_exists(msg);
 
-	eapp = new_external_app(conn, msg, path);
-	if (!eapp)
+	esvc = new_external_service(conn, msg, path);
+	if (!esvc)
 		return btd_error_failed(msg, "Not enough resources");
 
-	external_apps = g_slist_prepend(external_apps, eapp);
+	external_services = g_slist_prepend(external_services, esvc);
 
-	DBG("New app %p: %s", eapp, path);
+	DBG("New service %p: %s", esvc, path);
 
 	return NULL;
 }
-- 
1.8.3.1

