Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/7] Bluetooth: Unify helpers for bdaddr_list manipulations
Date: Wed,  9 Jul 2014 11:43:06 +0300
Message-Id: <1404895392-12588-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404895392-12588-1-git-send-email-johan.hedberg@gmail.com>
References: <1404895392-12588-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We already have several lists with struct bdaddr_list entries, and there
will be more in the future. Since the operations for adding, removing,
looking up and clearing entries in these lists are exactly the same it
doesn't make sense to define new functions for every single list. This
patch unifies the functions by passing the list_head to them instead of
a hci_dev pointer.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 15 +++----
 net/bluetooth/hci_core.c         | 85 ++++++----------------------------------
 net/bluetooth/hci_event.c        | 15 ++++---
 net/bluetooth/hci_sock.c         |  4 +-
 net/bluetooth/l2cap_core.c       |  7 ++--
 net/bluetooth/mgmt.c             |  6 ++-
 6 files changed, 36 insertions(+), 96 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c98de309967e..3a1caf10cc8d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -849,16 +849,11 @@ int hci_get_conn_info(struct hci_dev *hdev, void __user *arg);
 int hci_get_auth_info(struct hci_dev *hdev, void __user *arg);
 int hci_inquiry(void __user *arg);
 
-struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev,
-					 bdaddr_t *bdaddr, u8 type);
-int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
-int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
-
-struct bdaddr_list *hci_white_list_lookup(struct hci_dev *hdev,
-					  bdaddr_t *bdaddr, u8 type);
-void hci_white_list_clear(struct hci_dev *hdev);
-int hci_white_list_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
-int hci_white_list_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
+struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *list,
+					   bdaddr_t *bdaddr, u8 type);
+int hci_bdaddr_list_add(struct list_head *list, bdaddr_t *bdaddr, u8 type);
+int hci_bdaddr_list_del(struct list_head *list, bdaddr_t *bdaddr, u8 type);
+void hci_bdaddr_list_clear(struct list_head *list);
 
 struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 					       bdaddr_t *addr, u8 addr_type);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 421faf5fa1f5..705f8df7af96 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3351,12 +3351,12 @@ int hci_add_remote_oob_ext_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	return 0;
 }
 
-struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev,
+struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *bdaddr_list,
 					 bdaddr_t *bdaddr, u8 type)
 {
 	struct bdaddr_list *b;
 
-	list_for_each_entry(b, &hdev->blacklist, list) {
+	list_for_each_entry(b, bdaddr_list, list) {
 		if (!bacmp(&b->bdaddr, bdaddr) && b->bdaddr_type == type)
 			return b;
 	}
@@ -3364,11 +3364,11 @@ struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev,
 	return NULL;
 }
 
-static void hci_blacklist_clear(struct hci_dev *hdev)
+void hci_bdaddr_list_clear(struct list_head *bdaddr_list)
 {
 	struct list_head *p, *n;
 
-	list_for_each_safe(p, n, &hdev->blacklist) {
+	list_for_each_safe(p, n, bdaddr_list) {
 		struct bdaddr_list *b = list_entry(p, struct bdaddr_list, list);
 
 		list_del(p);
@@ -3376,14 +3376,14 @@ static void hci_blacklist_clear(struct hci_dev *hdev)
 	}
 }
 
-int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
+int hci_bdaddr_list_add(struct list_head *list, bdaddr_t *bdaddr, u8 type)
 {
 	struct bdaddr_list *entry;
 
 	if (!bacmp(bdaddr, BDADDR_ANY))
 		return -EBADF;
 
-	if (hci_blacklist_lookup(hdev, bdaddr, type))
+	if (hci_bdaddr_list_lookup(list, bdaddr, type))
 		return -EEXIST;
 
 	entry = kzalloc(sizeof(struct bdaddr_list), GFP_KERNEL);
@@ -3393,82 +3393,21 @@ int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 	bacpy(&entry->bdaddr, bdaddr);
 	entry->bdaddr_type = type;
 
-	list_add(&entry->list, &hdev->blacklist);
+	list_add(&entry->list, list);
 
 	return 0;
 }
 
-int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
+int hci_bdaddr_list_del(struct list_head *list, bdaddr_t *bdaddr, u8 type)
 {
 	struct bdaddr_list *entry;
 
 	if (!bacmp(bdaddr, BDADDR_ANY)) {
-		hci_blacklist_clear(hdev);
+		hci_bdaddr_list_clear(list);
 		return 0;
 	}
 
-	entry = hci_blacklist_lookup(hdev, bdaddr, type);
-	if (!entry)
-		return -ENOENT;
-
-	list_del(&entry->list);
-	kfree(entry);
-
-	return 0;
-}
-
-struct bdaddr_list *hci_white_list_lookup(struct hci_dev *hdev,
-					  bdaddr_t *bdaddr, u8 type)
-{
-	struct bdaddr_list *b;
-
-	list_for_each_entry(b, &hdev->le_white_list, list) {
-		if (!bacmp(&b->bdaddr, bdaddr) && b->bdaddr_type == type)
-			return b;
-	}
-
-	return NULL;
-}
-
-void hci_white_list_clear(struct hci_dev *hdev)
-{
-	struct list_head *p, *n;
-
-	list_for_each_safe(p, n, &hdev->le_white_list) {
-		struct bdaddr_list *b = list_entry(p, struct bdaddr_list, list);
-
-		list_del(p);
-		kfree(b);
-	}
-}
-
-int hci_white_list_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
-{
-	struct bdaddr_list *entry;
-
-	if (!bacmp(bdaddr, BDADDR_ANY))
-		return -EBADF;
-
-	entry = kzalloc(sizeof(struct bdaddr_list), GFP_KERNEL);
-	if (!entry)
-		return -ENOMEM;
-
-	bacpy(&entry->bdaddr, bdaddr);
-	entry->bdaddr_type = type;
-
-	list_add(&entry->list, &hdev->le_white_list);
-
-	return 0;
-}
-
-int hci_white_list_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
-{
-	struct bdaddr_list *entry;
-
-	if (!bacmp(bdaddr, BDADDR_ANY))
-		return -EBADF;
-
-	entry = hci_white_list_lookup(hdev, bdaddr, type);
+	entry = hci_bdaddr_list_lookup(list, bdaddr, type);
 	if (!entry)
 		return -ENOENT;
 
@@ -4096,13 +4035,13 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	destroy_workqueue(hdev->req_workqueue);
 
 	hci_dev_lock(hdev);
-	hci_blacklist_clear(hdev);
+	hci_bdaddr_list_clear(&hdev->blacklist);
 	hci_uuids_clear(hdev);
 	hci_link_keys_clear(hdev);
 	hci_smp_ltks_clear(hdev);
 	hci_smp_irks_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
-	hci_white_list_clear(hdev);
+	hci_bdaddr_list_clear(&hdev->le_white_list);
 	hci_conn_params_clear_all(hdev);
 	hci_dev_unlock(hdev);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f6997901bdd7..381c631423f1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1222,7 +1222,7 @@ static void hci_cc_le_clear_white_list(struct hci_dev *hdev,
 	if (status)
 		return;
 
-	hci_white_list_clear(hdev);
+	hci_bdaddr_list_clear(&hdev->le_white_list);
 }
 
 static void hci_cc_le_add_to_white_list(struct hci_dev *hdev,
@@ -1240,7 +1240,8 @@ static void hci_cc_le_add_to_white_list(struct hci_dev *hdev,
 	if (!sent)
 		return;
 
-	hci_white_list_add(hdev, &sent->bdaddr, sent->bdaddr_type);
+	hci_bdaddr_list_add(&hdev->le_white_list, &sent->bdaddr,
+			   sent->bdaddr_type);
 }
 
 static void hci_cc_le_del_from_white_list(struct hci_dev *hdev,
@@ -1258,7 +1259,8 @@ static void hci_cc_le_del_from_white_list(struct hci_dev *hdev,
 	if (!sent)
 		return;
 
-	hci_white_list_del(hdev, &sent->bdaddr, sent->bdaddr_type);
+	hci_bdaddr_list_del(&hdev->le_white_list, &sent->bdaddr,
+			    sent->bdaddr_type);
 }
 
 static void hci_cc_le_read_supported_states(struct hci_dev *hdev,
@@ -2132,7 +2134,8 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 				      &flags);
 
 	if ((mask & HCI_LM_ACCEPT) &&
-	    !hci_blacklist_lookup(hdev, &ev->bdaddr, BDADDR_BREDR)) {
+	    !hci_bdaddr_list_lookup(&hdev->blacklist, &ev->bdaddr,
+				    BDADDR_BREDR)) {
 		/* Connection accepted */
 		struct inquiry_entry *ie;
 		struct hci_conn *conn;
@@ -4184,7 +4187,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		addr_type = BDADDR_LE_RANDOM;
 
 	/* Drop the connection if he device is blocked */
-	if (hci_blacklist_lookup(hdev, &conn->dst, addr_type)) {
+	if (hci_bdaddr_list_lookup(&hdev->blacklist, &conn->dst, addr_type)) {
 		hci_conn_drop(conn);
 		goto unlock;
 	}
@@ -4253,7 +4256,7 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 		return;
 
 	/* Ignore if the device is blocked */
-	if (hci_blacklist_lookup(hdev, addr, addr_type))
+	if (hci_bdaddr_list_lookup(&hdev->blacklist, addr, addr_type))
 		return;
 
 	/* If we're connectable, always connect any ADV_DIRECT_IND event */
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 802665751cc4..c64728d571ae 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -481,7 +481,7 @@ static int hci_sock_blacklist_add(struct hci_dev *hdev, void __user *arg)
 
 	hci_dev_lock(hdev);
 
-	err = hci_blacklist_add(hdev, &bdaddr, BDADDR_BREDR);
+	err = hci_bdaddr_list_add(&hdev->blacklist, &bdaddr, BDADDR_BREDR);
 
 	hci_dev_unlock(hdev);
 
@@ -498,7 +498,7 @@ static int hci_sock_blacklist_del(struct hci_dev *hdev, void __user *arg)
 
 	hci_dev_lock(hdev);
 
-	err = hci_blacklist_del(hdev, &bdaddr, BDADDR_BREDR);
+	err = hci_bdaddr_list_del(&hdev->blacklist, &bdaddr, BDADDR_BREDR);
 
 	hci_dev_unlock(hdev);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bf379a379fa0..d006e6c0e3b4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1460,6 +1460,7 @@ static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid,
 static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 {
 	struct hci_conn *hcon = conn->hcon;
+	struct hci_dev *hdev = hcon->hdev;
 	struct l2cap_chan *chan, *pchan;
 	u8 dst_type;
 
@@ -1478,7 +1479,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	dst_type = bdaddr_type(hcon, hcon->dst_type);
 
 	/* If device is blocked, do not create a channel for it */
-	if (hci_blacklist_lookup(hcon->hdev, &hcon->dst, dst_type))
+	if (hci_bdaddr_list_lookup(&hdev->blacklist, &hcon->dst, dst_type))
 		return;
 
 	/* For LE slave connections, make sure the connection interval
@@ -6918,8 +6919,8 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 	 * at least ensure that we ignore incoming data from them.
 	 */
 	if (hcon->type == LE_LINK &&
-	    hci_blacklist_lookup(hcon->hdev, &hcon->dst,
-				 bdaddr_type(hcon, hcon->dst_type))) {
+	    hci_bdaddr_list_lookup(&hcon->hdev->blacklist, &hcon->dst,
+				   bdaddr_type(hcon, hcon->dst_type))) {
 		kfree_skb(skb);
 		return;
 	}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 216aa93514b6..592e73eea76d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3956,7 +3956,8 @@ static int block_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	err = hci_blacklist_add(hdev, &cp->addr.bdaddr, cp->addr.type);
+	err = hci_bdaddr_list_add(&hdev->blacklist, &cp->addr.bdaddr,
+				  cp->addr.type);
 	if (err < 0) {
 		status = MGMT_STATUS_FAILED;
 		goto done;
@@ -3991,7 +3992,8 @@ static int unblock_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	err = hci_blacklist_del(hdev, &cp->addr.bdaddr, cp->addr.type);
+	err = hci_bdaddr_list_del(&hdev->blacklist, &cp->addr.bdaddr,
+				  cp->addr.type);
 	if (err < 0) {
 		status = MGMT_STATUS_INVALID_PARAMS;
 		goto done;
-- 
1.9.3

