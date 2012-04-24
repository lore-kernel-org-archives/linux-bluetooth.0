Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/6 v4] client: remove unused field
Date: Tue, 24 Apr 2012 15:03:11 +0300
Message-Id: <1335268995-20572-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1335268995-20572-1-git-send-email-luiz.dentz@gmail.com>
References: <1335268995-20572-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The errorcode field is set but never used, so it can safely be removed.
In addition there is no need for such a field, because errors can be
propagated using the available callback.
---
 client/transfer.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index f1cdbf0..1fa23c3 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -67,7 +67,6 @@ struct obc_transfer {
 	guint xfer;
 	gint64 size;
 	gint64 transferred;
-	int err;
 };
 
 static GQuark obc_transfer_error_quark(void)
@@ -288,10 +287,8 @@ static gboolean get_xfer_progress(const void *buf, gsize len,
 		gint w;
 
 		w = write(transfer->fd, buf, len);
-		if (w < 0) {
-			transfer->err = -errno;
+		if (w < 0)
 			return FALSE;
-		}
 
 		transfer->transferred += w;
 	}
@@ -310,10 +307,8 @@ static void xfer_complete(GObex *obex, GError *err, gpointer user_data)
 
 	transfer->xfer = 0;
 
-	if (err) {
-		transfer->err = err->code;
+	if (err)
 		goto done;
-	}
 
 	transfer->size = transfer->transferred;
 
@@ -390,10 +385,8 @@ static gssize put_xfer_progress(void *buf, gsize len, gpointer user_data)
 	gssize size;
 
 	size = read(transfer->fd, buf, len);
-	if (size <= 0) {
-		transfer->err = -errno;
+	if (size <= 0)
 		return size;
-	}
 
 	if (callback)
 		callback->func(transfer, transfer->transferred, NULL,
-- 
1.7.7.6

