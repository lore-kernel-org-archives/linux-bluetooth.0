Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Convert link keys list to use RCU
Date: Wed, 19 Nov 2014 15:22:22 +0200
Message-Id: <1416403342-14715-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch converts the hdev->link_keys list to be protected through
RCU, thereby eliminating the need to hold the hdev lock while accessing
the list.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 37 ++++++++++++++++++-------------------
 net/bluetooth/hci_event.c        |  4 ++--
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a805b3d97c0b..396c09840fdf 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -130,6 +130,7 @@ struct smp_irk {
 
 struct link_key {
 	struct list_head list;
+	struct rcu_head rcu;
 	bdaddr_t bdaddr;
 	u8 type;
 	u8 val[HCI_LINK_KEY_SIZE];
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a67a4b8e4e1c..5c319a49a5a4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -274,15 +274,13 @@ static const struct file_operations inquiry_cache_fops = {
 static int link_keys_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
-	struct list_head *p, *n;
+	struct link_key *key;
 
-	hci_dev_lock(hdev);
-	list_for_each_safe(p, n, &hdev->link_keys) {
-		struct link_key *key = list_entry(p, struct link_key, list);
+	rcu_read_lock();
+	list_for_each_entry_rcu(key, &hdev->link_keys, list)
 		seq_printf(f, "%pMR %u %*phN %u\n", &key->bdaddr, key->type,
 			   HCI_LINK_KEY_SIZE, key->val, key->pin_len);
-	}
-	hci_dev_unlock(hdev);
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -3101,15 +3099,11 @@ void hci_uuids_clear(struct hci_dev *hdev)
 
 void hci_link_keys_clear(struct hci_dev *hdev)
 {
-	struct list_head *p, *n;
-
-	list_for_each_safe(p, n, &hdev->link_keys) {
-		struct link_key *key;
-
-		key = list_entry(p, struct link_key, list);
+	struct link_key *key;
 
-		list_del(p);
-		kfree(key);
+	list_for_each_entry_rcu(key, &hdev->link_keys, list) {
+		list_del_rcu(&key->list);
+		kfree_rcu(key, rcu);
 	}
 }
 
@@ -3137,9 +3131,14 @@ struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct link_key *k;
 
-	list_for_each_entry(k, &hdev->link_keys, list)
-		if (bacmp(bdaddr, &k->bdaddr) == 0)
+	rcu_read_lock();
+	list_for_each_entry_rcu(k, &hdev->link_keys, list) {
+		if (bacmp(bdaddr, &k->bdaddr) == 0) {
+			rcu_read_unlock();
 			return k;
+		}
+	}
+	rcu_read_unlock();
 
 	return NULL;
 }
@@ -3290,7 +3289,7 @@ struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
 		key = kzalloc(sizeof(*key), GFP_KERNEL);
 		if (!key)
 			return NULL;
-		list_add(&key->list, &hdev->link_keys);
+		list_add_rcu(&key->list, &hdev->link_keys);
 	}
 
 	BT_DBG("%s key for %pMR type %u", hdev->name, bdaddr, type);
@@ -3383,8 +3382,8 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 
 	BT_DBG("%s removing %pMR", hdev->name, bdaddr);
 
-	list_del(&key->list);
-	kfree(key);
+	list_del_rcu(&key->list);
+	kfree_rcu(key, rcu);
 
 	return 0;
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 54680fd39608..bd0a80120665 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3324,8 +3324,8 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	 */
 	if (key->type == HCI_LK_DEBUG_COMBINATION &&
 	    !test_bit(HCI_KEEP_DEBUG_KEYS, &hdev->dev_flags)) {
-		list_del(&key->list);
-		kfree(key);
+		list_del_rcu(&key->list);
+		kfree_rcu(key, rcu);
 	} else if (conn) {
 		if (persistent)
 			clear_bit(HCI_CONN_FLUSH_KEY, &conn->flags);
-- 
2.1.0

