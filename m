Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 03/11] client: refactor transfer callback use
Date: Mon, 12 Mar 2012 14:32:37 +0100
Message-Id: <1331559165-28367-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Separated internal functions are used to report success, failure, and
progress, instead of using the callback directly.

This makes the code more readable.
---
 client/transfer.c |   86 ++++++++++++++++++++++++++++++++--------------------
 1 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index a609aa9..f2a153c 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -138,10 +138,47 @@ static DBusMessage *obc_transfer_get_properties(DBusConnection *connection,
 	return reply;
 }
 
-static void obc_transfer_abort(struct obc_transfer *transfer)
+static void transfer_notify_progress(struct obc_transfer *transfer)
+{
+	struct transfer_callback *callback = transfer->callback;
+
+	DBG("%p", transfer);
+
+	if ((callback != NULL) && (transfer->transferred != transfer->size))
+		callback->func(transfer, transfer->transferred, NULL,
+								callback->data);
+}
+
+static void transfer_notify_complete(struct obc_transfer *transfer)
+{
+	struct transfer_callback *callback = transfer->callback;
+
+	DBG("%p", transfer);
+
+	if (callback != NULL) {
+		transfer->callback = NULL;
+		callback->func(transfer, transfer->transferred, NULL,
+								callback->data);
+		g_free(callback);
+	}
+}
+
+static void transfer_notify_error(struct obc_transfer *transfer, GError *err)
 {
 	struct transfer_callback *callback = transfer->callback;
 
+	if (callback != NULL) {
+		transfer->callback = NULL;
+		callback->func(transfer, transfer->transferred, err,
+								callback->data);
+		g_free(callback);
+	}
+}
+
+static void obc_transfer_abort(struct obc_transfer *transfer)
+{
+	GError *err;
+
 	if (transfer->xfer > 0) {
 		g_obex_cancel_transfer(transfer->xfer);
 		transfer->xfer = 0;
@@ -152,15 +189,10 @@ static void obc_transfer_abort(struct obc_transfer *transfer)
 		transfer->obex = NULL;
 	}
 
-	if (callback) {
-		GError *err;
-
-		err = g_error_new(OBC_TRANSFER_ERROR, -ECANCELED, "%s",
+	err = g_error_new(OBC_TRANSFER_ERROR, -ECANCELED, "%s",
 							strerror(ECANCELED));
-		callback->func(transfer, transfer->transferred, err,
-							callback->data);
-		g_error_free(err);
-	}
+	transfer_notify_error(transfer, err);
+	g_error_free(err);
 }
 
 static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
@@ -304,7 +336,6 @@ static void obc_transfer_read(struct obc_transfer *transfer,
 static void get_buf_xfer_complete(GObex *obex, GError *err, gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
-	struct transfer_callback *callback = transfer->callback;
 	gsize bsize;
 
 	transfer->xfer = 0;
@@ -327,15 +358,13 @@ static void get_buf_xfer_complete(GObex *obex, GError *err, gpointer user_data)
 	transfer->size = strlen(transfer->buffer);
 
 done:
-	if (callback)
-		callback->func(transfer, transfer->size, err, callback->data);
+	transfer_notify_complete(transfer);
 }
 
 static void get_buf_xfer_progress(GObex *obex, GError *err, GObexPacket *rsp,
 							gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
-	struct transfer_callback *callback = transfer->callback;
 	GObexPacket *req;
 	GObexHeader *hdr;
 	const guint8 *buf;
@@ -392,30 +421,29 @@ static void get_buf_xfer_progress(GObex *obex, GError *err, GObexPacket *rsp,
 							transfer, &err);
 	}
 
-	if (callback && transfer->transferred != transfer->size)
-		callback->func(transfer, transfer->transferred, err,
-							callback->data);
+	transfer_notify_progress(transfer);
 }
 
 static void xfer_complete(GObex *obex, GError *err, gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
-	struct transfer_callback *callback = transfer->callback;
 
 	transfer->xfer = 0;
 
-	if (err == NULL)
-		transfer->size = transfer->transferred;
+	if (err != NULL) {
+		transfer_notify_error(transfer, err);
+		return;
+	}
 
-	if (callback)
-		callback->func(transfer, transfer->size, err, callback->data);
+	transfer->size = transfer->transferred;
+
+	transfer_notify_complete(transfer);
 }
 
 static gboolean get_xfer_progress(const void *buf, gsize len,
 							gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
-	struct transfer_callback *callback = transfer->callback;
 
 	obc_transfer_read(transfer, buf, len);
 
@@ -429,9 +457,7 @@ static gboolean get_xfer_progress(const void *buf, gsize len,
 		transfer->filled -= w;
 	}
 
-	if (callback && transfer->transferred != transfer->size)
-		callback->func(transfer, transfer->transferred, NULL,
-							callback->data);
+	transfer_notify_progress(transfer);
 
 	return TRUE;
 }
@@ -439,7 +465,6 @@ static gboolean get_xfer_progress(const void *buf, gsize len,
 static gssize put_buf_xfer_progress(void *buf, gsize len, gpointer user_data)
 {
 	struct obc_transfer *transfer = user_data;
-	struct transfer_callback *callback = transfer->callback;
 	gsize size;
 
 	if (transfer->transferred == transfer->size)
@@ -454,9 +479,7 @@ static gssize put_buf_xfer_progress(void *buf, gsize len, gpointer user_data)
 
 	transfer->transferred += size;
 
-	if (callback)
-		callback->func(transfer, transfer->transferred, NULL,
-							callback->data);
+	transfer_notify_progress(transfer);
 
 	return size;
 }
@@ -464,16 +487,13 @@ static gssize put_buf_xfer_progress(void *buf, gsize len, gpointer user_data)
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
+	transfer_notify_progress(transfer);
 
 	transfer->transferred += size;
 
-- 
1.7.7.6

