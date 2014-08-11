Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/9] Bluetooth: Fix double free of SMP data skb
Date: Mon, 11 Aug 2014 22:06:39 +0300
Message-Id: <1407784004-12448-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407784004-12448-1-git-send-email-johan.hedberg@gmail.com>
References: <1407784004-12448-1-git-send-email-johan.hedberg@gmail.com>
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
 net/bluetooth/smp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 7a295d7edc44..5103dc739a17 100644
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

