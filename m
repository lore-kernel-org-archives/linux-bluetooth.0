Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH obexd 2/2] client: Call g_obex_abort_transfer() in
 obc_transfer_abort()
Date: Tue, 27 Mar 2012 16:03:45 +0530
Message-id: <1332844425-13766-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/transfer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 60c2e4f..f476680 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -144,7 +144,7 @@ static void obc_transfer_abort(struct obc_transfer *transfer)
 	struct transfer_callback *callback = transfer->callback;
 
 	if (transfer->xfer > 0) {
-		g_obex_cancel_transfer(transfer->xfer);
+		g_obex_abort_transfer(transfer->xfer);
 		transfer->xfer = 0;
 	}
 
-- 
1.7.1

