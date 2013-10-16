Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Ignore SMP data on non-LE links
Date: Wed, 16 Oct 2013 11:37:01 +0300
Message-Id: <1381912621-10238-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1381912621-10238-1-git-send-email-johan.hedberg@gmail.com>
References: <1381912621-10238-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The SMP CID is only defined for LE transports. Instead of returning an
error from smp_sig_channel() in this case (which would cause a
disconnection) just return 0 to ignore the data, which is consistent
with the behavior for other unknown CIDs.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 463e50c..fc200e0 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -856,7 +856,7 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	if (hcon->type != LE_LINK) {
 		kfree_skb(skb);
-		return -ENOTSUPP;
+		return 0;
 	}
 
 	if (skb->len < 1) {
-- 
1.8.3.1

