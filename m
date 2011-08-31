Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 2/2] Enhance obc_session_put() function
Date: Wed, 31 Aug 2011 15:35:14 +0200
Message-Id: <1314797714-25193-3-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1314797714-25193-1-git-send-email-lkslawek@gmail.com>
References: <1314797714-25193-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds all features already present in obc_session_get() to
obc_session_put(), e.g. asynchronous notification when the transfer has ended,
application parameters header support.
---
 client/session.c  |   32 ++++++++++++++++++++++++++++----
 client/session.h  |    6 ++++--
 client/sync.c     |    3 ++-
 client/transfer.c |    7 +++++--
 4 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/client/session.c b/client/session.c
index 8ad20d1..14944b6 100644
--- a/client/session.c
+++ b/client/session.c
@@ -1341,9 +1341,13 @@ static void session_prepare_put(struct obc_session *session,
 	DBG("Transfer(%p) started", transfer);
 }
 
-int obc_session_put(struct obc_session *session, char *buf, const char *targetname)
+int obc_session_put(struct obc_session *session, const char *type,
+		const char *filename, const char *targetname,
+		const guint8 *apparam, gint apparam_size,
+		session_callback_t func, char *buf, void *user_data)
 {
 	struct obc_transfer *transfer;
+	struct obc_transfer_params *params = NULL;
 	int err;
 
 	if (session->obex == NULL)
@@ -1352,13 +1356,33 @@ int obc_session_put(struct obc_session *session, char *buf, const char *targetna
 	if (session->pending != NULL)
 		return -EISCONN;
 
-	transfer = obc_transfer_register(session->conn, NULL, targetname, NULL,
-								NULL, session);
-	if (transfer == NULL)
+	if (apparam != NULL) {
+		params = g_new0(struct obc_transfer_params, 1);
+		params->data = g_new(guint8, apparam_size);
+		memcpy(params->data, apparam, apparam_size);
+		params->size = apparam_size;
+	}
+
+	transfer = obc_transfer_register(session->conn, filename, targetname,
+							type, params, session);
+	if (transfer == NULL) {
+		if (params != NULL) {
+			g_free(params->data);
+			g_free(params);
+		}
 		return -EIO;
+	}
 
 	obc_transfer_set_buffer(transfer, buf);
 
+	if (func != NULL) {
+		struct session_callback *callback;
+		callback = g_new0(struct session_callback, 1);
+		callback->func = func;
+		callback->data = user_data;
+		session->callback = callback;
+	}
+
 	err = session_request(session, session_prepare_put, transfer);
 	if (err < 0)
 		return err;
diff --git a/client/session.h b/client/session.h
index 8a9480b..62a5b92 100644
--- a/client/session.h
+++ b/client/session.h
@@ -71,5 +71,7 @@ int obc_session_pull(struct obc_session *session,
 				session_callback_t function, void *user_data);
 const char *obc_session_register(struct obc_session *session,
 						GDBusDestroyFunction destroy);
-int obc_session_put(struct obc_session *session, char *buf,
-				const char *targetname);
+int obc_session_put(struct obc_session *session, const char *type,
+		const char *filename, const char *targetname,
+		const guint8 *apparam, gint apparam_size,
+		session_callback_t func, char *buf, void *user_data);
diff --git a/client/sync.c b/client/sync.c
index 349f950..d4ff500 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -146,7 +146,8 @@ static DBusMessage *sync_putphonebook(DBusConnection *connection,
 
 	buffer = g_strdup(buf);
 
-	if (obc_session_put(sync->session, buffer, sync->phonebook_path) < 0)
+	if (obc_session_put(sync->session, NULL, NULL, sync->phonebook_path,
+					NULL, 0, NULL, buffer, NULL) < 0)
 		return g_dbus_create_error(message,
 				ERROR_INF ".Failed", "Failed");
 
diff --git a/client/transfer.c b/client/transfer.c
index af48f69..d2adba3 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -531,8 +531,11 @@ int obc_transfer_put(struct obc_transfer *transfer, transfer_callback_t func,
 done:
 	obex = obc_session_get_obex(session);
 	size = transfer->size < UINT32_MAX ? transfer->size : 0;
-	transfer->xfer = gw_obex_put_async(obex, transfer->name,
-						transfer->type, size,
+	transfer->xfer = gw_obex_put_async_with_apparam(obex, transfer->name,
+						transfer->type,
+						transfer->params->data,
+						transfer->params->size,
+						size,
 						-1, NULL);
 	if (transfer->xfer == NULL)
 		return -ENOTCONN;
-- 
1.7.4.1

