Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Convert hci_dev_list to use RCU instead of an rwlock
Date: Mon, 14 Jul 2014 16:28:57 +0300
Message-Id: <1405344537-31542-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since the HCI device list (hci_dev_list) is mostly accessed in a
read-only fashion we can make use of RCU instead of an rwlock to make
this access more efficient. This patch does the necessary changes to use
RCU for the hci_dev_list.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/a2mp.c             |  8 ++++----
 net/bluetooth/hci_conn.c         |  6 +++---
 net/bluetooth/hci_core.c         | 22 +++++++++-------------
 net/bluetooth/hci_sock.c         |  6 +++---
 net/bluetooth/l2cap_core.c       |  6 +++---
 net/bluetooth/mgmt.c             | 20 ++++++++++----------
 7 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b52c2ef3f56d..a26421ec7d99 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -463,7 +463,6 @@ struct hci_conn_params {
 
 extern struct list_head hci_dev_list;
 extern struct list_head hci_cb_list;
-extern rwlock_t hci_dev_list_lock;
 extern rwlock_t hci_cb_list_lock;
 
 /* ----- HCI interface to upper protocols ----- */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 5dcade511fdb..530d5140e1be 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -145,12 +145,12 @@ static int a2mp_discover_req(struct amp_mgr *mgr, struct sk_buff *skb,
 		skb_pull(skb, sizeof(ext_feat));
 	}
 
-	read_lock(&hci_dev_list_lock);
+	rcu_read_lock();
 
 	/* at minimum the BR/EDR needs to be listed */
 	num_ctrl = 1;
 
-	list_for_each_entry(hdev, &hci_dev_list, list) {
+	list_for_each_entry_rcu(hdev, &hci_dev_list, list) {
 		if (hdev->dev_type == HCI_AMP)
 			num_ctrl++;
 	}
@@ -158,7 +158,7 @@ static int a2mp_discover_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	len = num_ctrl * sizeof(struct a2mp_cl) + sizeof(*rsp);
 	rsp = kmalloc(len, GFP_ATOMIC);
 	if (!rsp) {
-		read_unlock(&hci_dev_list_lock);
+		rcu_read_unlock();
 		return -ENOMEM;
 	}
 
@@ -167,7 +167,7 @@ static int a2mp_discover_req(struct amp_mgr *mgr, struct sk_buff *skb,
 
 	__a2mp_add_cl(mgr, rsp->cl);
 
-	read_unlock(&hci_dev_list_lock);
+	rcu_read_unlock();
 
 	a2mp_send(mgr, A2MP_DISCOVER_RSP, hdr->ident, len, rsp);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 490ee8846d9e..19cfbc825c25 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -549,9 +549,9 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 
 	BT_DBG("%pMR -> %pMR", src, dst);
 
-	read_lock(&hci_dev_list_lock);
+	rcu_read_lock();
 
-	list_for_each_entry(d, &hci_dev_list, list) {
+	list_for_each_entry_rcu(d, &hci_dev_list, list) {
 		if (!test_bit(HCI_UP, &d->flags) ||
 		    test_bit(HCI_USER_CHANNEL, &d->dev_flags) ||
 		    d->dev_type != HCI_BREDR)
@@ -576,7 +576,7 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 	if (hdev)
 		hdev = hci_dev_hold(hdev);
 
-	read_unlock(&hci_dev_list_lock);
+	rcu_read_unlock();
 	return hdev;
 }
 EXPORT_SYMBOL(hci_get_route);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 172041e2b15a..ae96cf9bef6d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -45,7 +45,6 @@ static void hci_tx_work(struct work_struct *work);
 
 /* HCI device list */
 LIST_HEAD(hci_dev_list);
-DEFINE_RWLOCK(hci_dev_list_lock);
 
 /* HCI callback list */
 LIST_HEAD(hci_cb_list);
@@ -1918,14 +1917,14 @@ struct hci_dev *hci_dev_get(int index)
 	if (index < 0)
 		return NULL;
 
-	read_lock(&hci_dev_list_lock);
-	list_for_each_entry(d, &hci_dev_list, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(d, &hci_dev_list, list) {
 		if (d->id == index) {
 			hdev = hci_dev_hold(d);
 			break;
 		}
 	}
-	read_unlock(&hci_dev_list_lock);
+	rcu_read_unlock();
 	return hdev;
 }
 
@@ -2842,8 +2841,8 @@ int hci_get_dev_list(void __user *arg)
 
 	dr = dl->dev_req;
 
-	read_lock(&hci_dev_list_lock);
-	list_for_each_entry(hdev, &hci_dev_list, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(hdev, &hci_dev_list, list) {
 		unsigned long flags = hdev->flags;
 
 		/* When the auto-off is configured it means the transport
@@ -2859,7 +2858,7 @@ int hci_get_dev_list(void __user *arg)
 		if (++n >= dev_num)
 			break;
 	}
-	read_unlock(&hci_dev_list_lock);
+	rcu_read_unlock();
 
 	dl->dev_num = n;
 	size = sizeof(*dl) + n * sizeof(*dr);
@@ -4058,9 +4057,7 @@ int hci_register_dev(struct hci_dev *hdev)
 		set_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
 	}
 
-	write_lock(&hci_dev_list_lock);
-	list_add(&hdev->list, &hci_dev_list);
-	write_unlock(&hci_dev_list_lock);
+	list_add_rcu(&hdev->list, &hci_dev_list);
 
 	/* Devices that are marked for raw-only usage are unconfigured
 	 * and should not be included in normal operation.
@@ -4098,9 +4095,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	id = hdev->id;
 
-	write_lock(&hci_dev_list_lock);
-	list_del(&hdev->list);
-	write_unlock(&hci_dev_list_lock);
+	list_del_rcu(&hdev->list);
+	synchronize_rcu();
 
 	hci_dev_do_close(hdev);
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 115f149362ba..5e15fd7ff395 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -367,9 +367,9 @@ static void send_monitor_replay(struct sock *sk)
 {
 	struct hci_dev *hdev;
 
-	read_lock(&hci_dev_list_lock);
+	rcu_read_lock();
 
-	list_for_each_entry(hdev, &hci_dev_list, list) {
+	list_for_each_entry_rcu(hdev, &hci_dev_list, list) {
 		struct sk_buff *skb;
 
 		skb = create_monitor_event(hdev, HCI_DEV_REG);
@@ -380,7 +380,7 @@ static void send_monitor_replay(struct sock *sk)
 			kfree_skb(skb);
 	}
 
-	read_unlock(&hci_dev_list_lock);
+	rcu_read_unlock();
 }
 
 /* Generate internal stack event */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8538cb07b0c0..a0172f5868c8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1096,15 +1096,15 @@ static bool __amp_capable(struct l2cap_chan *chan)
 	if (!(conn->fixed_chan_mask & L2CAP_FC_A2MP))
 		return false;
 
-	read_lock(&hci_dev_list_lock);
-	list_for_each_entry(hdev, &hci_dev_list, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(hdev, &hci_dev_list, list) {
 		if (hdev->amp_type != AMP_TYPE_BREDR &&
 		    test_bit(HCI_UP, &hdev->flags)) {
 			amp_available = true;
 			break;
 		}
 	}
-	read_unlock(&hci_dev_list_lock);
+	rcu_read_unlock();
 
 	if (chan->chan_policy == BT_CHANNEL_POLICY_AMP_PREFERRED)
 		return amp_available;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7703b72653ff..d0ceeff66c81 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -367,10 +367,10 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("sock %p", sk);
 
-	read_lock(&hci_dev_list_lock);
+	rcu_read_lock();
 
 	count = 0;
-	list_for_each_entry(d, &hci_dev_list, list) {
+	list_for_each_entry_rcu(d, &hci_dev_list, list) {
 		if (d->dev_type == HCI_BREDR &&
 		    !test_bit(HCI_UNCONFIGURED, &d->dev_flags))
 			count++;
@@ -379,12 +379,12 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 	rp_len = sizeof(*rp) + (2 * count);
 	rp = kmalloc(rp_len, GFP_ATOMIC);
 	if (!rp) {
-		read_unlock(&hci_dev_list_lock);
+		rcu_read_unlock();
 		return -ENOMEM;
 	}
 
 	count = 0;
-	list_for_each_entry(d, &hci_dev_list, list) {
+	list_for_each_entry_rcu(d, &hci_dev_list, list) {
 		if (test_bit(HCI_SETUP, &d->dev_flags) ||
 		    test_bit(HCI_CONFIG, &d->dev_flags) ||
 		    test_bit(HCI_USER_CHANNEL, &d->dev_flags))
@@ -406,7 +406,7 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 	rp->num_controllers = cpu_to_le16(count);
 	rp_len = sizeof(*rp) + (2 * count);
 
-	read_unlock(&hci_dev_list_lock);
+	rcu_read_unlock();
 
 	err = cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_INDEX_LIST, 0, rp,
 			   rp_len);
@@ -427,10 +427,10 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("sock %p", sk);
 
-	read_lock(&hci_dev_list_lock);
+	rcu_read_lock();
 
 	count = 0;
-	list_for_each_entry(d, &hci_dev_list, list) {
+	list_for_each_entry_rcu(d, &hci_dev_list, list) {
 		if (d->dev_type == HCI_BREDR &&
 		    test_bit(HCI_UNCONFIGURED, &d->dev_flags))
 			count++;
@@ -439,12 +439,12 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 	rp_len = sizeof(*rp) + (2 * count);
 	rp = kmalloc(rp_len, GFP_ATOMIC);
 	if (!rp) {
-		read_unlock(&hci_dev_list_lock);
+		rcu_read_unlock();
 		return -ENOMEM;
 	}
 
 	count = 0;
-	list_for_each_entry(d, &hci_dev_list, list) {
+	list_for_each_entry_rcu(d, &hci_dev_list, list) {
 		if (test_bit(HCI_SETUP, &d->dev_flags) ||
 		    test_bit(HCI_CONFIG, &d->dev_flags) ||
 		    test_bit(HCI_USER_CHANNEL, &d->dev_flags))
@@ -466,7 +466,7 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 	rp->num_controllers = cpu_to_le16(count);
 	rp_len = sizeof(*rp) + (2 * count);
 
-	read_unlock(&hci_dev_list_lock);
+	rcu_read_unlock();
 
 	err = cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_UNCONF_INDEX_LIST,
 			   0, rp, rp_len);
-- 
1.9.3

