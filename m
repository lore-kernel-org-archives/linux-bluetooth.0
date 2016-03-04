Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Olivier Martin <olivier@labapart.com>
To: linux-bluetooth@vger.kernel.org
Cc: olivier.martin.fr@gmail.com, Olivier Martin <olivier@labapart.com>
Subject: [PATCH v2] gatt-database: Fix GATT object ordering
Date: Fri,  4 Mar 2016 16:50:11 +0000
Message-Id: <1457110211-2702-1-git-send-email-olivier@labapart.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no guarantee the objects returned by GetManagedObjects
are ordered in the required order which is Service, Characteristic
Descriptor due to their respective dependencies.

This change ensures the objects are processed in the correct order.
---
 src/gatt-database.c | 105 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 30 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index d906e2b..93e4ddb 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -89,6 +89,7 @@ struct gatt_app {
 	GDBusClient *client;
 	bool failed;
 	struct queue *services;
+	struct queue *proxies;
 };
 
 struct external_service {
@@ -365,6 +366,7 @@ static void app_free(void *data)
 	struct gatt_app *app = data;
 
 	queue_destroy(app->services, service_free);
+	queue_destroy(app->proxies, NULL);
 
 	if (app->client) {
 		g_dbus_client_set_disconnect_watch(app->client, NULL, NULL);
@@ -1428,39 +1430,12 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 	if (app->failed)
 		return;
 
+	queue_push_tail(app->proxies, proxy);
+
 	iface = g_dbus_proxy_get_interface(proxy);
 	path = g_dbus_proxy_get_path(proxy);
 
-	if (g_strcmp0(iface, GATT_SERVICE_IFACE) == 0) {
-		struct external_service *service;
-
-		service = create_service(app, proxy, path);
-		if (!service) {
-			app->failed = true;
-			return;
-		}
-	} else if (g_strcmp0(iface, GATT_CHRC_IFACE) == 0) {
-		struct external_chrc *chrc;
-
-		chrc = chrc_create(app, proxy, path);
-		if (!chrc) {
-			app->failed = true;
-			return;
-		}
-	} else if (g_strcmp0(iface, GATT_DESC_IFACE) == 0) {
-		struct external_desc *desc;
-
-		desc = desc_create(app, proxy);
-		if (!desc) {
-			app->failed = true;
-			return;
-		}
-	} else {
-		DBG("Ignoring unrelated interface: %s", iface);
-		return;
-	}
-
-	DBG("Object added: path: %s, iface: %s", path, iface);
+	DBG("Object received: %s, iface: %s", path, iface);
 }
 
 static void proxy_removed_cb(GDBusProxy *proxy, void *user_data)
@@ -2139,12 +2114,81 @@ static bool database_add_app(struct gatt_app *app)
 	return true;
 }
 
+void register_service(void *data, void *user_data)
+{
+	struct gatt_app *app = user_data;
+	GDBusProxy *proxy = data;
+	const char *iface = g_dbus_proxy_get_interface(proxy);
+	const char *path = g_dbus_proxy_get_path(proxy);
+
+	if (g_strcmp0(iface, GATT_SERVICE_IFACE) == 0) {
+		struct external_service *service;
+
+		service = create_service(app, proxy, path);
+		if (!service) {
+			app->failed = true;
+			return;
+		}
+	}
+}
+
+void register_characteristic(void *data, void *user_data)
+{
+	struct gatt_app *app = user_data;
+	GDBusProxy *proxy = data;
+	const char *iface = g_dbus_proxy_get_interface(proxy);
+	const char *path = g_dbus_proxy_get_path(proxy);
+
+	if (g_strcmp0(iface, GATT_CHRC_IFACE) == 0) {
+		struct external_chrc *chrc;
+
+		chrc = chrc_create(app, proxy, path);
+		if (!chrc) {
+			app->failed = true;
+			return;
+		}
+	}
+}
+
+void register_descriptor(void *data, void *user_data)
+{
+	struct gatt_app *app = user_data;
+	GDBusProxy *proxy = data;
+	const char *iface = g_dbus_proxy_get_interface(proxy);
+	const char *path = g_dbus_proxy_get_path(proxy);
+
+	if (g_strcmp0(iface, GATT_DESC_IFACE) == 0) {
+		struct external_desc *desc;
+
+		desc = desc_create(app, proxy);
+		if (!desc) {
+			app->failed = true;
+			return;
+		}
+	}
+}
+
 static void client_ready_cb(GDBusClient *client, void *user_data)
 {
 	struct gatt_app *app = user_data;
 	DBusMessage *reply;
 	bool fail = false;
 
+	/*
+	 * Process received objects
+	 */
+	if (queue_isempty(app->proxies)) {
+		error("No object received");
+		fail = true;
+		reply = btd_error_failed(app->reg,
+					"No object received");
+		goto reply;
+	}
+
+	queue_foreach(app->proxies, register_service, app);
+	queue_foreach(app->proxies, register_characteristic, app);
+	queue_foreach(app->proxies, register_descriptor, app);
+
 	if (!app->services || app->failed) {
 		error("No valid external GATT objects found");
 		fail = true;
@@ -2198,6 +2242,7 @@ static struct gatt_app *create_app(DBusConnection *conn, DBusMessage *msg,
 		goto fail;
 
 	app->services = queue_new();
+	app->proxies = queue_new();
 	app->reg = dbus_message_ref(msg);
 
 	g_dbus_client_set_disconnect_watch(app->client, client_disconnect_cb,
-- 
2.1.4

