Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 3/3] client: Fix cancellation of queued transfers
Date: Tue, 12 Jun 2012 14:10:26 +0200
Message-Id: <1339503026-17276-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1339503026-17276-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1339503026-17276-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Cancelling queued (not started yet) transfers should not fail. Instead,
they must be removed from the queue, so we just need to call the
transfer callback.
---
 client/transfer.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index f296638..cb7c26c 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -204,10 +204,20 @@ static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
 				ERROR_INTERFACE ".InProgress",
 				"Cancellation already in progress");
 
-	if (transfer->xfer == 0)
-		return g_dbus_create_error(message,
-				ERROR_INTERFACE ".Failed",
-				"Failed");
+	if (transfer->xfer == 0) {
+		struct transfer_callback *callback = transfer->callback;
+
+		if (callback != NULL) {
+			GError *err;
+
+			err = g_error_new(OBC_TRANSFER_ERROR, -ECANCELED, "%s",
+						"Transfer cancelled by user");
+			callback->func(transfer, err, callback->data);
+			g_error_free(err);
+		}
+
+		return dbus_message_new_method_return(message);
+	}
 
 	if (transfer->progress_id != 0) {
 		g_source_remove(transfer->progress_id);
-- 
1.7.7.6

