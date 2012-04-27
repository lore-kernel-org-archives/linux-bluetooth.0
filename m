Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH obexd v0 2/6] client: Give transfer pointer in session callbacks
Date: Fri, 27 Apr 2012 12:33:36 +0200
Message-Id: <1335522820-11826-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1335522820-11826-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1335522820-11826-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Operations involving a transfer object in session.h should use a
callback that provides access to the transfer object.

Note that the ownership of this object is not changed in any way,
meaning that the session is still responsible for it. However this
pointer can be useful during the execution of the callback, in order to
access data members of the transfer.
---
 client/ftp.c     |    6 ++++--
 client/manager.c |    2 ++
 client/map.c     |    5 +++--
 client/pbap.c    |    5 ++++-
 client/session.c |   48 +++++++++++++++++++++++++++++-------------------
 client/session.h |   12 ++++++++----
 client/sync.c    |    1 +
 7 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index 0e6af47..baeeb2d 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -172,8 +172,9 @@ static const GMarkupParser parser = {
 	NULL
 };
 
-static void get_file_callback(struct obc_session *session, GError *err,
-							void *user_data)
+static void get_file_callback(struct obc_session *session,
+					struct obc_transfer *transfer,
+					GError *err, void *user_data)
 {
 	DBusMessage *msg = user_data;
 	DBusMessage *reply;
@@ -190,6 +191,7 @@ static void get_file_callback(struct obc_session *session, GError *err,
 }
 
 static void list_folder_callback(struct obc_session *session,
+					struct obc_transfer *transfer,
 					GError *err, void *user_data)
 {
 	DBusMessage *msg = user_data;
diff --git a/client/manager.c b/client/manager.c
index 6d08702..2eb944e 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -247,6 +247,7 @@ static DBusMessage *send_files(DBusConnection *connection,
 }
 
 static void pull_complete_callback(struct obc_session *session,
+					struct obc_transfer *transfer,
 					GError *err, void *user_data)
 {
 	struct send_data *data = user_data;
@@ -448,6 +449,7 @@ static DBusMessage *remove_session(DBusConnection *connection,
 }
 
 static void capabilities_complete_callback(struct obc_session *session,
+						struct obc_transfer *transfer,
 						GError *err, void *user_data)
 {
 	struct send_data *data = user_data;
diff --git a/client/map.c b/client/map.c
index 1b4e404..05ba6aa 100644
--- a/client/map.c
+++ b/client/map.c
@@ -94,8 +94,9 @@ static DBusMessage *map_setpath(DBusConnection *connection,
 	return NULL;
 }
 
-static void buffer_cb(struct obc_session *session, GError *err,
-							void *user_data)
+static void buffer_cb(struct obc_session *session,
+					struct obc_transfer *transfer,
+					GError *err, void *user_data)
 {
 	struct map_data *map = user_data;
 	DBusMessage *reply;
diff --git a/client/pbap.c b/client/pbap.c
index d96b651..0912ac0 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -339,6 +339,7 @@ static void read_return_apparam(struct obc_session *session,
 }
 
 static void pull_phonebook_callback(struct obc_session *session,
+					struct obc_transfer *transfer,
 					GError *err, void *user_data)
 {
 	struct pending_request *request = user_data;
@@ -377,6 +378,7 @@ send:
 }
 
 static void phonebook_size_callback(struct obc_session *session,
+					struct obc_transfer *transfer,
 					GError *err, void *user_data)
 {
 	struct pending_request *request = user_data;
@@ -405,6 +407,7 @@ send:
 }
 
 static void pull_vcard_listing_callback(struct obc_session *session,
+					struct obc_transfer *transfer,
 					GError *err, void *user_data)
 {
 	struct pending_request *request = user_data;
@@ -457,7 +460,7 @@ static DBusMessage *pull_phonebook(struct pbap_data *pbap,
 {
 	struct pending_request *request;
 	struct pullphonebook_apparam apparam;
-	session_callback_t func;
+	session_transfer_callback_t func;
 	GError *err = NULL;
 
 	apparam.filter_tag = FILTER_TAG;
diff --git a/client/session.c b/client/session.c
index 824ef49..50947d3 100644
--- a/client/session.c
+++ b/client/session.c
@@ -69,7 +69,7 @@ struct pending_request {
 	struct obc_session *session;
 	struct obc_transfer *transfer;
 	GFunc auth_complete;
-	session_callback_t func;
+	void *func; /* session_callback_t or session_transfer_callback_t */
 	void *data;
 };
 
@@ -142,7 +142,7 @@ static void session_unregistered(struct obc_session *session)
 static struct pending_request *pending_request_new(struct obc_session *session,
 						struct obc_transfer *transfer,
 						GFunc auth_complete,
-						session_callback_t func,
+						void *func,
 						void *data)
 {
 	struct pending_request *p;
@@ -497,16 +497,21 @@ void obc_session_shutdown(struct obc_session *session)
 						"Session closed by user");
 
 	if (session->p != NULL && session->p->id != 0) {
-		if (session->p->func)
-			session->p->func(session, err, session->p->data);
+		session_transfer_callback_t callback = session->p->func;
+
+		if (callback)
+			callback(session, session->p->transfer, err,
+							session->p->data);
 
 		pending_request_free(session->p);
 		session->p = NULL;
 	}
 
 	while ((p = g_queue_pop_head(session->queue))) {
-		if (p->func)
-			p->func(session, err, p->data);
+		session_transfer_callback_t callback = p->func;
+
+		if (callback)
+			callback(session, p->transfer, err, p->data);
 
 		pending_request_free(p);
 	}
@@ -745,7 +750,7 @@ static int pending_request_auth(struct pending_request *p)
 
 static guint session_request(struct obc_session *session,
 					struct obc_transfer *transfer,
-					session_callback_t func,
+					session_transfer_callback_t func,
 					void *data, GError **err)
 {
 	struct pending_request *p;
@@ -785,6 +790,7 @@ static void session_process_queue(struct obc_session *session)
 	obc_session_ref(session);
 
 	while ((p = g_queue_pop_head(session->queue))) {
+		session_transfer_callback_t callback;
 		int err;
 
 		err = pending_request_auth(p);
@@ -793,12 +799,13 @@ static void session_process_queue(struct obc_session *session)
 			break;
 		}
 
-		if (p->func) {
+		callback = p->func;
+		if (callback) {
 			GError *gerr = NULL;
 
 			g_set_error(&gerr, OBEX_IO_ERROR, err,
 							"Authorization failed");
-			p->func(session, gerr, p->data);
+			callback(session, p->transfer, gerr, p->data);
 			g_error_free(gerr);
 		}
 
@@ -824,6 +831,7 @@ static void session_terminate_transfer(struct obc_session *session,
 					GError *gerr)
 {
 	struct pending_request *p = session->p;
+	session_transfer_callback_t callback;
 
 	if (p == NULL || p->transfer != transfer) {
 		GList *match;
@@ -841,8 +849,9 @@ static void session_terminate_transfer(struct obc_session *session,
 
 	obc_session_ref(session);
 
-	if (p->func)
-		p->func(session, gerr, p->data);
+	callback = p->func;
+	if (callback)
+		callback(session, p->transfer, gerr, p->data);
 
 	pending_request_free(p);
 
@@ -949,8 +958,8 @@ static void session_start_transfer(gpointer data, gpointer user_data)
 guint obc_session_get(struct obc_session *session, const char *type,
 				const char *name, const char *targetfile,
 				const guint8 *apparam, gint apparam_size,
-				session_callback_t func, void *user_data,
-				GError **err)
+				session_transfer_callback_t func,
+				void *user_data, GError **err)
 {
 	struct obc_transfer *transfer;
 	struct obc_transfer_params *params = NULL;
@@ -1011,8 +1020,8 @@ guint obc_session_send(struct obc_session *session, const char *filename,
 
 guint obc_session_pull(struct obc_session *session,
 				const char *type, const char *targetfile,
-				session_callback_t function, void *user_data,
-				GError **err)
+				session_transfer_callback_t function,
+				void *user_data, GError **err)
 {
 	return obc_session_get(session, type, NULL, targetfile, NULL, 0,
 						function, user_data, err);
@@ -1284,14 +1293,15 @@ static void async_cb(GObex *obex, GError *err, GObexPacket *rsp,
 {
 	struct pending_request *p = user_data;
 	struct obc_session *session = p->session;
+	session_callback_t callback = p->func;
 	GError *gerr = NULL;
 	uint8_t code;
 
 	p->req_id = 0;
 
 	if (err != NULL) {
-		if (p->func)
-			p->func(p->session, err, p->data);
+		if (callback)
+			callback(p->session, err, p->data);
 		goto done;
 	}
 
@@ -1300,8 +1310,8 @@ static void async_cb(GObex *obex, GError *err, GObexPacket *rsp,
 		g_set_error(&gerr, OBEX_IO_ERROR, code, "%s",
 							g_obex_strerror(code));
 
-	if (p->func)
-		p->func(p->session, gerr, p->data);
+	if (callback)
+		callback(p->session, gerr, p->data);
 
 	if (gerr != NULL)
 		g_clear_error(&gerr);
diff --git a/client/session.h b/client/session.h
index b44cf3f..d97abc3 100644
--- a/client/session.h
+++ b/client/session.h
@@ -26,9 +26,13 @@
 #include <gdbus.h>
 
 struct obc_session;
+struct obc_transfer;
 
 typedef void (*session_callback_t) (struct obc_session *session,
 					GError *err, void *user_data);
+typedef void (*session_transfer_callback_t) (struct obc_session *session,
+						struct obc_transfer *transfer,
+						GError *err, void *user_data);
 
 struct obc_session *obc_session_create(const char *source,
 						const char *destination,
@@ -61,12 +65,12 @@ guint obc_session_send(struct obc_session *session, const char *filename,
 guint obc_session_get(struct obc_session *session, const char *type,
 				const char *name, const char *targetfile,
 				const guint8  *apparam, gint apparam_size,
-				session_callback_t func, void *user_data,
-				GError **err);
+				session_transfer_callback_t func,
+				void *user_data, GError **err);
 guint obc_session_pull(struct obc_session *session,
 				const char *type, const char *targetfile,
-				session_callback_t function, void *user_data,
-				GError **err);
+				session_transfer_callback_t function,
+				void *user_data, GError **err);
 const char *obc_session_register(struct obc_session *session,
 						GDBusDestroyFunction destroy);
 guint obc_session_put(struct obc_session *session, const char *contents,
diff --git a/client/sync.c b/client/sync.c
index 9a26f5b..e3a78d5 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -84,6 +84,7 @@ static DBusMessage *sync_setlocation(DBusConnection *connection,
 }
 
 static void sync_getphonebook_callback(struct obc_session *session,
+					struct obc_transfer *transfer,
 					GError *err, void *user_data)
 {
 	struct sync_data *sync = user_data;
-- 
1.7.7.6

