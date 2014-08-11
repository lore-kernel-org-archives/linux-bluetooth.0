Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix double free of SMP data skb
Date: Mon, 11 Aug 2014 15:35:28 +0300
Message-Id: <1407760528-25463-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In the case that the SMP recv callback returns error the calling code in
l2cap_core.c expects that it still owns the skb and will try to free it.
The SMP code should therefore not try to free the skb if it return an
error. This patch fixes such behavior in the SMP command handler
function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
This patch should probably get Cc: stable, however it should only be
applied after my "[PATCH 0/3] Some more SMP fixes" patch set. The reason
I ordered these like this is for this patch to have the familiar
smp_sig_channel function name to ease backporting.

 net/bluetooth/smp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 470604d8b16f..1aa06947af7e 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1387,10 +1387,8 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 		return 0;
 	}
 
-	if (skb->len < 1) {
-		kfree_skb(skb);
+	if (skb->len < 1)
 		return -EILSEQ;
-	}
 
 	if (!test_bit(HCI_LE_ENABLED, &hcon->hdev->dev_flags)) {
 		err = -EOPNOTSUPP;
@@ -1410,8 +1408,9 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 	if (code != SMP_CMD_PAIRING_REQ && code != SMP_CMD_SECURITY_REQ &&
 	    !test_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags)) {
 		BT_ERR("Unexpected SMP command 0x%02x. Disconnecting.", code);
-		kfree_skb(skb);
-		return -EOPNOTSUPP;
+		reason = SMP_CMD_NOTSUPP;
+		err = -EOPNOTSUPP;
+		goto done;
 	}
 
 	switch (code) {
@@ -1472,8 +1471,8 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 done:
 	if (reason)
 		smp_failure(conn, reason);
-
-	kfree_skb(skb);
+	if (!err)
+		kfree_skb(skb);
 	return err;
 }
 
-- 
1.9.3

