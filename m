Return-Path: <cyrus@holtmann.org>
From: <ramm@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Ram Malovany <ramm@ti.com>
Subject: [PATCH] Bluetooth: Fix for double free of st buffer.
Date: Tue, 17 Jul 2012 10:49:30 +0300
Message-ID: <1342511370-26470-1-git-send-email-ramm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ram Malovany <ramm@ti.com>

When the Shared Transport line discipline driver (st_core) get data it
pushes the skb received to the relevant protocol stacks , it then
excepts that the relevant protocol stacks should handle the buffer ,
and if it cannot then the stack should respond with an error.
In our case the Bluetooth driver for shared transport (btwilink) should
always be able to handle the buffer , in case of an error it will
release it , thus we always should return 0.

Signed-off-by: Ram Malovany <ramm@ti.com>
---
 drivers/bluetooth/btwilink.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index 8869469..1f60d84 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -94,18 +94,22 @@ static void st_reg_completion_cb(void *priv_data, char data)
 }
 
 /* Called by Shared Transport layer when receive data is
- * available */
+ * available
+ * Return:
+ * 0 if buffer handled (affectivly allways even if error found)
+ * if return !=0 the buffer will be freed by the st
+ */
 static long st_receive(void *priv_data, struct sk_buff *skb)
 {
 	struct ti_st *lhst = priv_data;
 	int err;
 
 	if (!skb)
-		return -EFAULT;
+		return 0;
 
 	if (!lhst) {
 		kfree_skb(skb);
-		return -EFAULT;
+		return 0;
 	}
 
 	skb->dev = (void *) lhst->hdev;
@@ -114,7 +118,7 @@ static long st_receive(void *priv_data, struct sk_buff *skb)
 	err = hci_recv_frame(skb);
 	if (err < 0) {
 		BT_ERR("Unable to push skb to HCI core(%d)", err);
-		return err;
+		return 0;
 	}
 
 	lhst->hdev->stat.byte_rx += skb->len;
-- 
1.7.4.1

