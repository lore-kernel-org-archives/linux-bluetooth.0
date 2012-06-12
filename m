Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 2/3] client: Remove obc_transfer_abort
Date: Tue, 12 Jun 2012 14:10:25 +0200
Message-Id: <1339503026-17276-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1339503026-17276-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1339503026-17276-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Refactor the code to remove function obc_transfer_abort, which is used
only once and is anyway coupled to the D-Bus API.
---
 client/transfer.c |   26 +++++++++++---------------
 1 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 0686afe..f296638 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -187,20 +187,6 @@ static void abort_complete(GObex *obex, GError *err, gpointer user_data)
 	}
 }
 
-static gboolean obc_transfer_abort(struct obc_transfer *transfer)
-{
-	if (transfer->xfer == 0)
-		return FALSE;
-
-	if (transfer->progress_id != 0) {
-		g_source_remove(transfer->progress_id);
-		transfer->progress_id = 0;
-	}
-
-	return g_obex_cancel_transfer(transfer->xfer, abort_complete,
-								transfer);
-}
-
 static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
@@ -218,7 +204,17 @@ static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
 				ERROR_INTERFACE ".InProgress",
 				"Cancellation already in progress");
 
-	if (!obc_transfer_abort(transfer))
+	if (transfer->xfer == 0)
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".Failed",
+				"Failed");
+
+	if (transfer->progress_id != 0) {
+		g_source_remove(transfer->progress_id);
+		transfer->progress_id = 0;
+	}
+
+	if (!g_obex_cancel_transfer(transfer->xfer, abort_complete, transfer))
 		return g_dbus_create_error(message,
 				ERROR_INTERFACE ".Failed",
 				"Failed");
-- 
1.7.7.6

