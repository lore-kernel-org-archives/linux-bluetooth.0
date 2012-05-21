Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 03/12] client: Wrap OPP into specific session type
Date: Mon, 21 May 2012 11:07:05 +0200
Message-Id: <1337591234-24919-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

---
 client/manager.c |  270 ++----------------------------------------------------
 client/opp.c     |  193 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 201 insertions(+), 262 deletions(-)

diff --git a/client/manager.c b/client/manager.c
index 3005fe8..4078211 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -53,10 +53,6 @@
 struct send_data {
 	DBusConnection *connection;
 	DBusMessage *message;
-	gchar *sender;
-	gchar *agent;
-	char *filename;
-	GPtrArray *files;
 };
 
 static GSList *sessions = NULL;
@@ -84,7 +80,7 @@ static void create_callback(struct obc_session *session,
 						GError *err, void *user_data)
 {
 	struct send_data *data = user_data;
-	unsigned int i;
+	const char *path;
 
 	if (err != NULL) {
 		DBusMessage *error = g_dbus_create_error(data->message,
@@ -95,48 +91,16 @@ static void create_callback(struct obc_session *session,
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
-		struct obc_transfer *transfer;
-
-		transfer = obc_transfer_put(NULL, basename, filename, NULL, 0,
-									NULL);
-
-		g_free(basename);
-		if (transfer == NULL)
-			break;
-
-		if (!obc_session_queue(session, transfer, NULL, NULL, NULL))
-			break;
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
 
@@ -175,205 +139,6 @@ static int parse_device_dict(DBusMessageIter *iter,
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
-					struct obc_transfer *transfer,
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
-	pull = obc_transfer_get("text/x-vcard", NULL, data->filename, &gerr);
-	if (pull == NULL)
-		goto fail;
-
-	if (!obc_session_queue(session, pull, pull_complete_callback, data,
-								&gerr))
-		goto fail;
-
-	return;
-
-fail:
-	if (err == NULL)
-		err = gerr;
-
-	reply = g_dbus_create_error(data->message,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
-	g_dbus_send_message(data->connection, reply);
-	shutdown_session(session);
-	dbus_message_unref(data->message);
-	dbus_connection_unref(data->connection);
-	g_clear_error(&gerr);
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
@@ -412,10 +177,10 @@ static DBusMessage *create_session(DBusConnection *connection,
 
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
@@ -423,7 +188,6 @@ static DBusMessage *create_session(DBusConnection *connection,
 
 	dbus_message_unref(data->message);
 	dbus_connection_unref(data->connection);
-	g_free(data->sender);
 	g_free(data);
 
 	return g_dbus_create_error(message, "org.openobex.Error.Failed", NULL);
@@ -494,7 +258,6 @@ done:
 	shutdown_session(session);
 	dbus_message_unref(data->message);
 	dbus_connection_unref(data->connection);
-	g_free(data->sender);
 	g_free(data);
 }
 
@@ -532,7 +295,6 @@ fail:
 	dbus_message_unref(data->message);
 	dbus_connection_unref(data->connection);
 	g_clear_error(&gerr);
-	g_free(data->sender);
 	g_free(data);
 }
 
@@ -549,7 +311,7 @@ static DBusMessage *get_capabilities(DBusConnection *connection,
 	dbus_message_iter_recurse(&iter, &dict);
 
 	parse_device_dict(&dict, &source, &dest, &target, &channel);
-	if (dest == NULL)
+	if ((dest == NULL) || (target == NULL))
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
 
@@ -560,12 +322,9 @@ static DBusMessage *get_capabilities(DBusConnection *connection,
 
 	data->connection = dbus_connection_ref(connection);
 	data->message = dbus_message_ref(message);
-	data->sender = g_strdup(dbus_message_get_sender(message));
-
-	if (!target)
-		target = "OPP";
 
-	session = obc_session_create(source, dest, target, channel, data->sender,
+	session = obc_session_create(source, dest, target, channel,
+					dbus_message_get_sender(message),
 					capability_obc_session_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
@@ -574,23 +333,12 @@ static DBusMessage *get_capabilities(DBusConnection *connection,
 
 	dbus_message_unref(data->message);
 	dbus_connection_unref(data->connection);
-	g_free(data->sender);
 	g_free(data);
 
 	return g_dbus_create_error(message, "org.openobex.Error.Failed", NULL);
 }
 
 static const GDBusMethodTable client_methods[] = {
-	{ GDBUS_ASYNC_METHOD("SendFiles",
-			GDBUS_ARGS({ "device", "a{sv}" }, { "files", "as" },
-					{ "agent", "o" }), NULL, send_files) },
-	{ GDBUS_ASYNC_METHOD("PullBusinessCard",
-			GDBUS_ARGS({ "device", "a{sv}" }, { "file", "s" }), NULL,
-			pull_business_card) },
-	{ GDBUS_ASYNC_METHOD("ExchangeBusinessCards",
-			GDBUS_ARGS({ "device", "a{sv}" },
-					{ "clientfile", "s" }, { "file", "s" }),
-			NULL, exchange_business_cards) },
 	{ GDBUS_ASYNC_METHOD("CreateSession",
 			GDBUS_ARGS({ "devices", "a{sv}" }),
 			GDBUS_ARGS({ "session", "o" }), create_session) },
diff --git a/client/opp.c b/client/opp.c
index efbf3e9..424ae8d 100644
--- a/client/opp.c
+++ b/client/opp.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
 #include <gdbus.h>
 
 #include "log.h"
@@ -35,22 +36,212 @@
 #include "opp.h"
 
 #define OPP_UUID "00001105-0000-1000-8000-00805f9b34fb"
+#define OPP_INTERFACE "org.openobex.ObjectPush"
+#define ERROR_INF OPP_INTERFACE ".Error"
+
+struct opp_data {
+	struct obc_session *session;
+};
+
+static DBusConnection *conn = NULL;
+
+static DBusMessage *opp_send_files(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct opp_data *opp = user_data;
+	DBusMessageIter iter, array;
+	DBusMessage *reply;
+	GError *err = NULL;
+
+	dbus_message_iter_init(message, &iter);
+	dbus_message_iter_recurse(&iter, &array);
+
+	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_STRING) {
+		char *filename;
+		char *basename;
+		struct obc_transfer *transfer;
+
+		dbus_message_iter_get_basic(&array, &filename);
+		basename = g_path_get_basename(filename);
+
+		transfer = obc_transfer_put(NULL, basename, filename, NULL, 0,
+									&err);
+
+		g_free(basename);
+
+		if (transfer == NULL)
+			goto fail;
+
+		if (!obc_session_queue(opp->session, transfer, NULL, NULL,
+									&err))
+			goto fail;
+
+		dbus_message_iter_next(&array);
+	}
+
+	return dbus_message_new_method_return(message);
+
+fail:
+	reply = g_dbus_create_error(message,
+				ERROR_INF ".Failed", "%s", err->message);
+	g_error_free(err);
+	return reply;
+
+}
+
+static void pull_complete_callback(struct obc_session *session,
+					struct obc_transfer *transfer,
+					GError *err, void *user_data)
+{
+	DBusMessage *message = user_data;
+
+	if (err != NULL) {
+		DBusMessage *error = g_dbus_create_error(message,
+					"org.openobex.Error.Failed",
+					"%s", err->message);
+		g_dbus_send_message(conn, error);
+		goto done;
+	}
+
+	g_dbus_send_reply(conn, message, DBUS_TYPE_INVALID);
+
+done:
+	dbus_message_unref(message);
+}
+
+static DBusMessage *opp_pull_business_card(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct opp_data *opp = user_data;
+	struct obc_transfer *pull;
+	DBusMessageIter iter;
+	DBusMessage *reply;
+	const char *filename = NULL;
+	GError *err = NULL;
+
+	dbus_message_iter_init(message, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message,
+				ERROR_INF ".InvalidArguments", NULL);
+
+	dbus_message_iter_get_basic(&iter, &filename);
+
+	pull = obc_transfer_get("text/x-vcard", NULL, filename, &err);
+	if (pull == NULL)
+		goto fail;
+
+	if (!obc_session_queue(opp->session, pull, pull_complete_callback,
+								message, &err))
+		goto fail;
+
+	dbus_message_ref(message);
+
+	return NULL;
+
+fail:
+	reply = g_dbus_create_error(message,
+				ERROR_INF ".Failed", "%s", err->message);
+	g_error_free(err);
+	return reply;
+}
+
+static DBusMessage *opp_exchange_business_cards(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	return g_dbus_create_error(message, "org.openobex.Error.Failed", NULL);
+}
+
+static const GDBusMethodTable opp_methods[] = {
+	{ GDBUS_METHOD("SendFiles",
+		GDBUS_ARGS({ "files", "as" }),
+		NULL,
+		opp_send_files) },
+	{ GDBUS_ASYNC_METHOD("PullBusinessCard",
+		GDBUS_ARGS({ "targetfile", "s" }),
+		NULL,
+		opp_pull_business_card) },
+	{ GDBUS_ASYNC_METHOD("ExchangeBusinessCards",
+		GDBUS_ARGS({ "clientfile", "s" }, { "targetfile", "s" }),
+		NULL,
+		opp_exchange_business_cards) },
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
-- 
1.7.7.6

