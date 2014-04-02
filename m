Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 4/7] gatt: Add GattManager1.UnregisterService()
Date: Wed,  2 Apr 2014 15:30:23 -0300
Message-Id: <1396463426-7268-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1396463426-7268-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1396463426-7268-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds GattManager1.UnregisterService() method implementation
according to doc/gatt-api.txt.
---
 src/gatt-dbus.c | 64 ++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 17 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index b29371d..3ded9cd 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -56,7 +56,6 @@ struct external_service {
 	DBusMessage *reg;
 	GDBusClient *client;
 	GSList *proxies;
-	unsigned int watch;
 };
 
 struct proxy_write_data {
@@ -80,21 +79,35 @@ static int external_service_path_cmp(gconstpointer a, gconstpointer b)
 	return g_strcmp0(esvc->path, path);
 }
 
-static void external_service_watch_destroy(gpointer user_data)
+static gboolean external_service_destroy(void *user_data)
 {
 	struct external_service *esvc = user_data;
 
-	/* TODO: Remove from the database */
-
-	external_services = g_slist_remove(external_services, esvc);
-
 	g_dbus_client_unref(esvc->client);
+
 	if (esvc->reg)
 		dbus_message_unref(esvc->reg);
 
 	g_free(esvc->owner);
 	g_free(esvc->path);
 	g_free(esvc);
+
+	return FALSE;
+}
+
+static void remove_service(DBusConnection *conn, void *user_data)
+{
+	struct external_service *esvc = user_data;
+
+	/* TODO: Remove from the database */
+
+	external_services = g_slist_remove(external_services, esvc);
+
+	/*
+	 * Do not run in the same loop, this may be a disconnect
+	 * watch call and GDBusClient should not be destroyed.
+	 */
+	g_idle_add(external_service_destroy, esvc);
 }
 
 static int proxy_path_cmp(gconstpointer a, gconstpointer b)
@@ -483,7 +496,7 @@ reply:
 	g_dbus_send_message(conn, reply);
 }
 
-static struct external_service *new_external_service(DBusConnection *conn,
+static struct external_service *external_service_new(DBusConnection *conn,
 					DBusMessage *msg, const char *path)
 {
 	struct external_service *esvc;
@@ -495,20 +508,13 @@ static struct external_service *new_external_service(DBusConnection *conn,
 		return NULL;
 
 	esvc = g_new0(struct external_service, 1);
-
-	esvc->watch = g_dbus_add_disconnect_watch(btd_get_dbus_connection(),
-			sender, NULL, esvc, external_service_watch_destroy);
-	if (esvc->watch == 0) {
-		g_dbus_client_unref(client);
-		g_free(esvc);
-		return NULL;
-	}
-
 	esvc->owner = g_strdup(sender);
 	esvc->reg = dbus_message_ref(msg);
 	esvc->client = client;
 	esvc->path = g_strdup(path);
 
+	g_dbus_client_set_disconnect_watch(client, remove_service, esvc);
+
 	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
 								NULL, esvc);
 
@@ -536,7 +542,7 @@ static DBusMessage *register_service(DBusConnection *conn,
 						external_service_path_cmp))
 		return btd_error_already_exists(msg);
 
-	esvc = new_external_service(conn, msg, path);
+	esvc = external_service_new(conn, msg, path);
 	if (!esvc)
 		return btd_error_failed(msg, "Not enough resources");
 
@@ -550,6 +556,30 @@ static DBusMessage *register_service(DBusConnection *conn,
 static DBusMessage *unregister_service(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
+	struct external_service *esvc;
+	DBusMessageIter iter;
+	const char *path;
+	GSList *list;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_OBJECT_PATH)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &path);
+
+	list = g_slist_find_custom(external_services, path,
+						external_service_path_cmp);
+	if (!list)
+		return btd_error_does_not_exist(msg);
+
+	esvc = list->data;
+	if (!strcmp(dbus_message_get_sender(msg), esvc->owner))
+		return btd_error_does_not_exist(msg);
+
+	remove_service(conn, esvc);
+
 	return dbus_message_new_method_return(msg);
 }
 
-- 
1.8.3.1

