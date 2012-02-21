Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 7/8] client: fix canceling queued transfers
Date: Tue, 21 Feb 2012 14:57:11 +0100
Message-Id: <1329832632-3681-8-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329832632-3681-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329832632-3681-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The Cancel() method in the D-Bus api should also abort queued transfers,
which should just be removed from the queue.
---
 client/transfer.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index b470a3a..dea9a2a 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -143,11 +143,15 @@ static void obc_transfer_abort(struct obc_transfer *transfer)
 {
 	struct transfer_callback *callback = transfer->callback;
 
-	if (transfer->xfer == 0)
-		return;
+	if (transfer->xfer != 0) {
+		g_obex_cancel_transfer(transfer->xfer);
+		transfer->xfer = 0;
+	}
 
-	g_obex_cancel_transfer(transfer->xfer);
-	transfer->xfer = 0;
+	if (transfer->obex != NULL) {
+		g_obex_unref(transfer->obex);
+		transfer->obex = NULL;
+	}
 
 	if (callback) {
 		GError *err;
-- 
1.7.6.5

