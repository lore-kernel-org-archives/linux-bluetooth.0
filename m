Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v3 03/20] client: wrap OPP into specific session type
Date: Tue, 13 Dec 2011 17:44:06 +0100
Message-ID: <1323794663-2711-4-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/manager.c             |  249 ++----------------------------------------
 client/opp.c                 |  171 ++++++++++++++++++++++++++++-
 client/session.c             |   34 ++++--
 test/exchange-business-cards |   10 ++-
 test/get-capabilities        |   15 +--
 test/pull-business-card      |    9 ++-
 test/send-files              |   85 ++------------
 7 files changed, 239 insertions(+), 334 deletions(-)

diff --git a/client/manager.c b/client/manager.c
index f6628d7..7c9bbb3 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -52,10 +52,6 @@
 struct send_data {
 	DBusConnection *connection;
 	DBusMessage *message;
-	gchar *sender;
-	gchar *agent;
-	char *filename;
-	GPtrArray *files;
 };
 
 static GSList *sessions = NULL;
@@ -82,7 +78,7 @@ static void create_callback(struct obc_session *session, GError *err,
 							void *user_data)
 {
 	struct send_data *data = user_data;
-	unsigned int i;
+	const char *path;
 
 	if (err != NULL) {
 		DBusMessage *error = g_dbus_create_error(data->message,
@@ -93,44 +89,16 @@ static void create_callback(struct obc_session *session, GError *err,
 		goto done;
 	}
 
-	if (obc_session_get_target(session) != NULL) {
-		const char *path;
 
-		path = obc_session_register(session, unregister_session);
+	path = obc_session_register(session, unregister_session);
 
-		g_dbus_send_reply(data->connection, data->message,
+	g_dbus_send_reply(data->connection, data->message,
 				DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID);
-		goto done;
-	}
-
-	g_dbus_send_reply(data->connection, data->message, DBUS_TYPE_INVALID);
-
-	obc_session_set_agent(session, data->sender, data->agent);
-
-	for (i = 0; i < data->files->len; i++) {
-		const gchar *filename = g_ptr_array_index(data->files, i);
-		gchar *basename = g_path_get_basename(filename);
-
-		if (obc_session_send(session, filename, basename) < 0) {
-			g_free(basename);
-			break;
-		}
-
-		g_free(basename);
-	}
-
-	/* No need to keep a reference for SendFiles */
-	sessions = g_slist_remove(sessions, session);
-	obc_session_unref(session);
 
 done:
-	if (data->files)
-		g_ptr_array_free(data->files, TRUE);
 	dbus_message_unref(data->message);
 	dbus_connection_unref(data->connection);
-	g_free(data->sender);
-	g_free(data->agent);
 	g_free(data);
 }
 
@@ -169,192 +137,6 @@ static int parse_device_dict(DBusMessageIter *iter,
 	return 0;
 }
 
-static DBusMessage *send_files(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
-{
-	DBusMessageIter iter, array;
-	struct obc_session *session;
-	GPtrArray *files;
-	struct send_data *data;
-	const char *agent, *source = NULL, *dest = NULL, *target = NULL;
-	const char *sender;
-	uint8_t channel = 0;
-
-	dbus_message_iter_init(message, &iter);
-	dbus_message_iter_recurse(&iter, &array);
-
-	parse_device_dict(&array, &source, &dest, &target, &channel);
-	if (dest == NULL)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.InvalidArguments", NULL);
-
-	dbus_message_iter_next(&iter);
-	dbus_message_iter_recurse(&iter, &array);
-
-	files = g_ptr_array_new();
-	if (files == NULL)
-		return g_dbus_create_error(message,
-					"org.openobex.Error.NoMemory", NULL);
-
-	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_STRING) {
-		char *value;
-
-		dbus_message_iter_get_basic(&array, &value);
-		g_ptr_array_add(files, value);
-
-		dbus_message_iter_next(&array);
-	}
-
-	dbus_message_iter_next(&iter);
-	dbus_message_iter_get_basic(&iter, &agent);
-
-	if (files->len == 0) {
-		g_ptr_array_free(files, TRUE);
-		return g_dbus_create_error(message,
-				"org.openobex.Error.InvalidArguments", NULL);
-	}
-
-	sender = dbus_message_get_sender(message);
-
-	data = g_try_malloc0(sizeof(*data));
-	if (data == NULL) {
-		g_ptr_array_free(files, TRUE);
-		return g_dbus_create_error(message,
-					"org.openobex.Error.NoMemory", NULL);
-	}
-
-	data->connection = dbus_connection_ref(connection);
-	data->message = dbus_message_ref(message);
-	data->sender = g_strdup(sender);
-	data->agent = g_strdup(agent);
-	data->files = files;
-
-	session = obc_session_create(source, dest, "OPP", channel, sender,
-							create_callback, data);
-	if (session != NULL) {
-		sessions = g_slist_append(sessions, session);
-		return NULL;
-	}
-
-	g_ptr_array_free(data->files, TRUE);
-	dbus_message_unref(data->message);
-	dbus_connection_unref(data->connection);
-	g_free(data->sender);
-	g_free(data->agent);
-	g_free(data);
-
-	return g_dbus_create_error(message, "org.openobex.Error.Failed", NULL);
-}
-
-static void pull_complete_callback(struct obc_session *session,
-					GError *err, void *user_data)
-{
-	struct send_data *data = user_data;
-
-	if (err != NULL) {
-		DBusMessage *error = g_dbus_create_error(data->message,
-					"org.openobex.Error.Failed",
-					"%s", err->message);
-		g_dbus_send_message(data->connection, error);
-		goto done;
-	}
-
-	g_dbus_send_reply(data->connection, data->message, DBUS_TYPE_INVALID);
-
-done:
-	shutdown_session(session);
-	dbus_message_unref(data->message);
-	dbus_connection_unref(data->connection);
-	g_free(data->filename);
-	g_free(data->sender);
-	g_free(data);
-}
-
-static void pull_obc_session_callback(struct obc_session *session,
-					GError *err, void *user_data)
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
-	obc_session_pull(session, "text/x-vcard", data->filename,
-						pull_complete_callback, data);
-
-	return;
-
-done:
-	dbus_message_unref(data->message);
-	dbus_connection_unref(data->connection);
-	g_free(data->filename);
-	g_free(data->sender);
-	g_free(data);
-}
-
-static DBusMessage *pull_business_card(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
-{
-	DBusMessageIter iter, dict;
-	struct obc_session *session;
-	struct send_data *data;
-	const char *source = NULL, *dest = NULL, *target = NULL;
-	const char *name = NULL;
-	uint8_t channel = 0;
-
-	dbus_message_iter_init(message, &iter);
-	dbus_message_iter_recurse(&iter, &dict);
-
-	parse_device_dict(&dict, &source, &dest, &target, &channel);
-	if (dest == NULL)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.InvalidArguments", NULL);
-
-	dbus_message_iter_next(&iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.InvalidArguments", NULL);
-
-	dbus_message_iter_get_basic(&iter, &name);
-
-	data = g_try_malloc0(sizeof(*data));
-	if (data == NULL)
-		return g_dbus_create_error(message,
-					"org.openobex.Error.NoMemory", NULL);
-
-	data->connection = dbus_connection_ref(connection);
-	data->message = dbus_message_ref(message);
-	data->sender = g_strdup(dbus_message_get_sender(message));
-	data->filename = g_strdup(name);
-
-	session = obc_session_create(source, dest, "OPP", channel, data->sender,
-					pull_obc_session_callback, data);
-	if (session != NULL) {
-		sessions = g_slist_append(sessions, session);
-		return NULL;
-	}
-
-	dbus_message_unref(data->message);
-	dbus_connection_unref(data->connection);
-	g_free(data->sender);
-	g_free(data->filename);
-	g_free(data);
-
-	return g_dbus_create_error(message, "org.openobex.Error.Failed", NULL);
-}
-
-static DBusMessage *exchange_business_cards(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
-{
-	return g_dbus_create_error(message, "org.openobex.Error.Failed", NULL);
-}
-
 static struct obc_session *find_session(const char *path)
 {
 	GSList *l;
@@ -393,10 +175,10 @@ static DBusMessage *create_session(DBusConnection *connection,
 
 	data->connection = dbus_connection_ref(connection);
 	data->message = dbus_message_ref(message);
-	data->sender = g_strdup(dbus_message_get_sender(message));
 
-	session = obc_session_create(source, dest, target, channel, data->sender,
-							create_callback, data);
+	session = obc_session_create(source, dest, target, channel,
+					dbus_message_get_sender(message),
+					create_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
 		return NULL;
@@ -404,7 +186,6 @@ static DBusMessage *create_session(DBusConnection *connection,
 
 	dbus_message_unref(data->message);
 	dbus_connection_unref(data->connection);
-	g_free(data->sender);
 	g_free(data);
 
 	return g_dbus_create_error(message, "org.openobex.Error.Failed", NULL);
@@ -467,7 +248,6 @@ done:
 	shutdown_session(session);
 	dbus_message_unref(data->message);
 	dbus_connection_unref(data->connection);
-	g_free(data->sender);
 	g_free(data);
 }
 
@@ -493,7 +273,6 @@ static void capability_obc_session_callback(struct obc_session *session,
 done:
 	dbus_message_unref(data->message);
 	dbus_connection_unref(data->connection);
-	g_free(data->sender);
 	g_free(data);
 }
 
@@ -510,7 +289,7 @@ static DBusMessage *get_capabilities(DBusConnection *connection,
 	dbus_message_iter_recurse(&iter, &dict);
 
 	parse_device_dict(&dict, &source, &dest, &target, &channel);
-	if (dest == NULL)
+	if ((dest == NULL) || (target == NULL))
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
 
@@ -521,12 +300,9 @@ static DBusMessage *get_capabilities(DBusConnection *connection,
 
 	data->connection = dbus_connection_ref(connection);
 	data->message = dbus_message_ref(message);
-	data->sender = g_strdup(dbus_message_get_sender(message));
 
-	if (!target)
-		target = "OPP";
-
-	session = obc_session_create(source, dest, target, channel, data->sender,
+	session = obc_session_create(source, dest, target, channel,
+					dbus_message_get_sender(message),
 					capability_obc_session_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
@@ -535,19 +311,12 @@ static DBusMessage *get_capabilities(DBusConnection *connection,
 
 	dbus_message_unref(data->message);
 	dbus_connection_unref(data->connection);
-	g_free(data->sender);
 	g_free(data);
 
 	return g_dbus_create_error(message, "org.openobex.Error.Failed", NULL);
 }
 
 static GDBusMethodTable client_methods[] = {
-	{ "SendFiles", "a{sv}aso", "", send_files,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "PullBusinessCard", "a{sv}s", "", pull_business_card,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "ExchangeBusinessCards", "a{sv}ss", "", exchange_business_cards,
-						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "CreateSession", "a{sv}", "o", create_session,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "RemoveSession", "o", "", remove_session,
diff --git a/client/opp.c b/client/opp.c
index be382ef..3b24f85 100644
--- a/client/opp.c
+++ b/client/opp.c
@@ -25,6 +25,8 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
+
 #include "log.h"
 
 #include "session.h"
@@ -32,22 +34,189 @@
 #include "opp.h"
 
 #define OPP_UUID "00001105-0000-1000-8000-00805f9b34fb"
+#define OPP_INTERFACE "org.openobex.ObjectPush"
+#define ERROR_INF OPP_INTERFACE ".Error"
+
+struct opp_data {
+	struct obc_session *session;
+};
+
+struct pull_data {
+	DBusConnection *connection;
+	DBusMessage *message;
+};
+
+static DBusConnection *conn = NULL;
+
+static DBusMessage *opp_send_files(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct opp_data *opp = user_data;
+	DBusMessageIter iter, array;
+
+	dbus_message_iter_init(message, &iter);
+	dbus_message_iter_recurse(&iter, &array);
+
+	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_STRING) {
+		char *filename;
+		char *basename;
+
+		dbus_message_iter_get_basic(&array, &filename);
+		basename = g_path_get_basename(filename);
+
+		if (obc_session_send(opp->session, filename, basename) < 0) {
+			g_free(basename);
+			break;
+		}
+
+		g_free(basename);
+		dbus_message_iter_next(&array);
+	}
+
+	return dbus_message_new_method_return(message);
+}
+
+static void pull_complete_callback(struct obc_session *session,
+					GError *err, void *user_data)
+{
+	struct pull_data *data = user_data;
+
+	if (err != NULL) {
+		DBusMessage *error = g_dbus_create_error(data->message,
+					ERROR_INF ".Failed",
+					"%s", err->message);
+		g_dbus_send_message(data->connection, error);
+		goto done;
+	}
+
+	g_dbus_send_reply(data->connection, data->message, DBUS_TYPE_INVALID);
+
+done:
+	dbus_message_unref(data->message);
+	dbus_connection_unref(data->connection);
+}
+
+static DBusMessage *opp_pull_business_card(DBusConnection *connection,
+						DBusMessage *message,
+						void *user_data)
+{
+	struct opp_data *opp = user_data;
+	struct pull_data *data;
+	DBusMessageIter iter;
+	const char *filename = NULL;
+
+	dbus_message_iter_init(message, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message,
+				ERROR_INF ".InvalidArguments", NULL);
+
+	dbus_message_iter_get_basic(&iter, &filename);
+
+	data = g_try_malloc0(sizeof(*data));
+	if (!data)
+		return g_dbus_create_error(message,
+				ERROR_INF ".Failed", "No Memory");
+
+	data->connection = connection;
+	data->message = dbus_message_ref(message);
+
+	obc_session_pull(opp->session, "text/x-vcard", filename,
+						pull_complete_callback, data);
+
+	return NULL;
+}
+
+static DBusMessage *opp_exchange_business_cards(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	return g_dbus_create_error(message, ERROR_INF ".Failed", NULL);
+}
+
+static GDBusMethodTable opp_methods[] = {
+	{ "SendFiles",		"as",	"",	opp_send_files,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "PullBusinessCard",	"s",	"",	opp_pull_business_card,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "ExchangeBusinessCards", "ss", "",	opp_exchange_business_cards,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ }
+};
+
+static void opp_free(void *data)
+{
+	struct opp_data *opp = data;
+
+	obc_session_unref(opp->session);
+	g_free(opp);
+}
+
+static int opp_probe(struct obc_session *session)
+{
+	struct opp_data *opp;
+	const char *path;
+
+	path = obc_session_get_path(session);
+
+	DBG("%s", path);
+
+	opp = g_try_new0(struct opp_data, 1);
+	if (!opp)
+		return -ENOMEM;
+
+	opp->session = obc_session_ref(session);
+
+	if (!g_dbus_register_interface(conn, path, OPP_INTERFACE, opp_methods,
+						NULL, NULL, opp, opp_free)) {
+		opp_free(opp);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void opp_remove(struct obc_session *session)
+{
+	const char *path = obc_session_get_path(session);
+
+	DBG("%s", path);
+
+	g_dbus_unregister_interface(conn, path, OPP_INTERFACE);
+}
 
 static struct obc_driver opp = {
 	.service = "OPP",
 	.uuid = OPP_UUID,
+	.probe = opp_probe,
+	.remove = opp_remove
 };
 
 int opp_init(void)
 {
+	int err;
+
 	DBG("");
 
-	return obc_driver_register(&opp);
+	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	if (!conn)
+		return -EIO;
+
+	err = obc_driver_register(&opp);
+	if (err < 0) {
+		dbus_connection_unref(conn);
+		conn = NULL;
+		return err;
+	}
+
+	return 0;
 }
 
 void opp_exit(void)
 {
 	DBG("");
 
+	dbus_connection_unref(conn);
+	conn = NULL;
+
 	obc_driver_unregister(&opp);
 }
diff --git a/client/session.c b/client/session.c
index 9f02512..3bd9dc4 100644
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
 
diff --git a/test/exchange-business-cards b/test/exchange-business-cards
index 4b0c7ed..548ad2d 100755
--- a/test/exchange-business-cards
+++ b/test/exchange-business-cards
@@ -11,5 +11,11 @@ if (len(sys.argv) < 4):
 	print "Usage: %s <device> <clientfile> <file>" % (sys.argv[0])
 	sys.exit(1)
 
-client.ExchangeBusinessCards({ "Destination": sys.argv[1] },
-						sys.argv[2], sys.argv[3])
+print "Creating Session"
+session_path = client.CreateSession({"Destination": sys.argv[1],
+					"Target": "OPP"})
+opp = dbus.Interface(bus.get_object("org.openobex.client",
+					session_path),
+					"org.openobex.ObjectPush")
+
+opp.ExchangeBusinessCards(sys.argv[2], sys.argv[3])
diff --git a/test/get-capabilities b/test/get-capabilities
index c835bd9..1bbc274 100755
--- a/test/get-capabilities
+++ b/test/get-capabilities
@@ -7,14 +7,13 @@ bus = dbus.SessionBus()
 client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
 					"org.openobex.Client")
 
-if (len(sys.argv) < 2):
-	print "Usage: %s <device> [target]" % (sys.argv[0])
+if (len(sys.argv) < 3):
+	print "Usage: %s <device> <target>" % (sys.argv[0])
 	sys.exit(1)
 
-if (len(sys.argv) == 3):
-	dict = {"Destination": sys.argv[1],
-		"Target": sys.argv[2]}
-else:
-	dict = {"Destination": sys.argv[1]}
+print "Creating Session"
+session_path = client.CreateSession("", sys.argv[1], sys.argv[2], dict())
+session = dbus.Interface(bus.get_object("org.openobex.client", session_path),
+							"org.openobex.Session")
 
-print client.GetCapabilities(dict)
+print session.GetCapabilities()
diff --git a/test/pull-business-card b/test/pull-business-card
index b13968d..5912155 100755
--- a/test/pull-business-card
+++ b/test/pull-business-card
@@ -28,7 +28,14 @@ if __name__ == '__main__':
 		print "Usage: %s <device> <file>" % (sys.argv[0])
 		sys.exit(1)
 
-	client.PullBusinessCard({ "Destination": sys.argv[1] }, sys.argv[2],
+	print "Creating Session"
+	session_path = client.CreateSession({"Destination": sys.argv[1],
+						"Target": "OPP"})
+	opp = dbus.Interface(bus.get_object("org.openobex.client",
+						session_path),
+						"org.openobex.ObjectPush")
+
+	opp.PullBusinessCard(sys.argv[2],
 				reply_handler=success, error_handler=failure)
 
 	mainloop.run()
diff --git a/test/send-files b/test/send-files
index 52f9c04..504a066 100755
--- a/test/send-files
+++ b/test/send-files
@@ -1,82 +1,23 @@
 #!/usr/bin/python
 
-import gobject
-
 import os
 import sys
-import time
 import dbus
-import dbus.service
-import dbus.mainloop.glib
-
-class Agent(dbus.service.Object):
-	def __init__(self, conn=None, obj_path=None):
-		dbus.service.Object.__init__(self, conn, obj_path)
-
-	@dbus.service.method("org.openobex.Agent",
-					in_signature="o", out_signature="s")
-	def Request(self, path):
-		print "Transfer Request"
-		self.transfer = dbus.Interface(bus.get_object("org.openobex.client",
-						path), "org.openobex.Transfer")
-		properties = self.transfer.GetProperties()
-		for key in properties.keys():
-			print "  %s = %s" % (key, properties[key])
-		self.start = True
-		return ""
-
-	@dbus.service.method("org.openobex.Agent",
-					in_signature="ot", out_signature="")
-	def Progress(self, path, transferred):
-		if (self.start):
-			print "Transfer Started"
-			properties = self.transfer.GetProperties()
-			self.transfer_size = properties['Size']
-			self.start_time = time.time()
-			self.start = False
-		else:
-			speed = transferred / abs((time.time() - self.start_time) * 1000)
-			progress = "(" + str(transferred) + "/" + str(self.transfer_size) + " bytes) @ " + str(int(speed)) + " kB/s"
-			out = "\rTransfer progress " + progress
-			sys.stdout.write(out)
-			sys.stdout.flush()
-		return
-
-	@dbus.service.method("org.openobex.Agent",
-					in_signature="o", out_signature="")
-	def Complete(self, path):
-		print "\nTransfer finished"
-		return
-
-	@dbus.service.method("org.openobex.Agent",
-					in_signature="os", out_signature="")
-	def Error(self, path, error):
-		print "\nTransfer finished with an error: %s" % (error)
-		return
-
-	@dbus.service.method("org.openobex.Agent",
-					in_signature="", out_signature="")
-	def Release(self):
-		mainloop.quit()
-		return
-
-if __name__ == '__main__':
-	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
-
-	bus = dbus.SessionBus()
-	client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
-							"org.openobex.Client")
 
-	if (len(sys.argv) < 3):
-		print "Usage: %s <device> <file> [file*]" % (sys.argv[0])
-		sys.exit(1)
+bus = dbus.SessionBus()
+client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
+						"org.openobex.Client")
 
-	path = "/test/agent"
-	agent = Agent(bus, path)
+if (len(sys.argv) < 3):
+	print "Usage: %s <device> <file> [file*]" % (sys.argv[0])
+	sys.exit(1)
 
-	mainloop = gobject.MainLoop()
-	files = [os.path.realpath(f) for f in sys.argv[2:]]
+files = [os.path.realpath(f) for f in sys.argv[2:]]
 
-	client.SendFiles({ "Destination": sys.argv[1] }, files, path)
+print "Creating Session"
+session_path = client.CreateSession({"Destination": sys.argv[1],
+					"Target": "OPP"})
+opp = dbus.Interface(bus.get_object("org.openobex.client", session_path),
+					"org.openobex.ObjectPush")
 
-	mainloop.run()
+opp.SendFiles(files)
-- 
1.7.6.4

