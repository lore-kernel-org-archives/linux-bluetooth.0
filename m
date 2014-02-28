Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 5/9] gatt: Make RegisterService() async
Date: Fri, 28 Feb 2014 14:05:32 -0300
Message-Id: <1393607136-16908-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1393607136-16908-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1393607136-16908-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GDBus proxy objects consistency should be checked, and attributes
declaration inserted in the local GATT database before replying
the caller.
---
 src/gatt-dbus.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 93d5b7c..b8c7b17 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -50,6 +50,7 @@
 struct external_app {
 	char *owner;
 	char *path;
+	DBusMessage *reg;
 	GDBusClient *client;
 	GSList *proxies;
 	unsigned int watch;
@@ -74,6 +75,8 @@ static void external_app_watch_destroy(gpointer user_data)
 	external_apps = g_slist_remove(external_apps, eapp);
 
 	g_dbus_client_unref(eapp->client);
+	if (eapp->reg)
+		dbus_message_unref(eapp->reg);
 
 	g_free(eapp->owner);
 	g_free(eapp->path);
@@ -164,6 +167,8 @@ static void client_ready(void *user_data)
 {
 	struct external_app *eapp = user_data;
 	GDBusProxy *proxy;
+	DBusConnection *conn = btd_get_dbus_connection();
+	DBusMessage *reply;
 
 	if (eapp->proxies == NULL)
 		goto fail;
@@ -174,17 +179,28 @@ static void client_ready(void *user_data)
 
 	DBG("Added GATT service %s", eapp->path);
 
-	return;
+	reply = dbus_message_new_method_return(eapp->reg);
+	goto reply;
 
 fail:
-	DBG("No proxies: inconsistent service (%s)!", eapp->path);
+	error("Could not register external service: %s", eapp->path);
+
+	reply = btd_error_invalid_args(eapp->reg);
+	/* TODO: missing eapp cleanup */
+
+reply:
+	dbus_message_unref(eapp->reg);
+	eapp->reg = NULL;
+
+	g_dbus_send_message(conn, reply);
 }
 
 static struct external_app *new_external_app(DBusConnection *conn,
-					const char *sender, const char *path)
+					DBusMessage *msg, const char *path)
 {
 	struct external_app *eapp;
 	GDBusClient *client;
+	const char *sender = dbus_message_get_sender(msg);
 
 	client = g_dbus_client_new(conn, sender, "/");
 	if (client == NULL)
@@ -201,6 +217,7 @@ static struct external_app *new_external_app(DBusConnection *conn,
 	}
 
 	eapp->owner = g_strdup(sender);
+	eapp->reg = dbus_message_ref(msg);
 	eapp->client = client;
 	eapp->path = g_strdup(path);
 
@@ -230,7 +247,7 @@ static DBusMessage *register_service(DBusConnection *conn,
 	if (g_slist_find_custom(external_apps, path, external_app_path_cmp))
 		return btd_error_already_exists(msg);
 
-	eapp = new_external_app(conn, dbus_message_get_sender(msg), path);
+	eapp = new_external_app(conn, msg, path);
 	if (eapp == NULL)
 		return btd_error_failed(msg, "Not enough resources");
 
@@ -238,7 +255,7 @@ static DBusMessage *register_service(DBusConnection *conn,
 
 	DBG("New app %p: %s", eapp, path);
 
-	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+	return NULL;
 }
 
 static DBusMessage *unregister_service(DBusConnection *conn,
@@ -248,7 +265,7 @@ static DBusMessage *unregister_service(DBusConnection *conn,
 }
 
 static const GDBusMethodTable methods[] = {
-	{ GDBUS_EXPERIMENTAL_METHOD("RegisterService",
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterService",
 				GDBUS_ARGS({ "service", "o"},
 						{ "options", "a{sv}"}),
 				NULL, register_service) },
-- 
1.8.3.1

