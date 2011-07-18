Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 6/6] client: separate manager interface code from main
Date: Mon, 18 Jul 2011 13:35:16 +0300
Message-Id: <1310985316-2197-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1310985316-2197-1-git-send-email-luiz.dentz@gmail.com>
References: <1310985316-2197-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Move manager interface code to it own file.
---
 Makefile.am      |    1 +
 client/main.c    |  540 +-------------------------------------------------
 client/manager.c |  589 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/manager.h |   25 +++
 4 files changed, 619 insertions(+), 536 deletions(-)
 create mode 100644 client/manager.c
 create mode 100644 client/manager.h

diff --git a/Makefile.am b/Makefile.am
index 8b80da3..5080ee1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -125,6 +125,7 @@ libexec_PROGRAMS += client/obex-client
 client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
 				$(gwobex_sources) $(btio_sources) \
 				client/main.c src/log.h src/log.c \
+				client/manager.h client/manager.c \
 				client/session.h client/session.c \
 				client/pbap.h client/pbap.c \
 				client/sync.h client/sync.c \
diff --git a/client/main.c b/client/main.c
index 19ca436..618ad21 100644
--- a/client/main.c
+++ b/client/main.c
@@ -35,521 +35,7 @@
 #include <gdbus.h>
 
 #include "log.h"
-#include "transfer.h"
-#include "session.h"
-
-#define CLIENT_SERVICE  "org.openobex.client"
-
-#define CLIENT_INTERFACE  "org.openobex.Client"
-#define CLIENT_PATH       "/"
-
-struct send_data {
-	DBusConnection *connection;
-	DBusMessage *message;
-	gchar *sender;
-	gchar *agent;
-	char *filename;
-	GPtrArray *files;
-};
-
-static GSList *sessions = NULL;
-
-static void shutdown_session(struct session_data *session)
-{
-	sessions = g_slist_remove(sessions, session);
-	session_shutdown(session);
-	session_unref(session);
-}
-
-static void unregister_session(void *data)
-{
-	struct session_data *session = data;
-
-	if (g_slist_find(sessions, session) == NULL)
-		return;
-
-	sessions = g_slist_remove(sessions, session);
-	session_unref(session);
-}
-
-static void create_callback(struct session_data *session, GError *err,
-							void *user_data)
-{
-	struct send_data *data = user_data;
-	unsigned int i;
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
-	if (session_get_target(session) != NULL) {
-		const char *path;
-
-		path = session_register(session, unregister_session);
-
-		g_dbus_send_reply(data->connection, data->message,
-				DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID);
-		goto done;
-	}
-
-	g_dbus_send_reply(data->connection, data->message, DBUS_TYPE_INVALID);
-
-	session_set_agent(session, data->sender, data->agent);
-
-	for (i = 0; i < data->files->len; i++) {
-		const gchar *filename = g_ptr_array_index(data->files, i);
-		gchar *basename = g_path_get_basename(filename);
-
-		if (session_send(session, filename, basename) < 0) {
-			g_free(basename);
-			break;
-		}
-
-		g_free(basename);
-	}
-
-	/* No need to keep a reference for SendFiles */
-	sessions = g_slist_remove(sessions, session);
-	session_unref(session);
-
-done:
-	if (data->files)
-		g_ptr_array_free(data->files, TRUE);
-	dbus_message_unref(data->message);
-	dbus_connection_unref(data->connection);
-	g_free(data->sender);
-	g_free(data->agent);
-	g_free(data);
-}
-
-static int parse_device_dict(DBusMessageIter *iter,
-		const char **source, const char **dest, const char **target,
-		uint8_t *channel)
-{
-	while (dbus_message_iter_get_arg_type(iter) == DBUS_TYPE_DICT_ENTRY) {
-		DBusMessageIter entry, value;
-		const char *key;
-
-		dbus_message_iter_recurse(iter, &entry);
-		dbus_message_iter_get_basic(&entry, &key);
-
-		dbus_message_iter_next(&entry);
-		dbus_message_iter_recurse(&entry, &value);
-
-		switch (dbus_message_iter_get_arg_type(&value)) {
-		case DBUS_TYPE_STRING:
-			if (g_str_equal(key, "Source") == TRUE)
-				dbus_message_iter_get_basic(&value, source);
-			else if (g_str_equal(key, "Destination") == TRUE)
-				dbus_message_iter_get_basic(&value, dest);
-			else if (g_str_equal(key, "Target") == TRUE)
-				dbus_message_iter_get_basic(&value, target);
-			break;
-		case DBUS_TYPE_BYTE:
-			if (g_str_equal(key, "Channel") == TRUE)
-				dbus_message_iter_get_basic(&value, channel);
-			break;
-		}
-
-		dbus_message_iter_next(iter);
-	}
-
-	return 0;
-}
-
-static DBusMessage *send_files(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
-{
-	DBusMessageIter iter, array;
-	struct session_data *session;
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
-	session = session_create(source, dest, "OPP", channel, sender,
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
-static void pull_complete_callback(struct session_data *session,
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
-static void pull_session_callback(struct session_data *session,
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
-	session_pull(session, "text/x-vcard", data->filename,
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
-	struct session_data *session;
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
-	session = session_create(source, dest, "OPP", channel, data->sender,
-					pull_session_callback, data);
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
-static struct session_data *find_session(const char *path)
-{
-	GSList *l;
-
-	for (l = sessions; l; l = l->next) {
-		struct session_data *session = l->data;
-
-		if (g_str_equal(session_get_path(session), path) == TRUE)
-			return session;
-	}
-
-	return NULL;
-}
-
-static DBusMessage *create_session(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
-{
-	DBusMessageIter iter, dict;
-	struct session_data *session;
-	struct send_data *data;
-	const char *source = NULL, *dest = NULL, *target = NULL;
-	uint8_t channel = 0;
-
-	dbus_message_iter_init(message, &iter);
-	dbus_message_iter_recurse(&iter, &dict);
-
-	parse_device_dict(&dict, &source, &dest, &target, &channel);
-	if (dest == NULL || target == NULL)
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
-	data->sender = g_strdup(dbus_message_get_sender(message));
-
-	session = session_create(source, dest, target, channel, data->sender,
-							create_callback, data);
-	if (session != NULL) {
-		sessions = g_slist_append(sessions, session);
-		return NULL;
-	}
-
-	dbus_message_unref(data->message);
-	dbus_connection_unref(data->connection);
-	g_free(data->sender);
-	g_free(data);
-
-	return g_dbus_create_error(message, "org.openobex.Error.Failed", NULL);
-}
-
-static DBusMessage *remove_session(DBusConnection *connection,
-				DBusMessage *message, void *user_data)
-{
-	struct session_data *session;
-	const gchar *sender, *path;
-
-	if (dbus_message_get_args(message, NULL,
-			DBUS_TYPE_OBJECT_PATH, &path,
-			DBUS_TYPE_INVALID) == FALSE)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.InvalidArguments", NULL);
-
-	session = find_session(path);
-	if (session == NULL)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.InvalidArguments", NULL);
-
-	sender = dbus_message_get_sender(message);
-	if (g_str_equal(sender, session_get_owner(session)) == FALSE)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.NotAuthorized",
-				"Not Authorized");
-
-	shutdown_session(session);
-
-	return dbus_message_new_method_return(message);
-}
-
-static void capabilities_complete_callback(struct session_data *session,
-						GError *err, void *user_data)
-{
-	struct transfer_data *transfer = session_get_transfer(session);
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
-	capabilities = transfer_get_buffer(transfer, &size);
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
-	g_free(data->sender);
-	g_free(data);
-}
-
-static void capability_session_callback(struct session_data *session,
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
-	session_pull(session, "x-obex/capability", NULL,
-				capabilities_complete_callback, data);
-
-	return;
-
-done:
-	dbus_message_unref(data->message);
-	dbus_connection_unref(data->connection);
-	g_free(data->sender);
-	g_free(data);
-}
-
-static DBusMessage *get_capabilities(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
-{
-	DBusMessageIter iter, dict;
-	struct session_data *session;
-	struct send_data *data;
-	const char *source = NULL, *dest = NULL, *target = NULL;
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
-	data = g_try_malloc0(sizeof(*data));
-	if (data == NULL)
-		return g_dbus_create_error(message,
-					"org.openobex.Error.NoMemory", NULL);
-
-	data->connection = dbus_connection_ref(connection);
-	data->message = dbus_message_ref(message);
-	data->sender = g_strdup(dbus_message_get_sender(message));
-
-	if (!target)
-		target = "OPP";
-
-	session = session_create(source, dest, target, channel, data->sender,
-					capability_session_callback, data);
-	if (session != NULL) {
-		sessions = g_slist_append(sessions, session);
-		return NULL;
-	}
-
-	dbus_message_unref(data->message);
-	dbus_connection_unref(data->connection);
-	g_free(data->sender);
-	g_free(data);
-
-	return g_dbus_create_error(message, "org.openobex.Error.Failed", NULL);
-}
-
-static GDBusMethodTable client_methods[] = {
-	{ "SendFiles", "a{sv}aso", "", send_files,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "PullBusinessCard", "a{sv}s", "", pull_business_card,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "ExchangeBusinessCards", "a{sv}ss", "", exchange_business_cards,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "CreateSession", "a{sv}", "o", create_session,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "RemoveSession", "o", "", remove_session,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ "GetCapabilities", "a{sv}", "s", get_capabilities,
-						G_DBUS_METHOD_FLAG_ASYNC },
-	{ }
-};
+#include "manager.h"
 
 static GMainLoop *event_loop = NULL;
 
@@ -585,8 +71,6 @@ int main(int argc, char *argv[])
 {
 	GOptionContext *context;
 	struct sigaction sa;
-	DBusConnection *conn;
-	DBusError derr;
 	GError *gerr = NULL;
 
 	context = g_option_context_new(NULL);
@@ -601,24 +85,10 @@ int main(int argc, char *argv[])
 
 	g_option_context_free(context);
 
-	dbus_error_init(&derr);
+	event_loop = g_main_loop_new(NULL, FALSE);
 
-	conn = g_dbus_setup_bus(DBUS_BUS_SESSION, CLIENT_SERVICE, &derr);
-	if (dbus_error_is_set(&derr) == TRUE) {
-		g_printerr("%s: %s\n", derr.name, derr.message);
-		dbus_error_free(&derr);
+	if (manager_init() < 0)
 		exit(EXIT_FAILURE);
-	}
-
-	if (g_dbus_register_interface(conn, CLIENT_PATH, CLIENT_INTERFACE,
-						client_methods, NULL, NULL,
-							NULL, NULL) == FALSE) {
-		g_printerr("Can't register client interface\n");
-		dbus_connection_unref(conn);
-		exit(EXIT_FAILURE);
-	}
-
-	event_loop = g_main_loop_new(NULL, FALSE);
 
 	__obex_log_init("obex-client", option_debug, !option_stderr);
 
@@ -631,9 +101,7 @@ int main(int argc, char *argv[])
 
 	g_main_loop_run(event_loop);
 
-	g_dbus_unregister_interface(conn, CLIENT_PATH, CLIENT_INTERFACE);
-
-	dbus_connection_unref(conn);
+	manager_exit();
 
 	g_main_loop_unref(event_loop);
 
diff --git a/client/manager.c b/client/manager.c
new file mode 100644
index 0000000..e7eb70d
--- /dev/null
+++ b/client/manager.c
@@ -0,0 +1,589 @@
+/*
+ *
+ *  OBEX Client
+ *
+ *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <syslog.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "log.h"
+#include "transfer.h"
+#include "session.h"
+#include "manager.h"
+
+#define CLIENT_SERVICE  "org.openobex.client"
+
+#define CLIENT_INTERFACE  "org.openobex.Client"
+#define CLIENT_PATH       "/"
+
+struct send_data {
+	DBusConnection *connection;
+	DBusMessage *message;
+	gchar *sender;
+	gchar *agent;
+	char *filename;
+	GPtrArray *files;
+};
+
+static GSList *sessions = NULL;
+
+static void shutdown_session(struct session_data *session)
+{
+	sessions = g_slist_remove(sessions, session);
+	session_shutdown(session);
+	session_unref(session);
+}
+
+static void unregister_session(void *data)
+{
+	struct session_data *session = data;
+
+	if (g_slist_find(sessions, session) == NULL)
+		return;
+
+	sessions = g_slist_remove(sessions, session);
+	session_unref(session);
+}
+
+static void create_callback(struct session_data *session, GError *err,
+							void *user_data)
+{
+	struct send_data *data = user_data;
+	unsigned int i;
+
+	if (err != NULL) {
+		DBusMessage *error = g_dbus_create_error(data->message,
+					"org.openobex.Error.Failed",
+					"%s", err->message);
+		g_dbus_send_message(data->connection, error);
+		shutdown_session(session);
+		goto done;
+	}
+
+	if (session_get_target(session) != NULL) {
+		const char *path;
+
+		path = session_register(session, unregister_session);
+
+		g_dbus_send_reply(data->connection, data->message,
+				DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID);
+		goto done;
+	}
+
+	g_dbus_send_reply(data->connection, data->message, DBUS_TYPE_INVALID);
+
+	session_set_agent(session, data->sender, data->agent);
+
+	for (i = 0; i < data->files->len; i++) {
+		const gchar *filename = g_ptr_array_index(data->files, i);
+		gchar *basename = g_path_get_basename(filename);
+
+		if (session_send(session, filename, basename) < 0) {
+			g_free(basename);
+			break;
+		}
+
+		g_free(basename);
+	}
+
+	/* No need to keep a reference for SendFiles */
+	sessions = g_slist_remove(sessions, session);
+	session_unref(session);
+
+done:
+	if (data->files)
+		g_ptr_array_free(data->files, TRUE);
+	dbus_message_unref(data->message);
+	dbus_connection_unref(data->connection);
+	g_free(data->sender);
+	g_free(data->agent);
+	g_free(data);
+}
+
+static int parse_device_dict(DBusMessageIter *iter,
+		const char **source, const char **dest, const char **target,
+		uint8_t *channel)
+{
+	while (dbus_message_iter_get_arg_type(iter) == DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter entry, value;
+		const char *key;
+
+		dbus_message_iter_recurse(iter, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		switch (dbus_message_iter_get_arg_type(&value)) {
+		case DBUS_TYPE_STRING:
+			if (g_str_equal(key, "Source") == TRUE)
+				dbus_message_iter_get_basic(&value, source);
+			else if (g_str_equal(key, "Destination") == TRUE)
+				dbus_message_iter_get_basic(&value, dest);
+			else if (g_str_equal(key, "Target") == TRUE)
+				dbus_message_iter_get_basic(&value, target);
+			break;
+		case DBUS_TYPE_BYTE:
+			if (g_str_equal(key, "Channel") == TRUE)
+				dbus_message_iter_get_basic(&value, channel);
+			break;
+		}
+
+		dbus_message_iter_next(iter);
+	}
+
+	return 0;
+}
+
+static DBusMessage *send_files(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	DBusMessageIter iter, array;
+	struct session_data *session;
+	GPtrArray *files;
+	struct send_data *data;
+	const char *agent, *source = NULL, *dest = NULL, *target = NULL;
+	const char *sender;
+	uint8_t channel = 0;
+
+	dbus_message_iter_init(message, &iter);
+	dbus_message_iter_recurse(&iter, &array);
+
+	parse_device_dict(&array, &source, &dest, &target, &channel);
+	if (dest == NULL)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_recurse(&iter, &array);
+
+	files = g_ptr_array_new();
+	if (files == NULL)
+		return g_dbus_create_error(message,
+					"org.openobex.Error.NoMemory", NULL);
+
+	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_STRING) {
+		char *value;
+
+		dbus_message_iter_get_basic(&array, &value);
+		g_ptr_array_add(files, value);
+
+		dbus_message_iter_next(&array);
+	}
+
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_get_basic(&iter, &agent);
+
+	if (files->len == 0) {
+		g_ptr_array_free(files, TRUE);
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+	}
+
+	sender = dbus_message_get_sender(message);
+
+	data = g_try_malloc0(sizeof(*data));
+	if (data == NULL) {
+		g_ptr_array_free(files, TRUE);
+		return g_dbus_create_error(message,
+					"org.openobex.Error.NoMemory", NULL);
+	}
+
+	data->connection = dbus_connection_ref(connection);
+	data->message = dbus_message_ref(message);
+	data->sender = g_strdup(sender);
+	data->agent = g_strdup(agent);
+	data->files = files;
+
+	session = session_create(source, dest, "OPP", channel, sender,
+							create_callback, data);
+	if (session != NULL) {
+		sessions = g_slist_append(sessions, session);
+		return NULL;
+	}
+
+	g_ptr_array_free(data->files, TRUE);
+	dbus_message_unref(data->message);
+	dbus_connection_unref(data->connection);
+	g_free(data->sender);
+	g_free(data->agent);
+	g_free(data);
+
+	return g_dbus_create_error(message, "org.openobex.Error.Failed", NULL);
+}
+
+static void pull_complete_callback(struct session_data *session,
+					GError *err, void *user_data)
+{
+	struct send_data *data = user_data;
+
+	if (err != NULL) {
+		DBusMessage *error = g_dbus_create_error(data->message,
+					"org.openobex.Error.Failed",
+					"%s", err->message);
+		g_dbus_send_message(data->connection, error);
+		goto done;
+	}
+
+	g_dbus_send_reply(data->connection, data->message, DBUS_TYPE_INVALID);
+
+done:
+	shutdown_session(session);
+	dbus_message_unref(data->message);
+	dbus_connection_unref(data->connection);
+	g_free(data->filename);
+	g_free(data->sender);
+	g_free(data);
+}
+
+static void pull_session_callback(struct session_data *session,
+					GError *err, void *user_data)
+{
+	struct send_data *data = user_data;
+
+	if (err != NULL) {
+		DBusMessage *error = g_dbus_create_error(data->message,
+					"org.openobex.Error.Failed",
+					"%s", err->message);
+		g_dbus_send_message(data->connection, error);
+		shutdown_session(session);
+		goto done;
+	}
+
+	session_pull(session, "text/x-vcard", data->filename,
+						pull_complete_callback, data);
+
+	return;
+
+done:
+	dbus_message_unref(data->message);
+	dbus_connection_unref(data->connection);
+	g_free(data->filename);
+	g_free(data->sender);
+	g_free(data);
+}
+
+static DBusMessage *pull_business_card(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	DBusMessageIter iter, dict;
+	struct session_data *session;
+	struct send_data *data;
+	const char *source = NULL, *dest = NULL, *target = NULL;
+	const char *name = NULL;
+	uint8_t channel = 0;
+
+	dbus_message_iter_init(message, &iter);
+	dbus_message_iter_recurse(&iter, &dict);
+
+	parse_device_dict(&dict, &source, &dest, &target, &channel);
+	if (dest == NULL)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	dbus_message_iter_get_basic(&iter, &name);
+
+	data = g_try_malloc0(sizeof(*data));
+	if (data == NULL)
+		return g_dbus_create_error(message,
+					"org.openobex.Error.NoMemory", NULL);
+
+	data->connection = dbus_connection_ref(connection);
+	data->message = dbus_message_ref(message);
+	data->sender = g_strdup(dbus_message_get_sender(message));
+	data->filename = g_strdup(name);
+
+	session = session_create(source, dest, "OPP", channel, data->sender,
+					pull_session_callback, data);
+	if (session != NULL) {
+		sessions = g_slist_append(sessions, session);
+		return NULL;
+	}
+
+	dbus_message_unref(data->message);
+	dbus_connection_unref(data->connection);
+	g_free(data->sender);
+	g_free(data->filename);
+	g_free(data);
+
+	return g_dbus_create_error(message, "org.openobex.Error.Failed", NULL);
+}
+
+static DBusMessage *exchange_business_cards(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	return g_dbus_create_error(message, "org.openobex.Error.Failed", NULL);
+}
+
+static struct session_data *find_session(const char *path)
+{
+	GSList *l;
+
+	for (l = sessions; l; l = l->next) {
+		struct session_data *session = l->data;
+
+		if (g_str_equal(session_get_path(session), path) == TRUE)
+			return session;
+	}
+
+	return NULL;
+}
+
+static DBusMessage *create_session(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	DBusMessageIter iter, dict;
+	struct session_data *session;
+	struct send_data *data;
+	const char *source = NULL, *dest = NULL, *target = NULL;
+	uint8_t channel = 0;
+
+	dbus_message_iter_init(message, &iter);
+	dbus_message_iter_recurse(&iter, &dict);
+
+	parse_device_dict(&dict, &source, &dest, &target, &channel);
+	if (dest == NULL || target == NULL)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	data = g_try_malloc0(sizeof(*data));
+	if (data == NULL)
+		return g_dbus_create_error(message,
+					"org.openobex.Error.NoMemory", NULL);
+
+	data->connection = dbus_connection_ref(connection);
+	data->message = dbus_message_ref(message);
+	data->sender = g_strdup(dbus_message_get_sender(message));
+
+	session = session_create(source, dest, target, channel, data->sender,
+							create_callback, data);
+	if (session != NULL) {
+		sessions = g_slist_append(sessions, session);
+		return NULL;
+	}
+
+	dbus_message_unref(data->message);
+	dbus_connection_unref(data->connection);
+	g_free(data->sender);
+	g_free(data);
+
+	return g_dbus_create_error(message, "org.openobex.Error.Failed", NULL);
+}
+
+static DBusMessage *remove_session(DBusConnection *connection,
+				DBusMessage *message, void *user_data)
+{
+	struct session_data *session;
+	const gchar *sender, *path;
+
+	if (dbus_message_get_args(message, NULL,
+			DBUS_TYPE_OBJECT_PATH, &path,
+			DBUS_TYPE_INVALID) == FALSE)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	session = find_session(path);
+	if (session == NULL)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	sender = dbus_message_get_sender(message);
+	if (g_str_equal(sender, session_get_owner(session)) == FALSE)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.NotAuthorized",
+				"Not Authorized");
+
+	shutdown_session(session);
+
+	return dbus_message_new_method_return(message);
+}
+
+static void capabilities_complete_callback(struct session_data *session,
+						GError *err, void *user_data)
+{
+	struct transfer_data *transfer = session_get_transfer(session);
+	struct send_data *data = user_data;
+	const char *capabilities;
+	int size;
+
+	if (err != NULL) {
+		DBusMessage *error = g_dbus_create_error(data->message,
+					"org.openobex.Error.Failed",
+					"%s", err->message);
+		g_dbus_send_message(data->connection, error);
+		goto done;
+	}
+
+	capabilities = transfer_get_buffer(transfer, &size);
+	if (size == 0)
+		capabilities = "";
+
+	g_dbus_send_reply(data->connection, data->message,
+			DBUS_TYPE_STRING, &capabilities,
+			DBUS_TYPE_INVALID);
+
+done:
+
+	shutdown_session(session);
+	dbus_message_unref(data->message);
+	dbus_connection_unref(data->connection);
+	g_free(data->sender);
+	g_free(data);
+}
+
+static void capability_session_callback(struct session_data *session,
+						GError *err, void *user_data)
+{
+	struct send_data *data = user_data;
+
+	if (err != NULL) {
+		DBusMessage *error = g_dbus_create_error(data->message,
+					"org.openobex.Error.Failed",
+					"%s", err->message);
+		g_dbus_send_message(data->connection, error);
+		shutdown_session(session);
+		goto done;
+	}
+
+	session_pull(session, "x-obex/capability", NULL,
+				capabilities_complete_callback, data);
+
+	return;
+
+done:
+	dbus_message_unref(data->message);
+	dbus_connection_unref(data->connection);
+	g_free(data->sender);
+	g_free(data);
+}
+
+static DBusMessage *get_capabilities(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	DBusMessageIter iter, dict;
+	struct session_data *session;
+	struct send_data *data;
+	const char *source = NULL, *dest = NULL, *target = NULL;
+	uint8_t channel = 0;
+
+	dbus_message_iter_init(message, &iter);
+	dbus_message_iter_recurse(&iter, &dict);
+
+	parse_device_dict(&dict, &source, &dest, &target, &channel);
+	if (dest == NULL)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	data = g_try_malloc0(sizeof(*data));
+	if (data == NULL)
+		return g_dbus_create_error(message,
+					"org.openobex.Error.NoMemory", NULL);
+
+	data->connection = dbus_connection_ref(connection);
+	data->message = dbus_message_ref(message);
+	data->sender = g_strdup(dbus_message_get_sender(message));
+
+	if (!target)
+		target = "OPP";
+
+	session = session_create(source, dest, target, channel, data->sender,
+					capability_session_callback, data);
+	if (session != NULL) {
+		sessions = g_slist_append(sessions, session);
+		return NULL;
+	}
+
+	dbus_message_unref(data->message);
+	dbus_connection_unref(data->connection);
+	g_free(data->sender);
+	g_free(data);
+
+	return g_dbus_create_error(message, "org.openobex.Error.Failed", NULL);
+}
+
+static GDBusMethodTable client_methods[] = {
+	{ "SendFiles", "a{sv}aso", "", send_files,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "PullBusinessCard", "a{sv}s", "", pull_business_card,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "ExchangeBusinessCards", "a{sv}ss", "", exchange_business_cards,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "CreateSession", "a{sv}", "o", create_session,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "RemoveSession", "o", "", remove_session,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "GetCapabilities", "a{sv}", "s", get_capabilities,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ }
+};
+
+static DBusConnection *conn = NULL;
+
+int manager_init(void)
+{
+	DBusError derr;
+
+	dbus_error_init(&derr);
+
+	conn = g_dbus_setup_bus(DBUS_BUS_SESSION, CLIENT_SERVICE, &derr);
+	if (dbus_error_is_set(&derr) == TRUE) {
+		g_printerr("%s: %s\n", derr.name, derr.message);
+		dbus_error_free(&derr);
+		return -1;
+	}
+
+	if (g_dbus_register_interface(conn, CLIENT_PATH, CLIENT_INTERFACE,
+						client_methods, NULL, NULL,
+							NULL, NULL) == FALSE) {
+		g_printerr("Can't register client interface\n");
+		dbus_connection_unref(conn);
+		conn = NULL;
+		return -1;
+	}
+
+	return 0;
+}
+
+void manager_exit(void)
+{
+	if (conn == NULL)
+		return;
+
+	g_dbus_unregister_interface(conn, CLIENT_PATH, CLIENT_INTERFACE);
+	dbus_connection_unref(conn);
+}
diff --git a/client/manager.h b/client/manager.h
new file mode 100644
index 0000000..8756982
--- /dev/null
+++ b/client/manager.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  OBEX Server
+ *
+ *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+int manager_init(void);
+void manager_exit(void);
-- 
1.7.6

