Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 6/6 v4] client: Remove file in case of error
Date: Tue, 24 Apr 2012 15:03:15 +0300
Message-Id: <1335268995-20572-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1335268995-20572-1-git-send-email-luiz.dentz@gmail.com>
References: <1335268995-20572-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the transfer operation is GET and it has not complete by the time its
freed remove the file as its contents maybe corrupted/incomplete.
---
 client/transfer.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 5fcc35d..230f3ae 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -196,6 +196,10 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 	if (transfer->xfer)
 		g_obex_cancel_transfer(transfer->xfer);
 
+	if (transfer->op == G_OBEX_OP_GET &&
+					transfer->transferred != transfer->size)
+		remove(transfer->filename);
+
 	if (transfer->fd > 0)
 		close(transfer->fd);
 
-- 
1.7.7.6

