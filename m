Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 2/4] client: fix naming convention in transfer api
Date: Wed,  7 Mar 2012 15:50:27 +0100
Message-Id: <1331131829-28509-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1331131829-28509-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331131829-28509-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The terms can be quite misleading, so this patch proposes to follow the
terminology in the D-Bus api:
       - Name: the remote name of the object being transferred
       - Filename: the name of the file in local the filesystem

Both values can be NULL independently.

This fixes the problem of using the terms differently in get and put
operations. The result was that the properties "Name" and "Filename" were
swapped in D-Bus in the case of get.

Once the fields map to obex fields, the interpretation of the response
from the agent becomes more complicated. Depending on the transfer type,
either the name or the filename field must be updated.
---
 client/session.c  |   16 ++++++++++------
 client/transfer.c |    7 +++----
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/client/session.c b/client/session.c
index 57a5b06..28fae03 100644
--- a/client/session.c
+++ b/client/session.c
@@ -685,8 +685,12 @@ static void session_request_reply(DBusPendingCall *call, gpointer user_data)
 
 	DBG("Agent.Request() reply: %s", name);
 
-	if (strlen(name))
-		obc_transfer_set_name(transfer, name);
+	if (strlen(name)) {
+		if (p->auth_complete == session_prepare_put)
+			obc_transfer_set_name(transfer, name);
+		else
+			obc_transfer_set_filename(transfer, name);
+	}
 
 	if (p->auth_complete)
 		p->auth_complete(session, transfer);
@@ -955,8 +959,8 @@ int obc_session_get(struct obc_session *session, const char *type,
 		agent = NULL;
 
 	transfer = obc_transfer_register(session->conn, session->obex,
-							agent, filename,
-							targetname, type,
+							agent, targetname,
+							filename, type,
 							params);
 	if (transfer == NULL) {
 		if (params != NULL) {
@@ -1015,8 +1019,8 @@ int obc_session_pull(struct obc_session *session,
 		agent = NULL;
 
 	transfer = obc_transfer_register(session->conn, session->obex,
-								agent, NULL,
-								filename, type,
+								agent, filename,
+								NULL, type,
 								NULL);
 	if (transfer == NULL) {
 		return -EIO;
diff --git a/client/transfer.c b/client/transfer.c
index 3471655..60c2e4f 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -526,9 +526,8 @@ int obc_transfer_get(struct obc_transfer *transfer)
 			strncmp(transfer->type, "x-bt/", 5) == 0)) {
 		rsp_cb = get_buf_xfer_progress;
 	} else {
-		int fd = open(transfer->name ? : transfer->filename,
+		int fd = open(transfer->filename ? : transfer->name,
 				O_WRONLY | O_CREAT, 0600);
-
 		if (fd < 0) {
 			error("open(): %s(%d)", strerror(errno), errno);
 			return -errno;
@@ -540,9 +539,9 @@ int obc_transfer_get(struct obc_transfer *transfer)
 
 	req = g_obex_packet_new(G_OBEX_OP_GET, TRUE, G_OBEX_HDR_INVALID);
 
-	if (transfer->filename != NULL)
+	if (transfer->name != NULL)
 		g_obex_packet_add_unicode(req, G_OBEX_HDR_NAME,
-							transfer->filename);
+							transfer->name);
 
 	if (transfer->type != NULL)
 		g_obex_packet_add_bytes(req, G_OBEX_HDR_TYPE, transfer->type,
-- 
1.7.6.5

