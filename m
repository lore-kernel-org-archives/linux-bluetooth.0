Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Convert hci_dev_list_lock to a mutex
Date: Mon, 14 Jul 2014 13:29:00 +0300
Message-Id: <1405333740-1122-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are several places that are acquiring this lock that would benefit
from the ability to sleep. Since it's not a performance sensitive lock
simply convert it to a mutex to give more flexibility to its users.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/a2mp.c             |  6 +++---
 net/bluetooth/hci_conn.c         |  4 ++--
 net/bluetooth/hci_core.c         | 18 +++++++++---------
 net/bluetooth/hci_sock.c         |  4 ++--
 net/bluetooth/l2cap_core.c       |  4 ++--
 net/bluetooth/mgmt.c             | 12 ++++++------
 7 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b52c2ef3f56d..72495e8a1847 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -463,7 +463,7 @@ struct hci_conn_params {
 
 extern struct list_head hci_dev_list;
 extern struct list_head hci_cb_list;
-extern rwlock_t hci_dev_list_lock;
+extern struct mutex hci_dev_list_lock;
 extern rwlock_t hci_cb_list_lock;
 
 /* ----- HCI interface to upper protocols ----- */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 5dcade511fdb..a7af830ee4fc 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -145,7 +145,7 @@ static int a2mp_discover_req(struct amp_mgr *mgr, struct sk_buff *skb,
 		skb_pull(skb, sizeof(ext_feat));
 	}
 
-	read_lock(&hci_dev_list_lock);
+	mutex_lock(&hci_dev_list_lock);
 
 	/* at minimum the BR/EDR needs to be listed */
 	num_ctrl = 1;
@@ -158,7 +158,7 @@ static int a2mp_discover_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	len = num_ctrl * sizeof(struct a2mp_cl) + sizeof(*rsp);
 	rsp = kmalloc(len, GFP_ATOMIC);
 	if (!rsp) {
-		read_unlock(&hci_dev_list_lock);
+		mutex_unlock(&hci_dev_list_lock);
 		return -ENOMEM;
 	}
 
@@ -167,7 +167,7 @@ static int a2mp_discover_req(struct amp_mgr *mgr, struct sk_buff *skb,
 
 	__a2mp_add_cl(mgr, rsp->cl);
 
-	read_unlock(&hci_dev_list_lock);
+	mutex_unlock(&hci_dev_list_lock);
 
 	a2mp_send(mgr, A2MP_DISCOVER_RSP, hdr->ident, len, rsp);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 490ee8846d9e..6f24e1377749 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -549,7 +549,7 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 
 	BT_DBG("%pMR -> %pMR", src, dst);
 
-	read_lock(&hci_dev_list_lock);
+	mutex_lock(&hci_dev_list_lock);
 
 	list_for_each_entry(d, &hci_dev_list, list) {
 		if (!test_bit(HCI_UP, &d->flags) ||
@@ -576,7 +576,7 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 	if (hdev)
 		hdev = hci_dev_hold(hdev);
 
-	read_unlock(&hci_dev_list_lock);
+	mutex_unlock(&hci_dev_list_lock);
 	return hdev;
 }
 EXPORT_SYMBOL(hci_get_route);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 172041e2b15a..b5329d8ab7f9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -45,7 +45,7 @@ static void hci_tx_work(struct work_struct *work);
 
 /* HCI device list */
 LIST_HEAD(hci_dev_list);
-DEFINE_RWLOCK(hci_dev_list_lock);
+DEFINE_MUTEX(hci_dev_list_lock);
 
 /* HCI callback list */
 LIST_HEAD(hci_cb_list);
@@ -1918,14 +1918,14 @@ struct hci_dev *hci_dev_get(int index)
 	if (index < 0)
 		return NULL;
 
-	read_lock(&hci_dev_list_lock);
+	mutex_lock(&hci_dev_list_lock);
 	list_for_each_entry(d, &hci_dev_list, list) {
 		if (d->id == index) {
 			hdev = hci_dev_hold(d);
 			break;
 		}
 	}
-	read_unlock(&hci_dev_list_lock);
+	mutex_unlock(&hci_dev_list_lock);
 	return hdev;
 }
 
@@ -2842,7 +2842,7 @@ int hci_get_dev_list(void __user *arg)
 
 	dr = dl->dev_req;
 
-	read_lock(&hci_dev_list_lock);
+	mutex_lock(&hci_dev_list_lock);
 	list_for_each_entry(hdev, &hci_dev_list, list) {
 		unsigned long flags = hdev->flags;
 
@@ -2859,7 +2859,7 @@ int hci_get_dev_list(void __user *arg)
 		if (++n >= dev_num)
 			break;
 	}
-	read_unlock(&hci_dev_list_lock);
+	mutex_unlock(&hci_dev_list_lock);
 
 	dl->dev_num = n;
 	size = sizeof(*dl) + n * sizeof(*dr);
@@ -4058,9 +4058,9 @@ int hci_register_dev(struct hci_dev *hdev)
 		set_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
 	}
 
-	write_lock(&hci_dev_list_lock);
+	mutex_lock(&hci_dev_list_lock);
 	list_add(&hdev->list, &hci_dev_list);
-	write_unlock(&hci_dev_list_lock);
+	mutex_unlock(&hci_dev_list_lock);
 
 	/* Devices that are marked for raw-only usage are unconfigured
 	 * and should not be included in normal operation.
@@ -4098,9 +4098,9 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	id = hdev->id;
 
-	write_lock(&hci_dev_list_lock);
+	mutex_lock(&hci_dev_list_lock);
 	list_del(&hdev->list);
-	write_unlock(&hci_dev_list_lock);
+	mutex_unlock(&hci_dev_list_lock);
 
 	hci_dev_do_close(hdev);
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 115f149362ba..9695ec6e3945 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -367,7 +367,7 @@ static void send_monitor_replay(struct sock *sk)
 {
 	struct hci_dev *hdev;
 
-	read_lock(&hci_dev_list_lock);
+	mutex_lock(&hci_dev_list_lock);
 
 	list_for_each_entry(hdev, &hci_dev_list, list) {
 		struct sk_buff *skb;
@@ -380,7 +380,7 @@ static void send_monitor_replay(struct sock *sk)
 			kfree_skb(skb);
 	}
 
-	read_unlock(&hci_dev_list_lock);
+	mutex_unlock(&hci_dev_list_lock);
 }
 
 /* Generate internal stack event */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8538cb07b0c0..2ace2e2f9587 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1096,7 +1096,7 @@ static bool __amp_capable(struct l2cap_chan *chan)
 	if (!(conn->fixed_chan_mask & L2CAP_FC_A2MP))
 		return false;
 
-	read_lock(&hci_dev_list_lock);
+	mutex_lock(&hci_dev_list_lock);
 	list_for_each_entry(hdev, &hci_dev_list, list) {
 		if (hdev->amp_type != AMP_TYPE_BREDR &&
 		    test_bit(HCI_UP, &hdev->flags)) {
@@ -1104,7 +1104,7 @@ static bool __amp_capable(struct l2cap_chan *chan)
 			break;
 		}
 	}
-	read_unlock(&hci_dev_list_lock);
+	mutex_unlock(&hci_dev_list_lock);
 
 	if (chan->chan_policy == BT_CHANNEL_POLICY_AMP_PREFERRED)
 		return amp_available;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7703b72653ff..ef8376230f7f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -367,7 +367,7 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("sock %p", sk);
 
-	read_lock(&hci_dev_list_lock);
+	mutex_lock(&hci_dev_list_lock);
 
 	count = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
@@ -379,7 +379,7 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 	rp_len = sizeof(*rp) + (2 * count);
 	rp = kmalloc(rp_len, GFP_ATOMIC);
 	if (!rp) {
-		read_unlock(&hci_dev_list_lock);
+		mutex_unlock(&hci_dev_list_lock);
 		return -ENOMEM;
 	}
 
@@ -406,7 +406,7 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 	rp->num_controllers = cpu_to_le16(count);
 	rp_len = sizeof(*rp) + (2 * count);
 
-	read_unlock(&hci_dev_list_lock);
+	mutex_unlock(&hci_dev_list_lock);
 
 	err = cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_INDEX_LIST, 0, rp,
 			   rp_len);
@@ -427,7 +427,7 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("sock %p", sk);
 
-	read_lock(&hci_dev_list_lock);
+	mutex_lock(&hci_dev_list_lock);
 
 	count = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
@@ -439,7 +439,7 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 	rp_len = sizeof(*rp) + (2 * count);
 	rp = kmalloc(rp_len, GFP_ATOMIC);
 	if (!rp) {
-		read_unlock(&hci_dev_list_lock);
+		mutex_unlock(&hci_dev_list_lock);
 		return -ENOMEM;
 	}
 
@@ -466,7 +466,7 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 	rp->num_controllers = cpu_to_le16(count);
 	rp_len = sizeof(*rp) + (2 * count);
 
-	read_unlock(&hci_dev_list_lock);
+	mutex_unlock(&hci_dev_list_lock);
 
 	err = cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_UNCONF_INDEX_LIST,
 			   0, rp, rp_len);
-- 
1.9.3

