Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd 7/9] client: expose obc_transfer_set_callback
Date: Tue, 21 Feb 2012 09:46:21 +0100
Message-Id: <1329813983-26707-8-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329813983-26707-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329813983-26707-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This will allow setting the callback before the transfer is started,
particularly to report queued transfer cancellations.
---
 client/session.c  |    9 +++++++--
 client/transfer.c |   14 +++-----------
 client/transfer.h |   10 ++++++----
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/client/session.c b/client/session.c
index 50a6a5d..e9cc3ee 100644
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
@@ -704,6 +707,8 @@ static int session_request(struct obc_session *session,
 	struct pending_request *p;
 	int err;
 
+	obc_transfer_set_callback(transfer, transfer_progress, session);
+
 	p = pending_request_new(session, transfer, auth_complete, func, data);
 
 	if (session->p) {
@@ -877,7 +882,7 @@ static void session_prepare_get(gpointer data, gpointer user_data)
 	struct obc_transfer *transfer = user_data;
 	int ret;
 
-	ret = obc_transfer_get(transfer, transfer_progress, session);
+	ret = obc_transfer_get(transfer);
 	if (ret < 0) {
 		GError *gerr = NULL;
 
@@ -1022,7 +1027,7 @@ static void session_prepare_put(gpointer data, gpointer user_data)
 	struct obc_transfer *transfer = user_data;
 	int ret;
 
-	ret = obc_transfer_put(transfer, transfer_progress, session);
+	ret = obc_transfer_put(transfer);
 	if (ret < 0) {
 		GError *gerr = NULL;
 
diff --git a/client/transfer.c b/client/transfer.c
index 4054799..2cf5786 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -488,7 +488,7 @@ static gssize put_xfer_progress(void *buf, gsize len, gpointer user_data)
 	return size;
 }
 
-static void obc_transfer_set_callback(struct obc_transfer *transfer,
+void obc_transfer_set_callback(struct obc_transfer *transfer,
 					transfer_callback_t func,
 					void *user_data)
 {
@@ -503,8 +503,7 @@ static void obc_transfer_set_callback(struct obc_transfer *transfer,
 	transfer->callback = callback;
 }
 
-int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
-			void *user_data)
+int obc_transfer_get(struct obc_transfer *transfer)
 {
 	GError *err = NULL;
 	GObexPacket *req;
@@ -558,14 +557,10 @@ int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
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
@@ -606,9 +601,6 @@ done:
 	if (transfer->xfer == 0)
 		return -ENOTCONN;
 
-	if (func)
-		obc_transfer_set_callback(transfer, func, user_data);
-
 	return 0;
 }
 
diff --git a/client/transfer.h b/client/transfer.h
index e5387fc..348c17c 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -42,10 +42,12 @@ struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 
 void obc_transfer_unregister(struct obc_transfer *transfer);
 
-int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
-			void *user_data);
-int obc_transfer_put(struct obc_transfer *transfer, transfer_callback_t func,
-			void *user_data);
+void obc_transfer_set_callback(struct obc_transfer *transfer,
+					transfer_callback_t func,
+					void *user_data);
+
+int obc_transfer_get(struct obc_transfer *transfer);
+int obc_transfer_put(struct obc_transfer *transfer);
 
 int obc_transfer_get_params(struct obc_transfer *transfer,
 					struct obc_transfer_params *params);
-- 
1.7.6.5

