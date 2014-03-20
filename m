Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] obexd/client: Fix not being able cancel GET requests
Date: Thu, 20 Mar 2014 15:50:50 +0200
Message-Id: <1395323451-31229-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395323451-31229-1-git-send-email-luiz.dentz@gmail.com>
References: <1395323451-31229-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case of GET operation the code does not use g_obex_get_req_pkt since
the beggining to be able to read the header from the first response, this
means that the request should be cancel with g_obex_cancel_req not with
g_obex_cancel_transfer.
---
 obexd/client/transfer.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index 6295b83..3564a34 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -80,6 +80,7 @@ struct obc_transfer {
 	char *name;		/* Transfer object name */
 	char *type;		/* Transfer object type */
 	int fd;
+	guint req;
 	guint xfer;
 	gint64 size;
 	gint64 transferred;
@@ -158,6 +159,14 @@ static DBusMessage *obc_transfer_cancel(DBusConnection *connection,
 				ERROR_INTERFACE ".InProgress",
 				"Cancellation already in progress");
 
+	if (transfer->req > 0) {
+		if (!g_obex_cancel_req(transfer->obex, transfer->req, TRUE))
+			return g_dbus_create_error(message,
+						ERROR_INTERFACE ".Failed",
+						"Failed");
+		transfer->req = 0;
+	}
+
 	if (transfer->xfer == 0) {
 		struct transfer_callback *callback = transfer->callback;
 
@@ -383,6 +392,9 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 {
 	DBG("%p", transfer);
 
+	if (transfer->req > 0)
+		g_obex_cancel_req(transfer->obex, transfer->req, TRUE);
+
 	if (transfer->xfer)
 		g_obex_cancel_transfer(transfer->xfer, NULL, NULL);
 
@@ -694,6 +706,8 @@ static void get_xfer_progress_first(GObex *obex, GError *err, GObexPacket *rsp,
 				transfer->status == TRANSFER_STATUS_SUSPENDED)
 		return;
 
+	transfer->req = 0;
+
 	req = g_obex_packet_new(G_OBEX_OP_GET, TRUE, G_OBEX_HDR_INVALID);
 
 	transfer->xfer = g_obex_get_req_pkt(obex, req, get_xfer_progress,
@@ -783,11 +797,11 @@ static gboolean transfer_start_get(struct obc_transfer *transfer, GError **err)
 		g_obex_packet_add_header(req, hdr);
 	}
 
-	transfer->xfer = g_obex_send_req(transfer->obex, req,
+	transfer->req = g_obex_send_req(transfer->obex, req,
 						FIRST_PACKET_TIMEOUT,
 						get_xfer_progress_first,
 						transfer, err);
-	if (transfer->xfer == 0)
+	if (transfer->req == 0)
 		return FALSE;
 
 	if (transfer->path == NULL)
-- 
1.8.5.3

