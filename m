Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v3 10/14] client: Remove internal transfer progress report
Date: Wed, 30 May 2012 17:50:19 +0200
Message-Id: <1338393023-29941-11-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338393023-29941-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338393023-29941-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The new D-Bus API uses signals to report the progress updates, so the
internal progress callback is not needed any more.
---
 client/session.c  |   25 ++++++-------------------
 client/transfer.c |   18 +++---------------
 client/transfer.h |    3 +--
 3 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/client/session.c b/client/session.c
index 989439c..8e21da4 100644
--- a/client/session.c
+++ b/client/session.c
@@ -103,9 +103,8 @@ static void session_start_transfer(gpointer data, gpointer user_data);
 static void session_terminate_transfer(struct obc_session *session,
 					struct obc_transfer *transfer,
 					GError *gerr);
-static void transfer_progress(struct obc_transfer *transfer,
-					gint64 transferred, GError *err,
-					void *user_data);
+static void transfer_complete(struct obc_transfer *transfer,
+					GError *err, void *user_data);
 
 static GQuark obex_io_error_quark(void)
 {
@@ -669,7 +668,7 @@ guint obc_session_queue(struct obc_session *session,
 		return 0;
 	}
 
-	obc_transfer_set_callback(transfer, transfer_progress, session);
+	obc_transfer_set_callback(transfer, transfer_complete, session);
 
 	p = pending_request_new(session, transfer, session_start_transfer,
 							func, user_data);
@@ -786,27 +785,15 @@ static void session_notify_error(struct obc_session *session,
 	session_terminate_transfer(session, transfer, err);
 }
 
-static void session_notify_progress(struct obc_session *session,
-					struct obc_transfer *transfer,
-					gint64 transferred)
-{
-	DBG("Transfer(%p) progress: %ld bytes", transfer,
-			(long int ) transferred);
-
-	if (transferred == obc_transfer_get_size(transfer))
-		session_notify_complete(session, transfer);
-}
-
-static void transfer_progress(struct obc_transfer *transfer,
-					gint64 transferred, GError *err,
-					void *user_data)
+static void transfer_complete(struct obc_transfer *transfer,
+					GError *err, void *user_data)
 {
 	struct obc_session *session = user_data;
 
 	if (err != 0)
 		goto fail;
 
-	session_notify_progress(session, transfer, transferred);
+	session_notify_complete(session, transfer);
 
 	return;
 
diff --git a/client/transfer.c b/client/transfer.c
index 1138aa6..a14624d 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -135,15 +135,13 @@ static void abort_complete(GObex *obex, GError *err, gpointer user_data)
 		return;
 
 	if (err) {
-		callback->func(transfer, transfer->transferred, err,
-							callback->data);
+		callback->func(transfer, err, callback->data);
 	} else {
 		GError *abort_err;
 
 		abort_err = g_error_new(OBC_TRANSFER_ERROR, -ECANCELED, "%s",
 						"Transfer cancelled by user");
-		callback->func(transfer, transfer->transferred, abort_err,
-							callback->data);
+		callback->func(transfer, abort_err, callback->data);
 		g_error_free(abort_err);
 	}
 }
@@ -409,7 +407,6 @@ static gboolean get_xfer_progress(const void *buf, gsize len,
 							gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
-	struct transfer_callback *callback = transfer->callback;
 
 	if (transfer->fd > 0) {
 		gint w;
@@ -421,10 +418,6 @@ static gboolean get_xfer_progress(const void *buf, gsize len,
 		transfer->transferred += w;
 	}
 
-	if (callback && transfer->transferred != transfer->size)
-		callback->func(transfer, transfer->transferred, NULL,
-							callback->data);
-
 	return TRUE;
 }
 
@@ -462,7 +455,7 @@ static void xfer_complete(GObex *obex, GError *err, gpointer user_data)
 	}
 
 	if (callback)
-		callback->func(transfer, transfer->size, err, callback->data);
+		callback->func(transfer, err, callback->data);
 }
 
 static void get_xfer_progress_first(GObex *obex, GError *err, GObexPacket *rsp,
@@ -529,17 +522,12 @@ static void get_xfer_progress_first(GObex *obex, GError *err, GObexPacket *rsp,
 static gssize put_xfer_progress(void *buf, gsize len, gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
-	struct transfer_callback *callback = transfer->callback;
 	gssize size;
 
 	size = read(transfer->fd, buf, len);
 	if (size <= 0)
 		return size;
 
-	if (callback)
-		callback->func(transfer, transfer->transferred, NULL,
-							callback->data);
-
 	transfer->transferred += size;
 
 	return size;
diff --git a/client/transfer.h b/client/transfer.h
index bfa166d..15c157a 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -24,8 +24,7 @@
 struct obc_transfer;
 
 typedef void (*transfer_callback_t) (struct obc_transfer *transfer,
-					gint64 transferred, GError *err,
-					void *user_data);
+					GError *err, void *user_data);
 
 struct obc_transfer *obc_transfer_get(const char *type, const char *name,
 					const char *filename, GError **err);
-- 
1.7.7.6

