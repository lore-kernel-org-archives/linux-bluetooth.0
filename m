Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 47/49] Bluetooth: Fix SMP debug key handling
Date: Wed,  3 Dec 2014 17:02:41 +0200
Message-Id: <1417618963-18010-48-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We need to keep debug keys around at least until the point that they are
used - otherwise e.g. slave role behavior wouldn't work as there'd be no
key to be looked up. The correct behavior should therefore be to return
any stored keys but when we clean up the SMP context to remove the key
from the hdev list if keeping debug keys around hasn't been requestsed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 10 +---------
 net/bluetooth/smp.c      | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c8123f04a33c..f0018562b028 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3246,15 +3246,7 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		if (addr_type != k->bdaddr_type || bacmp(bdaddr, &k->bdaddr))
 			continue;
 
-		if (smp_ltk_is_sc(k)) {
-			if (k->type == SMP_LTK_P256_DEBUG &&
-			    !test_bit(HCI_KEEP_DEBUG_KEYS, &hdev->dev_flags))
-				continue;
-			rcu_read_unlock();
-			return k;
-		}
-
-		if (ltk_role(k->type) == role) {
+		if (smp_ltk_is_sc(k) || ltk_role(k->type) == role) {
 			rcu_read_unlock();
 			return k;
 		}
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index c5dcb6563579..aeae4bed7ded 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -670,6 +670,7 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 {
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
+	struct hci_conn *hcon = conn->hcon;
 	bool complete;
 
 	BUG_ON(!smp);
@@ -677,7 +678,7 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 	cancel_delayed_work_sync(&smp->security_timer);
 
 	complete = test_bit(SMP_FLAG_COMPLETE, &smp->flags);
-	mgmt_smp_complete(conn->hcon, complete);
+	mgmt_smp_complete(hcon, complete);
 
 	kfree(smp->csrk);
 	kfree(smp->slave_csrk);
@@ -686,6 +687,16 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 	crypto_free_blkcipher(smp->tfm_aes);
 	crypto_free_hash(smp->tfm_cmac);
 
+	/* Ensure that we don't leave any debug key around if debug key
+	 * support hasn't been explicitly enabled.
+	 */
+	if (smp->ltk && smp->ltk->type == SMP_LTK_P256_DEBUG &&
+	    !test_bit(HCI_KEEP_DEBUG_KEYS, &hcon->hdev->dev_flags)) {
+		list_del_rcu(&smp->ltk->list);
+		kfree_rcu(smp->ltk, rcu);
+		smp->ltk = NULL;
+	}
+
 	/* If pairing failed clean up any keys we might have */
 	if (!complete) {
 		if (smp->ltk) {
@@ -706,7 +717,7 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 
 	chan->data = NULL;
 	kfree(smp);
-	hci_conn_drop(conn->hcon);
+	hci_conn_drop(hcon);
 }
 
 static void smp_failure(struct l2cap_conn *conn, u8 reason)
-- 
2.1.0

