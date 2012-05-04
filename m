Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 6/6] client: Create transfers in modules
Date: Fri,  4 May 2012 14:39:38 +0200
Message-Id: <1336135178-21707-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1336135178-21707-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1336135178-21707-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

After this patch the modules are responsible for creating the transfers,
and these objects must be queued using the session API.

This way the transfer initiator has full access to the transfer object,
in case for example it wants to access some member variable.

For convenience reasons, the function obc_session_queue() is designed
such that the preceding transfer creation might have failed. This means
that the given transfer might be NULL and the error object could already
be set. In this case the function will just return 0.
---
 client/ftp.c     |   25 ++++++++++----
 client/manager.c |   24 ++++++++++----
 client/map.c     |   18 ++++++----
 client/pbap.c    |   30 ++++++++++-------
 client/session.c |   94 +++++++++++------------------------------------------
 client/session.h |   17 ++-------
 client/sync.c    |   20 +++++++----
 7 files changed, 98 insertions(+), 130 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index 86c2a3c..15c56f5 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -258,11 +258,14 @@ static DBusMessage *list_folder(DBusConnection *connection,
 {
 	struct ftp_data *ftp = user_data;
 	struct obc_session *session = ftp->session;
+	struct obc_transfer *transfer;
 	GError *err = NULL;
 
-	obc_session_get(session, "x-obex/folder-listing", NULL, NULL,
-				NULL, 0, list_folder_callback, message, &err);
-	if (err != NULL) {
+	transfer = obc_transfer_get("x-obex/folder-listing", NULL, NULL,
+				NULL, 0,  &err);
+
+	if (!obc_session_queue(session, transfer, list_folder_callback,
+							message, &err)) {
 		DBusMessage *reply = g_dbus_create_error(message,
 						"org.openobex.Error.Failed",
 						"%s", err->message);
@@ -280,6 +283,7 @@ static DBusMessage *get_file(DBusConnection *connection,
 {
 	struct ftp_data *ftp = user_data;
 	struct obc_session *session = ftp->session;
+	struct obc_transfer *transfer;
 	const char *target_file, *source_file;
 	GError *err = NULL;
 
@@ -290,9 +294,11 @@ static DBusMessage *get_file(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
 
-	obc_session_get(session, NULL, source_file, target_file, NULL, 0,
-					get_file_callback, message, &err);
-	if (err != NULL) {
+	transfer = obc_transfer_get(NULL, source_file, target_file, NULL, 0,
+									&err);
+
+	if (!obc_session_queue(session, transfer, get_file_callback, message,
+								&err)) {
 		DBusMessage *reply = g_dbus_create_error(message,
 						"org.openobex.Error.Failed",
 						"%s", err->message);
@@ -310,6 +316,7 @@ static DBusMessage *put_file(DBusConnection *connection,
 {
 	struct ftp_data *ftp = user_data;
 	struct obc_session *session = ftp->session;
+	struct obc_transfer *transfer;
 	gchar *sourcefile, *targetfile;
 	GError *err = NULL;
 
@@ -321,8 +328,10 @@ static DBusMessage *put_file(DBusConnection *connection,
 				"org.openobex.Error.InvalidArguments",
 				"Invalid arguments in method call");
 
-	obc_session_send(session, sourcefile, targetfile, &err);
-	if (err != NULL) {
+	transfer = obc_transfer_put(NULL, targetfile, sourcefile, NULL, 0,
+								NULL, 0, &err);
+
+	if (!obc_session_queue(session, transfer, NULL, NULL, &err)) {
 		DBusMessage *reply = g_dbus_create_error(message,
 						"org.openobex.Error.Failed",
 						"%s", err->message);
diff --git a/client/manager.c b/client/manager.c
index a46519f..93ba1d7 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -113,8 +113,12 @@ static void create_callback(struct obc_session *session,
 	for (i = 0; i < data->files->len; i++) {
 		const gchar *filename = g_ptr_array_index(data->files, i);
 		gchar *basename = g_path_get_basename(filename);
+		struct obc_transfer *transfer;
 
-		if (obc_session_send(session, filename, basename, NULL) == 0) {
+		transfer = obc_transfer_put(NULL, basename, filename, NULL, 0,
+								NULL, 0, NULL);
+
+		if (!obc_session_queue(session, transfer, NULL, NULL, NULL)) {
 			g_free(basename);
 			break;
 		}
@@ -278,6 +282,7 @@ static void pull_obc_session_callback(struct obc_session *session,
 						GError *err, void *user_data)
 {
 	struct send_data *data = user_data;
+	struct obc_transfer *pull;
 	DBusMessage *reply;
 	GError *gerr = NULL;
 
@@ -288,9 +293,11 @@ static void pull_obc_session_callback(struct obc_session *session,
 		goto fail;
 	}
 
-	obc_session_pull(session, "text/x-vcard", data->filename,
-					pull_complete_callback, data, &gerr);
-	if (gerr != NULL) {
+	pull = obc_transfer_get("text/x-vcard", NULL, data->filename, NULL, 0,
+									&gerr);
+
+	if (!obc_session_queue(session, pull, pull_complete_callback, data,
+								&gerr)) {
 		reply = g_dbus_create_error(data->message,
 						"org.openobex.Error.Failed",
 						"%s", gerr->message);
@@ -497,6 +504,7 @@ static void capability_obc_session_callback(struct obc_session *session,
 						GError *err, void *user_data)
 {
 	struct send_data *data = user_data;
+	struct obc_transfer *pull;
 	DBusMessage *reply;
 	GError *gerr = NULL;
 
@@ -507,9 +515,11 @@ static void capability_obc_session_callback(struct obc_session *session,
 		goto fail;
 	}
 
-	obc_session_pull(session, "x-obex/capability", NULL,
-				capabilities_complete_callback, data, &gerr);
-	if (gerr != NULL) {
+	pull = obc_transfer_get("x-obex/capability", NULL, data->filename,
+								NULL, 0, &gerr);
+
+	if (!obc_session_queue(session, pull, capabilities_complete_callback,
+								data, &gerr)) {
 		reply = g_dbus_create_error(data->message,
 					"org.openobex.Error.Failed",
 					"%s", gerr->message);
diff --git a/client/map.c b/client/map.c
index eb06834..3bb01a6 100644
--- a/client/map.c
+++ b/client/map.c
@@ -135,12 +135,13 @@ static DBusMessage *map_get_folder_listing(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	struct map_data *map = user_data;
+	struct obc_transfer *transfer;
 	GError *err = NULL;
 
-	obc_session_get(map->session, "x-obex/folder-listing", NULL,
-							NULL, NULL, 0,
-							buffer_cb, map, &err);
-	if (err != NULL) {
+	transfer = obc_transfer_get("x-obex/folder-listing", NULL, NULL,
+								NULL, 0, &err);
+
+	if (!obc_session_queue(map->session, transfer, buffer_cb, map, &err)) {
 		DBusMessage *reply = g_dbus_create_error(message,
 						"org.openobex.Error.Failed",
 						"%s", err->message);
@@ -157,6 +158,7 @@ static DBusMessage *map_get_message_listing(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	struct map_data *map = user_data;
+	struct obc_transfer *transfer;
 	const char *folder;
 	DBusMessageIter msg_iter;
 	GError *err = NULL;
@@ -169,10 +171,10 @@ static DBusMessage *map_get_message_listing(DBusConnection *connection,
 
 	dbus_message_iter_get_basic(&msg_iter, &folder);
 
-	obc_session_get(map->session, "x-bt/MAP-msg-listing", folder,
-							NULL, NULL, 0,
-							buffer_cb, map, &err);
-	if (err != NULL) {
+	transfer = obc_transfer_get("x-bt/MAP-msg-listing", folder, NULL,
+								NULL, 0, &err);
+
+	if (!obc_session_queue(map->session, transfer, buffer_cb, map, &err)) {
 		DBusMessage *reply = g_dbus_create_error(message,
 						"org.openobex.Error.Failed",
 						"%s", err->message);
diff --git a/client/pbap.c b/client/pbap.c
index b178aff..33c6371 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -462,6 +462,7 @@ static DBusMessage *pull_phonebook(struct pbap_data *pbap,
 {
 	struct pending_request *request;
 	struct pullphonebook_apparam apparam;
+	struct obc_transfer *transfer;
 	session_callback_t func;
 	GError *err = NULL;
 
@@ -492,10 +493,10 @@ static DBusMessage *pull_phonebook(struct pbap_data *pbap,
 
 	request = pending_request_new(pbap, message);
 
-	obc_session_get(pbap->session, "x-bt/phonebook", name, NULL,
-				(guint8 *) &apparam, sizeof(apparam),
-				func, request, &err);
-	if (err != NULL) {
+	transfer = obc_transfer_get("x-bt/phonebook", name, NULL, &apparam,
+							sizeof(apparam), &err);
+
+	if (!obc_session_queue(pbap->session, transfer, func, request, &err)) {
 		DBusMessage *reply = g_dbus_create_error(message,
 						"org.openobex.Error.Failed",
 						"%s", err->message);
@@ -525,6 +526,7 @@ static DBusMessage *pull_vcard_listing(struct pbap_data *pbap,
 					guint16 count, guint16 offset)
 {
 	struct pending_request *request;
+	struct obc_transfer *transfer;
 	guint8 *p, *apparam = NULL;
 	gint apparam_size;
 	GError *err = NULL;
@@ -557,11 +559,13 @@ static DBusMessage *pull_vcard_listing(struct pbap_data *pbap,
 
 	request = pending_request_new(pbap, message);
 
-	obc_session_get(pbap->session, "x-bt/vcard-listing", name, NULL,
-				apparam, apparam_size,
-				pull_vcard_listing_callback, request, &err);
+	transfer = obc_transfer_get("x-bt/vcard-listing", name, NULL,
+						apparam, apparam_size, &err);
+
 	g_free(apparam);
-	if (err != NULL) {
+
+	if (!obc_session_queue(pbap->session, transfer,
+				pull_vcard_listing_callback, request, &err)) {
 		DBusMessage *reply = g_dbus_create_error(message,
 						"org.openobex.Error.Failed",
 						"%s", err->message);
@@ -760,6 +764,7 @@ static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
 	struct pullvcardentry_apparam apparam;
 	const char *name;
 	struct pending_request *request;
+	struct obc_transfer *transfer;
 	GError *err = NULL;
 
 	if (!pbap->path)
@@ -782,10 +787,11 @@ static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
 
 	request = pending_request_new(pbap, message);
 
-	obc_session_get(pbap->session, "x-bt/vcard", name, NULL,
-				(guint8 *)&apparam, sizeof(apparam),
-				pull_phonebook_callback, request, &err);
-	if (err != NULL) {
+	transfer = obc_transfer_get("x-bt/vcard", name, NULL,
+					&apparam, sizeof(apparam), &err);
+
+	if (!obc_session_queue(pbap->session, transfer, pull_phonebook_callback,
+							request, &err)) {
 		DBusMessage *reply = g_dbus_create_error(message,
 						"org.openobex.Error.Failed",
 						"%s", err->message);
diff --git a/client/session.c b/client/session.c
index f8f8da4..f38f032 100644
--- a/client/session.c
+++ b/client/session.c
@@ -745,15 +745,30 @@ static int pending_request_auth(struct pending_request *p)
 									NULL);
 }
 
-static guint session_request(struct obc_session *session,
-					struct obc_transfer *transfer,
-					session_callback_t func,
-					void *data, GError **err)
+guint obc_session_queue(struct obc_session *session,
+				struct obc_transfer *transfer,
+				session_callback_t func, void *user_data,
+				GError **err)
 {
 	struct pending_request *p;
 	const char *agent;
 	int perr;
 
+	if (transfer == NULL) {
+		if (err != NULL && *err == NULL)
+			g_set_error(err, OBEX_IO_ERROR, -EINVAL,
+						"Invalid arguments");
+
+		return 0;
+	}
+
+	if (session->obex == NULL) {
+		obc_transfer_unregister(transfer);
+		g_set_error(err, OBEX_IO_ERROR, -ENOTCONN,
+						"Session not connected");
+		return 0;
+	}
+
 	if (session->agent)
 		agent = obc_agent_get_name(session->agent);
 	else
@@ -767,7 +782,7 @@ static guint session_request(struct obc_session *session,
 	obc_transfer_set_callback(transfer, transfer_progress, session);
 
 	p = pending_request_new(session, transfer, session_start_transfer,
-								func, data);
+							func, user_data);
 	if (session->p) {
 		g_queue_push_tail(session->queue, p);
 		return p->id;
@@ -956,56 +971,6 @@ static void session_start_transfer(gpointer data, gpointer user_data)
 	DBG("Transfer(%p) started", transfer);
 }
 
-guint obc_session_get(struct obc_session *session, const char *type,
-				const char *name, const char *targetfile,
-				const guint8 *apparam, gint apparam_size,
-				session_callback_t func, void *user_data,
-				GError **err)
-{
-	struct obc_transfer *transfer;
-
-	if (session->obex == NULL) {
-		g_set_error(err, OBEX_IO_ERROR, -ENOTCONN,
-						"Session not connected");
-		return 0;
-	}
-
-	transfer = obc_transfer_get(type, name, targetfile, apparam,
-							apparam_size, err);
-	if (transfer == NULL)
-		return 0;
-
-	return session_request(session, transfer, func, user_data, err);
-}
-
-guint obc_session_send(struct obc_session *session, const char *filename,
-				const char *name, GError **err)
-{
-	struct obc_transfer *transfer;
-
-	if (session->obex == NULL) {
-		g_set_error(err, OBEX_IO_ERROR, -ENOTCONN,
-						"Session not connected");
-		return 0;
-	}
-
-	transfer = obc_transfer_put(NULL, name, filename, NULL, 0, NULL, 0,
-									err);
-	if (transfer == NULL)
-		return 0;
-
-	return session_request(session, transfer, NULL, NULL, err);
-}
-
-guint obc_session_pull(struct obc_session *session,
-				const char *type, const char *targetfile,
-				session_callback_t function, void *user_data,
-				GError **err)
-{
-	return obc_session_get(session, type, NULL, targetfile, NULL, 0,
-						function, user_data, err);
-}
-
 const char *obc_session_register(struct obc_session *session,
 						GDBusDestroyFunction destroy)
 {
@@ -1036,25 +1001,6 @@ fail:
 	return NULL;
 }
 
-guint obc_session_put(struct obc_session *session, const char *contents,
-				size_t size, const char *name, GError **err)
-{
-	struct obc_transfer *transfer;
-
-	if (session->obex == NULL) {
-		g_set_error(err, OBEX_IO_ERROR, -ENOTCONN,
-						"Session not connected");
-		return 0;
-	}
-
-	transfer = obc_transfer_put(NULL, name, NULL, contents, size, NULL, 0,
-									err);
-	if (transfer == NULL)
-		return 0;
-
-	return session_request(session, transfer, NULL, NULL, err);
-}
-
 static void agent_destroy(gpointer data, gpointer user_data)
 {
 	struct obc_session *session = user_data;
diff --git a/client/session.h b/client/session.h
index 06aaa1b..2cac032 100644
--- a/client/session.h
+++ b/client/session.h
@@ -54,22 +54,13 @@ const char *obc_session_get_agent(struct obc_session *session);
 const char *obc_session_get_path(struct obc_session *session);
 const char *obc_session_get_target(struct obc_session *session);
 
-guint obc_session_send(struct obc_session *session, const char *filename,
-				const char *name, GError **err);
-guint obc_session_get(struct obc_session *session, const char *type,
-				const char *name, const char *targetfile,
-				const guint8  *apparam, gint apparam_size,
-				session_callback_t func, void *user_data,
-				GError **err);
-guint obc_session_pull(struct obc_session *session,
-				const char *type, const char *targetfile,
-				session_callback_t function, void *user_data,
-				GError **err);
 const char *obc_session_register(struct obc_session *session,
 						GDBusDestroyFunction destroy);
-guint obc_session_put(struct obc_session *session, const char *contents,
-				size_t size, const char *name, GError **err);
 
+guint obc_session_queue(struct obc_session *session,
+				struct obc_transfer *transfer,
+				session_callback_t func, void *user_data,
+				GError **err);
 guint obc_session_setpath(struct obc_session *session, const char *path,
 				session_callback_t func, void *user_data,
 				GError **err);
diff --git a/client/sync.c b/client/sync.c
index c0b3800..278c405 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -127,6 +127,7 @@ static DBusMessage *sync_getphonebook(DBusConnection *connection,
 			DBusMessage *message, void *user_data)
 {
 	struct sync_data *sync = user_data;
+	struct obc_transfer *transfer;
 	GError *err = NULL;
 
 	if (sync->msg)
@@ -137,11 +138,12 @@ static DBusMessage *sync_getphonebook(DBusConnection *connection,
 	if (!sync->phonebook_path)
 		sync->phonebook_path = g_strdup("telecom/pb.vcf");
 
-	obc_session_get(sync->session, "phonebook", sync->phonebook_path,
-					NULL, NULL, 0,
-					sync_getphonebook_callback, sync,
-					&err);
-	if (err != 0) {
+	transfer = obc_transfer_get("phonebook", sync->phonebook_path,
+							NULL, NULL, 0, &err);
+
+	if (!obc_session_queue(sync->session, transfer,
+						sync_getphonebook_callback,
+						sync, &err)) {
 		DBusMessage *reply = g_dbus_create_error(message,
 						ERROR_INF ".Failed",
 						err->message);
@@ -158,6 +160,7 @@ static DBusMessage *sync_putphonebook(DBusConnection *connection,
 			DBusMessage *message, void *user_data)
 {
 	struct sync_data *sync = user_data;
+	struct obc_transfer *transfer;
 	const char *buf;
 	GError *err = NULL;
 
@@ -171,9 +174,10 @@ static DBusMessage *sync_putphonebook(DBusConnection *connection,
 	if (!sync->phonebook_path)
 		sync->phonebook_path = g_strdup("telecom/pb.vcf");
 
-	obc_session_put(sync->session, buf, strlen(buf), sync->phonebook_path,
-									&err);
-	if (err != NULL) {
+	transfer = obc_transfer_put(NULL, sync->phonebook_path, NULL, buf,
+						strlen(buf), NULL, 0, &err);
+
+	if (!obc_session_queue(sync->session, transfer, NULL, NULL, &err)) {
 		DBusMessage *reply = g_dbus_create_error(message,
 						ERROR_INF ".Failed",
 						err->message);
-- 
1.7.7.6

