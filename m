Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Convert IRK list to RCU
Date: Thu, 13 Nov 2014 14:37:48 +0200
Message-Id: <1415882270-5621-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1415882270-5621-1-git-send-email-johan.hedberg@gmail.com>
References: <1415882270-5621-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch set converts the hdev->identity_resolving_keys list to use
RCU to eliminate the need to use hci_dev_lock/unlock.

An additional change that must be done is to remove use of
CRYPTO_ALG_ASYNC for the hdev-specific AES crypto context. The reason is
that this context is used for matching RPAs and the loop that does the
matching is under the RCU read lock, i.e. is an atomic section which
cannot sleep.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 46 +++++++++++++++++++++++-----------------
 net/bluetooth/smp.c              | 10 ++++-----
 3 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a4adef22ad7c..fe2d5f299e12 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -121,6 +121,7 @@ struct smp_ltk {
 
 struct smp_irk {
 	struct list_head list;
+	struct rcu_head rcu;
 	bdaddr_t rpa;
 	bdaddr_t bdaddr;
 	u8 addr_type;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c9495fb9f595..90ea0b7670d2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -748,16 +748,15 @@ static const struct file_operations white_list_fops = {
 static int identity_resolving_keys_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
-	struct list_head *p, *n;
+	struct smp_irk *irk;
 
-	hci_dev_lock(hdev);
-	list_for_each_safe(p, n, &hdev->identity_resolving_keys) {
-		struct smp_irk *irk = list_entry(p, struct smp_irk, list);
+	rcu_read_lock();
+	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
 		seq_printf(f, "%pMR (type %u) %*phN %pMR\n",
 			   &irk->bdaddr, irk->addr_type,
 			   16, irk->val, &irk->rpa);
 	}
-	hci_dev_unlock(hdev);
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -3114,11 +3113,11 @@ void hci_smp_ltks_clear(struct hci_dev *hdev)
 
 void hci_smp_irks_clear(struct hci_dev *hdev)
 {
-	struct smp_irk *k, *tmp;
+	struct smp_irk *k;
 
-	list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_keys, list) {
-		list_del(&k->list);
-		kfree(k);
+	list_for_each_entry_rcu(k, &hdev->identity_resolving_keys, list) {
+		list_del_rcu(&k->list);
+		kfree_rcu(k, rcu);
 	}
 }
 
@@ -3221,17 +3220,22 @@ struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *rpa)
 {
 	struct smp_irk *irk;
 
-	list_for_each_entry(irk, &hdev->identity_resolving_keys, list) {
-		if (!bacmp(&irk->rpa, rpa))
+	rcu_read_lock();
+	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
+		if (!bacmp(&irk->rpa, rpa)) {
+			rcu_read_unlock();
 			return irk;
+		}
 	}
 
-	list_for_each_entry(irk, &hdev->identity_resolving_keys, list) {
+	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
 		if (smp_irk_matches(hdev, irk->val, rpa)) {
 			bacpy(&irk->rpa, rpa);
+			rcu_read_unlock();
 			return irk;
 		}
 	}
+	rcu_read_unlock();
 
 	return NULL;
 }
@@ -3245,11 +3249,15 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	if (addr_type == ADDR_LE_DEV_RANDOM && (bdaddr->b[5] & 0xc0) != 0xc0)
 		return NULL;
 
-	list_for_each_entry(irk, &hdev->identity_resolving_keys, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
 		if (addr_type == irk->addr_type &&
-		    bacmp(bdaddr, &irk->bdaddr) == 0)
+		    bacmp(bdaddr, &irk->bdaddr) == 0) {
+			rcu_read_unlock();
 			return irk;
+		}
 	}
+	rcu_read_unlock();
 
 	return NULL;
 }
@@ -3344,7 +3352,7 @@ struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		bacpy(&irk->bdaddr, bdaddr);
 		irk->addr_type = addr_type;
 
-		list_add(&irk->list, &hdev->identity_resolving_keys);
+		list_add_rcu(&irk->list, &hdev->identity_resolving_keys);
 	}
 
 	memcpy(irk->val, val, 16);
@@ -3390,16 +3398,16 @@ int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 
 void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type)
 {
-	struct smp_irk *k, *tmp;
+	struct smp_irk *k;
 
-	list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_keys, list) {
+	list_for_each_entry_rcu(k, &hdev->identity_resolving_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) || k->addr_type != addr_type)
 			continue;
 
 		BT_DBG("%s removing %pMR", hdev->name, bdaddr);
 
-		list_del(&k->list);
-		kfree(k);
+		list_del_rcu(&k->list);
+		kfree_rcu(k, rcu);
 	}
 }
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index fd2dfe5222bc..7b610f615257 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -393,8 +393,8 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 		}
 
 		if (smp->remote_irk) {
-			list_del(&smp->remote_irk->list);
-			kfree(smp->remote_irk);
+			list_del_rcu(&smp->remote_irk->list);
+			kfree_rcu(smp->remote_irk, rcu);
 		}
 	}
 
@@ -655,8 +655,8 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 		 * just remove it.
 		 */
 		if (!bacmp(&smp->remote_irk->rpa, BDADDR_ANY)) {
-			list_del(&smp->remote_irk->list);
-			kfree(smp->remote_irk);
+			list_del_rcu(&smp->remote_irk->list);
+			kfree_rcu(smp->remote_irk, rcu);
 			smp->remote_irk = NULL;
 		}
 	}
@@ -1696,7 +1696,7 @@ int smp_register(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
+	tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0, 0);
 	if (IS_ERR(tfm_aes)) {
 		int err = PTR_ERR(tfm_aes);
 		BT_ERR("Unable to create crypto context");
-- 
2.1.0

