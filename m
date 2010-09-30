Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix not detecting errors on small files
Date: Thu, 30 Sep 2010 11:09:59 +0300
Message-Id: <1285834199-20500-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Make use of gw_obex_xfer_close instead of gw_obex_xfer_flush since the
former not only flushes the remaining data but also wait for the response
catching errors that gw_obex_xfer_flush doesn't.
---
 client/transfer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 8ceb36f..ea98b32 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -380,7 +380,7 @@ static void put_xfer_progress(GwObexXfer *xfer, gpointer user_data)
 		transfer->filled += len;
 
 		if (transfer->filled == 0) {
-			gw_obex_xfer_flush(xfer, &err);
+			gw_obex_xfer_close(xfer, &err);
 			goto done;
 		}
 
-- 
1.7.1

