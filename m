Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] doc/gatt-api: Merge RegisterProfile with RegisterApplication
Date: Fri,  6 May 2016 22:11:00 +0300
Message-Id: <1462561862-500-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1462561862-500-1-git-send-email-luiz.dentz@gmail.com>
References: <1462561862-500-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Since RegisterApplication makes use of ObjectManager it is also possible
to verify the existance of GattProfile objects unifying the API for both
services (GATT server) and profiles (GATT client).
---
 doc/gatt-api.txt    |  37 ++---
 src/gatt-database.c | 414 +++++++++++++++++++++-------------------------------
 2 files changed, 172 insertions(+), 279 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 683b1b7..9404986 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -218,8 +218,8 @@ Properties	string UUID [read-only]
 				"encrypt-authenticated-read"
 				"encrypt-authenticated-write"
 
-Profile hierarcy
-================
+GATT Profile hierarcy
+=====================
 
 Local profile (GATT client) instance. By registering this type of object
 an application effectively indicates support for a specific GATT profile
@@ -238,6 +238,10 @@ Methods		void Release()
 			profile, because when this method gets called it has
 			already been unregistered.
 
+Properties	array{string} UUIDs [read-only]
+
+			128-bit GATT service UUIDs.
+
 
 GATT Manager hierarchy
 ======================
@@ -306,11 +310,12 @@ Object path	[variable prefix]/{hci0,hci1,...}
 Methods		void RegisterApplication(object application, dict options)
 
 			Registers a local GATT services hierarchy as described
-			above.
+			above (GATT Server) and/or GATT profiles (GATT Client).
 
 			The application object path together with the D-Bus
 			system bus connection ID define the identification of
-			the application registering a GATT based service.
+			the application registering a GATT based
+			service or profile.
 
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.AlreadyExists
@@ -324,27 +329,3 @@ Methods		void RegisterApplication(object application, dict options)
 
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.DoesNotExist
-
-		void RegisterProfile(object profile, array{string} UUIDs,
-				     dict options)
-
-			Registers a GATT (client role) profile exported
-			under interface GattProfile1. The array of UUIDs
-			specifies the mandatory set of remote service
-			UUIDs that should all be available for the
-			remote device to match this profile. Matching
-			devices will be added to the auto-connection
-			list and connected whenever available.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.AlreadyExists
-
-		void UnregisterProfile(object profile)
-
-			This unregisters the profile that has been
-			previously registered. The object path parameter
-			must match the same value that has been used
-			on registration.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.DoesNotExist
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 7f36ffd..594972a 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -54,6 +54,7 @@
 #endif
 
 #define GATT_MANAGER_IFACE	"org.bluez.GattManager1"
+#define GATT_PROFILE_IFACE	"org.bluez.GattProfile1"
 #define GATT_SERVICE_IFACE	"org.bluez.GattService1"
 #define GATT_CHRC_IFACE		"org.bluez.GattCharacteristic1"
 #define GATT_DESC_IFACE		"org.bluez.GattDescriptor1"
@@ -88,6 +89,7 @@ struct gatt_app {
 	DBusMessage *reg;
 	GDBusClient *client;
 	bool failed;
+	struct queue *profiles;
 	struct queue *services;
 	struct queue *proxies;
 };
@@ -103,10 +105,8 @@ struct external_service {
 };
 
 struct external_profile {
-	struct btd_gatt_database *database;
-	char *owner;
-	char *path;	/* Path to GattProfile1 */
-	unsigned int id;
+	struct gatt_app *app;
+	GDBusProxy *proxy;
 	struct queue *profiles; /* btd_profile list */
 };
 
@@ -362,30 +362,6 @@ static void service_free(void *data)
 	free(service);
 }
 
-static void app_free(void *data)
-{
-	struct gatt_app *app = data;
-
-	queue_destroy(app->services, service_free);
-	queue_destroy(app->proxies, NULL);
-
-	if (app->client) {
-		g_dbus_client_set_disconnect_watch(app->client, NULL, NULL);
-		g_dbus_client_set_proxy_handlers(app->client, NULL, NULL,
-								NULL, NULL);
-		g_dbus_client_set_ready_watch(app->client, NULL, NULL);
-		g_dbus_client_unref(app->client);
-	}
-
-	if (app->reg)
-		dbus_message_unref(app->reg);
-
-	g_free(app->owner);
-	g_free(app->path);
-
-	free(app);
-}
-
 static void profile_remove(void *data)
 {
 	struct btd_profile *p = data;
@@ -403,20 +379,10 @@ static void profile_remove(void *data)
 
 static void profile_release(struct external_profile *profile)
 {
-	DBusMessage *msg;
-
-	if (!profile->id)
-		return;
-
-	DBG("Releasing \"%s\"", profile->owner);
-
-	g_dbus_remove_watch(btd_get_dbus_connection(), profile->id);
+	DBG("Releasing \"%s\"", profile->app->owner);
 
-	msg = dbus_message_new_method_call(profile->owner, profile->path,
-						"org.bluez.GattProfile1",
-						"Release");
-	if (msg)
-		g_dbus_send_message(btd_get_dbus_connection(), msg);
+	g_dbus_proxy_method_call(profile->proxy, "Release", NULL, NULL, NULL,
+									NULL);
 }
 
 static void profile_free(void *data)
@@ -427,12 +393,36 @@ static void profile_free(void *data)
 
 	profile_release(profile);
 
-	g_free(profile->owner);
-	g_free(profile->path);
+	g_dbus_proxy_unref(profile->proxy);
 
 	free(profile);
 }
 
+static void app_free(void *data)
+{
+	struct gatt_app *app = data;
+
+	queue_destroy(app->profiles, profile_free);
+	queue_destroy(app->services, service_free);
+	queue_destroy(app->proxies, NULL);
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
 static void gatt_database_free(void *data)
 {
 	struct btd_gatt_database *database = data;
@@ -2209,9 +2199,6 @@ static bool database_add_app(struct gatt_app *app)
 {
 	const struct queue_entry *entry;
 
-	if (queue_isempty(app->services))
-		return false;
-
 	entry = queue_get_entries(app->services);
 	while (entry) {
 		if (!database_add_service(entry->data)) {
@@ -2225,6 +2212,132 @@ static bool database_add_app(struct gatt_app *app)
 	return true;
 }
 
+static int profile_device_probe(struct btd_service *service)
+{
+	struct btd_profile *p = btd_service_get_profile(service);
+
+	DBG("%s probed", p->name);
+
+	return 0;
+}
+
+static void profile_device_remove(struct btd_service *service)
+{
+	struct btd_profile *p = btd_service_get_profile(service);
+
+	DBG("%s removed", p->name);
+}
+
+static int profile_add(struct external_profile *profile, const char *uuid)
+{
+	struct btd_profile *p;
+
+	p = new0(struct btd_profile, 1);
+
+	/* Assign directly to avoid having extra fields */
+	p->name = (const void *) g_strdup_printf("%s%s/%s", profile->app->owner,
+				g_dbus_proxy_get_path(profile->proxy), uuid);
+	if (!p->name) {
+		free(p);
+		return -ENOMEM;
+	}
+
+	p->remote_uuid = (const void *) g_strdup(uuid);
+	if (!p->remote_uuid) {
+		g_free((void *) p->name);
+		free(p);
+		return -ENOMEM;
+	}
+
+	p->device_probe = profile_device_probe;
+	p->device_remove = profile_device_remove;
+	p->auto_connect = true;
+	p->external = true;
+
+	queue_push_tail(profile->profiles, p);
+
+	DBG("Added \"%s\"", p->name);
+
+	return 0;
+}
+
+static void add_profile(void *data, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+
+	btd_profile_register(data);
+	adapter_add_profile(adapter, data);
+}
+
+static struct external_profile *create_profile(struct gatt_app *app,
+						GDBusProxy *proxy,
+						const char *path)
+
+{
+	struct external_profile *profile;
+	DBusMessageIter iter, array;
+
+	if (!path || !g_str_has_prefix(path, "/"))
+		return NULL;
+
+	profile = new0(struct external_profile, 1);
+
+	profile->app = app;
+	profile->proxy = g_dbus_proxy_ref(proxy);
+	profile->profiles = queue_new();
+
+	if (!g_dbus_proxy_get_property(proxy, "UUIDs", &iter)) {
+		DBG("UUIDs property not found");
+		goto fail;
+	}
+
+	dbus_message_iter_recurse(&iter, &array);
+
+	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_STRING) {
+		const char *uuid;
+
+		dbus_message_iter_get_basic(&array, &uuid);
+
+		if (profile_add(profile, uuid) < 0)
+			goto fail;
+
+		dbus_message_iter_next(&array);
+	}
+
+	if (queue_isempty(profile->profiles))
+		goto fail;
+
+	queue_foreach(profile->profiles, add_profile, app->database->adapter);
+	queue_push_tail(app->profiles, profile);
+
+	return profile;
+
+fail:
+	profile_free(profile);
+	return NULL;
+}
+
+static void register_profile(void *data, void *user_data)
+{
+	struct gatt_app *app = user_data;
+	GDBusProxy *proxy = data;
+	const char *iface = g_dbus_proxy_get_interface(proxy);
+	const char *path = g_dbus_proxy_get_path(proxy);
+
+	if (app->failed)
+		return;
+
+	if (g_strcmp0(iface, GATT_PROFILE_IFACE) == 0) {
+		struct external_profile *profile;
+
+		profile = create_profile(app, proxy, path);
+		if (!profile) {
+			app->failed = true;
+			return;
+		}
+	}
+}
+
 static void register_service(void *data, void *user_data)
 {
 	struct gatt_app *app = user_data;
@@ -2307,11 +2420,13 @@ static void client_ready_cb(GDBusClient *client, void *user_data)
 		goto reply;
 	}
 
+	queue_foreach(app->proxies, register_profile, app);
 	queue_foreach(app->proxies, register_service, app);
 	queue_foreach(app->proxies, register_characteristic, app);
 	queue_foreach(app->proxies, register_descriptor, app);
 
-	if (!app->services || app->failed) {
+	if ((queue_isempty(app->services) && queue_isempty(app->profiles)) ||
+							app->failed) {
 		error("No valid external GATT objects found");
 		fail = true;
 		reply = btd_error_failed(app->reg,
@@ -2364,6 +2479,7 @@ static struct gatt_app *create_app(DBusConnection *conn, DBusMessage *msg,
 		goto fail;
 
 	app->services = queue_new();
+	app->profiles = queue_new();
 	app->proxies = queue_new();
 	app->reg = dbus_message_ref(msg);
 
@@ -2450,203 +2566,6 @@ static DBusMessage *manager_unregister_app(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
-static void profile_exited(DBusConnection *conn, void *user_data)
-{
-	struct external_profile *profile = user_data;
-
-	DBG("\"%s\" exited", profile->owner);
-
-	profile->id = 0;
-
-	queue_remove(profile->database->profiles, profile);
-
-	profile_free(profile);
-}
-
-static int profile_device_probe(struct btd_service *service)
-{
-	struct btd_profile *p = btd_service_get_profile(service);
-
-	DBG("%s probed", p->name);
-
-	return 0;
-}
-
-static void profile_device_remove(struct btd_service *service)
-{
-	struct btd_profile *p = btd_service_get_profile(service);
-
-	DBG("%s removed", p->name);
-}
-
-static int profile_add(struct external_profile *profile, const char *uuid)
-{
-	struct btd_profile *p;
-
-	p = new0(struct btd_profile, 1);
-
-	/* Assign directly to avoid having extra fields */
-	p->name = (const void *) g_strdup_printf("%s%s/%s", profile->owner,
-							profile->path, uuid);
-	if (!p->name) {
-		free(p);
-		return -ENOMEM;
-	}
-
-	p->remote_uuid = (const void *) g_strdup(uuid);
-	if (!p->remote_uuid) {
-		g_free((void *) p->name);
-		free(p);
-		return -ENOMEM;
-	}
-
-	p->device_probe = profile_device_probe;
-	p->device_remove = profile_device_remove;
-	p->auto_connect = true;
-	p->external = true;
-
-	queue_push_tail(profile->profiles, p);
-
-	DBG("Added \"%s\"", p->name);
-
-	return 0;
-}
-
-static void add_profile(void *data, void *user_data)
-{
-	struct btd_adapter *adapter = user_data;
-
-	btd_profile_register(data);
-	adapter_add_profile(adapter, data);
-}
-
-static int profile_create(DBusConnection *conn,
-				struct btd_gatt_database *database,
-				const char *sender, const char *path,
-				DBusMessageIter *iter)
-{
-	struct external_profile *profile;
-	DBusMessageIter uuids;
-
-	if (!path || !g_str_has_prefix(path, "/"))
-		return -EINVAL;
-
-	profile = new0(struct external_profile, 1);
-
-	profile->owner = g_strdup(sender);
-	if (!profile->owner)
-		goto fail;
-
-	profile->path = g_strdup(path);
-	if (!profile->path)
-		goto fail;
-
-	profile->profiles = queue_new();
-	profile->database = database;
-	profile->id = g_dbus_add_disconnect_watch(conn, sender, profile_exited,
-								profile, NULL);
-
-	dbus_message_iter_recurse(iter, &uuids);
-
-	while (dbus_message_iter_get_arg_type(&uuids) == DBUS_TYPE_STRING) {
-		const char *uuid;
-
-		dbus_message_iter_get_basic(&uuids, &uuid);
-
-		if (profile_add(profile, uuid) < 0)
-			goto fail;
-
-		dbus_message_iter_next(&uuids);
-	}
-
-	if (queue_isempty(profile->profiles))
-		goto fail;
-
-	queue_foreach(profile->profiles, add_profile, database->adapter);
-	queue_push_tail(database->profiles, profile);
-
-	return 0;
-
-fail:
-	profile_free(profile);
-	return -EINVAL;
-}
-
-static bool match_profile(const void *a, const void *b)
-{
-	const struct external_profile *profile = a;
-	const struct svc_match_data *data = b;
-
-	return g_strcmp0(profile->path, data->path) == 0 &&
-				g_strcmp0(profile->owner, data->sender) == 0;
-}
-
-static DBusMessage *manager_register_profile(DBusConnection *conn,
-					DBusMessage *msg, void *user_data)
-{
-	struct btd_gatt_database *database = user_data;
-	const char *sender = dbus_message_get_sender(msg);
-	DBusMessageIter args;
-	const char *path;
-	struct svc_match_data match_data;
-
-	DBG("sender %s", sender);
-
-	if (!dbus_message_iter_init(msg, &args))
-		return btd_error_invalid_args(msg);
-
-	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
-		return btd_error_invalid_args(msg);
-
-	dbus_message_iter_get_basic(&args, &path);
-
-	match_data.path = path;
-	match_data.sender = sender;
-
-	if (queue_find(database->profiles, match_profile, &match_data))
-		return btd_error_already_exists(msg);
-
-	dbus_message_iter_next(&args);
-	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY)
-		return btd_error_invalid_args(msg);
-
-	if (profile_create(conn, database, sender, path, &args) < 0)
-		return btd_error_failed(msg, "Failed to register profile");
-
-	return dbus_message_new_method_return(msg);
-}
-
-static DBusMessage *manager_unregister_profile(DBusConnection *conn,
-					DBusMessage *msg, void *user_data)
-{
-	struct btd_gatt_database *database = user_data;
-	const char *sender = dbus_message_get_sender(msg);
-	const char *path;
-	DBusMessageIter args;
-	struct external_profile *profile;
-	struct svc_match_data match_data;
-
-	if (!dbus_message_iter_init(msg, &args))
-		return btd_error_invalid_args(msg);
-
-	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
-		return btd_error_invalid_args(msg);
-
-	dbus_message_iter_get_basic(&args, &path);
-
-	match_data.path = path;
-	match_data.sender = sender;
-
-	profile = queue_remove_if(database->profiles, match_profile,
-								&match_data);
-	if (!profile)
-		return btd_error_does_not_exist(msg);
-
-	profile_free(profile);
-
-	return dbus_message_new_method_return(msg);
-}
-
 static const GDBusMethodTable manager_methods[] = {
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterApplication",
 			GDBUS_ARGS({ "application", "o" },
@@ -2655,13 +2574,6 @@ static const GDBusMethodTable manager_methods[] = {
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("UnregisterApplication",
 					GDBUS_ARGS({ "application", "o" }),
 					NULL, manager_unregister_app) },
-	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterProfile",
-			GDBUS_ARGS({ "profile", "o" }, { "UUIDs", "as" },
-			{ "options", "a{sv}" }), NULL,
-			manager_register_profile) },
-	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("UnregisterProfile",
-					GDBUS_ARGS({ "profile", "o" }),
-					NULL, manager_unregister_profile) },
 	{ }
 };
 
-- 
2.5.5

