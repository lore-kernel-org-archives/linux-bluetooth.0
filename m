Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v3 07/20] client: move GetCapabilities to session API
Date: Tue, 13 Dec 2011 17:44:10 +0100
Message-ID: <1323794663-2711-8-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/manager.c |   99 ------------------------------------------------------
 client/session.c |   49 ++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 99 deletions(-)

diff --git a/client/manager.c b/client/manager.c
index 7c9bbb3..50b8bcb 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -219,110 +219,11 @@ static DBusMessage *remove_session(DBusConnection *connection,
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
index 3bd9dc4..19bf759 100644
--- a/client/session.c
+++ b/client/session.c
@@ -1027,10 +1027,59 @@ static DBusMessage *session_get_properties(DBusConnection *connection,
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
+	int err;
+
+	err = obc_session_pull(session, "x-obex/capability", NULL,
+				capabilities_complete_callback, message);
+
+	if (err < 0)
+		return g_dbus_create_error(message,
+					"org.openobex.Error.Failed",
+					"%s", strerror(err));
+
+	dbus_message_ref(message);
+
+	return NULL;
+}
+
 static GDBusMethodTable session_methods[] = {
 	{ "GetProperties",	"", "a{sv}",	session_get_properties	},
 	{ "AssignAgent",	"o", "",	assign_agent	},
 	{ "ReleaseAgent",	"o", "",	release_agent	},
+	{ "GetCapabilities",	"", "s",	get_capabilities,
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 
-- 
1.7.6.4

