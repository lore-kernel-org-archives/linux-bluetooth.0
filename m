Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Convert LTK list to RCU
Date: Thu, 13 Nov 2014 14:37:47 +0200
Message-Id: <1415882270-5621-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1415882270-5621-1-git-send-email-johan.hedberg@gmail.com>
References: <1415882270-5621-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch set converts the hdev->long_term_keys list to use RCU to
eliminate the need to use hci_dev_lock/unlock.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 42 +++++++++++++++++++++++-----------------
 net/bluetooth/hci_event.c        |  4 ++--
 net/bluetooth/smp.c              | 10 ++++------
 4 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4e39a5adfcab..a4adef22ad7c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -108,6 +108,7 @@ struct smp_csrk {
 
 struct smp_ltk {
 	struct list_head list;
+	struct rcu_head rcu;
 	bdaddr_t bdaddr;
 	u8 bdaddr_type;
 	u8 authenticated;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6c162c8809cf..c9495fb9f595 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -778,17 +778,15 @@ static const struct file_operations identity_resolving_keys_fops = {
 static int long_term_keys_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
-	struct list_head *p, *n;
+	struct smp_ltk *ltk;
 
-	hci_dev_lock(hdev);
-	list_for_each_safe(p, n, &hdev->long_term_keys) {
-		struct smp_ltk *ltk = list_entry(p, struct smp_ltk, list);
+	rcu_read_lock();
+	list_for_each_entry_rcu(ltk, &hdev->long_term_keys, list)
 		seq_printf(f, "%pMR (type %u) %u 0x%02x %u %.4x %.16llx %*phN\n",
 			   &ltk->bdaddr, ltk->bdaddr_type, ltk->authenticated,
 			   ltk->type, ltk->enc_size, __le16_to_cpu(ltk->ediv),
 			   __le64_to_cpu(ltk->rand), 16, ltk->val);
-	}
-	hci_dev_unlock(hdev);
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -3106,11 +3104,11 @@ void hci_link_keys_clear(struct hci_dev *hdev)
 
 void hci_smp_ltks_clear(struct hci_dev *hdev)
 {
-	struct smp_ltk *k, *tmp;
+	struct smp_ltk *k;
 
-	list_for_each_entry_safe(k, tmp, &hdev->long_term_keys, list) {
-		list_del(&k->list);
-		kfree(k);
+	list_for_each_entry_rcu(k, &hdev->long_term_keys, list) {
+		list_del_rcu(&k->list);
+		kfree_rcu(k, rcu);
 	}
 }
 
@@ -3184,15 +3182,18 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, __le64 rand,
 {
 	struct smp_ltk *k;
 
-	list_for_each_entry(k, &hdev->long_term_keys, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(k, &hdev->long_term_keys, list) {
 		if (k->ediv != ediv || k->rand != rand)
 			continue;
 
 		if (ltk_role(k->type) != role)
 			continue;
 
+		rcu_read_unlock();
 		return k;
 	}
+	rcu_read_unlock();
 
 	return NULL;
 }
@@ -3202,11 +3203,16 @@ struct smp_ltk *hci_find_ltk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 {
 	struct smp_ltk *k;
 
-	list_for_each_entry(k, &hdev->long_term_keys, list)
+	rcu_read_lock();
+	list_for_each_entry_rcu(k, &hdev->long_term_keys, list) {
 		if (addr_type == k->bdaddr_type &&
 		    bacmp(bdaddr, &k->bdaddr) == 0 &&
-		    ltk_role(k->type) == role)
+		    ltk_role(k->type) == role) {
+			rcu_read_unlock();
 			return k;
+		}
+	}
+	rcu_read_unlock();
 
 	return NULL;
 }
@@ -3309,7 +3315,7 @@ struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		key = kzalloc(sizeof(*key), GFP_KERNEL);
 		if (!key)
 			return NULL;
-		list_add(&key->list, &hdev->long_term_keys);
+		list_add_rcu(&key->list, &hdev->long_term_keys);
 	}
 
 	bacpy(&key->bdaddr, bdaddr);
@@ -3365,17 +3371,17 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 {
-	struct smp_ltk *k, *tmp;
+	struct smp_ltk *k;
 	int removed = 0;
 
-	list_for_each_entry_safe(k, tmp, &hdev->long_term_keys, list) {
+	list_for_each_entry_rcu(k, &hdev->long_term_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) || k->bdaddr_type != bdaddr_type)
 			continue;
 
 		BT_DBG("%s removing %pMR", hdev->name, bdaddr);
 
-		list_del(&k->list);
-		kfree(k);
+		list_del_rcu(&k->list);
+		kfree_rcu(k, rcu);
 		removed++;
 	}
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index aec3b1dce1cc..09d76547d985 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4578,8 +4578,8 @@ static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	 */
 	if (ltk->type == SMP_STK) {
 		set_bit(HCI_CONN_STK_ENCRYPT, &conn->flags);
-		list_del(&ltk->list);
-		kfree(ltk);
+		list_del_rcu(&ltk->list);
+		kfree_rcu(ltk, rcu);
 	} else {
 		clear_bit(HCI_CONN_STK_ENCRYPT, &conn->flags);
 	}
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 3dc5f0e66405..fd2dfe5222bc 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -383,13 +383,13 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 	/* If pairing failed clean up any keys we might have */
 	if (!complete) {
 		if (smp->ltk) {
-			list_del(&smp->ltk->list);
-			kfree(smp->ltk);
+			list_del_rcu(&smp->ltk->list);
+			kfree_rcu(smp->ltk, rcu);
 		}
 
 		if (smp->slave_ltk) {
-			list_del(&smp->slave_ltk->list);
-			kfree(smp->slave_ltk);
+			list_del_rcu(&smp->slave_ltk->list);
+			kfree_rcu(smp->slave_ltk, rcu);
 		}
 
 		if (smp->remote_irk) {
@@ -1321,7 +1321,6 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	skb_pull(skb, sizeof(*rp));
 
-	hci_dev_lock(hdev);
 	authenticated = (hcon->sec_level == BT_SECURITY_HIGH);
 	ltk = hci_add_ltk(hdev, &hcon->dst, hcon->dst_type, SMP_LTK,
 			  authenticated, smp->tk, smp->enc_key_size,
@@ -1329,7 +1328,6 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 	smp->ltk = ltk;
 	if (!(smp->remote_key_dist & KEY_DIST_MASK))
 		smp_distribute_keys(smp);
-	hci_dev_unlock(hdev);
 
 	return 0;
 }
-- 
2.1.0

