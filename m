Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v1 06/11] client: transfers take gobex when starting
Date: Tue, 10 Apr 2012 15:38:27 +0200
Message-Id: <1334065112-14966-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1334065112-14966-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334065112-14966-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

gobex api should not be used by a transfer until it is started. This
seems more explicit if the pointer is not passed during creation.
---
 client/session.c  |    9 ++++-----
 client/transfer.c |    7 ++++---
 client/transfer.h |    5 +++--
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/client/session.c b/client/session.c
index f27f45a..c628c6f 100644
--- a/client/session.c
+++ b/client/session.c
@@ -921,7 +921,7 @@ static void session_start_transfer(gpointer data, gpointer user_data)
 	struct obc_transfer *transfer = user_data;
 	GError *err = NULL;
 
-	if (!obc_transfer_start(transfer, &err)) {
+	if (!obc_transfer_start(transfer, session->obex, &err)) {
 		session_notify_error(session, transfer, err);
 		g_clear_error(&err);
 		return;
@@ -954,8 +954,7 @@ int obc_session_get(struct obc_session *session, const char *type,
 	else
 		agent = NULL;
 
-	transfer = obc_transfer_register(session->conn, session->obex,
-							agent,
+	transfer = obc_transfer_register(session->conn, agent,
 							OBC_TRANSFER_GET,
 							targetfile, name, type,
 							params);
@@ -982,7 +981,7 @@ int obc_session_send(struct obc_session *session, const char *filename,
 
 	agent = obc_agent_get_name(session->agent);
 
-	transfer = obc_transfer_register(session->conn, session->obex, agent,
+	transfer = obc_transfer_register(session->conn, agent,
 							OBC_TRANSFER_PUT,
 							filename,
 							name, NULL, NULL);
@@ -1048,7 +1047,7 @@ int obc_session_put(struct obc_session *session, char *buf, const char *name)
 
 	agent = obc_agent_get_name(session->agent);
 
-	transfer = obc_transfer_register(session->conn, session->obex, agent,
+	transfer = obc_transfer_register(session->conn, agent,
 							OBC_TRANSFER_PUT,
 							name, NULL, NULL, NULL);
 	if (transfer == NULL) {
diff --git a/client/transfer.c b/client/transfer.c
index 7f8c784..ea011a4 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -257,7 +257,6 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 }
 
 struct obc_transfer *obc_transfer_register(DBusConnection *conn,
-						GObex *obex,
 						const char *agent,
 						ObcTransferCommand cmd,
 						const char *filename,
@@ -268,7 +267,6 @@ struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 	struct obc_transfer *transfer;
 
 	transfer = g_new0(struct obc_transfer, 1);
-	transfer->obex = g_obex_ref(obex);
 	transfer->command = cmd;
 	transfer->agent = g_strdup(agent);
 	transfer->filename = g_strdup(filename);
@@ -628,8 +626,11 @@ done:
 	return TRUE;
 }
 
-gboolean obc_transfer_start(struct obc_transfer *transfer, GError **err)
+gboolean obc_transfer_start(struct obc_transfer *transfer, GObex *obex,
+								GError **err)
 {
+	transfer->obex = g_obex_ref(obex);
+
 	switch (transfer->command) {
 	case OBC_TRANSFER_GET:
 		return transfer_start_get(transfer, err);
diff --git a/client/transfer.h b/client/transfer.h
index fc86cce..a74ffea 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -38,7 +38,6 @@ typedef void (*transfer_callback_t) (struct obc_transfer *transfer,
 					void *user_data);
 
 struct obc_transfer *obc_transfer_register(DBusConnection *conn,
-					GObex *obex,
 					const char *agent,
 					ObcTransferCommand cmd,
 					const char *filename,
@@ -52,7 +51,9 @@ gboolean obc_transfer_set_callback(struct obc_transfer *transfer,
 					transfer_callback_t func,
 					void *user_data);
 
-gboolean obc_transfer_start(struct obc_transfer *transfer, GError **err);
+gboolean obc_transfer_start(struct obc_transfer *transfer,
+					GObex *obex,
+					GError **err);
 
 ObcTransferCommand obc_transfer_get_cmd(struct obc_transfer *transfer);
 const void *obc_transfer_get_params(struct obc_transfer *transfer,
-- 
1.7.7.6

