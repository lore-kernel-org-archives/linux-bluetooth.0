Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/2] client: Fix not propagating GError in session API functions
Date: Thu, 26 Apr 2012 17:37:58 +0300
Message-Id: <1335451079-11868-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The errors should be properly forward to the caller and not just convert
to generic error.
---
 client/ftp.c      |   43 ++++++++++++++++++++++++-----------
 client/manager.c  |   48 +++++++++++++++++++++++++++------------
 client/map.c      |   34 +++++++++++++++++-----------
 client/pbap.c     |   47 ++++++++++++++++++++++++---------------
 client/session.c  |   63 ++++++++++++++++++++++++++++------------------------
 client/session.h  |   22 ++++++++++--------
 client/sync.c     |   30 ++++++++++++++++++------
 client/transfer.c |   53 +++++++++++++++++++++++++++-----------------
 client/transfer.h |    6 +++-
 9 files changed, 216 insertions(+), 130 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index f415f2f..0e6af47 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -255,12 +255,17 @@ static DBusMessage *list_folder(DBusConnection *connection,
 {
 	struct ftp_data *ftp = user_data;
 	struct obc_session *session = ftp->session;
+	GError *err = NULL;
 
-	if (obc_session_get(session, "x-obex/folder-listing",
-			NULL, NULL, NULL, 0, list_folder_callback, message) < 0)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.Failed",
-				"Failed");
+	obc_session_get(session, "x-obex/folder-listing", NULL, NULL,
+				NULL, 0, list_folder_callback, message, &err);
+	if (err != NULL) {
+		DBusMessage *reply = g_dbus_create_error(message,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
+		g_error_free(err);
+		return reply;
+	}
 
 	dbus_message_ref(message);
 
@@ -273,6 +278,7 @@ static DBusMessage *get_file(DBusConnection *connection,
 	struct ftp_data *ftp = user_data;
 	struct obc_session *session = ftp->session;
 	const char *target_file, *source_file;
+	GError *err = NULL;
 
 	if (dbus_message_get_args(message, NULL,
 				DBUS_TYPE_STRING, &target_file,
@@ -281,11 +287,15 @@ static DBusMessage *get_file(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
 
-	if (obc_session_get(session, NULL, source_file,
-			target_file, NULL, 0, get_file_callback, message) < 0)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.Failed",
-				"Failed");
+	obc_session_get(session, NULL, source_file, target_file, NULL, 0,
+					get_file_callback, message, &err);
+	if (err != NULL) {
+		DBusMessage *reply = g_dbus_create_error(message,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
+		g_error_free(err);
+		return reply;
+	}
 
 	dbus_message_ref(message);
 
@@ -298,6 +308,7 @@ static DBusMessage *put_file(DBusConnection *connection,
 	struct ftp_data *ftp = user_data;
 	struct obc_session *session = ftp->session;
 	gchar *sourcefile, *targetfile;
+	GError *err = NULL;
 
 	if (dbus_message_get_args(message, NULL,
 					DBUS_TYPE_STRING, &sourcefile,
@@ -307,10 +318,14 @@ static DBusMessage *put_file(DBusConnection *connection,
 				"org.openobex.Error.InvalidArguments",
 				"Invalid arguments in method call");
 
-	if (obc_session_send(session, sourcefile, targetfile) < 0)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.Failed",
-				"Failed");
+	obc_session_send(session, sourcefile, targetfile, &err);
+	if (err != NULL) {
+		DBusMessage *reply = g_dbus_create_error(message,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
+		g_error_free(err);
+		return reply;
+	}
 
 	return dbus_message_new_method_return(message);
 }
diff --git a/client/manager.c b/client/manager.c
index 4f0b750..6d08702 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -112,7 +112,7 @@ static void create_callback(struct obc_session *session, GError *err,
 		const gchar *filename = g_ptr_array_index(data->files, i);
 		gchar *basename = g_path_get_basename(filename);
 
-		if (obc_session_send(session, filename, basename) < 0) {
+		if (obc_session_send(session, filename, basename, NULL) == 0) {
 			g_free(basename);
 			break;
 		}
@@ -274,22 +274,31 @@ static void pull_obc_session_callback(struct obc_session *session,
 					GError *err, void *user_data)
 {
 	struct send_data *data = user_data;
+	DBusMessage *reply;
+	GError *gerr = NULL;
 
 	if (err != NULL) {
-		DBusMessage *error = g_dbus_create_error(data->message,
-					"org.openobex.Error.Failed",
-					"%s", err->message);
-		g_dbus_send_message(data->connection, error);
-		shutdown_session(session);
-		goto done;
+		reply = g_dbus_create_error(data->message,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
+		goto fail;
 	}
 
 	obc_session_pull(session, "text/x-vcard", data->filename,
-						pull_complete_callback, data);
+					pull_complete_callback, data, &gerr);
+	if (gerr != NULL) {
+		reply = g_dbus_create_error(data->message,
+						"org.openobex.Error.Failed",
+						"%s", gerr->message);
+		g_error_free(gerr);
+		goto fail;
+	}
 
 	return;
 
-done:
+fail:
+	g_dbus_send_message(data->connection, reply);
+	shutdown_session(session);
 	dbus_message_unref(data->message);
 	dbus_connection_unref(data->connection);
 	g_free(data->filename);
@@ -482,22 +491,31 @@ static void capability_obc_session_callback(struct obc_session *session,
 						GError *err, void *user_data)
 {
 	struct send_data *data = user_data;
+	DBusMessage *reply;
+	GError *gerr = NULL;
 
 	if (err != NULL) {
-		DBusMessage *error = g_dbus_create_error(data->message,
+		reply = g_dbus_create_error(data->message,
 					"org.openobex.Error.Failed",
 					"%s", err->message);
-		g_dbus_send_message(data->connection, error);
-		shutdown_session(session);
-		goto done;
+		goto fail;
 	}
 
 	obc_session_pull(session, "x-obex/capability", NULL,
-				capabilities_complete_callback, data);
+				capabilities_complete_callback, data, &gerr);
+	if (gerr != NULL) {
+		reply = g_dbus_create_error(data->message,
+					"org.openobex.Error.Failed",
+					"%s", gerr->message);
+		g_error_free(gerr);
+		goto fail;
+	}
 
 	return;
 
-done:
+fail:
+	g_dbus_send_message(data->connection, reply);
+	shutdown_session(session);
 	dbus_message_unref(data->message);
 	dbus_connection_unref(data->connection);
 	g_free(data->sender);
diff --git a/client/map.c b/client/map.c
index 3841299..1b4e404 100644
--- a/client/map.c
+++ b/client/map.c
@@ -132,14 +132,18 @@ static DBusMessage *map_get_folder_listing(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	struct map_data *map = user_data;
-	int err;
+	GError *err = NULL;
 
-	err = obc_session_get(map->session, "x-obex/folder-listing",
-							NULL, NULL, NULL, 0,
-							buffer_cb, map);
-	if (err < 0)
-		return g_dbus_create_error(message, "org.openobex.Error.Failed",
-									NULL);
+	obc_session_get(map->session, "x-obex/folder-listing", NULL,
+							NULL, NULL, 0,
+							buffer_cb, map, &err);
+	if (err != NULL) {
+		DBusMessage *reply = g_dbus_create_error(message,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
+		g_error_free(err);
+		return reply;
+	}
 
 	map->msg = dbus_message_ref(message);
 
@@ -150,9 +154,9 @@ static DBusMessage *map_get_message_listing(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	struct map_data *map = user_data;
-	int err;
 	const char *folder;
 	DBusMessageIter msg_iter;
+	GError *err = NULL;
 
 	dbus_message_iter_init(message, &msg_iter);
 
@@ -162,12 +166,16 @@ static DBusMessage *map_get_message_listing(DBusConnection *connection,
 
 	dbus_message_iter_get_basic(&msg_iter, &folder);
 
-	err = obc_session_get(map->session, "x-bt/MAP-msg-listing", folder,
+	obc_session_get(map->session, "x-bt/MAP-msg-listing", folder,
 							NULL, NULL, 0,
-							buffer_cb, map);
-	if (err < 0)
-		return g_dbus_create_error(message, "org.openobex.Error.Failed",
-									NULL);
+							buffer_cb, map, &err);
+	if (err != NULL) {
+		DBusMessage *reply = g_dbus_create_error(message,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
+		g_error_free(err);
+		return reply;
+	}
 
 	map->msg = dbus_message_ref(message);
 
diff --git a/client/pbap.c b/client/pbap.c
index f8a72b0..baf2ca6 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -458,6 +458,7 @@ static DBusMessage *pull_phonebook(struct pbap_data *pbap,
 	struct pending_request *request;
 	struct pullphonebook_apparam apparam;
 	session_callback_t func;
+	GError *err = NULL;
 
 	apparam.filter_tag = FILTER_TAG;
 	apparam.filter_len = FILTER_LEN;
@@ -486,13 +487,16 @@ static DBusMessage *pull_phonebook(struct pbap_data *pbap,
 
 	request = pending_request_new(pbap, message);
 
-	if (obc_session_get(pbap->session, "x-bt/phonebook", name, NULL,
+	obc_session_get(pbap->session, "x-bt/phonebook", name, NULL,
 				(guint8 *) &apparam, sizeof(apparam),
-				func, request) < 0) {
+				func, request, &err);
+	if (err != NULL) {
+		DBusMessage *reply = g_dbus_create_error(message,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
+		g_error_free(err);
 		pending_request_free(request);
-		return g_dbus_create_error(message,
-				"org.openobex.Error.Failed",
-				"Failed");
+		return reply;
 	}
 
 	return NULL;
@@ -518,7 +522,7 @@ static DBusMessage *pull_vcard_listing(struct pbap_data *pbap,
 	struct pending_request *request;
 	guint8 *p, *apparam = NULL;
 	gint apparam_size;
-	int err;
+	GError *err = NULL;
 
 	/* trunc the searchval string if it's length exceed the max value of guint8 */
 	if (strlen(searchval) > 254)
@@ -548,15 +552,18 @@ static DBusMessage *pull_vcard_listing(struct pbap_data *pbap,
 
 	request = pending_request_new(pbap, message);
 
-	err = obc_session_get(pbap->session, "x-bt/vcard-listing", name, NULL,
+	obc_session_get(pbap->session, "x-bt/vcard-listing", name, NULL,
 				apparam, apparam_size,
-				pull_vcard_listing_callback, request);
+				pull_vcard_listing_callback, request, &err);
 	g_free(apparam);
-	if (err < 0) {
+	if (err != NULL) {
+		DBusMessage *reply = g_dbus_create_error(message,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
+		g_error_free(err);
 		pending_request_free(request);
-		return g_dbus_create_error(message,
-				"org.openobex.Error.Failed",
-				"Failed");
+		return reply;
+
 	}
 
 	return NULL;
@@ -748,6 +755,7 @@ static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
 	struct pullvcardentry_apparam apparam;
 	const char *name;
 	struct pending_request *request;
+	GError *err = NULL;
 
 	if (!pbap->path)
 		return g_dbus_create_error(message,
@@ -769,13 +777,16 @@ static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
 
 	request = pending_request_new(pbap, message);
 
-	if (obc_session_get(pbap->session, "x-bt/vcard", name, NULL,
-			(guint8 *)&apparam, sizeof(apparam),
-			pull_phonebook_callback, request) < 0) {
+	obc_session_get(pbap->session, "x-bt/vcard", name, NULL,
+				(guint8 *)&apparam, sizeof(apparam),
+				pull_phonebook_callback, request, &err);
+	if (err != NULL) {
+		DBusMessage *reply = g_dbus_create_error(message,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
+		g_error_free(err);
 		pending_request_free(request);
-		return g_dbus_create_error(message,
-				"org.openobex.Error.Failed",
-				"Failed");
+		return reply;
 	}
 
 	return NULL;
diff --git a/client/session.c b/client/session.c
index 7515ff0..1c923f4 100644
--- a/client/session.c
+++ b/client/session.c
@@ -743,33 +743,33 @@ static int pending_request_auth(struct pending_request *p)
 									NULL);
 }
 
-static int session_request(struct obc_session *session,
+static gboolean session_request(struct obc_session *session,
 					struct obc_transfer *transfer,
 					session_callback_t func,
-					void *data)
+					void *data, GError **err)
 {
 	struct pending_request *p;
-	int err;
+	int perr;
 
 	obc_transfer_set_callback(transfer, transfer_progress, session);
 
 	p = pending_request_new(session, transfer, session_start_transfer,
 								func, data);
-
 	if (session->p) {
 		g_queue_push_tail(session->queue, p);
-		return 0;
+		return TRUE;
 	}
 
-	err = pending_request_auth(p);
-	if (err < 0) {
+	perr = pending_request_auth(p);
+	if (perr < 0) {
+		g_set_error(err, OBEX_IO_ERROR, perr, "Authorization failed");
 		pending_request_free(p);
-		return err;
+		return FALSE;
 	}
 
 	session->p = p;
 
-	return 0;
+	return TRUE;
 }
 
 static void session_process_queue(struct obc_session *session)
@@ -946,17 +946,21 @@ static void session_start_transfer(gpointer data, gpointer user_data)
 	DBG("Transfer(%p) started", transfer);
 }
 
-int obc_session_get(struct obc_session *session, const char *type,
-		const char *name, const char *targetfile,
-		const guint8 *apparam, gint apparam_size,
-		session_callback_t func, void *user_data)
+gboolean obc_session_get(struct obc_session *session, const char *type,
+				const char *name, const char *targetfile,
+				const guint8 *apparam, gint apparam_size,
+				session_callback_t func, void *user_data,
+				GError **err)
 {
 	struct obc_transfer *transfer;
 	struct obc_transfer_params *params = NULL;
 	const char *agent;
 
-	if (session->obex == NULL)
-		return -ENOTCONN;
+	if (session->obex == NULL) {
+		g_set_error(err, OBEX_IO_ERROR, -ENOTCONN,
+						"Session not connected");
+		return 0;
+	}
 
 	if (apparam != NULL) {
 		params = g_new0(struct obc_transfer_params, 1);
@@ -971,20 +975,20 @@ int obc_session_get(struct obc_session *session, const char *type,
 		agent = NULL;
 
 	transfer = obc_transfer_get(session->conn, agent, targetfile, name,
-								type, params);
+							type, params, err);
 	if (transfer == NULL) {
 		if (params != NULL) {
 			g_free(params->data);
 			g_free(params);
 		}
-		return -EIO;
+		return 0;
 	}
 
-	return session_request(session, transfer, func, user_data);
+	return session_request(session, transfer, func, user_data, err);
 }
 
-int obc_session_send(struct obc_session *session, const char *filename,
-				const char *name)
+gboolean obc_session_send(struct obc_session *session, const char *filename,
+				const char *name, GError **err)
 {
 	struct obc_transfer *transfer;
 	const char *agent;
@@ -995,19 +999,20 @@ int obc_session_send(struct obc_session *session, const char *filename,
 	agent = obc_agent_get_name(session->agent);
 
 	transfer = obc_transfer_put(session->conn, agent, filename, name,
-					NULL, NULL, 0, NULL);
+					NULL, NULL, 0, NULL, err);
 	if (transfer == NULL)
 		return -EINVAL;
 
-	return session_request(session, transfer, NULL, NULL);
+	return session_request(session, transfer, NULL, NULL, err);
 }
 
-int obc_session_pull(struct obc_session *session,
+gboolean obc_session_pull(struct obc_session *session,
 				const char *type, const char *targetfile,
-				session_callback_t function, void *user_data)
+				session_callback_t function, void *user_data,
+				GError **err)
 {
 	return obc_session_get(session, type, NULL, targetfile, NULL, 0,
-							function, user_data);
+						function, user_data, err);
 }
 
 const char *obc_session_register(struct obc_session *session,
@@ -1040,8 +1045,8 @@ fail:
 	return NULL;
 }
 
-int obc_session_put(struct obc_session *session, const char *contents,
-					size_t size, const char *name)
+gboolean obc_session_put(struct obc_session *session, const char *contents,
+				size_t size, const char *name, GError **err)
 {
 	struct obc_transfer *transfer;
 	const char *agent;
@@ -1052,11 +1057,11 @@ int obc_session_put(struct obc_session *session, const char *contents,
 	agent = obc_agent_get_name(session->agent);
 
 	transfer = obc_transfer_put(session->conn, agent, NULL, name, NULL,
-							contents, size, NULL);
+						contents, size, NULL, err);
 	if (transfer == NULL)
 		return -EIO;
 
-	return session_request(session, transfer, NULL, NULL);
+	return session_request(session, transfer, NULL, NULL, err);
 }
 
 static void agent_destroy(gpointer data, gpointer user_data)
diff --git a/client/session.h b/client/session.h
index 7e6f42b..a0ee321 100644
--- a/client/session.h
+++ b/client/session.h
@@ -56,19 +56,21 @@ int obc_session_get_contents(struct obc_session *session, char **contents,
 								size_t *size);
 void *obc_session_get_params(struct obc_session *session, size_t *size);
 
-int obc_session_send(struct obc_session *session, const char *filename,
-				const char *name);
-int obc_session_get(struct obc_session *session, const char *type,
-		const char *name, const char *targetfile,
-		const guint8  *apparam, gint apparam_size,
-		session_callback_t func, void *user_data);
-int obc_session_pull(struct obc_session *session,
+gboolean obc_session_send(struct obc_session *session, const char *filename,
+				const char *name, GError **err);
+gboolean obc_session_get(struct obc_session *session, const char *type,
+				const char *name, const char *targetfile,
+				const guint8  *apparam, gint apparam_size,
+				session_callback_t func, void *user_data,
+				GError **err);
+gboolean obc_session_pull(struct obc_session *session,
 				const char *type, const char *targetfile,
-				session_callback_t function, void *user_data);
+				session_callback_t function, void *user_data,
+				GError **err);
 const char *obc_session_register(struct obc_session *session,
 						GDBusDestroyFunction destroy);
-int obc_session_put(struct obc_session *session, const char *contents,
-					size_t size, const char *name);
+gboolean obc_session_put(struct obc_session *session, const char *contents,
+				size_t size, const char *name, GError **err);
 
 guint obc_session_setpath(struct obc_session *session, const char *path,
 				session_callback_t func, void *user_data,
diff --git a/client/sync.c b/client/sync.c
index 0dffab7..9a26f5b 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -125,6 +125,7 @@ static DBusMessage *sync_getphonebook(DBusConnection *connection,
 			DBusMessage *message, void *user_data)
 {
 	struct sync_data *sync = user_data;
+	GError *err = NULL;
 
 	if (sync->msg)
 		return g_dbus_create_error(message,
@@ -134,10 +135,17 @@ static DBusMessage *sync_getphonebook(DBusConnection *connection,
 	if (!sync->phonebook_path)
 		sync->phonebook_path = g_strdup("telecom/pb.vcf");
 
-	if (obc_session_get(sync->session, "phonebook", sync->phonebook_path, NULL,
-				NULL, 0, sync_getphonebook_callback, sync) < 0)
-		return g_dbus_create_error(message,
-			ERROR_INF ".Failed", "Failed");
+	obc_session_get(sync->session, "phonebook", sync->phonebook_path,
+					NULL, NULL, 0,
+					sync_getphonebook_callback, sync,
+					&err);
+	if (err != 0) {
+		DBusMessage *reply = g_dbus_create_error(message,
+						ERROR_INF ".Failed",
+						err->message);
+		g_error_free(err);
+		return reply;
+	}
 
 	sync->msg = dbus_message_ref(message);
 
@@ -149,6 +157,7 @@ static DBusMessage *sync_putphonebook(DBusConnection *connection,
 {
 	struct sync_data *sync = user_data;
 	const char *buf;
+	GError *err = NULL;
 
 	if (dbus_message_get_args(message, NULL,
 			DBUS_TYPE_STRING, &buf,
@@ -160,10 +169,15 @@ static DBusMessage *sync_putphonebook(DBusConnection *connection,
 	if (!sync->phonebook_path)
 		sync->phonebook_path = g_strdup("telecom/pb.vcf");
 
-	if (obc_session_put(sync->session, buf, strlen(buf),
-						sync->phonebook_path) < 0)
-		return g_dbus_create_error(message,
-				ERROR_INF ".Failed", "Failed");
+	obc_session_put(sync->session, buf, strlen(buf), sync->phonebook_path,
+									&err);
+	if (err != NULL) {
+		DBusMessage *reply = g_dbus_create_error(message,
+						ERROR_INF ".Failed",
+						err->message);
+		g_error_free(err);
+		return reply;
+	}
 
 	return dbus_message_new_method_return(message);
 }
diff --git a/client/transfer.c b/client/transfer.c
index 230f3ae..db7ba61 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -229,7 +229,8 @@ static struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 						const char *filename,
 						const char *name,
 						const char *type,
-						struct obc_transfer_params *params)
+						struct obc_transfer_params *params,
+						GError **err)
 {
 	struct obc_transfer *transfer;
 
@@ -251,14 +252,20 @@ static struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 			TRANSFER_BASEPATH, counter++);
 
 	transfer->conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
-	if (transfer->conn == NULL)
+	if (transfer->conn == NULL) {
+		g_set_error(err, OBC_TRANSFER_ERROR, -EFAULT,
+						"Unable to connect to D-Bus");
 		goto fail;
+	}
 
 	if (g_dbus_register_interface(transfer->conn, transfer->path,
 				TRANSFER_INTERFACE,
 				obc_transfer_methods, NULL, NULL,
-				transfer, NULL) == FALSE)
+				transfer, NULL) == FALSE) {
+		g_set_error(err, OBC_TRANSFER_ERROR, -EFAULT,
+						"Unable to register to D-Bus");
 		goto fail;
+	}
 
 done:
 	DBG("%p registered %s", transfer, transfer->path);
@@ -271,32 +278,33 @@ fail:
 	return NULL;
 }
 
-static int transfer_open(struct obc_transfer *transfer, int flags, mode_t mode)
+static gboolean transfer_open(struct obc_transfer *transfer, int flags,
+						mode_t mode, GError **err)
 {
-	GError *err = NULL;
 	int fd;
 
 	if (transfer->filename != NULL) {
 		fd = open(transfer->filename, flags, mode);
 		if (fd < 0) {
 			error("open(): %s(%d)", strerror(errno), errno);
-			return -errno;
+			g_set_error(err, OBC_TRANSFER_ERROR, -errno,
+							"Unable to open file");
+			return FALSE;
 		}
 		goto done;
 	}
 
-	fd = g_file_open_tmp("obex-clientXXXXXX", &transfer->filename, &err);
+	fd = g_file_open_tmp("obex-clientXXXXXX", &transfer->filename, err);
 	if (fd < 0) {
-		error("g_file_open_tmp(): %s", err->message);
-		g_error_free(err);
-		return -EFAULT;
+		error("g_file_open_tmp(): %s", (*err)->message);
+		return FALSE;
 	}
 
 	remove(transfer->filename);
 
 done:
 	transfer->fd = fd;
-	return fd;
+	return TRUE;
 }
 
 struct obc_transfer *obc_transfer_get(DBusConnection *conn,
@@ -304,16 +312,19 @@ struct obc_transfer *obc_transfer_get(DBusConnection *conn,
 					const char *filename,
 					const char *name,
 					const char *type,
-					struct obc_transfer_params *params)
+					struct obc_transfer_params *params,
+					GError **err)
 {
 	struct obc_transfer *transfer;
+	int perr;
 
 	transfer = obc_transfer_register(conn, agent, G_OBEX_OP_GET, filename,
-							name, type, params);
+						name, type, params, err);
 	if (transfer == NULL)
 		return NULL;
 
-	if (transfer_open(transfer, O_WRONLY | O_CREAT | O_TRUNC, 0600) < 0) {
+	perr = transfer_open(transfer, O_WRONLY | O_CREAT | O_TRUNC, 0600, err);
+	if (perr < 0) {
 		obc_transfer_free(transfer);
 		return NULL;
 	}
@@ -328,22 +339,22 @@ struct obc_transfer *obc_transfer_put(DBusConnection *conn,
 					const char *type,
 					const char *contents,
 					size_t size,
-					struct obc_transfer_params *params)
+					struct obc_transfer_params *params,
+					GError **err)
 {
 	struct obc_transfer *transfer;
 	struct stat st;
 	int perr;
 
 	transfer = obc_transfer_register(conn, agent, G_OBEX_OP_PUT, filename,
-							name, type, params);
+						name, type, params, err);
 	if (transfer == NULL)
 		return NULL;
 
 	if (contents != NULL) {
 		ssize_t w;
 
-		perr = transfer_open(transfer, O_RDWR, 0);
-		if (perr < 0)
+		if (!transfer_open(transfer, O_RDWR, 0, err))
 			goto fail;
 
 		w = write(transfer->fd, contents, size);
@@ -357,15 +368,15 @@ struct obc_transfer *obc_transfer_put(DBusConnection *conn,
 			goto fail;
 		}
 	} else {
-		perr = transfer_open(transfer, O_RDONLY, 0);
-		if (perr < 0)
+		if (!transfer_open(transfer, O_RDONLY, 0, err))
 			goto fail;
 	}
 
 	perr = fstat(transfer->fd, &st);
 	if (perr < 0) {
 		error("fstat(): %s(%d)", strerror(errno), errno);
-		perr = -errno;
+		g_set_error(err, OBC_TRANSFER_ERROR, -errno,
+						"Unable to get file status");
 		goto fail;
 	}
 
diff --git a/client/transfer.h b/client/transfer.h
index a84e415..3f5e22d 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -37,7 +37,8 @@ struct obc_transfer *obc_transfer_get(DBusConnection *conn,
 					const char *filename,
 					const char *name,
 					const char *type,
-					struct obc_transfer_params *params);
+					struct obc_transfer_params *params,
+					GError **err);
 struct obc_transfer *obc_transfer_put(DBusConnection *conn,
 					const char *agent,
 					const char *filename,
@@ -45,7 +46,8 @@ struct obc_transfer *obc_transfer_put(DBusConnection *conn,
 					const char *type,
 					const char *contents,
 					size_t size,
-					struct obc_transfer_params *params);
+					struct obc_transfer_params *params,
+					GError **err);
 
 void obc_transfer_unregister(struct obc_transfer *transfer);
 
-- 
1.7.7.6

