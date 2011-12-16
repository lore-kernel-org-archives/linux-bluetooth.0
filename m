Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 2/3] client: Add file flexibility for GET
Date: Fri, 16 Dec 2011 14:23:09 +0100
Message-Id: <1324041790-17559-2-git-send-email-bulislaw@linux.com>
In-Reply-To: <1324041790-17559-1-git-send-email-bulislaw@linux.com>
References: <1324041790-17559-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sometimes it would be useful to use file (and actually register transfer
object) instead of memory buffer for GET, even for OBEX specific mime
types (in some cases amount of data might be substantial eg. MAP
GetMessage).
---
 client/transfer.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 472a04d..03e2825 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -232,7 +232,7 @@ struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 	transfer->params = params;
 
 	/* for OBEX specific mime types we don't need to register a transfer */
-	if (type != NULL &&
+	if (type != NULL && name == NULL &&
 			(strncmp(type, "x-obex/", 7) == 0 ||
 			strncmp(type, "x-bt/", 5) == 0))
 		goto done;
@@ -510,7 +510,7 @@ int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
 	if (transfer->xfer != 0)
 		return -EALREADY;
 
-	if (transfer->type != NULL &&
+	if (transfer->type != NULL && transfer->name == NULL &&
 			(strncmp(transfer->type, "x-obex/", 7) == 0 ||
 			strncmp(transfer->type, "x-bt/", 5) == 0)) {
 		rsp_cb = get_buf_xfer_progress;
-- 
1.7.4.1

