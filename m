Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Remove unnecessary hdev locking in smp.c
Date: Thu, 13 Nov 2014 14:37:49 +0200
Message-Id: <1415882270-5621-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1415882270-5621-1-git-send-email-johan.hedberg@gmail.com>
References: <1415882270-5621-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that the SMP related key lists are converted to RCU there is nothing
in smp_cmd_sign_info() or smp_cmd_ident_addr_info() that would require
taking the hdev lock (including the smp_distribute_keys call). This
patch removes this unnecessary locking.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 7b610f615257..069b76e03b57 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1374,8 +1374,6 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 
 	skb_pull(skb, sizeof(*info));
 
-	hci_dev_lock(hcon->hdev);
-
 	/* Strictly speaking the Core Specification (4.1) allows sending
 	 * an empty address which would force us to rely on just the IRK
 	 * as "identity information". However, since such
@@ -1403,8 +1401,6 @@ distribute:
 	if (!(smp->remote_key_dist & KEY_DIST_MASK))
 		smp_distribute_keys(smp);
 
-	hci_dev_unlock(hcon->hdev);
-
 	return 0;
 }
 
@@ -1413,7 +1409,6 @@ static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_cmd_sign_info *rp = (void *) skb->data;
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
-	struct hci_dev *hdev = conn->hcon->hdev;
 	struct smp_csrk *csrk;
 
 	BT_DBG("conn %p", conn);
@@ -1426,7 +1421,6 @@ static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	skb_pull(skb, sizeof(*rp));
 
-	hci_dev_lock(hdev);
 	csrk = kzalloc(sizeof(*csrk), GFP_KERNEL);
 	if (csrk) {
 		csrk->master = 0x01;
@@ -1434,7 +1428,6 @@ static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	}
 	smp->csrk = csrk;
 	smp_distribute_keys(smp);
-	hci_dev_unlock(hdev);
 
 	return 0;
 }
-- 
2.1.0

