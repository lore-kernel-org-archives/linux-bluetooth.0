Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Fix calling watch callbacks after it has been removed
Date: Mon,  6 Sep 2010 13:26:21 +0300
Message-Id: <1283768782-4283-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1283768782-4283-1-git-send-email-luiz.dentz@gmail.com>
References: <1283768782-4283-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto Von Dentz <luiz.dentz-von@nokia.com>

Pending call should be removed if the watch is removed since the
application no longer expect that to be reached and may already freed the
data associated with it.
---
 gdbus/watch.c |   75 ++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 8ad4815..249d927 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -43,11 +43,21 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 static guint listener_id = 0;
 static GSList *listeners = NULL;
 
+struct service_data {
+	DBusConnection *conn;
+	DBusPendingCall *call;
+	char *name;
+	const char *owner;
+	guint id;
+	struct filter_callback *callback;
+};
+
 struct filter_callback {
 	GDBusWatchFunction conn_func;
 	GDBusWatchFunction disc_func;
 	GDBusSignalFunction signal_func;
 	GDBusDestroyFunction destroy_func;
+	struct service_data *data;
 	void *user_data;
 	guint id;
 };
@@ -302,7 +312,7 @@ static struct filter_callback *filter_data_add_callback(
 {
 	struct filter_callback *cb = NULL;
 
-	cb = g_new(struct filter_callback, 1);
+	cb = g_new0(struct filter_callback, 1);
 
 	cb->conn_func = connect;
 	cb->disc_func = disconnect;
@@ -319,6 +329,24 @@ static struct filter_callback *filter_data_add_callback(
 	return cb;
 }
 
+static void service_data_free(struct service_data *data)
+{
+	struct filter_callback *callback = data->callback;
+
+	dbus_connection_unref(data->conn);
+
+	if (data->call)
+		dbus_pending_call_unref(data->call);
+
+	if (data->id)
+		g_source_remove(data->id);
+
+	g_free(data->name);
+	g_free(data);
+
+	callback->data = NULL;
+}
+
 static gboolean filter_data_remove_callback(struct filter_data *data,
 						struct filter_callback *cb)
 {
@@ -327,6 +355,13 @@ static gboolean filter_data_remove_callback(struct filter_data *data,
 	data->callbacks = g_slist_remove(data->callbacks, cb);
 	data->processed = g_slist_remove(data->processed, cb);
 
+	/* Cancel pending operations */
+	if (cb->data) {
+		if (cb->data->call)
+			dbus_pending_call_cancel(cb->data->call);
+		service_data_free(cb->data);
+	}
+
 	if (cb->destroy_func)
 		cb->destroy_func(cb->user_data);
 
@@ -515,28 +550,14 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }
 
-struct service_data {
-	DBusConnection *conn;
-	char *name;
-	const char *owner;
-	GDBusWatchFunction conn_func;
-	void *user_data;
-};
-
-static void service_data_free(struct service_data *data)
-{
-	dbus_connection_unref(data->conn);
-	g_free(data->name);
-	g_free(data);
-}
-
 static gboolean update_service(void *user_data)
 {
 	struct service_data *data = user_data;
+	struct filter_callback *cb = data->callback;
 
 	update_name_cache(data->name, data->owner);
-	if (data->conn_func)
-		data->conn_func(data->conn, data->user_data);
+	if (cb->conn_func)
+		cb->conn_func(data->conn, cb->user_data);
 
 	service_data_free(data);
 
@@ -575,11 +596,11 @@ done:
 	dbus_message_unref(reply);
 }
 
-static void check_service(DBusConnection *connection, const char *name,
-				GDBusWatchFunction connect, void *user_data)
+static void check_service(DBusConnection *connection,
+					const char *name,
+					struct filter_callback *callback)
 {
 	DBusMessage *message;
-	DBusPendingCall *call;
 	struct service_data *data;
 
 	data = g_try_malloc0(sizeof(*data));
@@ -590,12 +611,12 @@ static void check_service(DBusConnection *connection, const char *name,
 
 	data->conn = dbus_connection_ref(connection);
 	data->name = g_strdup(name);
-	data->conn_func = connect;
-	data->user_data = user_data;
+	data->callback = callback;
+	callback->data = data;
 
 	data->owner = check_name_cache(name);
 	if (data->owner != NULL) {
-		g_idle_add(update_service, data);
+		data->id = g_idle_add(update_service, data);
 		return;
 	}
 
@@ -611,13 +632,13 @@ static void check_service(DBusConnection *connection, const char *name,
 							DBUS_TYPE_INVALID);
 
 	if (dbus_connection_send_with_reply(connection, message,
-							&call, -1) == FALSE) {
+							&data->call, -1) == FALSE) {
 		error("Failed to execute method call");
 		g_free(data);
 		goto done;
 	}
 
-	if (call == NULL) {
+	if (data->call == NULL) {
 		error("D-Bus connection not available");
 		g_free(data);
 		goto done;
@@ -654,7 +675,7 @@ guint g_dbus_add_service_watch(DBusConnection *connection, const char *name,
 		return 0;
 
 	if (connect)
-		check_service(connection, name, connect, user_data);
+		check_service(connection, name, cb);
 
 	return cb->id;
 }
-- 
1.7.0.4

