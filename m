Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH obexd] client: Fix ABORT command not sending when user cancels
 the transfer
Date: Mon, 20 Feb 2012 18:19:32 +0530
Message-id: <1329742172-12124-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Issue: When user cancels the tranfer, after queuing the ABORT command
transfer->callback() with error will be called. In that session_unref
is called which disconnects the transport.

Fix: Just send ABORT command during abort and transfer->callback()
will be called after getting response of ABORT command.
---
 client/transfer.c      |   12 ------------
 gobex/gobex-transfer.c |    6 +++++-
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 157811d..88e8ef7 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -141,23 +141,11 @@ static DBusMessage *obc_transfer_get_properties(DBusConnection *connection,
 
 static void obc_transfer_abort(struct obc_transfer *transfer)
 {
-	struct transfer_callback *callback = transfer->callback;
-
 	if (transfer->xfer == 0)
 		return;
 
 	g_obex_cancel_transfer(transfer->xfer);
 	transfer->xfer = 0;
-
-	if (callback) {
-		GError *err;
-
-		err = g_error_new(OBC_TRANSFER_ERROR, -ECANCELED, "%s",
-							strerror(ECANCELED));
-		callback->func(transfer, transfer->transferred, err,
-							callback->data);
-		g_error_free(err);
-	}
 }
 
 static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index c62a91e..706952f 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -635,6 +635,10 @@ gboolean g_obex_cancel_transfer(guint id)
 	if (transfer == NULL)
 		return FALSE;
 
-	transfer_free(transfer);
+	if (transfer->req_id > 0)
+		g_obex_cancel_req(transfer->obex, transfer->req_id, FALSE);
+	else
+		transfer_free(transfer);
+
 	return TRUE;
 }
-- 
1.7.1

