Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/7] obexd/client: Fix not being able to cancel a suspended transfer
Date: Wed, 27 Aug 2014 19:04:45 +0300
Message-Id: <1409155490-25653-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1409155490-25653-1-git-send-email-luiz.dentz@gmail.com>
References: <1409155490-25653-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a transfer is suspended it should be resumed before cancelling
otherwise it will timeout.
---
 obexd/client/transfer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index 0b5735b..c31a722 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -160,6 +160,9 @@ static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
 				ERROR_INTERFACE ".InProgress",
 				"Cancellation already in progress");
 
+	if (transfer->status == TRANSFER_STATUS_SUSPENDED)
+		g_obex_resume(transfer->obex);
+
 	if (transfer->req > 0) {
 		if (!g_obex_cancel_req(transfer->obex, transfer->req, TRUE))
 			return g_dbus_create_error(message,
@@ -414,6 +417,9 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 {
 	DBG("%p", transfer);
 
+	if (transfer->status == TRANSFER_STATUS_SUSPENDED)
+		g_obex_resume(transfer->obex);
+
 	if (transfer->req > 0)
 		g_obex_cancel_req(transfer->obex, transfer->req, TRUE);
 
@@ -659,6 +665,9 @@ static void xfer_complete(GObex *obex, GError *err, gpointer user_data)
 		transfer->progress_id = 0;
 	}
 
+	if (transfer->status == TRANSFER_STATUS_SUSPENDED)
+		g_obex_resume(transfer->obex);
+
 	if (err)
 		transfer_set_status(transfer, TRANSFER_STATUS_ERROR);
 	else
-- 
1.9.3

