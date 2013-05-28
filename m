Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/9] obexd: Add process callback to session's pending_request
Date: Tue, 28 May 2013 14:37:05 +0200
Message-Id: <1369744633-8980-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1369744633-8980-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1369744633-8980-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This adds a process callback and a data destroy callback to the session's
pending_request structure.

This is needed as preparation of queuing all OBEX session commands.
---
 obexd/client/session.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index f1bdf18..1b02403 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -65,10 +65,17 @@ struct callback_data {
 	void *data;
 };
 
+struct pending_request;
+typedef int (*session_process_t) (struct pending_request *pr, GError **err);
+
+typedef void (*pending_destroy_t)(void *data);
+
 struct pending_request {
 	guint id;
 	guint req_id;
 	struct obc_session *session;
+	session_process_t process;
+	pending_destroy_t pending_destroy;
 	struct obc_transfer *transfer;
 	session_callback_t func;
 	void *data;
@@ -140,9 +147,11 @@ static void session_unregistered(struct obc_session *session)
 }
 
 static struct pending_request *pending_request_new(struct obc_session *session,
-						struct obc_transfer *transfer,
-						session_callback_t func,
-						void *data)
+					session_process_t process,
+					pending_destroy_t pending_destroy,
+					struct obc_transfer *transfer,
+					session_callback_t func,
+					void *data)
 {
 	struct pending_request *p;
 	static guint id = 0;
@@ -150,6 +159,8 @@ static struct pending_request *pending_request_new(struct obc_session *session,
 	p = g_new0(struct pending_request, 1);
 	p->id = ++id;
 	p->session = obc_session_ref(session);
+	p->process = process;
+	p->pending_destroy = pending_destroy;
 	p->transfer = transfer;
 	p->func = func;
 	p->data = data;
@@ -159,6 +170,9 @@ static struct pending_request *pending_request_new(struct obc_session *session,
 
 static void pending_request_free(struct pending_request *p)
 {
+	if (p->pending_destroy && p->data)
+		p->pending_destroy(p->data);
+
 	if (p->transfer)
 		obc_transfer_unregister(p->transfer);
 
@@ -678,7 +692,7 @@ guint obc_session_queue(struct obc_session *session,
 
 	obc_transfer_set_callback(transfer, transfer_complete, session);
 
-	p = pending_request_new(session, transfer, func, user_data);
+	p = pending_request_new(session, NULL, NULL, transfer, func, user_data);
 	g_queue_push_tail(session->queue, p);
 
 	if (session->queue_complete_id == 0)
@@ -943,7 +957,8 @@ guint obc_session_setpath(struct obc_session *session, const char *path,
 	data->user_data = user_data;
 	data->remaining = g_strsplit(strlen(path) ? path : "/", "/", 0);
 
-	p = pending_request_new(session, NULL, setpath_complete, data);
+	p = pending_request_new(session, NULL, NULL, NULL, setpath_complete,
+									data);
 
 	/* Relative path */
 	if (path[0] != '/')
@@ -1018,7 +1033,7 @@ guint obc_session_mkdir(struct obc_session *session, const char *folder,
 	}
 
 
-	p = pending_request_new(session, NULL, func, user_data);
+	p = pending_request_new(session, NULL, NULL, NULL, func, user_data);
 
 	p->req_id = g_obex_mkdir(session->obex, folder, async_cb, p, err);
 	if (*err != NULL) {
@@ -1047,7 +1062,7 @@ guint obc_session_copy(struct obc_session *session, const char *srcname,
 		return 0;
 	}
 
-	p = pending_request_new(session, NULL, func, user_data);
+	p = pending_request_new(session, NULL, NULL, NULL, func, user_data);
 
 	p->req_id = g_obex_copy(session->obex, srcname, destname, async_cb, p,
 									err);
@@ -1077,7 +1092,7 @@ guint obc_session_move(struct obc_session *session, const char *srcname,
 		return 0;
 	}
 
-	p = pending_request_new(session, NULL, func, user_data);
+	p = pending_request_new(session, NULL, NULL, NULL, func, user_data);
 
 	p->req_id = g_obex_move(session->obex, srcname, destname, async_cb, p,
 									err);
@@ -1107,7 +1122,7 @@ guint obc_session_delete(struct obc_session *session, const char *file,
 		return 0;
 	}
 
-	p = pending_request_new(session, NULL, func, user_data);
+	p = pending_request_new(session, NULL, NULL, NULL, func, user_data);
 
 	p->req_id = g_obex_delete(session->obex, file, async_cb, p, err);
 	if (*err != NULL) {
-- 
1.8.2.3

