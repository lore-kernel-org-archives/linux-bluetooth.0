Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v2 07/21] client: GetCapabilities moved to session API
Date: Thu, 8 Dec 2011 16:27:41 +0100
Message-ID: <1323358075-27857-8-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/manager.c |   99 ------------------------------------------------------
 client/session.c |   75 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 65 insertions(+), 109 deletions(-)

diff --git a/client/manager.c b/client/manager.c
index efc6745..99c495a 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -218,110 +218,11 @@ static DBusMessage *remove_session(DBusConnection *connection,
 	return dbus_message_new_method_return(message);
 }
 
-static void capabilities_complete_callback(struct obc_session *session,
-						GError *err, void *user_data)
-{
-	struct obc_transfer *transfer = obc_session_get_transfer(session);
-	struct send_data *data = user_data;
-	const char *capabilities;
-	int size;
-
-	if (err != NULL) {
-		DBusMessage *error = g_dbus_create_error(data->message,
-					"org.openobex.Error.Failed",
-					"%s", err->message);
-		g_dbus_send_message(data->connection, error);
-		goto done;
-	}
-
-	capabilities = obc_transfer_get_buffer(transfer, &size);
-	if (size == 0)
-		capabilities = "";
-
-	g_dbus_send_reply(data->connection, data->message,
-			DBUS_TYPE_STRING, &capabilities,
-			DBUS_TYPE_INVALID);
-
-done:
-
-	shutdown_session(session);
-	dbus_message_unref(data->message);
-	dbus_connection_unref(data->connection);
-	g_free(data);
-}
-
-static void capability_obc_session_callback(struct obc_session *session,
-						GError *err, void *user_data)
-{
-	struct send_data *data = user_data;
-
-	if (err != NULL) {
-		DBusMessage *error = g_dbus_create_error(data->message,
-					"org.openobex.Error.Failed",
-					"%s", err->message);
-		g_dbus_send_message(data->connection, error);
-		shutdown_session(session);
-		goto done;
-	}
-
-	obc_session_pull(session, "x-obex/capability", NULL,
-				capabilities_complete_callback, data);
-
-	return;
-
-done:
-	dbus_message_unref(data->message);
-	dbus_connection_unref(data->connection);
-	g_free(data);
-}
-
-static DBusMessage *get_capabilities(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
-{
-	DBusMessageIter iter, dict;
-	struct obc_session *session;
-	struct send_data *data;
-	const char *source = NULL, *dest = NULL, *target = NULL;
-	uint8_t channel = 0;
-
-	dbus_message_iter_init(message, &iter);
-	dbus_message_iter_recurse(&iter, &dict);
-
-	parse_device_dict(&dict, &source, &dest, &target, &channel);
-	if ((dest == NULL) || (target == NULL))
-		return g_dbus_create_error(message,
-				"org.openobex.Error.InvalidArguments", NULL);
-
-	data = g_try_malloc0(sizeof(*data));
-	if (data == NULL)
-		return g_dbus_create_error(message,
-					"org.openobex.Error.NoMemory", NULL);
-
-	data->connection = dbus_connection_ref(connection);
-	data->message = dbus_message_ref(message);
-
-	session = obc_session_create(source, dest, target, channel,
-					dbus_message_get_sender(message),
-					capability_obc_session_callback, data);
-	if (session != NULL) {
-		sessions = g_slist_append(sessions, session);
-		return NULL;
-	}
-
-	dbus_message_unref(data->message);
-	dbus_connection_unref(data->connection);
-	g_free(data);
-
-	return g_dbus_create_error(message, "org.openobex.Error.Failed", NULL);
-}
-
 static GDBusMethodTable client_methods[] = {
 	{ "CreateSession", "a{sv}", "o", create_session,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "RemoveSession", "o", "", remove_session,
 						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetCapabilities", "a{sv}", "s", get_capabilities,
-						G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 
diff --git a/client/session.c b/client/session.c
index 9f02512..0d56a1c 100644
--- a/client/session.c
+++ b/client/session.c
@@ -91,7 +91,6 @@ struct obc_session {
 	gchar *path;		/* Session path */
 	DBusConnection *conn;
 	DBusConnection *conn_system; /* system bus connection */
-	DBusMessage *msg;
 	GObex *obex;
 	GIOChannel *io;
 	struct obc_agent *agent;
@@ -100,7 +99,6 @@ struct obc_session {
 	guint watch;
 	GSList *pending;
 	GSList *pending_calls;
-	void *priv;
 	char *adapter;
 };
 
@@ -694,6 +692,7 @@ static void adapter_reply(DBusPendingCall *call, void *user_data)
 	struct callback_data *callback = user_data;
 	struct obc_session *session = callback->session;
 	struct pending_req *req = find_session_request(session, call);
+	GError *gerr = NULL;
 
 	reply = dbus_pending_call_steal_reply(call);
 
@@ -702,19 +701,26 @@ static void adapter_reply(DBusPendingCall *call, void *user_data)
 
 	dbus_error_init(&err);
 	if (dbus_set_error_from_message(&err, reply)) {
-		error("manager replied with an error: %s, %s",
-				err.name, err.message);
+		gerr = g_error_new(OBEX_IO_ERROR, -EIO,
+					"adapter replied with an error: %s, %s",
+					err.name, err.message);
+		error(gerr->message);
 		dbus_error_free(&err);
-
 		goto failed;
 	}
 
-	if (session_connect(session, callback) < 0)
+	if (session_connect(session, callback) < 0) {
+		gerr = g_error_new(OBEX_IO_ERROR, -EIO,
+					"session connect error");
 		goto failed;
+	}
 
 	goto proceed;
 
 failed:
+	callback->func(session, gerr, callback->data);
+	g_clear_error(&gerr);
+
 	obc_session_unref(session);
 	g_free(callback);
 
@@ -730,6 +736,7 @@ static void manager_reply(DBusPendingCall *call, void *user_data)
 	struct callback_data *callback = user_data;
 	struct obc_session *session = callback->session;
 	struct pending_req *req = find_session_request(session, call);
+	GError *gerr = NULL;
 
 	reply = dbus_pending_call_steal_reply(call);
 
@@ -738,10 +745,11 @@ static void manager_reply(DBusPendingCall *call, void *user_data)
 
 	dbus_error_init(&err);
 	if (dbus_set_error_from_message(&err, reply)) {
-		error("manager replied with an error: %s, %s",
-				err.name, err.message);
+		gerr = g_error_new(OBEX_IO_ERROR, -EIO,
+					"manager replied with an error: %s, %s",
+					err.name, err.message);
+		error(gerr->message);
 		dbus_error_free(&err);
-
 		goto failed;
 	}
 
@@ -756,8 +764,11 @@ static void manager_reply(DBusPendingCall *call, void *user_data)
 					BT_ADAPTER_IFACE, "RequestSession",
 					adapter_reply, callback,
 					DBUS_TYPE_INVALID);
-		if (!req)
+		if (!req) {
+			gerr = g_error_new(OBEX_IO_ERROR, -EIO,
+						"RequestSession failed");
 			goto failed;
+		}
 
 		session->pending_calls = g_slist_prepend(session->pending_calls,
 									req);
@@ -767,6 +778,9 @@ static void manager_reply(DBusPendingCall *call, void *user_data)
 	goto proceed;
 
 failed:
+	callback->func(session, gerr, callback->data);
+	g_clear_error(&gerr);
+
 	obc_session_unref(session);
 	g_free(callback);
 
@@ -1013,10 +1027,51 @@ static DBusMessage *session_get_properties(DBusConnection *connection,
 	return reply;
 }
 
+static void capabilities_complete_callback(struct obc_session *session,
+						GError *err, void *user_data)
+{
+	struct obc_transfer *transfer = obc_session_get_transfer(session);
+	DBusMessage *message = user_data;
+	const char *capabilities;
+	int size;
+
+	if (err != NULL) {
+		DBusMessage *error = g_dbus_create_error(message,
+					"org.openobex.Error.Failed",
+					"%s", err->message);
+		g_dbus_send_message(session->conn, error);
+		goto done;
+	}
+
+	capabilities = obc_transfer_get_buffer(transfer, &size);
+	if (size == 0)
+		capabilities = "";
+
+	g_dbus_send_reply(session->conn, message,
+			DBUS_TYPE_STRING, &capabilities,
+			DBUS_TYPE_INVALID);
+
+done:
+	dbus_message_unref(message);
+}
+
+static DBusMessage *get_capabilities(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct obc_session *session = user_data;
+
+	obc_session_pull(session, "x-obex/capability", NULL,
+				capabilities_complete_callback,
+				dbus_message_ref(message));
+
+	return NULL;
+}
+
 static GDBusMethodTable session_methods[] = {
 	{ "GetProperties",	"", "a{sv}",	session_get_properties	},
 	{ "AssignAgent",	"o", "",	assign_agent	},
 	{ "ReleaseAgent",	"o", "",	release_agent	},
+	{ "GetCapabilities",	"", "s",	get_capabilities },
 	{ }
 };
 
-- 
1.7.6.4

