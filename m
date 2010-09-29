Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix not detecting errors on small files
Date: Wed, 29 Sep 2010 17:27:36 +0300
Message-Id: <1285770456-8457-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

When flushing the last part of buffer/file we have to wait for response
since that can contain errors.

To fix this gw_obex_xfer_close is called in order to force gwobex to
resume the request and return any error related to it.
---
 client/transfer.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 8ceb36f..e5fcfcc 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -360,7 +360,7 @@ static void put_xfer_progress(GwObexXfer *xfer, gpointer user_data)
 {
 	struct transfer_data *transfer = user_data;
 	struct transfer_callback *callback = transfer->callback;
-	gint written, err = 0;
+	gint written = 0, err = 0;
 
 	if (transfer->buffer_len == 0) {
 		transfer->buffer_len = DEFAULT_BUFFER_SIZE;
@@ -380,7 +380,12 @@ static void put_xfer_progress(GwObexXfer *xfer, gpointer user_data)
 		transfer->filled += len;
 
 		if (transfer->filled == 0) {
-			gw_obex_xfer_flush(xfer, &err);
+			if (written > 0) {
+				gw_obex_xfer_flush(xfer, &err);
+				return;
+			}
+
+			gw_obex_xfer_close(xfer, &err);
 			goto done;
 		}
 
-- 
1.7.1

