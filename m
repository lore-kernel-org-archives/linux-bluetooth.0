Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] client: fix not being able to read apparams when transfer is complete
Date: Wed, 18 Jan 2012 13:37:37 +0200
Message-Id: <1326886657-10264-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Transfer id/xfer is set to zero when it is completed which should not
prevent the profiles to read the apparam of the last response.
---
 client/transfer.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index c481378..2532294 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -614,9 +614,6 @@ done:
 int obc_transfer_get_params(struct obc_transfer *transfer,
 					struct obc_transfer_params *params)
 {
-	if (transfer->xfer == 0)
-		return -ENOTCONN;
-
 	params->data = transfer->params->data;
 	params->size = transfer->params->size;
 
-- 
1.7.7.5

