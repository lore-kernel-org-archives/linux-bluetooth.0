Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] core/gatt-database: Implement Application API
Date: Tue,  5 Jan 2016 14:54:36 -0300
Message-Id: <1452016478-17221-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1452016478-17221-1-git-send-email-luiz.dentz@gmail.com>
References: <1452016478-17221-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements RegisterApplication/UnregisterApplication that allow
multiple services to be registered at once.
---
 src/gatt-database.c | 446 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 273 insertions(+), 173 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index e8ce7d5..ac0d92e 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -77,17 +77,23 @@ struct btd_gatt_database {
 	struct queue *ccc_callbacks;
 	struct gatt_db_attribute *svc_chngd;
 	struct gatt_db_attribute *svc_chngd_ccc;
-	struct queue *services;
+	struct queue *apps;
 	struct queue *profiles;
 };
 
-struct external_service {
+struct gatt_app {
 	struct btd_gatt_database *database;
-	bool failed;
 	char *owner;
-	char *path;	/* Path to GattService1 */
+	char *path;
 	DBusMessage *reg;
 	GDBusClient *client;
+	bool failed;
+	struct queue *services;
+};
+
+struct external_service {
+	struct gatt_app *app;
+	char *path;	/* Path to GattService1 */
 	GDBusProxy *proxy;
 	struct gatt_db_attribute *attrib;
 	uint16_t attr_cnt;
@@ -342,26 +348,41 @@ static void service_free(void *data)
 	queue_destroy(service->chrcs, chrc_free);
 	queue_destroy(service->descs, desc_free);
 
-	gatt_db_remove_service(service->database->db, service->attrib);
+	if (service->attrib)
+		gatt_db_remove_service(service->app->database->db,
+							service->attrib);
 
-	if (service->client) {
-		g_dbus_client_set_disconnect_watch(service->client, NULL, NULL);
-		g_dbus_client_set_proxy_handlers(service->client, NULL, NULL,
-								NULL, NULL);
-		g_dbus_client_set_ready_watch(service->client, NULL, NULL);
+	if (service->app->client)
 		g_dbus_proxy_unref(service->proxy);
-		g_dbus_client_unref(service->client);
-	}
-
-	if (service->reg)
-		dbus_message_unref(service->reg);
 
-	g_free(service->owner);
 	g_free(service->path);
 
 	free(service);
 }
 
+static void app_free(void *data)
+{
+	struct gatt_app *app = data;
+
+	queue_destroy(app->services, service_free);
+
+	if (app->client) {
+		g_dbus_client_set_disconnect_watch(app->client, NULL, NULL);
+		g_dbus_client_set_proxy_handlers(app->client, NULL, NULL,
+								NULL, NULL);
+		g_dbus_client_set_ready_watch(app->client, NULL, NULL);
+		g_dbus_client_unref(app->client);
+	}
+
+	if (app->reg)
+		dbus_message_unref(app->reg);
+
+	g_free(app->owner);
+	g_free(app->path);
+
+	free(app);
+}
+
 static void profile_remove(void *data)
 {
 	struct btd_profile *p = data;
@@ -434,7 +455,7 @@ static void gatt_database_free(void *data)
 	gatt_db_unregister(database->db, database->db_id);
 
 	queue_destroy(database->device_states, device_state_free);
-	queue_destroy(database->services, service_free);
+	queue_destroy(database->apps, app_free);
 	queue_destroy(database->profiles, profile_free);
 	queue_destroy(database->ccc_callbacks, ccc_cb_free);
 	database->device_states = NULL;
@@ -1012,67 +1033,101 @@ struct svc_match_data {
 	const char *sender;
 };
 
-static bool match_service(const void *a, const void *b)
+static bool match_app(const void *a, const void *b)
 {
-	const struct external_service *service = a;
+	const struct gatt_app *app = a;
 	const struct svc_match_data *data = b;
 
-	return g_strcmp0(service->path, data->path) == 0 &&
-				g_strcmp0(service->owner, data->sender) == 0;
+	return g_strcmp0(app->path, data->path) == 0 &&
+				g_strcmp0(app->owner, data->sender) == 0;
 }
 
-static gboolean service_free_idle_cb(void *data)
+static gboolean app_free_idle_cb(void *data)
 {
-	service_free(data);
+	app_free(data);
 
 	return FALSE;
 }
 
-static void service_remove_helper(void *data)
-{
-	struct external_service *service = data;
-
-	queue_remove(service->database->services, service);
-
-	/*
-	 * Do not run in the same loop, this may be a disconnect
-	 * watch call and GDBusClient should not be destroyed.
-	 */
-	g_idle_add(service_free_idle_cb, service);
-}
-
 static void client_disconnect_cb(DBusConnection *conn, void *user_data)
 {
+	struct gatt_app *app = user_data;
+	struct btd_gatt_database *database = app->database;
+
 	DBG("Client disconnected");
 
-	service_remove_helper(user_data);
+	if (queue_remove(database->apps, app))
+		app_free(app);
 }
 
-static void remove_service(void *data)
+static void remove_app(void *data)
 {
-	struct external_service *service = data;
+	struct gatt_app *app = data;
 
 	/*
 	 * Set callback to NULL to avoid potential race condition
-	 * when calling remove_service and GDBusClient unref.
+	 * when calling remove_app and GDBusClient unref.
 	 */
-	g_dbus_client_set_disconnect_watch(service->client, NULL, NULL);
+	g_dbus_client_set_disconnect_watch(app->client, NULL, NULL);
 
 	/*
 	 * Set proxy handlers to NULL, so that this gets called only once when
 	 * the first proxy that belongs to this service gets removed.
 	 */
-	g_dbus_client_set_proxy_handlers(service->client, NULL, NULL,
-								NULL, NULL);
+	g_dbus_client_set_proxy_handlers(app->client, NULL, NULL, NULL, NULL);
+
+
+	queue_remove(app->database->apps, app);
+
+	/*
+	 * Do not run in the same loop, this may be a disconnect
+	 * watch call and GDBusClient should not be destroyed.
+	 */
+	g_idle_add(app_free_idle_cb, app);
+}
+
+static bool match_service_by_path(const void *a, const void *b)
+{
+	const struct external_service *service = a;
+	const char *path = b;
 
-	service_remove_helper(service);
+	return strcmp(service->path, path) == 0;
 }
 
-static struct external_chrc *chrc_create(struct external_service *service,
+static bool parse_path(GDBusProxy *proxy, const char *name, const char **path)
+{
+	DBusMessageIter iter;
+
+	if (!g_dbus_proxy_get_property(proxy, name, &iter))
+		return false;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_OBJECT_PATH)
+		return false;
+
+	dbus_message_iter_get_basic(&iter, path);
+
+	return true;
+}
+
+static struct external_chrc *chrc_create(struct gatt_app *app,
 							GDBusProxy *proxy,
 							const char *path)
 {
+	struct external_service *service;
 	struct external_chrc *chrc;
+	const char *service_path;
+
+	if (!parse_path(proxy, "Service", &service_path)) {
+		error("Failed to obtain service path for characteristic");
+		return NULL;
+	}
+
+	service = queue_find(app->services, match_service_by_path,
+								service_path);
+	if (!service) {
+		error("Unable to find service for characteristic: %s", path);
+		return NULL;
+	}
 
 	chrc = new0(struct external_chrc, 1);
 	chrc->pending_reads = queue_new();
@@ -1092,11 +1147,40 @@ static struct external_chrc *chrc_create(struct external_service *service,
 	return chrc;
 }
 
-static struct external_desc *desc_create(struct external_service *service,
-							GDBusProxy *proxy,
-							const char *chrc_path)
+static bool match_chrc(const void *a, const void *b)
+{
+	const struct external_chrc *chrc = a;
+	const char *path = b;
+
+	return strcmp(chrc->path, path) == 0;
+}
+
+static bool match_service_by_chrc(const void *a, const void *b)
+{
+	const struct external_service *service = a;
+	const char *path = b;
+
+	return queue_find(service->chrcs, match_chrc, path);
+}
+
+static struct external_desc *desc_create(struct gatt_app *app,
+							GDBusProxy *proxy)
 {
+	struct external_service *service;
 	struct external_desc *desc;
+	const char *chrc_path;
+
+	if (!parse_path(proxy, "Characteristic", &chrc_path)) {
+		error("Failed to obtain characteristic path for descriptor");
+		return NULL;
+	}
+
+	service = queue_find(app->services, match_service_by_chrc, chrc_path);
+	if (!service) {
+		error("Unable to find service for characteristic: %s",
+								chrc_path);
+		return NULL;
+	}
 
 	desc = new0(struct external_desc, 1);
 	desc->pending_reads = queue_new();
@@ -1126,21 +1210,6 @@ static bool incr_attr_count(struct external_service *service, uint16_t incr)
 	return true;
 }
 
-static bool parse_path(GDBusProxy *proxy, const char *name, const char **path)
-{
-	DBusMessageIter iter;
-
-	if (!g_dbus_proxy_get_property(proxy, name, &iter))
-		return false;
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_OBJECT_PATH)
-		return false;
-
-	dbus_message_iter_get_basic(&iter, path);
-
-	return true;
-}
-
 static bool check_service_path(GDBusProxy *proxy,
 					struct external_service *service)
 {
@@ -1259,54 +1328,74 @@ static bool parse_flags(GDBusProxy *proxy, uint8_t *props, uint8_t *ext_props,
 	return parse_chrc_flags(&array, props, ext_props);
 }
 
+static struct external_service *create_service(struct gatt_app *app,
+						GDBusProxy *proxy,
+						const char *path)
+{
+	struct external_service *service;
+
+	if (!path || !g_str_has_prefix(path, "/"))
+		return NULL;
+
+	service = queue_find(app->services, match_service_by_path, path);
+	if (service) {
+		error("Duplicated service: %s", path);
+		return NULL;
+	}
+
+	service = new0(struct external_service, 1);
+
+	service->app = app;
+
+	service->path = g_strdup(path);
+	if (!service->path)
+		goto fail;
+
+	service->proxy = g_dbus_proxy_ref(proxy);
+	service->chrcs = queue_new();
+	service->descs = queue_new();
+
+	return service;
+
+fail:
+	service_free(service);
+	return NULL;
+}
+
 static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 {
-	struct external_service *service = user_data;
+	struct gatt_app *app = user_data;
 	const char *iface, *path;
 
-	if (service->failed || service->attrib)
+	if (app->failed)
 		return;
 
 	iface = g_dbus_proxy_get_interface(proxy);
 	path = g_dbus_proxy_get_path(proxy);
 
-	if (!g_str_has_prefix(path, service->path))
-		return;
-
 	if (g_strcmp0(iface, GATT_SERVICE_IFACE) == 0) {
-		if (service->proxy)
-			return;
+		struct external_service *service;
 
-		/*
-		 * TODO: We may want to support adding included services in a
-		 * single hierarchy.
-		 */
-		if (g_strcmp0(path, service->path) != 0) {
-			error("Multiple services added within hierarchy");
-			service->failed = true;
+		service = create_service(app, proxy, path);
+		if (!service) {
+			app->failed = true;
 			return;
 		}
 
 		/* Add 1 for the service declaration */
 		if (!incr_attr_count(service, 1)) {
 			error("Failed to increment attribute count");
-			service->failed = true;
+			app->failed = true;
 			return;
 		}
 
-		service->proxy = g_dbus_proxy_ref(proxy);
+		queue_push_tail(app->services, service);
 	} else if (g_strcmp0(iface, GATT_CHRC_IFACE) == 0) {
 		struct external_chrc *chrc;
 
-		if (g_strcmp0(path, service->path) == 0) {
-			error("Characteristic path same as service path");
-			service->failed = true;
-			return;
-		}
-
-		chrc = chrc_create(service, proxy, path);
+		chrc = chrc_create(app, proxy, path);
 		if (!chrc) {
-			service->failed = true;
+			app->failed = true;
 			return;
 		}
 
@@ -1314,9 +1403,9 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 		 * Add 2 for the characteristic declaration and the value
 		 * attribute.
 		 */
-		if (!incr_attr_count(service, 2)) {
+		if (!incr_attr_count(chrc->service, 2)) {
 			error("Failed to increment attribute count");
-			service->failed = true;
+			app->failed = true;
 			return;
 		}
 
@@ -1327,46 +1416,38 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 		 */
 		if (!parse_flags(proxy, &chrc->props, &chrc->ext_props, NULL)) {
 			error("Failed to parse characteristic properties");
-			service->failed = true;
+			app->failed = true;
 			return;
 		}
 
 		if ((chrc->props & BT_GATT_CHRC_PROP_NOTIFY ||
 				chrc->props & BT_GATT_CHRC_PROP_INDICATE) &&
-				!incr_attr_count(service, 1)) {
+				!incr_attr_count(chrc->service, 1)) {
 			error("Failed to increment attribute count for CCC");
-			service->failed = true;
+			app->failed = true;
 			return;
 		}
 
-		if (chrc->ext_props && !incr_attr_count(service, 1)) {
+		if (chrc->ext_props && !incr_attr_count(chrc->service, 1)) {
 			error("Failed to increment attribute count for CEP");
-			service->failed = true;
+			app->failed = true;
 			return;
 		}
 
-		queue_push_tail(service->chrcs, chrc);
+		queue_push_tail(chrc->service->chrcs, chrc);
 	} else if (g_strcmp0(iface, GATT_DESC_IFACE) == 0) {
 		struct external_desc *desc;
-		const char *chrc_path;
 
-		if (!parse_path(proxy, "Characteristic", &chrc_path)) {
-			error("Failed to obtain characteristic path for "
-								"descriptor");
-			service->failed = true;
-			return;
-		}
-
-		desc = desc_create(service, proxy, chrc_path);
+		desc = desc_create(app, proxy);
 		if (!desc) {
-			service->failed = true;
+			app->failed = true;
 			return;
 		}
 
 		/* Add 1 for the descriptor attribute */
-		if (!incr_attr_count(service, 1)) {
+		if (!incr_attr_count(desc->service, 1)) {
 			error("Failed to increment attribute count");
-			service->failed = true;
+			app->failed = true;
 			return;
 		}
 
@@ -1376,32 +1457,35 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 		 */
 		if (!parse_flags(proxy, NULL, NULL, &desc->perm)) {
 			error("Failed to parse characteristic properties");
-			service->failed = true;
+			app->failed = true;
 			return;
 		}
 
-		queue_push_tail(service->descs, desc);
+		queue_push_tail(desc->service->descs, desc);
 	} else {
 		DBG("Ignoring unrelated interface: %s", iface);
 		return;
 	}
 
-	DBG("Object added to service - path: %s, iface: %s", path, iface);
+	DBG("Object added: path: %s, iface: %s", path, iface);
 }
 
 static void proxy_removed_cb(GDBusProxy *proxy, void *user_data)
 {
-	struct external_service *service = user_data;
+	struct gatt_app *app = user_data;
+	struct external_service *service;
 	const char *path;
 
 	path = g_dbus_proxy_get_path(proxy);
 
-	if (!g_str_has_prefix(path, service->path))
+	service = queue_remove_if(app->services, match_service_by_path,
+							(void *) path);
+	if (!service)
 		return;
 
 	DBG("Proxy removed - removing service: %s", service->path);
 
-	remove_service(service);
+	service_free(service);
 }
 
 static bool parse_uuid(GDBusProxy *proxy, bt_uuid_t *uuid)
@@ -1769,7 +1853,7 @@ static void property_changed_cb(GDBusProxy *proxy, const char *name,
 	len = MIN(BT_ATT_MAX_VALUE_LEN, len);
 	value = len ? value : NULL;
 
-	send_notification_to_devices(chrc->service->database,
+	send_notification_to_devices(chrc->service->app->database,
 				gatt_db_attribute_get_handle(chrc->attrib),
 				value, len,
 				gatt_db_attribute_get_handle(chrc->ccc),
@@ -1783,7 +1867,7 @@ static bool database_add_ccc(struct external_service *service,
 				!(chrc->props & BT_GATT_CHRC_PROP_INDICATE))
 		return true;
 
-	chrc->ccc = service_add_ccc(service->attrib, service->database,
+	chrc->ccc = service_add_ccc(service->attrib, service->app->database,
 						ccc_write_cb, chrc, NULL);
 	if (!chrc->ccc) {
 		error("Failed to create CCC entry for characteristic");
@@ -1992,7 +2076,7 @@ static bool match_desc_unhandled(const void *a, const void *b)
 	return !desc->handled;
 }
 
-static bool create_service_entry(struct external_service *service)
+static bool database_add_service(struct external_service *service)
 {
 	bt_uuid_t uuid;
 	bool primary;
@@ -2008,7 +2092,7 @@ static bool create_service_entry(struct external_service *service)
 		return false;
 	}
 
-	service->attrib = gatt_db_add_service(service->database->db, &uuid,
+	service->attrib = gatt_db_add_service(service->app->database->db, &uuid,
 						primary, service->attr_cnt);
 	if (!service->attrib)
 		return false;
@@ -2036,98 +2120,114 @@ static bool create_service_entry(struct external_service *service)
 	return true;
 
 fail:
-	gatt_db_remove_service(service->database->db, service->attrib);
+	gatt_db_remove_service(service->app->database->db, service->attrib);
 	service->attrib = NULL;
 
 	return false;
 }
 
+static bool database_add_app(struct gatt_app *app)
+{
+	const struct queue_entry *entry;
+
+	if (queue_isempty(app->services))
+		return false;
+
+	entry = queue_get_entries(app->services);
+	while (entry) {
+		if (!database_add_service(entry->data)) {
+			error("Failed to add service");
+			return false;
+		}
+
+		entry = entry->next;
+	}
+
+	return true;
+}
+
 static void client_ready_cb(GDBusClient *client, void *user_data)
 {
-	struct external_service *service = user_data;
+	struct gatt_app *app = user_data;
 	DBusMessage *reply;
 	bool fail = false;
 
-	if (!service->proxy || service->failed) {
+	if (!app->services || app->failed) {
 		error("No valid external GATT objects found");
 		fail = true;
-		reply = btd_error_failed(service->reg,
+		reply = btd_error_failed(app->reg,
 					"No valid service object found");
 		goto reply;
 	}
 
-	if (!create_service_entry(service)) {
+	if (!database_add_app(app)) {
 		error("Failed to create GATT service entry in local database");
 		fail = true;
-		reply = btd_error_failed(service->reg,
+		reply = btd_error_failed(app->reg,
 					"Failed to create entry in database");
 		goto reply;
 	}
 
-	DBG("GATT service registered: %s", service->path);
+	DBG("GATT application registered: %s:%s", app->owner, app->path);
 
-	reply = dbus_message_new_method_return(service->reg);
+	reply = dbus_message_new_method_return(app->reg);
 
 reply:
 	g_dbus_send_message(btd_get_dbus_connection(), reply);
-	dbus_message_unref(service->reg);
-	service->reg = NULL;
+	dbus_message_unref(app->reg);
+	app->reg = NULL;
 
 	if (fail)
-		remove_service(service);
+		remove_app(app);
 }
 
-static struct external_service *create_service(DBusConnection *conn,
-					DBusMessage *msg, const char *path)
+static struct gatt_app *create_app(DBusConnection *conn, DBusMessage *msg,
+							const char *path)
 {
-	struct external_service *service;
+	struct gatt_app *app;
 	const char *sender = dbus_message_get_sender(msg);
 
 	if (!path || !g_str_has_prefix(path, "/"))
 		return NULL;
 
-	service = new0(struct external_service, 1);
+	app = new0(struct gatt_app, 1);
 
-	service->client = g_dbus_client_new_full(conn, sender, path, path);
-	if (!service->client)
+	app->client = g_dbus_client_new_full(conn, sender, path, path);
+	if (!app->client)
 		goto fail;
 
-	service->owner = g_strdup(sender);
-	if (!service->owner)
+	app->owner = g_strdup(sender);
+	if (!app->owner)
 		goto fail;
 
-	service->path = g_strdup(path);
-	if (!service->path)
+	app->path = g_strdup(path);
+	if (!app->path)
 		goto fail;
 
-	service->chrcs = queue_new();
-	service->descs = queue_new();
-
-	service->reg = dbus_message_ref(msg);
+	app->services = queue_new();
+	app->reg = dbus_message_ref(msg);
 
-	g_dbus_client_set_disconnect_watch(service->client,
-						client_disconnect_cb, service);
-	g_dbus_client_set_proxy_handlers(service->client, proxy_added_cb,
-							proxy_removed_cb, NULL,
-							service);
-	g_dbus_client_set_ready_watch(service->client, client_ready_cb,
-								service);
+	g_dbus_client_set_disconnect_watch(app->client, client_disconnect_cb,
+									app);
+	g_dbus_client_set_proxy_handlers(app->client, proxy_added_cb,
+					proxy_removed_cb, NULL, app);
+	g_dbus_client_set_ready_watch(app->client, client_ready_cb, app);
 
-	return service;
+	return app;
 
 fail:
-	service_free(service);
+	app_free(app);
 	return NULL;
 }
 
-static DBusMessage *manager_register_service(DBusConnection *conn,
+static DBusMessage *manager_register_app(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
 	struct btd_gatt_database *database = user_data;
 	const char *sender = dbus_message_get_sender(msg);
 	DBusMessageIter args;
 	const char *path;
-	struct external_service *service;
+	struct gatt_app *app;
 	struct svc_match_data match_data;
 
 	if (!dbus_message_iter_init(msg, &args))
@@ -2141,33 +2241,33 @@ static DBusMessage *manager_register_service(DBusConnection *conn,
 	match_data.path = path;
 	match_data.sender = sender;
 
-	if (queue_find(database->services, match_service, &match_data))
+	if (queue_find(database->apps, match_app, &match_data))
 		return btd_error_already_exists(msg);
 
 	dbus_message_iter_next(&args);
 	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY)
 		return btd_error_invalid_args(msg);
 
-	service = create_service(conn, msg, path);
-	if (!service)
-		return btd_error_failed(msg, "Failed to register service");
+	app = create_app(conn, msg, path);
+	if (!app)
+		return btd_error_failed(msg, "Failed to register application");
 
-	DBG("Registering service - path: %s", path);
+	DBG("Registering application: %s:%s", sender, path);
 
-	service->database = database;
-	queue_push_tail(database->services, service);
+	app->database = database;
+	queue_push_tail(database->apps, app);
 
 	return NULL;
 }
 
-static DBusMessage *manager_unregister_service(DBusConnection *conn,
+static DBusMessage *manager_unregister_app(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
 	struct btd_gatt_database *database = user_data;
 	const char *sender = dbus_message_get_sender(msg);
 	const char *path;
 	DBusMessageIter args;
-	struct external_service *service;
+	struct gatt_app *app;
 	struct svc_match_data match_data;
 
 	if (!dbus_message_iter_init(msg, &args))
@@ -2181,12 +2281,11 @@ static DBusMessage *manager_unregister_service(DBusConnection *conn,
 	match_data.path = path;
 	match_data.sender = sender;
 
-	service = queue_remove_if(database->services, match_service,
-								&match_data);
-	if (!service)
+	app = queue_remove_if(database->apps, match_app, &match_data);
+	if (!app)
 		return btd_error_does_not_exist(msg);
 
-	service_free(service);
+	app_free(app);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -2389,12 +2488,13 @@ static DBusMessage *manager_unregister_profile(DBusConnection *conn,
 }
 
 static const GDBusMethodTable manager_methods[] = {
-	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterService",
-			GDBUS_ARGS({ "service", "o" }, { "options", "a{sv}" }),
-			NULL, manager_register_service) },
-	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("UnregisterService",
-					GDBUS_ARGS({ "service", "o" }),
-					NULL, manager_unregister_service) },
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterApplication",
+			GDBUS_ARGS({ "application", "o" },
+			{ "options", "a{sv}" }), NULL,
+			manager_register_app) },
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("UnregisterApplication",
+					GDBUS_ARGS({ "application", "o" }),
+					NULL, manager_unregister_app) },
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterProfile",
 			GDBUS_ARGS({ "profile", "o" }, { "UUIDs", "as" },
 			{ "options", "a{sv}" }), NULL,
@@ -2418,7 +2518,7 @@ struct btd_gatt_database *btd_gatt_database_new(struct btd_adapter *adapter)
 	database->adapter = btd_adapter_ref(adapter);
 	database->db = gatt_db_new();
 	database->device_states = queue_new();
-	database->services = queue_new();
+	database->apps = queue_new();
 	database->profiles = queue_new();
 	database->ccc_callbacks = queue_new();
 
-- 
2.4.3

