Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 09/12] client: Move GetCapabilities to session API
Date: Mon, 21 May 2012 11:07:11 +0200
Message-Id: <1337591234-24919-10-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

---
 client/manager.c |  121 ------------------------------------------------------
 client/session.c |   68 ++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 121 deletions(-)

diff --git a/client/manager.c b/client/manager.c
index 4078211..94bcbdf 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -221,133 +221,12 @@ static DBusMessage *remove_session(DBusConnection *connection,
 	return dbus_message_new_method_return(message);
 }
 
-static void capabilities_complete_callback(struct obc_session *session,
-						struct obc_transfer *transfer,
-						GError *err, void *user_data)
-{
-	struct send_data *data = user_data;
-	char *contents;
-	size_t size;
-	int perr;
-
-	if (err != NULL) {
-		DBusMessage *error = g_dbus_create_error(data->message,
-					"org.openobex.Error.Failed",
-					"%s", err->message);
-		g_dbus_send_message(data->connection, error);
-		goto done;
-	}
-
-	perr = obc_transfer_get_contents(transfer, &contents, &size);
-	if (perr < 0) {
-		DBusMessage *error = g_dbus_create_error(data->message,
-						"org.openobex.Error.Failed",
-						"Error reading contents: %s",
-						strerror(-perr));
-		g_dbus_send_message(data->connection, error);
-		goto done;
-	}
-
-	g_dbus_send_reply(data->connection, data->message,
-			DBUS_TYPE_STRING, &contents,
-			DBUS_TYPE_INVALID);
-	g_free(contents);
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
-						struct obc_transfer *transfer,
-						GError *err, void *user_data)
-{
-	struct send_data *data = user_data;
-	struct obc_transfer *pull;
-	DBusMessage *reply;
-	GError *gerr = NULL;
-
-	if (err != NULL)
-		goto fail;
-
-	pull = obc_transfer_get("x-obex/capability", NULL, NULL, &gerr);
-	if (pull == NULL)
-		goto fail;
-
-	if (!obc_session_queue(session, pull, capabilities_complete_callback,
-								data, &gerr))
-		goto fail;
-
-	return;
-
-fail:
-	if (err == NULL)
-		err = gerr;
-
-	reply = g_dbus_create_error(data->message,
-					"org.openobex.Error.Failed",
-					"%s", err->message);
-	g_dbus_send_message(data->connection, reply);
-	shutdown_session(session);
-	dbus_message_unref(data->message);
-	dbus_connection_unref(data->connection);
-	g_clear_error(&gerr);
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
 static const GDBusMethodTable client_methods[] = {
 	{ GDBUS_ASYNC_METHOD("CreateSession",
 			GDBUS_ARGS({ "devices", "a{sv}" }),
 			GDBUS_ARGS({ "session", "o" }), create_session) },
 	{ GDBUS_ASYNC_METHOD("RemoveSession",
 			GDBUS_ARGS({ "session", "o" }), NULL, remove_session) },
-	{ GDBUS_ASYNC_METHOD("GetCapabilities",
-			GDBUS_ARGS({ "device", "a{sv}" }),
-			GDBUS_ARGS({ "capabilities", "s" }),
-			get_capabilities) },
 	{ }
 };
 
diff --git a/client/session.c b/client/session.c
index d4ec55d..1c5e452 100644
--- a/client/session.c
+++ b/client/session.c
@@ -648,6 +648,71 @@ static DBusMessage *session_get_properties(DBusConnection *connection,
 	return reply;
 }
 
+static void capabilities_complete_callback(struct obc_session *session,
+						struct obc_transfer *transfer,
+						GError *err, void *user_data)
+{
+	DBusMessage *message = user_data;
+	char *contents;
+	size_t size;
+	int perr;
+
+	if (err != NULL) {
+		DBusMessage *error = g_dbus_create_error(message,
+					"org.openobex.Error.Failed",
+					"%s", err->message);
+		g_dbus_send_message(session->conn, error);
+		goto done;
+	}
+
+	perr = obc_transfer_get_contents(transfer, &contents, &size);
+	if (perr < 0) {
+		DBusMessage *error = g_dbus_create_error(message,
+						"org.openobex.Error.Failed",
+						"Error reading contents: %s",
+						strerror(-perr));
+		g_dbus_send_message(session->conn, error);
+		goto done;
+	}
+
+	g_dbus_send_reply(session->conn, message,
+						DBUS_TYPE_STRING, &contents,
+						DBUS_TYPE_INVALID);
+	g_free(contents);
+
+done:
+	dbus_message_unref(message);
+}
+
+static DBusMessage *get_capabilities(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct obc_session *session = user_data;
+	struct obc_transfer *pull;
+	DBusMessage *reply;
+	GError *gerr = NULL;
+
+	pull = obc_transfer_get("x-obex/capability", NULL, NULL, &gerr);
+	if (pull == NULL)
+		goto fail;
+
+	if (!obc_session_queue(session, pull, capabilities_complete_callback,
+								message, &gerr))
+		goto fail;
+
+	dbus_message_ref(message);
+
+	return NULL;
+
+fail:
+	reply = g_dbus_create_error(message,
+					"org.openobex.Error.Failed",
+					"%s", gerr->message);
+	g_error_free(gerr);
+	return reply;
+
+}
+
 static const GDBusMethodTable session_methods[] = {
 	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
@@ -658,6 +723,9 @@ static const GDBusMethodTable session_methods[] = {
 	{ GDBUS_METHOD("ReleaseAgent",
 				GDBUS_ARGS({ "agent", "o" }), NULL,
 				release_agent) },
+	{ GDBUS_ASYNC_METHOD("GetCapabilities",
+				NULL, GDBUS_ARGS({ "capabilities", "s" }),
+				get_capabilities) },
 	{ }
 };
 
-- 
1.7.7.6

