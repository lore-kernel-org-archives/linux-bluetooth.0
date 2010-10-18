Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Make use of transfer->err to store transfer errors
Date: Mon, 18 Oct 2010 17:18:47 +0300
Message-Id: <1287411529-5806-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 client/transfer.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index ea98b32..6eec513 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -360,7 +360,7 @@ static void put_xfer_progress(GwObexXfer *xfer, gpointer user_data)
 {
 	struct transfer_data *transfer = user_data;
 	struct transfer_callback *callback = transfer->callback;
-	gint written, err = 0;
+	gint written;
 
 	if (transfer->buffer_len == 0) {
 		transfer->buffer_len = DEFAULT_BUFFER_SIZE;
@@ -373,20 +373,20 @@ static void put_xfer_progress(GwObexXfer *xfer, gpointer user_data)
 		len = read(transfer->fd, transfer->buffer + transfer->filled,
 				transfer->buffer_len - transfer->filled);
 		if (len < 0) {
-			err = -errno;
+			transfer->err = -errno;
 			goto done;
 		}
 
 		transfer->filled += len;
 
 		if (transfer->filled == 0) {
-			gw_obex_xfer_close(xfer, &err);
+			gw_obex_xfer_close(xfer, &transfer->err);
 			goto done;
 		}
 
 		if (gw_obex_xfer_write(xfer, transfer->buffer,
 					transfer->filled,
-					&written, &err) == FALSE)
+					&written, &transfer->err) == FALSE)
 			goto done;
 
 		transfer->filled -= written;
@@ -397,7 +397,7 @@ static void put_xfer_progress(GwObexXfer *xfer, gpointer user_data)
 
 done:
 	if (callback)
-		callback->func(transfer, transfer->transferred, err,
+		callback->func(transfer, transfer->transferred, transfer->err,
 				callback->data);
 }
 
-- 
1.7.1

