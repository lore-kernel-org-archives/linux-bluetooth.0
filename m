Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 4/8] client: make use of obc_ prefix for public functions
Date: Fri, 12 Aug 2011 11:45:10 +0300
Message-Id: <1313138714-6443-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1313138714-6443-1-git-send-email-luiz.dentz@gmail.com>
References: <1313138714-6443-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This should indicate more clearer which function are public to the
drivers.
---
 client/agent.c    |   30 +++---
 client/agent.h    |   20 ++--
 client/driver.c   |   10 +-
 client/driver.h   |   12 +-
 client/ftp.c      |   42 ++++----
 client/manager.c  |   68 +++++++-------
 client/pbap.c     |   54 ++++++------
 client/session.c  |  265 +++++++++++++++++++++++++++--------------------------
 client/session.h  |   46 +++++-----
 client/sync.c     |   18 ++--
 client/transfer.c |  108 +++++++++++-----------
 client/transfer.h |   35 ++++----
 12 files changed, 355 insertions(+), 353 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index fe2f35d..aa93db3 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -39,7 +39,7 @@ struct pending_request {
 	DBusFreeFunction destroy;
 };
 
-struct agent_data {
+struct obc_agent {
 	DBusConnection *conn;
 	char *name;
 	char *path;
@@ -60,7 +60,7 @@ static void pending_request_free(struct pending_request *req)
 	g_free(req);
 }
 
-void agent_free(struct agent_data *agent)
+void obc_agent_free(struct obc_agent *agent)
 {
 	if (agent->watch)
 		g_dbus_remove_watch(agent->conn, agent->watch);
@@ -79,23 +79,23 @@ void agent_free(struct agent_data *agent)
 
 static void agent_disconnected(DBusConnection *connection, void *user_data)
 {
-	struct agent_data *agent = user_data;
+	struct obc_agent *agent = user_data;
 
 	agent->watch = 0;
 
 	if (agent->destroy)
 		agent->destroy(agent, agent->data);
 
-	agent_free(agent);
+	obc_agent_free(agent);
 }
 
-struct agent_data *agent_create(DBusConnection *conn, const char *name,
+struct obc_agent *obc_agent_create(DBusConnection *conn, const char *name,
 					const char *path, GFunc destroy,
 					void *user_data)
 {
-	struct agent_data *agent;
+	struct obc_agent *agent;
 
-	agent = g_new0(struct agent_data, 1);
+	agent = g_new0(struct obc_agent, 1);
 	agent->conn = dbus_connection_ref(conn);
 	agent->name = g_strdup(name);
 	agent->path = g_strdup(path);
@@ -111,7 +111,7 @@ struct agent_data *agent_create(DBusConnection *conn, const char *name,
 
 static void agent_request_reply(DBusPendingCall *call, void *user_data)
 {
-	struct agent_data *agent = user_data;
+	struct obc_agent *agent = user_data;
 	struct pending_request *req = agent->pending;
 
 	if (req->function)
@@ -121,7 +121,7 @@ static void agent_request_reply(DBusPendingCall *call, void *user_data)
 	agent->pending = NULL;
 }
 
-int agent_request(struct agent_data *agent, const char *path,
+int obc_agent_request(struct obc_agent *agent, const char *path,
 				DBusPendingCallNotifyFunction function,
 				void *user_data, DBusFreeFunction destroy)
 {
@@ -162,7 +162,7 @@ int agent_request(struct agent_data *agent, const char *path,
 	return 0;
 }
 
-void agent_notify_progress(struct agent_data *agent, const char *path,
+void obc_agent_notify_progress(struct obc_agent *agent, const char *path,
 							guint64 transferred)
 {
 	DBusMessage *message;
@@ -184,7 +184,7 @@ void agent_notify_progress(struct agent_data *agent, const char *path,
 	g_dbus_send_message(agent->conn, message);
 }
 
-void agent_notify_complete(struct agent_data *agent, const char *path)
+void obc_agent_notify_complete(struct obc_agent *agent, const char *path)
 {
 	DBusMessage *message;
 
@@ -204,7 +204,7 @@ void agent_notify_complete(struct agent_data *agent, const char *path)
 	g_dbus_send_message(agent->conn, message);
 }
 
-void agent_notify_error(struct agent_data *agent, const char *path,
+void obc_agent_notify_error(struct obc_agent *agent, const char *path,
 							const char *err)
 {
 	DBusMessage *message;
@@ -226,7 +226,7 @@ void agent_notify_error(struct agent_data *agent, const char *path,
 	g_dbus_send_message(agent->conn, message);
 }
 
-void agent_release(struct agent_data *agent)
+void obc_agent_release(struct obc_agent *agent)
 {
 	DBusMessage *message;
 
@@ -240,12 +240,12 @@ void agent_release(struct agent_data *agent)
 	g_dbus_send_message(agent->conn, message);
 }
 
-const char *agent_get_name(struct agent_data *agent)
+const char *obc_agent_get_name(struct obc_agent *agent)
 {
 	return agent->name;
 }
 
-const char *agent_get_path(struct agent_data *agent)
+const char *obc_agent_get_path(struct obc_agent *agent)
 {
 	return agent->path;
 }
diff --git a/client/agent.h b/client/agent.h
index 6fc3ffd..69f2ffe 100644
--- a/client/agent.h
+++ b/client/agent.h
@@ -24,20 +24,20 @@
 
 #include <gdbus.h>
 
-struct agent_data;
+struct obc_agent;
 
-struct agent_data *agent_create(DBusConnection *conn, const char *name,
+struct obc_agent *obc_agent_create(DBusConnection *conn, const char *name,
 					const char *path, GFunc destroy,
 					void *user_data);
-void agent_free(struct agent_data *agent);
-const char *agent_get_name(struct agent_data *agent);
-const char *agent_get_path(struct agent_data *agent);
-int agent_request(struct agent_data *agent, const char *path,
+void obc_agent_free(struct obc_agent *agent);
+const char *obc_agent_get_name(struct obc_agent *agent);
+const char *obc_agent_get_path(struct obc_agent *agent);
+int obc_agent_request(struct obc_agent *agent, const char *path,
 				DBusPendingCallNotifyFunction function,
 				void *user_data, DBusFreeFunction destroy);
-void agent_notify_progress(struct agent_data *agent, const char *path,
+void obc_agent_notify_progress(struct obc_agent *agent, const char *path,
 							guint64 transferred);
-void agent_notify_complete(struct agent_data *agent, const char *path);
-void agent_notify_error(struct agent_data *agent, const char *path,
+void obc_agent_notify_complete(struct obc_agent *agent, const char *path);
+void obc_agent_notify_error(struct obc_agent *agent, const char *path,
 							const char *err);
-void agent_release(struct agent_data *agent);
+void obc_agent_release(struct obc_agent *agent);
diff --git a/client/driver.c b/client/driver.c
index 54c5c3b..f9e8fbc 100644
--- a/client/driver.c
+++ b/client/driver.c
@@ -35,12 +35,12 @@
 
 static GSList *drivers = NULL;
 
-struct driver_data *driver_find(const char *pattern)
+struct obc_driver *obc_driver_find(const char *pattern)
 {
 	GSList *l;
 
 	for (l = drivers; l; l = l->next) {
-		struct driver_data *driver = l->data;
+		struct obc_driver *driver = l->data;
 
 		if (strcasecmp(pattern, driver->service) == 0)
 			return driver;
@@ -52,14 +52,14 @@ struct driver_data *driver_find(const char *pattern)
 	return NULL;
 }
 
-int driver_register(struct driver_data *driver)
+int obc_driver_register(struct obc_driver *driver)
 {
 	if (!driver) {
 		error("Invalid driver");
 		return -EINVAL;
 	}
 
-	if (driver_find(driver->service)) {
+	if (obc_driver_find(driver->service)) {
 		error("Permission denied: service %s already registered",
 			driver->service);
 		return -EPERM;
@@ -72,7 +72,7 @@ int driver_register(struct driver_data *driver)
 	return 0;
 }
 
-void driver_unregister(struct driver_data *driver)
+void obc_driver_unregister(struct obc_driver *driver)
 {
 	if (!g_slist_find(drivers, driver)) {
 		error("Unable to unregister: No such driver %p", driver);
diff --git a/client/driver.h b/client/driver.h
index 5979fe8..4c54fb8 100644
--- a/client/driver.h
+++ b/client/driver.h
@@ -21,15 +21,15 @@
  *
  */
 
-struct driver_data {
+struct obc_driver {
 	const char *service;
 	const char *uuid;
 	void *target;
 	int target_len;
-	int (*probe) (struct session_data *session);
-	void (*remove) (struct session_data *session);
+	int (*probe) (struct obc_session *session);
+	void (*remove) (struct obc_session *session);
 };
 
-int driver_register(struct driver_data *driver);
-void driver_unregister(struct driver_data *driver);
-struct driver_data *driver_find(const char *pattern);
+int obc_driver_register(struct obc_driver *driver);
+void obc_driver_unregister(struct obc_driver *driver);
+struct obc_driver *obc_driver_find(const char *pattern);
diff --git a/client/ftp.c b/client/ftp.c
index 98514fd..5d1fa5c 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -34,7 +34,7 @@
 #define FTP_INTERFACE  "org.openobex.FileTransfer"
 
 struct ftp_data {
-	struct session_data *session;
+	struct obc_session *session;
 	DBusConnection *conn;
 	DBusMessage *msg;
 };
@@ -43,8 +43,8 @@ static DBusMessage *change_folder(DBusConnection *connection,
 				DBusMessage *message, void *user_data)
 {
 	struct ftp_data *ftp = user_data;
-	struct session_data *session = ftp->session;
-	GwObex *obex = session_get_obex(session);
+	struct obc_session *session = ftp->session;
+	GwObex *obex = obc_session_get_obex(session);
 	const char *folder;
 	int err;
 
@@ -141,7 +141,7 @@ static const GMarkupParser parser = {
 	NULL
 };
 
-static void get_file_callback(struct session_data *session, GError *err,
+static void get_file_callback(struct obc_session *session, GError *err,
 							void *user_data)
 {
 	struct ftp_data *ftp = user_data;
@@ -163,11 +163,11 @@ static void get_file_callback(struct session_data *session, GError *err,
 	ftp->msg = NULL;
 }
 
-static void list_folder_callback(struct session_data *session,
+static void list_folder_callback(struct obc_session *session,
 					GError *err, void *user_data)
 {
 	struct ftp_data *ftp = user_data;
-	struct transfer_data *transfer = session_get_transfer(session);
+	struct obc_transfer *transfer = obc_session_get_transfer(session);
 	GMarkupParseContext *ctxt;
 	DBusMessage *reply;
 	DBusMessageIter iter, array;
@@ -176,7 +176,7 @@ static void list_folder_callback(struct session_data *session,
 
 	reply = dbus_message_new_method_return(ftp->msg);
 
-	buf = transfer_get_buffer(transfer, &size);
+	buf = obc_transfer_get_buffer(transfer, &size);
 	if (size == 0)
 		goto done;
 
@@ -191,7 +191,7 @@ static void list_folder_callback(struct session_data *session,
 	g_markup_parse_context_free(ctxt);
 	dbus_message_iter_close_container(&iter, &array);
 
-	transfer_clear_buffer(transfer);
+	obc_transfer_clear_buffer(transfer);
 
 done:
 	g_dbus_send_message(ftp->conn, reply);
@@ -203,8 +203,8 @@ static DBusMessage *create_folder(DBusConnection *connection,
 				DBusMessage *message, void *user_data)
 {
 	struct ftp_data *ftp = user_data;
-	struct session_data *session = ftp->session;
-	GwObex *obex = session_get_obex(session);
+	struct obc_session *session = ftp->session;
+	GwObex *obex = obc_session_get_obex(session);
 	const char *folder;
 	int err;
 
@@ -226,14 +226,14 @@ static DBusMessage *list_folder(DBusConnection *connection,
 				DBusMessage *message, void *user_data)
 {
 	struct ftp_data *ftp = user_data;
-	struct session_data *session = ftp->session;
+	struct obc_session *session = ftp->session;
 
 	if (ftp->msg)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InProgress",
 				"Transfer in progress");
 
-	if (session_get(session, "x-obex/folder-listing",
+	if (obc_session_get(session, "x-obex/folder-listing",
 			NULL, NULL, NULL, 0, list_folder_callback, ftp) < 0)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.Failed",
@@ -248,7 +248,7 @@ static DBusMessage *get_file(DBusConnection *connection,
 				DBusMessage *message, void *user_data)
 {
 	struct ftp_data *ftp = user_data;
-	struct session_data *session = ftp->session;
+	struct obc_session *session = ftp->session;
 	const char *target_file, *source_file;
 
 	if (ftp->msg)
@@ -263,7 +263,7 @@ static DBusMessage *get_file(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
 
-	if (session_get(session, NULL, source_file,
+	if (obc_session_get(session, NULL, source_file,
 			target_file, NULL, 0, get_file_callback, NULL) < 0)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.Failed",
@@ -278,7 +278,7 @@ static DBusMessage *put_file(DBusConnection *connection,
 				DBusMessage *message, void *user_data)
 {
 	struct ftp_data *ftp = user_data;
-	struct session_data *session = ftp->session;
+	struct obc_session *session = ftp->session;
 	gchar *sourcefile, *targetfile;
 
 	if (dbus_message_get_args(message, NULL,
@@ -289,7 +289,7 @@ static DBusMessage *put_file(DBusConnection *connection,
 				"org.openobex.Error.InvalidArguments",
 				"Invalid arguments in method call");
 
-	if (session_send(session, sourcefile, targetfile) < 0)
+	if (obc_session_send(session, sourcefile, targetfile) < 0)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.Failed",
 				"Failed");
@@ -313,8 +313,8 @@ static DBusMessage *delete(DBusConnection *connection,
 				DBusMessage *message, void *user_data)
 {
 	struct ftp_data *ftp = user_data;
-	struct session_data *session = ftp->session;
-	GwObex *obex = session_get_obex(session);
+	struct obc_session *session = ftp->session;
+	GwObex *obex = obc_session_get_obex(session);
 	const char *file;
 	int err;
 
@@ -351,7 +351,7 @@ static void ftp_free(void *data)
 {
 	struct ftp_data *ftp = data;
 
-	session_unref(ftp->session);
+	obc_session_unref(ftp->session);
 	dbus_connection_unref(ftp->conn);
 	g_free(ftp);
 }
@@ -359,14 +359,14 @@ static void ftp_free(void *data)
 gboolean ftp_register_interface(DBusConnection *connection, const char *path,
 							void *user_data)
 {
-	struct session_data *session = user_data;
+	struct obc_session *session = user_data;
 	struct ftp_data *ftp;
 
 	ftp = g_try_new0(struct ftp_data, 1);
 	if (!ftp)
 		return FALSE;
 
-	ftp->session = session_ref(session);
+	ftp->session = obc_session_ref(session);
 	ftp->conn = dbus_connection_ref(connection);
 
 	if (!g_dbus_register_interface(connection, path, FTP_INTERFACE,
diff --git a/client/manager.c b/client/manager.c
index a272a87..11657bc 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -55,25 +55,25 @@ struct send_data {
 
 static GSList *sessions = NULL;
 
-static void shutdown_session(struct session_data *session)
+static void shutdown_session(struct obc_session *session)
 {
 	sessions = g_slist_remove(sessions, session);
-	session_shutdown(session);
-	session_unref(session);
+	obc_session_shutdown(session);
+	obc_session_unref(session);
 }
 
 static void unregister_session(void *data)
 {
-	struct session_data *session = data;
+	struct obc_session *session = data;
 
 	if (g_slist_find(sessions, session) == NULL)
 		return;
 
 	sessions = g_slist_remove(sessions, session);
-	session_unref(session);
+	obc_session_unref(session);
 }
 
-static void create_callback(struct session_data *session, GError *err,
+static void create_callback(struct obc_session *session, GError *err,
 							void *user_data)
 {
 	struct send_data *data = user_data;
@@ -88,10 +88,10 @@ static void create_callback(struct session_data *session, GError *err,
 		goto done;
 	}
 
-	if (session_get_target(session) != NULL) {
+	if (obc_session_get_target(session) != NULL) {
 		const char *path;
 
-		path = session_register(session, unregister_session);
+		path = obc_session_register(session, unregister_session);
 
 		g_dbus_send_reply(data->connection, data->message,
 				DBUS_TYPE_OBJECT_PATH, &path,
@@ -101,13 +101,13 @@ static void create_callback(struct session_data *session, GError *err,
 
 	g_dbus_send_reply(data->connection, data->message, DBUS_TYPE_INVALID);
 
-	session_set_agent(session, data->sender, data->agent);
+	obc_session_set_agent(session, data->sender, data->agent);
 
 	for (i = 0; i < data->files->len; i++) {
 		const gchar *filename = g_ptr_array_index(data->files, i);
 		gchar *basename = g_path_get_basename(filename);
 
-		if (session_send(session, filename, basename) < 0) {
+		if (obc_session_send(session, filename, basename) < 0) {
 			g_free(basename);
 			break;
 		}
@@ -117,7 +117,7 @@ static void create_callback(struct session_data *session, GError *err,
 
 	/* No need to keep a reference for SendFiles */
 	sessions = g_slist_remove(sessions, session);
-	session_unref(session);
+	obc_session_unref(session);
 
 done:
 	if (data->files)
@@ -168,7 +168,7 @@ static DBusMessage *send_files(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	DBusMessageIter iter, array;
-	struct session_data *session;
+	struct obc_session *session;
 	GPtrArray *files;
 	struct send_data *data;
 	const char *agent, *source = NULL, *dest = NULL, *target = NULL;
@@ -224,7 +224,7 @@ static DBusMessage *send_files(DBusConnection *connection,
 	data->agent = g_strdup(agent);
 	data->files = files;
 
-	session = session_create(source, dest, "OPP", channel, sender,
+	session = obc_session_create(source, dest, "OPP", channel, sender,
 							create_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
@@ -241,7 +241,7 @@ static DBusMessage *send_files(DBusConnection *connection,
 	return g_dbus_create_error(message, "org.openobex.Error.Failed", NULL);
 }
 
-static void pull_complete_callback(struct session_data *session,
+static void pull_complete_callback(struct obc_session *session,
 					GError *err, void *user_data)
 {
 	struct send_data *data = user_data;
@@ -265,7 +265,7 @@ done:
 	g_free(data);
 }
 
-static void pull_session_callback(struct session_data *session,
+static void pull_obc_session_callback(struct obc_session *session,
 					GError *err, void *user_data)
 {
 	struct send_data *data = user_data;
@@ -279,7 +279,7 @@ static void pull_session_callback(struct session_data *session,
 		goto done;
 	}
 
-	session_pull(session, "text/x-vcard", data->filename,
+	obc_session_pull(session, "text/x-vcard", data->filename,
 						pull_complete_callback, data);
 
 	return;
@@ -296,7 +296,7 @@ static DBusMessage *pull_business_card(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	DBusMessageIter iter, dict;
-	struct session_data *session;
+	struct obc_session *session;
 	struct send_data *data;
 	const char *source = NULL, *dest = NULL, *target = NULL;
 	const char *name = NULL;
@@ -328,8 +328,8 @@ static DBusMessage *pull_business_card(DBusConnection *connection,
 	data->sender = g_strdup(dbus_message_get_sender(message));
 	data->filename = g_strdup(name);
 
-	session = session_create(source, dest, "OPP", channel, data->sender,
-					pull_session_callback, data);
+	session = obc_session_create(source, dest, "OPP", channel, data->sender,
+					pull_obc_session_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
 		return NULL;
@@ -350,14 +350,14 @@ static DBusMessage *exchange_business_cards(DBusConnection *connection,
 	return g_dbus_create_error(message, "org.openobex.Error.Failed", NULL);
 }
 
-static struct session_data *find_session(const char *path)
+static struct obc_session *find_session(const char *path)
 {
 	GSList *l;
 
 	for (l = sessions; l; l = l->next) {
-		struct session_data *session = l->data;
+		struct obc_session *session = l->data;
 
-		if (g_str_equal(session_get_path(session), path) == TRUE)
+		if (g_str_equal(obc_session_get_path(session), path) == TRUE)
 			return session;
 	}
 
@@ -368,7 +368,7 @@ static DBusMessage *create_session(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	DBusMessageIter iter, dict;
-	struct session_data *session;
+	struct obc_session *session;
 	struct send_data *data;
 	const char *source = NULL, *dest = NULL, *target = NULL;
 	uint8_t channel = 0;
@@ -390,7 +390,7 @@ static DBusMessage *create_session(DBusConnection *connection,
 	data->message = dbus_message_ref(message);
 	data->sender = g_strdup(dbus_message_get_sender(message));
 
-	session = session_create(source, dest, target, channel, data->sender,
+	session = obc_session_create(source, dest, target, channel, data->sender,
 							create_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
@@ -408,7 +408,7 @@ static DBusMessage *create_session(DBusConnection *connection,
 static DBusMessage *remove_session(DBusConnection *connection,
 				DBusMessage *message, void *user_data)
 {
-	struct session_data *session;
+	struct obc_session *session;
 	const gchar *sender, *path;
 
 	if (dbus_message_get_args(message, NULL,
@@ -423,7 +423,7 @@ static DBusMessage *remove_session(DBusConnection *connection,
 				"org.openobex.Error.InvalidArguments", NULL);
 
 	sender = dbus_message_get_sender(message);
-	if (g_str_equal(sender, session_get_owner(session)) == FALSE)
+	if (g_str_equal(sender, obc_session_get_owner(session)) == FALSE)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.NotAuthorized",
 				"Not Authorized");
@@ -433,10 +433,10 @@ static DBusMessage *remove_session(DBusConnection *connection,
 	return dbus_message_new_method_return(message);
 }
 
-static void capabilities_complete_callback(struct session_data *session,
+static void capabilities_complete_callback(struct obc_session *session,
 						GError *err, void *user_data)
 {
-	struct transfer_data *transfer = session_get_transfer(session);
+	struct obc_transfer *transfer = obc_session_get_transfer(session);
 	struct send_data *data = user_data;
 	const char *capabilities;
 	int size;
@@ -449,7 +449,7 @@ static void capabilities_complete_callback(struct session_data *session,
 		goto done;
 	}
 
-	capabilities = transfer_get_buffer(transfer, &size);
+	capabilities = obc_transfer_get_buffer(transfer, &size);
 	if (size == 0)
 		capabilities = "";
 
@@ -466,7 +466,7 @@ done:
 	g_free(data);
 }
 
-static void capability_session_callback(struct session_data *session,
+static void capability_obc_session_callback(struct obc_session *session,
 						GError *err, void *user_data)
 {
 	struct send_data *data = user_data;
@@ -480,7 +480,7 @@ static void capability_session_callback(struct session_data *session,
 		goto done;
 	}
 
-	session_pull(session, "x-obex/capability", NULL,
+	obc_session_pull(session, "x-obex/capability", NULL,
 				capabilities_complete_callback, data);
 
 	return;
@@ -496,7 +496,7 @@ static DBusMessage *get_capabilities(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	DBusMessageIter iter, dict;
-	struct session_data *session;
+	struct obc_session *session;
 	struct send_data *data;
 	const char *source = NULL, *dest = NULL, *target = NULL;
 	uint8_t channel = 0;
@@ -521,8 +521,8 @@ static DBusMessage *get_capabilities(DBusConnection *connection,
 	if (!target)
 		target = "OPP";
 
-	session = session_create(source, dest, target, channel, data->sender,
-					capability_session_callback, data);
+	session = obc_session_create(source, dest, target, channel, data->sender,
+					capability_obc_session_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
 		return NULL;
diff --git a/client/pbap.c b/client/pbap.c
index a87ec07..2b8afbf 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -117,7 +117,7 @@ static const char *filter_list[] = {
 #define PBAP_INTERFACE  "org.openobex.PhonebookAccess"
 
 struct pbap_data {
-	struct session_data *session;
+	struct obc_session *session;
 	char *path;
 	DBusConnection *conn;
 	DBusMessage *msg;
@@ -236,7 +236,7 @@ static void pbap_reset_path(struct pbap_data *pbap)
 {
 	int err = 0;
 	char **paths = NULL, **item;
-	GwObex *obex = session_get_obex(pbap->session);
+	GwObex *obex = obc_session_get_obex(pbap->session);
 
 	if (!pbap->path)
 		return;
@@ -255,7 +255,7 @@ static gint pbap_set_path(struct pbap_data *pbap, const char *path)
 {
 	int err = 0;
 	char **paths = NULL, **item;
-	GwObex *obex = session_get_obex(pbap->session);
+	GwObex *obex = obc_session_get_obex(pbap->session);
 
 	if (!path)
 		return OBEX_RSP_BAD_REQUEST;
@@ -292,18 +292,18 @@ fail:
 	return err;
 }
 
-static void read_return_apparam(struct session_data *session,
+static void read_return_apparam(struct obc_session *session,
 				guint16 *phone_book_size, guint8 *new_missed_calls)
 {
-	struct transfer_data *transfer = session_get_transfer(session);
-	struct transfer_params params;
+	struct obc_transfer *transfer = obc_session_get_transfer(session);
+	struct obc_transfer_params params;
 	unsigned char *buf;
 	size_t size = 0;
 
 	*phone_book_size = 0;
 	*new_missed_calls = 0;
 
-	if (transfer_get_params(transfer, &params) < 0)
+	if (obc_transfer_get_params(transfer, &params) < 0)
 		return;
 
 	if (params.size < APPARAM_HDR_SIZE)
@@ -342,10 +342,10 @@ static void read_return_apparam(struct session_data *session,
 	}
 }
 
-static void pull_phonebook_callback(struct session_data *session,
+static void pull_phonebook_callback(struct obc_session *session,
 					GError *err, void *user_data)
 {
-	struct transfer_data *transfer = session_get_transfer(session);
+	struct obc_transfer *transfer = obc_session_get_transfer(session);
 	struct pbap_data *pbap = user_data;
 	DBusMessage *reply;
 	const char *buf;
@@ -363,7 +363,7 @@ static void pull_phonebook_callback(struct session_data *session,
 
 	reply = dbus_message_new_method_return(pbap->msg);
 
-	buf = transfer_get_buffer(transfer, &size);
+	buf = obc_transfer_get_buffer(transfer, &size);
 	if (size == 0)
 		buf = "";
 
@@ -371,7 +371,7 @@ static void pull_phonebook_callback(struct session_data *session,
 			DBUS_TYPE_STRING, &buf,
 			DBUS_TYPE_INVALID);
 
-	transfer_clear_buffer(transfer);
+	obc_transfer_clear_buffer(transfer);
 
 send:
 	g_dbus_send_message(pbap->conn, reply);
@@ -379,13 +379,13 @@ send:
 	pbap->msg = NULL;
 
 done:
-	transfer_unregister(transfer);
+	obc_transfer_unregister(transfer);
 }
 
-static void phonebook_size_callback(struct session_data *session,
+static void phonebook_size_callback(struct obc_session *session,
 					GError *err, void *user_data)
 {
-	struct transfer_data *transfer = session_get_transfer(session);
+	struct obc_transfer *transfer = obc_session_get_transfer(session);
 	struct pbap_data *pbap = user_data;
 	DBusMessage *reply;
 	guint16 phone_book_size;
@@ -409,7 +409,7 @@ static void phonebook_size_callback(struct session_data *session,
 			DBUS_TYPE_UINT16, &phone_book_size,
 			DBUS_TYPE_INVALID);
 
-	transfer_clear_buffer(transfer);
+	obc_transfer_clear_buffer(transfer);
 
 send:
 	g_dbus_send_message(pbap->conn, reply);
@@ -417,13 +417,13 @@ send:
 	pbap->msg = NULL;
 
 done:
-	transfer_unregister(transfer);
+	obc_transfer_unregister(transfer);
 }
 
-static void pull_vcard_listing_callback(struct session_data *session,
+static void pull_vcard_listing_callback(struct obc_session *session,
 					GError *err, void *user_data)
 {
-	struct transfer_data *transfer = session_get_transfer(session);
+	struct obc_transfer *transfer = obc_session_get_transfer(session);
 	struct pbap_data *pbap = user_data;
 	GMarkupParseContext *ctxt;
 	DBusMessage *reply;
@@ -443,7 +443,7 @@ static void pull_vcard_listing_callback(struct session_data *session,
 
 	reply = dbus_message_new_method_return(pbap->msg);
 
-	buf = transfer_get_buffer(transfer, &size);
+	buf = obc_transfer_get_buffer(transfer, &size);
 	if (size == 0)
 		buf = "";
 
@@ -457,14 +457,14 @@ static void pull_vcard_listing_callback(struct session_data *session,
 	g_markup_parse_context_free(ctxt);
 	dbus_message_iter_close_container(&iter, &array);
 
-	transfer_clear_buffer(transfer);
+	obc_transfer_clear_buffer(transfer);
 
 send:
 	g_dbus_send_message(pbap->conn, reply);
 	dbus_message_unref(pbap->msg);
 	pbap->msg = NULL;
 complete:
-	transfer_unregister(transfer);
+	obc_transfer_unregister(transfer);
 }
 
 static DBusMessage *pull_phonebook(struct pbap_data *pbap,
@@ -506,7 +506,7 @@ static DBusMessage *pull_phonebook(struct pbap_data *pbap,
 		return NULL;
 	}
 
-	if (session_get(pbap->session, "x-bt/phonebook", name, NULL,
+	if (obc_session_get(pbap->session, "x-bt/phonebook", name, NULL,
 				(guint8 *) &apparam, sizeof(apparam),
 				func, pbap) < 0)
 		return g_dbus_create_error(message,
@@ -570,7 +570,7 @@ static DBusMessage *pull_vcard_listing(struct pbap_data *pbap,
 	offset = GUINT16_TO_BE(offset);
 	p = fill_apparam(p, &offset, LISTSTARTOFFSET_TAG, LISTSTARTOFFSET_LEN);
 
-	err = session_get(pbap->session, "x-bt/vcard-listing", name, NULL,
+	err = obc_session_get(pbap->session, "x-bt/vcard-listing", name, NULL,
 				apparam, apparam_size,
 				pull_vcard_listing_callback, pbap);
 	g_free(apparam);
@@ -777,7 +777,7 @@ static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
 	apparam.format_len = FORMAT_LEN;
 	apparam.format = pbap->format;
 
-	if (session_get(pbap->session, "x-bt/vcard", name, NULL,
+	if (obc_session_get(pbap->session, "x-bt/vcard", name, NULL,
 			(guint8 *)&apparam, sizeof(apparam),
 			pull_phonebook_callback, pbap) < 0)
 		return g_dbus_create_error(message,
@@ -985,7 +985,7 @@ static void pbap_free(void *data)
 {
 	struct pbap_data *pbap = data;
 
-	session_unref(pbap->session);
+	obc_session_unref(pbap->session);
 	dbus_connection_unref(pbap->conn);
 	g_free(pbap);
 }
@@ -993,14 +993,14 @@ static void pbap_free(void *data)
 gboolean pbap_register_interface(DBusConnection *connection, const char *path,
 							void *user_data)
 {
-	struct session_data *session = user_data;
+	struct obc_session *session = user_data;
 	struct pbap_data *pbap;
 
 	pbap = g_try_new0(struct pbap_data, 1);
 	if (!pbap)
 		return FALSE;
 
-	pbap->session = session_ref(session);
+	pbap->session = obc_session_ref(session);
 	pbap->conn = dbus_connection_ref(connection);
 
 	if (g_dbus_register_interface(connection, path, PBAP_INTERFACE,
diff --git a/client/session.c b/client/session.c
index 3e3a817..4bcf225 100644
--- a/client/session.c
+++ b/client/session.c
@@ -63,7 +63,7 @@
 static guint64 counter = 0;
 
 struct callback_data {
-	struct session_data *session;
+	struct obc_session *session;
 	sdp_session_t *sdp;
 	session_callback_t func;
 	void *data;
@@ -76,8 +76,8 @@ struct session_callback {
 
 struct pending_data {
 	session_callback_t cb;
-	struct session_data *session;
-	struct transfer_data *transfer;
+	struct obc_session *session;
+	struct obc_transfer *transfer;
 };
 
 struct pending_req {
@@ -85,19 +85,19 @@ struct pending_req {
 	void *user_data;
 };
 
-struct session_data {
+struct obc_session {
 	gint refcount;
 	bdaddr_t src;
 	bdaddr_t dst;
 	uint8_t channel;
-	struct driver_data *driver;
+	struct obc_driver *driver;
 	gchar *path;		/* Session path */
 	DBusConnection *conn;
 	DBusConnection *conn_system; /* system bus connection */
 	DBusMessage *msg;
 	GwObex *obex;
 	GIOChannel *io;
-	struct agent_data *agent;
+	struct obc_agent *agent;
 	struct session_callback *callback;
 	gchar *owner;		/* Session owner */
 	guint watch;
@@ -109,10 +109,10 @@ struct session_data {
 
 static GSList *sessions = NULL;
 
-static void session_prepare_put(struct session_data *session, GError *err,
+static void session_prepare_put(struct obc_session *session, GError *err,
 								void *data);
-static void session_terminate_transfer(struct session_data *session,
-					struct transfer_data *transfer,
+static void session_terminate_transfer(struct obc_session *session,
+					struct obc_transfer *transfer,
 					GError *gerr);
 
 static GQuark obex_io_error_quark(void)
@@ -120,7 +120,7 @@ static GQuark obex_io_error_quark(void)
 	return g_quark_from_static_string("obex-io-error-quark");
 }
 
-struct session_data *session_ref(struct session_data *session)
+struct obc_session *obc_session_ref(struct obc_session *session)
 {
 	g_atomic_int_inc(&session->refcount);
 
@@ -129,7 +129,7 @@ struct session_data *session_ref(struct session_data *session)
 	return session;
 }
 
-static void session_unregistered(struct session_data *session)
+static void session_unregistered(struct obc_session *session)
 {
 	char *path;
 
@@ -147,7 +147,7 @@ static void session_unregistered(struct session_data *session)
 }
 
 static struct pending_req *find_session_request(
-				const struct session_data *session,
+				const struct obc_session *session,
 				const DBusPendingCall *call)
 {
 	GSList *l;
@@ -171,7 +171,7 @@ static void pending_req_finalize(struct pending_req *req)
 	g_free(req);
 }
 
-static void session_free(struct session_data *session)
+static void session_free(struct obc_session *session)
 {
 	GSList *l = session->pending_calls;
 
@@ -186,8 +186,8 @@ static void session_free(struct session_data *session)
 	}
 
 	if (session->agent) {
-		agent_release(session->agent);
-		agent_free(session->agent);
+		obc_agent_release(session->agent);
+		obc_agent_free(session->agent);
 	}
 
 	if (session->watch)
@@ -268,7 +268,7 @@ static struct pending_req *send_method_call(DBusConnection *connection,
 	return req;
 }
 
-void session_unref(struct session_data *session)
+void obc_session_unref(struct obc_session *session)
 {
 	gboolean ret;
 
@@ -290,8 +290,8 @@ void session_unref(struct session_data *session)
 static void rfcomm_callback(GIOChannel *io, GError *err, gpointer user_data)
 {
 	struct callback_data *callback = user_data;
-	struct session_data *session = callback->session;
-	struct driver_data *driver = session->driver;
+	struct obc_session *session = callback->session;
+	struct obc_driver *driver = session->driver;
 	GwObex *obex;
 	int fd;
 
@@ -319,7 +319,7 @@ static void rfcomm_callback(GIOChannel *io, GError *err, gpointer user_data)
 done:
 	callback->func(callback->session, err, callback->data);
 
-	session_unref(callback->session);
+	obc_session_unref(callback->session);
 
 	g_free(callback);
 }
@@ -351,7 +351,7 @@ static void search_callback(uint8_t type, uint16_t status,
 			uint8_t *rsp, size_t size, void *user_data)
 {
 	struct callback_data *callback = user_data;
-	struct session_data *session = callback->session;
+	struct obc_session *session = callback->session;
 	unsigned int scanned, bytesleft = size;
 	int seqlen = 0;
 	uint8_t dataType, channel = 0;
@@ -426,7 +426,7 @@ failed:
 	callback->func(session, gerr, callback->data);
 	g_clear_error(&gerr);
 
-	session_unref(callback->session);
+	obc_session_unref(callback->session);
 	g_free(callback);
 }
 
@@ -479,7 +479,7 @@ static gboolean service_callback(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct callback_data *callback = user_data;
-	struct session_data *session = callback->session;
+	struct obc_session *session = callback->session;
 	sdp_list_t *search, *attrid;
 	uint32_t range = 0x0000ffff;
 	GError *gerr = NULL;
@@ -522,7 +522,7 @@ failed:
 	callback->func(callback->session, gerr, callback->data);
 	g_clear_error(&gerr);
 
-	session_unref(callback->session);
+	obc_session_unref(callback->session);
 	g_free(callback);
 	return FALSE;
 }
@@ -558,7 +558,7 @@ static gboolean connection_complete(gpointer data)
 
 	cb->func(cb->session, 0, cb->data);
 
-	session_unref(cb->session);
+	obc_session_unref(cb->session);
 
 	g_free(cb);
 
@@ -567,14 +567,14 @@ static gboolean connection_complete(gpointer data)
 
 static void owner_disconnected(DBusConnection *connection, void *user_data)
 {
-	struct session_data *session = user_data;
+	struct obc_session *session = user_data;
 
 	DBG("");
 
-	session_shutdown(session);
+	obc_session_shutdown(session);
 }
 
-int session_set_owner(struct session_data *session, const char *name,
+int obc_session_set_owner(struct obc_session *session, const char *name,
 			GDBusWatchFunction func)
 {
 	if (session == NULL)
@@ -593,7 +593,7 @@ int session_set_owner(struct session_data *session, const char *name,
 	return 0;
 }
 
-static struct session_data *session_find(const char *source,
+static struct obc_session *session_find(const char *source,
 						const char *destination,
 						const char *service,
 						uint8_t channel,
@@ -602,7 +602,7 @@ static struct session_data *session_find(const char *source,
 	GSList *l;
 
 	for (l = sessions; l; l = l->next) {
-		struct session_data *session = l->data;
+		struct obc_session *session = l->data;
 		bdaddr_t adr;
 
 		if (source) {
@@ -630,7 +630,7 @@ static struct session_data *session_find(const char *source,
 	return NULL;
 }
 
-static int session_connect(struct session_data *session,
+static int session_connect(struct obc_session *session,
 						struct callback_data *callback)
 {
 	int err;
@@ -658,7 +658,7 @@ static void adapter_reply(DBusPendingCall *call, void *user_data)
 	DBusError err;
 	DBusMessage *reply;
 	struct callback_data *callback = user_data;
-	struct session_data *session = callback->session;
+	struct obc_session *session = callback->session;
 	struct pending_req *req = find_session_request(session, call);
 
 	reply = dbus_pending_call_steal_reply(call);
@@ -681,7 +681,7 @@ static void adapter_reply(DBusPendingCall *call, void *user_data)
 	goto proceed;
 
 failed:
-	session_unref(session);
+	obc_session_unref(session);
 	g_free(callback);
 
 proceed:
@@ -694,7 +694,7 @@ static void manager_reply(DBusPendingCall *call, void *user_data)
 	DBusMessage *reply;
 	char *adapter;
 	struct callback_data *callback = user_data;
-	struct session_data *session = callback->session;
+	struct obc_session *session = callback->session;
 	struct pending_req *req = find_session_request(session, call);
 
 	reply = dbus_pending_call_steal_reply(call);
@@ -733,14 +733,14 @@ static void manager_reply(DBusPendingCall *call, void *user_data)
 	goto proceed;
 
 failed:
-	session_unref(session);
+	obc_session_unref(session);
 	g_free(callback);
 
 proceed:
 	dbus_message_unref(reply);
 }
 
-struct session_data *session_create(const char *source,
+struct obc_session *obc_session_create(const char *source,
 						const char *destination,
 						const char *service,
 						uint8_t channel,
@@ -748,21 +748,21 @@ struct session_data *session_create(const char *source,
 						session_callback_t function,
 						void *user_data)
 {
-	struct session_data *session;
+	struct obc_session *session;
 	struct callback_data *callback;
 	struct pending_req *req;
-	struct driver_data *driver;
+	struct obc_driver *driver;
 
 	if (destination == NULL)
 		return NULL;
 
 	session = session_find(source, destination, service, channel, owner);
 	if (session) {
-		session_ref(session);
+		obc_session_ref(session);
 		goto proceed;
 	}
 
-	driver = driver_find(service);
+	driver = obc_driver_find(service);
 	if (!driver)
 		return NULL;
 
@@ -798,11 +798,11 @@ struct session_data *session_create(const char *source,
 proceed:
 	callback = g_try_malloc0(sizeof(*callback));
 	if (callback == NULL) {
-		session_unref(session);
+		obc_session_unref(session);
 		return NULL;
 	}
 
-	callback->session = session_ref(session);
+	callback->session = obc_session_ref(session);
 	callback->func = function;
 	callback->data = user_data;
 
@@ -822,7 +822,7 @@ proceed:
 	}
 
 	if (!req) {
-		session_unref(session);
+		obc_session_unref(session);
 		g_free(callback);
 		return NULL;
 	}
@@ -830,19 +830,20 @@ proceed:
 	session->pending_calls = g_slist_prepend(session->pending_calls, req);
 
 	if (owner)
-		session_set_owner(session, owner, owner_disconnected);
+		obc_session_set_owner(session, owner, owner_disconnected);
 
 	return session;
 }
 
-void session_shutdown(struct session_data *session)
+void obc_session_shutdown(struct obc_session *session)
 {
 	DBG("%p", session);
 
-	session_ref(session);
+	obc_session_ref(session);
 
 	/* Unregister any pending transfer */
-	g_slist_foreach(session->pending, (GFunc) transfer_unregister, NULL);
+	g_slist_foreach(session->pending, (GFunc) obc_transfer_unregister,
+									NULL);
 
 	/* Unregister interfaces */
 	if (session->path)
@@ -854,13 +855,13 @@ void session_shutdown(struct session_data *session)
 		shutdown(fd, SHUT_RDWR);
 	}
 
-	session_unref(session);
+	obc_session_unref(session);
 }
 
 static DBusMessage *assign_agent(DBusConnection *connection,
 				DBusMessage *message, void *user_data)
 {
-	struct session_data *session = user_data;
+	struct obc_session *session = user_data;
 	const gchar *sender, *path;
 
 	if (dbus_message_get_args(message, NULL,
@@ -872,7 +873,7 @@ static DBusMessage *assign_agent(DBusConnection *connection,
 
 	sender = dbus_message_get_sender(message);
 
-	if (session_set_agent(session, sender, path) < 0)
+	if (obc_session_set_agent(session, sender, path) < 0)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.AlreadyExists",
 				"Already exists");
@@ -883,8 +884,8 @@ static DBusMessage *assign_agent(DBusConnection *connection,
 static DBusMessage *release_agent(DBusConnection *connection,
 				DBusMessage *message, void *user_data)
 {
-	struct session_data *session = user_data;
-	struct agent_data *agent = session->agent;
+	struct obc_session *session = user_data;
+	struct obc_agent *agent = session->agent;
 	const gchar *sender;
 	gchar *path;
 
@@ -897,14 +898,16 @@ static DBusMessage *release_agent(DBusConnection *connection,
 
 	sender = dbus_message_get_sender(message);
 
-	if (agent == NULL ||
-			g_str_equal(sender, agent_get_name(agent)) == FALSE ||
-			g_str_equal(path, agent_get_path(agent)) == FALSE)
+	if (agent == NULL)
+		return dbus_message_new_method_return(message);
+
+	if (g_str_equal(sender, obc_agent_get_name(agent)) == FALSE ||
+			g_str_equal(path, obc_agent_get_path(agent)) == FALSE)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.NotAuthorized",
 				"Not Authorized");
 
-	agent_free(agent);
+	obc_agent_free(agent);
 
 	return dbus_message_new_method_return(message);
 }
@@ -946,7 +949,7 @@ static void append_entry(DBusMessageIter *dict,
 static DBusMessage *session_get_properties(DBusConnection *connection,
 				DBusMessage *message, void *user_data)
 {
-	struct session_data *session = user_data;
+	struct obc_session *session = user_data;
 	DBusMessage *reply;
 	DBusMessageIter iter, dict;
 	char addr[18];
@@ -986,7 +989,7 @@ static GDBusMethodTable session_methods[] = {
 static void session_request_reply(DBusPendingCall *call, gpointer user_data)
 {
 	struct pending_data *pending = user_data;
-	struct session_data *session = pending->session;
+	struct obc_session *session = pending->session;
 	DBusMessage *reply = dbus_pending_call_steal_reply(call);
 	const char *name;
 	DBusError derr;
@@ -1015,7 +1018,7 @@ static void session_request_reply(DBusPendingCall *call, gpointer user_data)
 	DBG("Agent.Request() reply: %s", name);
 
 	if (strlen(name))
-		transfer_set_name(pending->transfer, name);
+		obc_transfer_set_name(pending->transfer, name);
 
 	pending->cb(session, NULL, pending->transfer);
 	dbus_message_unref(reply);
@@ -1026,7 +1029,7 @@ static void session_request_reply(DBusPendingCall *call, gpointer user_data)
 static gboolean session_request_proceed(gpointer data)
 {
 	struct pending_data *pending = data;
-	struct transfer_data *transfer = pending->transfer;
+	struct obc_transfer *transfer = pending->transfer;
 
 	pending->cb(pending->session, NULL, transfer);
 	g_free(pending);
@@ -1034,10 +1037,10 @@ static gboolean session_request_proceed(gpointer data)
 	return FALSE;
 }
 
-static int session_request(struct session_data *session, session_callback_t cb,
-				struct transfer_data *transfer)
+static int session_request(struct obc_session *session, session_callback_t cb,
+				struct obc_transfer *transfer)
 {
-	struct agent_data *agent = session->agent;
+	struct obc_agent *agent = session->agent;
 	struct pending_data *pending;
 	const char *path;
 	int err;
@@ -1047,14 +1050,14 @@ static int session_request(struct session_data *session, session_callback_t cb,
 	pending->session = session;
 	pending->transfer = transfer;
 
-	path = transfer_get_path(transfer);
+	path = obc_transfer_get_path(transfer);
 
 	if (agent == NULL || path == NULL) {
 		g_idle_add(session_request_proceed, pending);
 		return 0;
 	}
 
-	err = agent_request(agent, path, session_request_reply, pending,
+	err = obc_agent_request(agent, path, session_request_reply, pending,
 								g_free);
 	if (err < 0) {
 		g_free(pending);
@@ -1064,8 +1067,8 @@ static int session_request(struct session_data *session, session_callback_t cb,
 	return 0;
 }
 
-static void session_terminate_transfer(struct session_data *session,
-					struct transfer_data *transfer,
+static void session_terminate_transfer(struct obc_session *session,
+					struct obc_transfer *transfer,
 					GError *gerr)
 {
 	struct session_callback *callback = session->callback;
@@ -1075,29 +1078,29 @@ static void session_terminate_transfer(struct session_data *session,
 		return;
 	}
 
-	session_ref(session);
+	obc_session_ref(session);
 
-	transfer_unregister(transfer);
+	obc_transfer_unregister(transfer);
 
 	if (session->pending)
 		session_request(session, session_prepare_put,
 				session->pending->data);
 
-	session_unref(session);
+	obc_session_unref(session);
 }
 
-static void session_notify_complete(struct session_data *session,
-				struct transfer_data *transfer)
+static void session_notify_complete(struct obc_session *session,
+				struct obc_transfer *transfer)
 {
-	struct agent_data *agent = session->agent;
+	struct obc_agent *agent = session->agent;
 	const char *path;
 
-	path = transfer_get_path(transfer);
+	path = obc_transfer_get_path(transfer);
 
 	if (agent == NULL || path == NULL)
 		goto done;
 
-	agent_notify_complete(agent, path);
+	obc_agent_notify_complete(agent, path);
 
 done:
 
@@ -1106,18 +1109,18 @@ done:
 	session_terminate_transfer(session, transfer, NULL);
 }
 
-static void session_notify_error(struct session_data *session,
-				struct transfer_data *transfer,
+static void session_notify_error(struct obc_session *session,
+				struct obc_transfer *transfer,
 				GError *err)
 {
-	struct agent_data *agent = session->agent;
+	struct obc_agent *agent = session->agent;
 	const char *path;
 
-	path = transfer_get_path(transfer);
+	path = obc_transfer_get_path(transfer);
 	if (agent == NULL || path == NULL)
 		goto done;
 
-	agent_notify_error(agent, path, err->message);
+	obc_agent_notify_error(agent, path, err->message);
 
 done:
 	error("Transfer(%p) Error: %s", transfer, err->message);
@@ -1125,31 +1128,31 @@ done:
 	session_terminate_transfer(session, transfer, err);
 }
 
-static void session_notify_progress(struct session_data *session,
-					struct transfer_data *transfer,
+static void session_notify_progress(struct obc_session *session,
+					struct obc_transfer *transfer,
 					gint64 transferred)
 {
-	struct agent_data *agent = session->agent;
+	struct obc_agent *agent = session->agent;
 	const char *path;
 
-	path = transfer_get_path(transfer);
+	path = obc_transfer_get_path(transfer);
 	if (agent == NULL || path == NULL)
 		goto done;
 
-	agent_notify_progress(agent, path, transferred);
+	obc_agent_notify_progress(agent, path, transferred);
 
 done:
 	DBG("Transfer(%p) progress: %ld bytes", transfer,
 			(long int ) transferred);
 
-	if (transferred == transfer_get_size(transfer))
+	if (transferred == obc_transfer_get_size(transfer))
 		session_notify_complete(session, transfer);
 }
 
-static void transfer_progress(struct transfer_data *transfer, gint64 transferred,
+static void transfer_progress(struct obc_transfer *transfer, gint64 transferred,
 				int err, void *user_data)
 {
-	struct session_data *session = user_data;
+	struct obc_session *session = user_data;
 	GError *gerr = NULL;
 
 	if (err != 0)
@@ -1166,13 +1169,13 @@ fail:
 	g_clear_error(&gerr);
 }
 
-static void session_prepare_get(struct session_data *session,
+static void session_prepare_get(struct obc_session *session,
 				GError *err, void *data)
 {
-	struct transfer_data *transfer = data;
+	struct obc_transfer *transfer = data;
 	int ret;
 
-	ret = transfer_get(transfer, transfer_progress, session);
+	ret = obc_transfer_get(transfer, transfer_progress, session);
 	if (ret < 0) {
 		GError *gerr = NULL;
 
@@ -1185,27 +1188,27 @@ static void session_prepare_get(struct session_data *session,
 	DBG("Transfer(%p) started", transfer);
 }
 
-int session_get(struct session_data *session, const char *type,
+int obc_session_get(struct obc_session *session, const char *type,
 		const char *filename, const char *targetname,
 		const guint8 *apparam, gint apparam_size,
 		session_callback_t func, void *user_data)
 {
-	struct transfer_data *transfer;
-	struct transfer_params *params = NULL;
+	struct obc_transfer *transfer;
+	struct obc_transfer_params *params = NULL;
 	int err;
 
 	if (session->obex == NULL)
 		return -ENOTCONN;
 
 	if (apparam != NULL) {
-		params = g_new0(struct transfer_params, 1);
+		params = g_new0(struct obc_transfer_params, 1);
 		params->data = g_new(guint8, apparam_size);
 		memcpy(params->data, apparam, apparam_size);
 		params->size = apparam_size;
 	}
 
-	transfer = transfer_register(session->conn, filename, targetname, type,
-					params, session);
+	transfer = obc_transfer_register(session->conn, filename, targetname,
+							type, params, session);
 	if (transfer == NULL) {
 		if (params != NULL) {
 			g_free(params->data);
@@ -1229,17 +1232,17 @@ int session_get(struct session_data *session, const char *type,
 	return 0;
 }
 
-int session_send(struct session_data *session, const char *filename,
+int obc_session_send(struct obc_session *session, const char *filename,
 				const char *targetname)
 {
-	struct transfer_data *transfer;
+	struct obc_transfer *transfer;
 	int err;
 
 	if (session->obex == NULL)
 		return -ENOTCONN;
 
-	transfer = transfer_register(session->conn, filename, targetname, NULL,
-					NULL, session);
+	transfer = obc_transfer_register(session->conn, filename, targetname,
+							NULL, NULL, session);
 	if (transfer == NULL)
 		return -EINVAL;
 
@@ -1254,23 +1257,23 @@ int session_send(struct session_data *session, const char *filename,
 	return 0;
 
 fail:
-	transfer_unregister(transfer);
+	obc_transfer_unregister(transfer);
 
 	return err;
 }
 
-int session_pull(struct session_data *session,
+int obc_session_pull(struct obc_session *session,
 				const char *type, const char *filename,
 				session_callback_t function, void *user_data)
 {
-	struct transfer_data *transfer;
+	struct obc_transfer *transfer;
 	int err;
 
 	if (session->obex == NULL)
 		return -ENOTCONN;
 
-	transfer = transfer_register(session->conn, NULL, filename, type, NULL,
-								session);
+	transfer = obc_transfer_register(session->conn, NULL, filename, type,
+								NULL, session);
 	if (transfer == NULL) {
 		return -EIO;
 	}
@@ -1287,11 +1290,11 @@ int session_pull(struct session_data *session,
 	if (err == 0)
 		return 0;
 
-	transfer_unregister(transfer);
+	obc_transfer_unregister(transfer);
 	return err;
 }
 
-const char *session_register(struct session_data *session,
+const char *obc_session_register(struct obc_session *session,
 						GDBusDestroyFunction destroy)
 {
 	if (session->path)
@@ -1321,13 +1324,13 @@ fail:
 	return NULL;
 }
 
-static void session_prepare_put(struct session_data *session,
+static void session_prepare_put(struct obc_session *session,
 				GError *err, void *data)
 {
-	struct transfer_data *transfer = data;
+	struct obc_transfer *transfer = data;
 	int ret;
 
-	ret = transfer_put(transfer, transfer_progress, session);
+	ret = obc_transfer_put(transfer, transfer_progress, session);
 	if (ret < 0) {
 		GError *gerr = NULL;
 
@@ -1341,9 +1344,9 @@ static void session_prepare_put(struct session_data *session,
 	DBG("Transfer(%p) started", transfer);
 }
 
-int session_put(struct session_data *session, char *buf, const char *targetname)
+int obc_session_put(struct obc_session *session, char *buf, const char *targetname)
 {
-	struct transfer_data *transfer;
+	struct obc_transfer *transfer;
 	int err;
 
 	if (session->obex == NULL)
@@ -1352,12 +1355,12 @@ int session_put(struct session_data *session, char *buf, const char *targetname)
 	if (session->pending != NULL)
 		return -EISCONN;
 
-	transfer = transfer_register(session->conn, NULL, targetname, NULL,
+	transfer = obc_transfer_register(session->conn, NULL, targetname, NULL,
 								NULL, session);
 	if (transfer == NULL)
 		return -EIO;
 
-	transfer_set_buffer(transfer, buf);
+	obc_transfer_set_buffer(transfer, buf);
 
 	err = session_request(session, session_prepare_put, transfer);
 	if (err < 0)
@@ -1368,15 +1371,15 @@ int session_put(struct session_data *session, char *buf, const char *targetname)
 
 static void agent_destroy(gpointer data, gpointer user_data)
 {
-	struct session_data *session = user_data;
+	struct obc_session *session = user_data;
 
 	session->agent = NULL;
 }
 
-int session_set_agent(struct session_data *session, const char *name,
+int obc_session_set_agent(struct obc_session *session, const char *name,
 							const char *path)
 {
-	struct agent_data *agent;
+	struct obc_agent *agent;
 
 	if (session == NULL)
 		return -EINVAL;
@@ -1384,20 +1387,20 @@ int session_set_agent(struct session_data *session, const char *name,
 	if (session->agent)
 		return -EALREADY;
 
-	agent = agent_create(session->conn, name, path, agent_destroy,
+	agent = obc_agent_create(session->conn, name, path, agent_destroy,
 								session);
 
 	if (session->watch == 0)
-		session_set_owner(session, name, owner_disconnected);
+		obc_session_set_owner(session, name, owner_disconnected);
 
 	session->agent = agent;
 
 	return 0;
 }
 
-const char *session_get_agent(struct session_data *session)
+const char *obc_session_get_agent(struct obc_session *session)
 {
-	struct agent_data *agent;
+	struct obc_agent *agent;
 
 	if (session == NULL)
 		return NULL;
@@ -1406,10 +1409,10 @@ const char *session_get_agent(struct session_data *session)
 	if (agent == NULL)
 		return NULL;
 
-	return agent_get_name(session->agent);
+	return obc_agent_get_name(session->agent);
 }
 
-const char *session_get_owner(struct session_data *session)
+const char *obc_session_get_owner(struct obc_session *session)
 {
 	if (session == NULL)
 		return NULL;
@@ -1417,34 +1420,34 @@ const char *session_get_owner(struct session_data *session)
 	return session->owner;
 }
 
-const char *session_get_path(struct session_data *session)
+const char *obc_session_get_path(struct obc_session *session)
 {
 	return session->path;
 }
 
-const char *session_get_target(struct session_data *session)
+const char *obc_session_get_target(struct obc_session *session)
 {
 	return session->driver->target;
 }
 
-GwObex *session_get_obex(struct session_data *session)
+GwObex *obc_session_get_obex(struct obc_session *session)
 {
 	return session->obex;
 }
 
-struct transfer_data *session_get_transfer(struct session_data *session)
+struct obc_transfer *obc_session_get_transfer(struct obc_session *session)
 {
 	return session->pending ? session->pending->data : NULL;
 }
 
-void session_add_transfer(struct session_data *session,
-					struct transfer_data *transfer)
+void obc_session_add_transfer(struct obc_session *session,
+					struct obc_transfer *transfer)
 {
 	session->pending = g_slist_append(session->pending, transfer);
 }
 
-void session_remove_transfer(struct session_data *session,
-					struct transfer_data *transfer)
+void obc_session_remove_transfer(struct obc_session *session,
+					struct obc_transfer *transfer)
 {
 	session->pending = g_slist_remove(session->pending, transfer);
 }
diff --git a/client/session.h b/client/session.h
index 014daaf..8a9480b 100644
--- a/client/session.h
+++ b/client/session.h
@@ -25,12 +25,12 @@
 #include <gdbus.h>
 #include <gw-obex.h>
 
-struct session_data;
+struct obc_session;
 
-typedef void (*session_callback_t) (struct session_data *session,
+typedef void (*session_callback_t) (struct obc_session *session,
 					GError *err, void *user_data);
 
-struct session_data *session_create(const char *source,
+struct obc_session *obc_session_create(const char *source,
 						const char *destination,
 						const char *service,
 						uint8_t channel,
@@ -38,38 +38,38 @@ struct session_data *session_create(const char *source,
 						session_callback_t function,
 						void *user_data);
 
-struct session_data *session_ref(struct session_data *session);
-void session_unref(struct session_data *session);
-void session_shutdown(struct session_data *session);
+struct obc_session *obc_session_ref(struct obc_session *session);
+void obc_session_unref(struct obc_session *session);
+void obc_session_shutdown(struct obc_session *session);
 
-int session_set_owner(struct session_data *session, const char *name,
+int obc_session_set_owner(struct obc_session *session, const char *name,
 			GDBusWatchFunction func);
-const char *session_get_owner(struct session_data *session);
+const char *obc_session_get_owner(struct obc_session *session);
 
-int session_set_agent(struct session_data *session, const char *name,
+int obc_session_set_agent(struct obc_session *session, const char *name,
 							const char *path);
-const char *session_get_agent(struct session_data *session);
+const char *obc_session_get_agent(struct obc_session *session);
 
-const char *session_get_path(struct session_data *session);
-const char *session_get_target(struct session_data *session);
-GwObex *session_get_obex(struct session_data *session);
+const char *obc_session_get_path(struct obc_session *session);
+const char *obc_session_get_target(struct obc_session *session);
+GwObex *obc_session_get_obex(struct obc_session *session);
 
-struct transfer_data *session_get_transfer(struct session_data *session);
-void session_add_transfer(struct session_data *session,
-					struct transfer_data *transfer);
-void session_remove_transfer(struct session_data *session,
-					struct transfer_data *transfer);
+struct obc_transfer *obc_session_get_transfer(struct obc_session *session);
+void obc_session_add_transfer(struct obc_session *session,
+					struct obc_transfer *transfer);
+void obc_session_remove_transfer(struct obc_session *session,
+					struct obc_transfer *transfer);
 
-int session_send(struct session_data *session, const char *filename,
+int obc_session_send(struct obc_session *session, const char *filename,
 				const char *remotename);
-int session_get(struct session_data *session, const char *type,
+int obc_session_get(struct obc_session *session, const char *type,
 		const char *filename, const char *targetname,
 		const guint8  *apparam, gint apparam_size,
 		session_callback_t func, void *user_data);
-int session_pull(struct session_data *session,
+int obc_session_pull(struct obc_session *session,
 				const char *type, const char *filename,
 				session_callback_t function, void *user_data);
-const char *session_register(struct session_data *session,
+const char *obc_session_register(struct obc_session *session,
 						GDBusDestroyFunction destroy);
-int session_put(struct session_data *session, char *buf,
+int obc_session_put(struct obc_session *session, char *buf,
 				const char *targetname);
diff --git a/client/sync.c b/client/sync.c
index d9b6af7..abeb717 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -37,7 +37,7 @@
 #define ERROR_INF SYNC_INTERFACE ".Error"
 
 struct sync_data {
-	struct session_data *session;
+	struct obc_session *session;
 	char *phonebook_path;
 	DBusConnection *conn;
 	DBusMessage *msg;
@@ -73,10 +73,10 @@ static DBusMessage *sync_setlocation(DBusConnection *connection,
 	return dbus_message_new_method_return(message);
 }
 
-static void sync_getphonebook_callback(struct session_data *session,
+static void sync_getphonebook_callback(struct obc_session *session,
 					GError *err, void *user_data)
 {
-	struct transfer_data *transfer = session_get_transfer(session);
+	struct obc_transfer *transfer = obc_session_get_transfer(session);
 	struct sync_data *sync = user_data;
 	DBusMessage *reply;
 	const char *buf;
@@ -84,7 +84,7 @@ static void sync_getphonebook_callback(struct session_data *session,
 
 	reply = dbus_message_new_method_return(sync->msg);
 
-	buf = transfer_get_buffer(transfer, &size);
+	buf = obc_transfer_get_buffer(transfer, &size);
 	if (size == 0)
 		buf = "";
 
@@ -110,7 +110,7 @@ static DBusMessage *sync_getphonebook(DBusConnection *connection,
 	if (!sync->phonebook_path)
 		sync->phonebook_path = g_strdup("telecom/pb.vcf");
 
-	if (session_get(sync->session, "phonebook", sync->phonebook_path, NULL,
+	if (obc_session_get(sync->session, "phonebook", sync->phonebook_path, NULL,
 				NULL, 0, sync_getphonebook_callback, sync) < 0)
 		return g_dbus_create_error(message,
 			ERROR_INF ".Failed", "Failed");
@@ -139,7 +139,7 @@ static DBusMessage *sync_putphonebook(DBusConnection *connection,
 
 	buffer = g_strdup(buf);
 
-	if (session_put(sync->session, buffer, sync->phonebook_path) < 0)
+	if (obc_session_put(sync->session, buffer, sync->phonebook_path) < 0)
 		return g_dbus_create_error(message,
 				ERROR_INF ".Failed", "Failed");
 
@@ -159,7 +159,7 @@ static void sync_free(void *data)
 {
 	struct sync_data *sync = data;
 
-	session_unref(sync->session);
+	obc_session_unref(sync->session);
 	dbus_connection_unref(sync->conn);
 	g_free(sync->phonebook_path);
 	g_free(sync);
@@ -168,14 +168,14 @@ static void sync_free(void *data)
 gboolean sync_register_interface(DBusConnection *connection, const char *path,
 							void *user_data)
 {
-	struct session_data *session = user_data;
+	struct obc_session *session = user_data;
 	struct sync_data *sync;
 
 	sync = g_try_new0(struct sync_data, 1);
 	if (!sync)
 		return FALSE;
 
-	sync->session = session_ref(session);
+	sync->session = obc_session_ref(session);
 	sync->conn = dbus_connection_ref(connection);
 
 	if (g_dbus_register_interface(connection, path, SYNC_INTERFACE,
diff --git a/client/transfer.c b/client/transfer.c
index 39b0c91..af48f69 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -51,9 +51,9 @@ struct transfer_callback {
 	void *data;
 };
 
-struct transfer_data {
-	struct session_data *session;
-	struct transfer_params *params;
+struct obc_transfer {
+	struct obc_session *session;
+	struct obc_transfer_params *params;
 	struct transfer_callback *callback;
 	DBusConnection *conn;
 	char *path;		/* Transfer path */
@@ -104,10 +104,10 @@ static void append_entry(DBusMessageIter *dict,
 	dbus_message_iter_close_container(dict, &entry);
 }
 
-static DBusMessage *transfer_get_properties(DBusConnection *connection,
+static DBusMessage *obc_transfer_get_properties(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	struct transfer_data *transfer = user_data;
+	struct obc_transfer *transfer = user_data;
 	DBusMessage *reply;
 	DBusMessageIter iter, dict;
 
@@ -131,16 +131,16 @@ static DBusMessage *transfer_get_properties(DBusConnection *connection,
 	return reply;
 }
 
-static DBusMessage *transfer_cancel(DBusConnection *connection,
+static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	struct transfer_data *transfer = user_data;
-	struct session_data *session = transfer->session;
+	struct obc_transfer *transfer = user_data;
+	struct obc_session *session = transfer->session;
 	const gchar *sender, *agent;
 	DBusMessage *reply;
 
 	sender = dbus_message_get_sender(message);
-	agent = session_get_agent(session);
+	agent = obc_session_get_agent(session);
 	if (g_str_equal(sender, agent) == FALSE)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.NotAuthorized",
@@ -150,20 +150,20 @@ static DBusMessage *transfer_cancel(DBusConnection *connection,
 	if (!reply)
 		return NULL;
 
-	transfer_abort(transfer);
+	obc_transfer_abort(transfer);
 
 	return reply;
 }
 
-static GDBusMethodTable transfer_methods[] = {
-	{ "GetProperties", "", "a{sv}", transfer_get_properties },
-	{ "Cancel", "", "", transfer_cancel },
+static GDBusMethodTable obc_transfer_methods[] = {
+	{ "GetProperties", "", "a{sv}", obc_transfer_get_properties },
+	{ "Cancel", "", "", obc_transfer_cancel },
 	{ }
 };
 
-static void transfer_free(struct transfer_data *transfer)
+static void obc_transfer_free(struct obc_transfer *transfer)
 {
-	struct session_data *session = transfer->session;
+	struct obc_session *session = transfer->session;
 
 	DBG("%p", transfer);
 
@@ -175,9 +175,9 @@ static void transfer_free(struct transfer_data *transfer)
 	if (transfer->fd > 0)
 		close(transfer->fd);
 
-	session_remove_transfer(session, transfer);
+	obc_session_remove_transfer(session, transfer);
 
-	session_unref(session);
+	obc_session_unref(session);
 
 	if (transfer->params != NULL) {
 		g_free(transfer->params->data);
@@ -196,18 +196,18 @@ static void transfer_free(struct transfer_data *transfer)
 	g_free(transfer);
 }
 
-struct transfer_data *transfer_register(DBusConnection *conn,
+struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 						const char *filename,
 						const char *name,
 						const char *type,
-						struct transfer_params *params,
+						struct obc_transfer_params *params,
 						void *user_data)
 {
-	struct session_data *session = user_data;
-	struct transfer_data *transfer;
+	struct obc_session *session = user_data;
+	struct obc_transfer *transfer;
 
-	transfer = g_new0(struct transfer_data, 1);
-	transfer->session = session_ref(session);
+	transfer = g_new0(struct obc_transfer, 1);
+	transfer->session = obc_session_ref(session);
 	transfer->filename = g_strdup(filename);
 	transfer->name = g_strdup(name);
 	transfer->type = g_strdup(type);
@@ -224,27 +224,27 @@ struct transfer_data *transfer_register(DBusConnection *conn,
 
 	transfer->conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
 	if (transfer->conn == NULL) {
-		transfer_free(transfer);
+		obc_transfer_free(transfer);
 		return NULL;
 	}
 
 	if (g_dbus_register_interface(transfer->conn, transfer->path,
 				TRANSFER_INTERFACE,
-				transfer_methods, NULL, NULL,
+				obc_transfer_methods, NULL, NULL,
 				transfer, NULL) == FALSE) {
-		transfer_free(transfer);
+		obc_transfer_free(transfer);
 		return NULL;
 	}
 
 done:
 	DBG("%p registered %s", transfer, transfer->path);
 
-	session_add_transfer(session, transfer);
+	obc_session_add_transfer(session, transfer);
 
 	return transfer;
 }
 
-void transfer_unregister(struct transfer_data *transfer)
+void obc_transfer_unregister(struct obc_transfer *transfer)
 {
 	if (transfer->path) {
 		g_dbus_unregister_interface(transfer->conn,
@@ -253,10 +253,10 @@ void transfer_unregister(struct transfer_data *transfer)
 
 	DBG("%p unregistered %s", transfer, transfer->path);
 
-	transfer_free(transfer);
+	obc_transfer_free(transfer);
 }
 
-static gboolean transfer_read(struct transfer_data *transfer, GwObexXfer *xfer)
+static gboolean obc_transfer_read(struct obc_transfer *transfer, GwObexXfer *xfer)
 {
 	gint bsize, bread;
 
@@ -300,10 +300,10 @@ static gboolean transfer_read(struct transfer_data *transfer, GwObexXfer *xfer)
 static void get_buf_xfer_progress(GwObexXfer *xfer,
 					gpointer user_data)
 {
-	struct transfer_data *transfer = user_data;
+	struct obc_transfer *transfer = user_data;
 	struct transfer_callback *callback = transfer->callback;
 
-	if (transfer_read(transfer, xfer) == FALSE)
+	if (obc_transfer_read(transfer, xfer) == FALSE)
 		goto fail;
 
 	if (gw_obex_xfer_object_done(xfer)) {
@@ -335,10 +335,10 @@ fail:
 
 static void get_xfer_progress(GwObexXfer *xfer, gpointer user_data)
 {
-	struct transfer_data *transfer = user_data;
+	struct obc_transfer *transfer = user_data;
 	struct transfer_callback *callback = transfer->callback;
 
-	if (transfer_read(transfer, xfer) == FALSE)
+	if (obc_transfer_read(transfer, xfer) == FALSE)
 		goto done;
 
 	if (transfer->fd > 0) {
@@ -361,7 +361,7 @@ done:
 
 static void put_buf_xfer_progress(GwObexXfer *xfer, gpointer user_data)
 {
-	struct transfer_data *transfer = user_data;
+	struct obc_transfer *transfer = user_data;
 	struct transfer_callback *callback = transfer->callback;
 	gint written;
 
@@ -386,7 +386,7 @@ done:
 
 static void put_xfer_progress(GwObexXfer *xfer, gpointer user_data)
 {
-	struct transfer_data *transfer = user_data;
+	struct obc_transfer *transfer = user_data;
 	struct transfer_callback *callback = transfer->callback;
 	gint written;
 
@@ -429,7 +429,7 @@ done:
 				callback->data);
 }
 
-static void transfer_set_callback(struct transfer_data *transfer,
+static void obc_transfer_set_callback(struct obc_transfer *transfer,
 					transfer_callback_t func,
 					void *user_data)
 {
@@ -444,10 +444,10 @@ static void transfer_set_callback(struct transfer_data *transfer,
 	transfer->callback = callback;
 }
 
-int transfer_get(struct transfer_data *transfer, transfer_callback_t func,
+int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
 			void *user_data)
 {
-	struct session_data *session = transfer->session;
+	struct obc_session *session = transfer->session;
 	GwObex *obex;
 	gw_obex_xfer_cb_t cb;
 
@@ -470,7 +470,7 @@ int transfer_get(struct transfer_data *transfer, transfer_callback_t func,
 		cb = get_xfer_progress;
 	}
 
-	obex = session_get_obex(session);
+	obex = obc_session_get_obex(session);
 
 	if (transfer->params != NULL)
 		transfer->xfer = gw_obex_get_async_with_apparam(obex,
@@ -488,17 +488,17 @@ int transfer_get(struct transfer_data *transfer, transfer_callback_t func,
 		return -ENOTCONN;
 
 	if (func)
-		transfer_set_callback(transfer, func, user_data);
+		obc_transfer_set_callback(transfer, func, user_data);
 
 	gw_obex_xfer_set_callback(transfer->xfer, cb, transfer);
 
 	return 0;
 }
 
-int transfer_put(struct transfer_data *transfer, transfer_callback_t func,
+int obc_transfer_put(struct obc_transfer *transfer, transfer_callback_t func,
 			void *user_data)
 {
-	struct session_data *session = transfer->session;
+	struct obc_session *session = transfer->session;
 	GwObex *obex;
 	gw_obex_xfer_cb_t cb;
 	struct stat st;
@@ -529,7 +529,7 @@ int transfer_put(struct transfer_data *transfer, transfer_callback_t func,
 	cb = put_xfer_progress;
 
 done:
-	obex = session_get_obex(session);
+	obex = obc_session_get_obex(session);
 	size = transfer->size < UINT32_MAX ? transfer->size : 0;
 	transfer->xfer = gw_obex_put_async(obex, transfer->name,
 						transfer->type, size,
@@ -538,14 +538,14 @@ done:
 		return -ENOTCONN;
 
 	if (func)
-		transfer_set_callback(transfer, func, user_data);
+		obc_transfer_set_callback(transfer, func, user_data);
 
 	gw_obex_xfer_set_callback(transfer->xfer, cb, transfer);
 
 	return 0;
 }
 
-void transfer_abort(struct transfer_data *transfer)
+void obc_transfer_abort(struct obc_transfer *transfer)
 {
 	struct transfer_callback *callback = transfer->callback;
 
@@ -561,8 +561,8 @@ void transfer_abort(struct transfer_data *transfer)
 				callback->data);
 }
 
-int transfer_get_params(struct transfer_data *transfer,
-					struct transfer_params *params)
+int obc_transfer_get_params(struct obc_transfer *transfer,
+					struct obc_transfer_params *params)
 {
 	if (!transfer->xfer)
 		return -ENOTCONN;
@@ -573,12 +573,12 @@ int transfer_get_params(struct transfer_data *transfer,
 	return 0;
 }
 
-void transfer_clear_buffer(struct transfer_data *transfer)
+void obc_transfer_clear_buffer(struct obc_transfer *transfer)
 {
 	transfer->filled = 0;
 }
 
-const char *transfer_get_buffer(struct transfer_data *transfer, int *size)
+const char *obc_transfer_get_buffer(struct obc_transfer *transfer, int *size)
 {
 	if (size)
 		*size = transfer->filled;
@@ -586,24 +586,24 @@ const char *transfer_get_buffer(struct transfer_data *transfer, int *size)
 	return transfer->buffer;
 }
 
-void transfer_set_buffer(struct transfer_data *transfer, char *buffer)
+void obc_transfer_set_buffer(struct obc_transfer *transfer, char *buffer)
 {
 	transfer->size = strlen(buffer);
 	transfer->buffer = buffer;
 }
 
-void transfer_set_name(struct transfer_data *transfer, const char *name)
+void obc_transfer_set_name(struct obc_transfer *transfer, const char *name)
 {
 	g_free(transfer->name);
 	transfer->name = g_strdup(name);
 }
 
-const char *transfer_get_path(struct transfer_data *transfer)
+const char *obc_transfer_get_path(struct obc_transfer *transfer)
 {
 	return transfer->path;
 }
 
-gint64 transfer_get_size(struct transfer_data *transfer)
+gint64 obc_transfer_get_size(struct obc_transfer *transfer)
 {
 	return transfer->size;
 }
diff --git a/client/transfer.h b/client/transfer.h
index ac14623..ec0cf8e 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -23,39 +23,38 @@
 
 #include <gw-obex.h>
 
-struct transfer_params {
+struct obc_transfer_params {
 	guint8 *data;
 	size_t size;
 };
 
-struct transfer_callback;
-struct transfer_data;
+struct obc_transfer;
 
-typedef void (*transfer_callback_t) (struct transfer_data *transfer,
+typedef void (*transfer_callback_t) (struct obc_transfer *transfer,
 					gint64 transferred, gint err,
 					void *user_data);
 
-struct transfer_data *transfer_register(DBusConnection *conn,
+struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 						const char *filename,
 						const char *name,
 						const char *type,
-						struct transfer_params *params,
+						struct obc_transfer_params *params,
 						void *user_data);
 
-void transfer_unregister(struct transfer_data *transfer);
+void obc_transfer_unregister(struct obc_transfer *transfer);
 
-int transfer_get(struct transfer_data *transfer, transfer_callback_t func,
+int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
 			void *user_data);
-int transfer_put(struct transfer_data *transfer, transfer_callback_t func,
+int obc_transfer_put(struct obc_transfer *transfer, transfer_callback_t func,
 			void *user_data);
-void transfer_abort(struct transfer_data *transfer);
+void obc_transfer_abort(struct obc_transfer *transfer);
 
-int transfer_get_params(struct transfer_data *transfer,
-					struct transfer_params *params);
-const char *transfer_get_buffer(struct transfer_data *transfer, int *size);
-void transfer_set_buffer(struct transfer_data *transfer, char *buffer);
-void transfer_clear_buffer(struct transfer_data *transfer);
+int obc_transfer_get_params(struct obc_transfer *transfer,
+					struct obc_transfer_params *params);
+const char *obc_transfer_get_buffer(struct obc_transfer *transfer, int *size);
+void obc_transfer_set_buffer(struct obc_transfer *transfer, char *buffer);
+void obc_transfer_clear_buffer(struct obc_transfer *transfer);
 
-void transfer_set_name(struct transfer_data *transfer, const char *name);
-const char *transfer_get_path(struct transfer_data *transfer);
-gint64 transfer_get_size(struct transfer_data *transfer);
+void obc_transfer_set_name(struct obc_transfer *transfer, const char *name);
+const char *obc_transfer_get_path(struct obc_transfer *transfer);
+gint64 obc_transfer_get_size(struct obc_transfer *transfer);
-- 
1.7.6

