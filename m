Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Cc: Christian Fetzer <christian.fetzer@bmw-carit.de>
Subject: [PATCH 8/8] obexd: Remove transferred file only if the GET operation failed
Date: Fri, 11 Jan 2013 16:55:57 +0100
Message-Id: <1357919757-10334-9-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1357919757-10334-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1357919757-10334-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

Since 9606375649e12f1b9f302bbb5bb8f87957387ddd xfer_complete() sets the
transfer status rather than the size. Adapt obc_transfer_free to check
for the completed status to avoid deletion of completed transfers.
---
 obexd/client/transfer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index 541f405..427eab7 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -327,7 +327,8 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 	}
 
 	if (transfer->op == G_OBEX_OP_GET &&
-					transfer->transferred != transfer->size)
+				transfer->status != TRANSFER_STATUS_COMPLETE &&
+				transfer->filename)
 		remove(transfer->filename);
 
 	if (transfer->fd > 0)
-- 
1.8.1

