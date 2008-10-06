Return-Path: <cyrus@holtmann.org>
From: Tomas Winkler <tomas.winkler@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH V2] btsdio: fix tx error path
Date: Mon,  6 Oct 2008 13:40:23 +0200
Message-Id: <1223293223-21162-1-git-send-email-tomas.winkler@intel.com>
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes accumulating of the header
in case packet was requeued in the error path.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btsdio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 58630cc..c422e89 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -91,6 +91,7 @@ static int btsdio_tx_packet(struct btsdio_data *data, struct sk_buff *skb)
 
 	err = sdio_writesb(data->func, REG_TDAT, skb->data, skb->len);
 	if (err < 0) {
+		skb_pull(skb, 4);
 		sdio_writeb(data->func, 0x01, REG_PC_WRT, NULL);
 		return err;
 	}
-- 
1.5.4.3

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
