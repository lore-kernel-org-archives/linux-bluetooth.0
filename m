Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 6/8] client: expose obc_transfer_set_callback
Date: Tue, 21 Feb 2012 14:57:10 +0100
Message-Id: <1329832632-3681-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329832632-3681-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329832632-3681-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This will allow setting the callback before the transfer is started,
particularly to report queued transfer cancellations.
---
 client/session.c  |    9 +++++++--
 client/transfer.c |   19 +++++++------------
 client/transfer.h |   10 ++++++----
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/client/session.c b/client/session.c
index 3429f0a..e3b5a56 100644
--- a/client/session.c
+++ b/client/session.c
@@ -107,6 +107,9 @@ static void session_prepare_put(gpointer data, gpointer user_data);
 static void session_terminate_transfer(struct obc_session *session,
 					struct obc_transfer *transfer,
 					GError *gerr);
+static void transfer_progress(struct obc_transfer *transfer,
+					gint64 transferred, GError *err,
+					void *user_data);
 
 GQuark obex_io_error_quark(void)
 {
@@ -710,6 +713,8 @@ static int session_request(struct obc_session *session,
 	struct pending_request *p;
 	int err;
 
+	obc_transfer_set_callback(transfer, transfer_progress, session);
+
 	p = pending_request_new(session, transfer, auth_complete, func, data);
 
 	if (session->p) {
@@ -888,7 +893,7 @@ static void session_prepare_get(gpointer data, gpointer user_data)
 	struct obc_transfer *transfer = user_data;
 	int ret;
 
-	ret = obc_transfer_get(transfer, transfer_progress, session);
+	ret = obc_transfer_get(transfer);
 	if (ret < 0) {
 		GError *gerr = NULL;
 
@@ -1033,7 +1038,7 @@ static void session_prepare_put(gpointer data, gpointer user_data)
 	struct obc_transfer *transfer = user_data;
 	int ret;
 
-	ret = obc_transfer_put(transfer, transfer_progress, session);
+	ret = obc_transfer_put(transfer);
 	if (ret < 0) {
 		GError *gerr = NULL;
 
diff --git a/client/transfer.c b/client/transfer.c
index 4054799..b470a3a 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -488,23 +488,25 @@ static gssize put_xfer_progress(void *buf, gsize len, gpointer user_data)
 	return size;
 }
 
-static void obc_transfer_set_callback(struct obc_transfer *transfer,
+gboolean obc_transfer_set_callback(struct obc_transfer *transfer,
 					transfer_callback_t func,
 					void *user_data)
 {
 	struct transfer_callback *callback;
 
-	g_free(transfer->callback);
+	if (transfer->callback != NULL)
+		return FALSE;
 
 	callback = g_new0(struct transfer_callback, 1);
 	callback->func = func;
 	callback->data = user_data;
 
 	transfer->callback = callback;
+
+	return TRUE;
 }
 
-int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
-			void *user_data)
+int obc_transfer_get(struct obc_transfer *transfer)
 {
 	GError *err = NULL;
 	GObexPacket *req;
@@ -558,14 +560,10 @@ int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
 	if (transfer->xfer == 0)
 		return -ENOTCONN;
 
-	if (func)
-		obc_transfer_set_callback(transfer, func, user_data);
-
 	return 0;
 }
 
-int obc_transfer_put(struct obc_transfer *transfer, transfer_callback_t func,
-			void *user_data)
+int obc_transfer_put(struct obc_transfer *transfer)
 {
 	GError *err = NULL;
 	GObexPacket *req;
@@ -606,9 +604,6 @@ done:
 	if (transfer->xfer == 0)
 		return -ENOTCONN;
 
-	if (func)
-		obc_transfer_set_callback(transfer, func, user_data);
-
 	return 0;
 }
 
diff --git a/client/transfer.h b/client/transfer.h
index e5387fc..e7e1000 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -42,10 +42,12 @@ struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 
 void obc_transfer_unregister(struct obc_transfer *transfer);
 
-int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
-			void *user_data);
-int obc_transfer_put(struct obc_transfer *transfer, transfer_callback_t func,
-			void *user_data);
+gboolean obc_transfer_set_callback(struct obc_transfer *transfer,
+					transfer_callback_t func,
+					void *user_data);
+
+int obc_transfer_get(struct obc_transfer *transfer);
+int obc_transfer_put(struct obc_transfer *transfer);
 
 int obc_transfer_get_params(struct obc_transfer *transfer,
 					struct obc_transfer_params *params);
-- 
1.7.6.5

