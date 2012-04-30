Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH obexd v1 3/6] client: Give transfer pointer in session callbacks
Date: Mon, 30 Apr 2012 17:26:24 +0200
Message-Id: <1335799587-10370-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1335799587-10370-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1335799587-10370-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Operations involving a transfer object will receive a pointer to such
transfer in the callback.

Note that the ownership of this object is not changed in any way,
meaning that the session is still responsible for it. However this
pointer can be useful during the execution of the callback, in order to
access data members of the transfer.
---
 client/driver.c  |    2 ++
 client/ftp.c     |   13 ++++++++-----
 client/manager.c |   12 +++++++++---
 client/map.c     |   11 +++++++----
 client/opp.c     |    3 +++
 client/pbap.c    |   15 ++++++++++-----
 client/session.c |   34 ++++++++++++++++++----------------
 client/session.h |    1 +
 client/sync.c    |    2 ++
 9 files changed, 60 insertions(+), 33 deletions(-)

diff --git a/client/driver.c b/client/driver.c
index f9e8fbc..fe61219 100644
--- a/client/driver.c
+++ b/client/driver.c
@@ -28,7 +28,9 @@
 #include <string.h>
 #include <errno.h>
 #include <glib.h>
+#include <gdbus.h>
 
+#include "transfer.h"
 #include "session.h"
 #include "driver.h"
 #include "log.h"
diff --git a/client/ftp.c b/client/ftp.c
index 0e6af47..0cb3adc 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -32,6 +32,7 @@
 
 #include "log.h"
 
+#include "transfer.h"
 #include "session.h"
 #include "driver.h"
 #include "ftp.h"
@@ -50,8 +51,8 @@ struct ftp_data {
 	struct obc_session *session;
 };
 
-static void async_cb(struct obc_session *session, GError *err,
-							gpointer user_data)
+static void async_cb(struct obc_session *session, struct obc_transfer *transfer,
+						GError *err, void *user_data)
 {
 	DBusMessage *reply, *msg = user_data;
 
@@ -172,8 +173,9 @@ static const GMarkupParser parser = {
 	NULL
 };
 
-static void get_file_callback(struct obc_session *session, GError *err,
-							void *user_data)
+static void get_file_callback(struct obc_session *session,
+						struct obc_transfer *transfer,
+						GError *err, void *user_data)
 {
 	DBusMessage *msg = user_data;
 	DBusMessage *reply;
@@ -190,7 +192,8 @@ static void get_file_callback(struct obc_session *session, GError *err,
 }
 
 static void list_folder_callback(struct obc_session *session,
-					GError *err, void *user_data)
+						struct obc_transfer *transfer,
+						GError *err, void *user_data)
 {
 	DBusMessage *msg = user_data;
 	GMarkupParseContext *ctxt;
diff --git a/client/manager.c b/client/manager.c
index 6d08702..820ef37 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -35,6 +35,7 @@
 #include <gdbus.h>
 
 #include "log.h"
+#include "transfer.h"
 #include "session.h"
 #include "manager.h"
 #include "bluetooth.h"
@@ -78,8 +79,9 @@ static void unregister_session(void *data)
 	obc_session_unref(session);
 }
 
-static void create_callback(struct obc_session *session, GError *err,
-							void *user_data)
+static void create_callback(struct obc_session *session,
+						struct obc_transfer *transfer,
+						GError *err, void *user_data)
 {
 	struct send_data *data = user_data;
 	unsigned int i;
@@ -247,6 +249,7 @@ static DBusMessage *send_files(DBusConnection *connection,
 }
 
 static void pull_complete_callback(struct obc_session *session,
+					struct obc_transfer *transfer,
 					GError *err, void *user_data)
 {
 	struct send_data *data = user_data;
@@ -271,7 +274,8 @@ done:
 }
 
 static void pull_obc_session_callback(struct obc_session *session,
-					GError *err, void *user_data)
+						struct obc_transfer *transfer,
+						GError *err, void *user_data)
 {
 	struct send_data *data = user_data;
 	DBusMessage *reply;
@@ -448,6 +452,7 @@ static DBusMessage *remove_session(DBusConnection *connection,
 }
 
 static void capabilities_complete_callback(struct obc_session *session,
+						struct obc_transfer *transfer,
 						GError *err, void *user_data)
 {
 	struct send_data *data = user_data;
@@ -488,6 +493,7 @@ done:
 }
 
 static void capability_obc_session_callback(struct obc_session *session,
+						struct obc_transfer *transfer,
 						GError *err, void *user_data)
 {
 	struct send_data *data = user_data;
diff --git a/client/map.c b/client/map.c
index 1b4e404..50d02c6 100644
--- a/client/map.c
+++ b/client/map.c
@@ -32,6 +32,7 @@
 #include "log.h"
 
 #include "map.h"
+#include "transfer.h"
 #include "session.h"
 #include "driver.h"
 
@@ -49,8 +50,9 @@ struct map_data {
 
 static DBusConnection *conn = NULL;
 
-static void simple_cb(struct obc_session *session, GError *err,
-							gpointer user_data)
+static void simple_cb(struct obc_session *session,
+						struct obc_transfer *transfer,
+						GError *err, void *user_data)
 {
 	DBusMessage *reply;
 	struct map_data *map = user_data;
@@ -94,8 +96,9 @@ static DBusMessage *map_setpath(DBusConnection *connection,
 	return NULL;
 }
 
-static void buffer_cb(struct obc_session *session, GError *err,
-							void *user_data)
+static void buffer_cb(struct obc_session *session,
+						struct obc_transfer *transfer,
+						GError *err, void *user_data)
 {
 	struct map_data *map = user_data;
 	DBusMessage *reply;
diff --git a/client/opp.c b/client/opp.c
index be382ef..efbf3e9 100644
--- a/client/opp.c
+++ b/client/opp.c
@@ -25,8 +25,11 @@
 #include <config.h>
 #endif
 
+#include <gdbus.h>
+
 #include "log.h"
 
+#include "transfer.h"
 #include "session.h"
 #include "driver.h"
 #include "opp.h"
diff --git a/client/pbap.c b/client/pbap.c
index d96b651..c43d8dd 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -36,6 +36,7 @@
 
 #include "log.h"
 
+#include "transfer.h"
 #include "session.h"
 #include "driver.h"
 #include "pbap.h"
@@ -271,8 +272,9 @@ static void pbap_reset_path(struct pbap_data *pbap)
 	obc_session_setpath(pbap->session, pbap->path, NULL, NULL, NULL);
 }
 
-static void pbap_setpath_cb(struct obc_session *session, GError *err,
-							gpointer user_data)
+static void pbap_setpath_cb(struct obc_session *session,
+						struct obc_transfer *transfer,
+						GError *err, void *user_data)
 {
 	struct pending_request *request = user_data;
 	struct pbap_data *pbap = request->pbap;
@@ -339,7 +341,8 @@ static void read_return_apparam(struct obc_session *session,
 }
 
 static void pull_phonebook_callback(struct obc_session *session,
-					GError *err, void *user_data)
+						struct obc_transfer *transfer,
+						GError *err, void *user_data)
 {
 	struct pending_request *request = user_data;
 	DBusMessage *reply;
@@ -377,7 +380,8 @@ send:
 }
 
 static void phonebook_size_callback(struct obc_session *session,
-					GError *err, void *user_data)
+						struct obc_transfer *transfer,
+						GError *err, void *user_data)
 {
 	struct pending_request *request = user_data;
 	DBusMessage *reply;
@@ -405,7 +409,8 @@ send:
 }
 
 static void pull_vcard_listing_callback(struct obc_session *session,
-					GError *err, void *user_data)
+						struct obc_transfer *transfer,
+						GError *err, void *user_data)
 {
 	struct pending_request *request = user_data;
 	GMarkupParseContext *ctxt;
diff --git a/client/session.c b/client/session.c
index 824ef49..408428c 100644
--- a/client/session.c
+++ b/client/session.c
@@ -245,7 +245,7 @@ static void connect_cb(GObex *obex, GError *err, GObexPacket *rsp,
 				"OBEX Connect failed with 0x%02x", rsp_code);
 
 done:
-	callback->func(callback->session, gerr, callback->data);
+	callback->func(callback->session, NULL, gerr, callback->data);
 	if (gerr != NULL)
 		g_error_free(gerr);
 	obc_session_unref(callback->session);
@@ -303,7 +303,7 @@ static void transport_func(GIOChannel *io, GError *err, gpointer user_data)
 
 	return;
 done:
-	callback->func(callback->session, err, callback->data);
+	callback->func(callback->session, NULL, err, callback->data);
 	obc_session_unref(callback->session);
 	g_free(callback);
 }
@@ -373,7 +373,7 @@ static gboolean connection_complete(gpointer data)
 {
 	struct callback_data *cb = data;
 
-	cb->func(cb->session, 0, cb->data);
+	cb->func(cb->session, NULL, NULL, cb->data);
 
 	obc_session_unref(cb->session);
 
@@ -498,7 +498,8 @@ void obc_session_shutdown(struct obc_session *session)
 
 	if (session->p != NULL && session->p->id != 0) {
 		if (session->p->func)
-			session->p->func(session, err, session->p->data);
+			session->p->func(session, session->p->transfer, err,
+							session->p->data);
 
 		pending_request_free(session->p);
 		session->p = NULL;
@@ -506,7 +507,7 @@ void obc_session_shutdown(struct obc_session *session)
 
 	while ((p = g_queue_pop_head(session->queue))) {
 		if (p->func)
-			p->func(session, err, p->data);
+			p->func(session, p->transfer, err, p->data);
 
 		pending_request_free(p);
 	}
@@ -798,7 +799,7 @@ static void session_process_queue(struct obc_session *session)
 
 			g_set_error(&gerr, OBEX_IO_ERROR, err,
 							"Authorization failed");
-			p->func(session, gerr, p->data);
+			p->func(session, p->transfer, gerr, p->data);
 			g_error_free(gerr);
 		}
 
@@ -842,7 +843,7 @@ static void session_terminate_transfer(struct obc_session *session,
 	obc_session_ref(session);
 
 	if (p->func)
-		p->func(session, gerr, p->data);
+		p->func(session, p->transfer, gerr, p->data);
 
 	pending_request_free(p);
 
@@ -1171,14 +1172,15 @@ const void *obc_session_get_params(struct obc_session *session, size_t *size)
 	return obc_transfer_get_params(transfer, size);
 }
 
-static void setpath_complete(struct obc_session *session, GError *err,
-							void *user_data)
+static void setpath_complete(struct obc_session *session,
+						struct obc_transfer *transfer,
+						GError *err, void *user_data)
 {
 	struct pending_request *p = user_data;
 	struct setpath_data *data = p->data;
 
 	if (data->func)
-		data->func(session, err, data->user_data);
+		data->func(session, NULL, err, data->user_data);
 
 	g_strfreev(data->remaining);
 	g_free(data);
@@ -1202,7 +1204,7 @@ static void setpath_cb(GObex *obex, GError *err, GObexPacket *rsp,
 	p->req_id = 0;
 
 	if (err != NULL) {
-		setpath_complete(p->session, err, user_data);
+		setpath_complete(p->session, NULL, err, user_data);
 		return;
 	}
 
@@ -1211,14 +1213,14 @@ static void setpath_cb(GObex *obex, GError *err, GObexPacket *rsp,
 		GError *gerr = NULL;
 		g_set_error(&gerr, OBEX_IO_ERROR, code, "%s",
 							g_obex_strerror(code));
-		setpath_complete(p->session, err, user_data);
+		setpath_complete(p->session, NULL, err, user_data);
 		g_clear_error(&gerr);
 		return;
 	}
 
 	next = data->remaining[data->index];
 	if (next == NULL) {
-		setpath_complete(p->session, NULL, user_data);
+		setpath_complete(p->session, NULL, NULL, user_data);
 		return;
 	}
 
@@ -1226,7 +1228,7 @@ static void setpath_cb(GObex *obex, GError *err, GObexPacket *rsp,
 
 	p->req_id = g_obex_setpath(obex, next, setpath_cb, p, &err);
 	if (err != NULL) {
-		setpath_complete(p->session, err, data);
+		setpath_complete(p->session, NULL, err, data);
 		g_error_free(err);
 	}
 }
@@ -1291,7 +1293,7 @@ static void async_cb(GObex *obex, GError *err, GObexPacket *rsp,
 
 	if (err != NULL) {
 		if (p->func)
-			p->func(p->session, err, p->data);
+			p->func(p->session, NULL, err, p->data);
 		goto done;
 	}
 
@@ -1301,7 +1303,7 @@ static void async_cb(GObex *obex, GError *err, GObexPacket *rsp,
 							g_obex_strerror(code));
 
 	if (p->func)
-		p->func(p->session, gerr, p->data);
+		p->func(p->session, NULL, gerr, p->data);
 
 	if (gerr != NULL)
 		g_clear_error(&gerr);
diff --git a/client/session.h b/client/session.h
index b44cf3f..ca97900 100644
--- a/client/session.h
+++ b/client/session.h
@@ -28,6 +28,7 @@
 struct obc_session;
 
 typedef void (*session_callback_t) (struct obc_session *session,
+					struct obc_transfer *transfer,
 					GError *err, void *user_data);
 
 struct obc_session *obc_session_create(const char *source,
diff --git a/client/sync.c b/client/sync.c
index 9a26f5b..c549040 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -34,6 +34,7 @@
 
 #include "log.h"
 
+#include "transfer.h"
 #include "session.h"
 #include "driver.h"
 #include "sync.h"
@@ -84,6 +85,7 @@ static DBusMessage *sync_setlocation(DBusConnection *connection,
 }
 
 static void sync_getphonebook_callback(struct obc_session *session,
+					struct obc_transfer *transfer,
 					GError *err, void *user_data)
 {
 	struct sync_data *sync = user_data;
-- 
1.7.7.6

