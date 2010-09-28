Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix not detecting errors when transferring the last part of the buffer
Date: Tue, 28 Sep 2010 10:52:25 +0300
Message-Id: <1285660345-1819-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

The last part has to be flushed in order to sent the remaining buffer as
a obex packet and detect possible errors.
---
 client/transfer.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 58ac265..8ceb36f 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -379,8 +379,10 @@ static void put_xfer_progress(GwObexXfer *xfer, gpointer user_data)
 
 		transfer->filled += len;
 
-		if (transfer->filled == 0)
+		if (transfer->filled == 0) {
+			gw_obex_xfer_flush(xfer, &err);
 			goto done;
+		}
 
 		if (gw_obex_xfer_write(xfer, transfer->buffer,
 					transfer->filled,
-- 
1.7.1

