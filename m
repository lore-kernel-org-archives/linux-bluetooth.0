Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 02/22] Bluetooth: Replace spin_lock by mutex in hci_dev
Date: Sat, 17 Dec 2011 19:29:22 -0200
Message-Id: <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Now we run everything in HCI in process context, so it's a better idea use
mutex instead spin_lock. The macro remains hci_dev_lock() (and I got rid
of hci_dev_lock_bh()), of course.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/hci_core.h |    8 +--
 net/bluetooth/hci_conn.c         |   12 ++--
 net/bluetooth/hci_core.c         |   38 +++++++-------
 net/bluetooth/hci_sock.c         |    8 ++--
 net/bluetooth/hci_sysfs.c        |   20 ++++----
 net/bluetooth/hidp/core.c        |    4 +-
 net/bluetooth/l2cap_core.c       |    4 +-
 net/bluetooth/mgmt.c             |  104 +++++++++++++++++++-------------------
 net/bluetooth/sco.c              |    4 +-
 9 files changed, 100 insertions(+), 102 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1e28be4..e7dbe59 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -117,7 +117,7 @@ struct adv_entry {
 #define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
-	spinlock_t	lock;
+	struct mutex	lock;
 	atomic_t	refcnt;
 
 	char		name[8];
@@ -566,10 +566,8 @@ static inline struct hci_dev *hci_dev_hold(struct hci_dev *d)
 	return NULL;
 }
 
-#define hci_dev_lock(d)		spin_lock(&d->lock)
-#define hci_dev_unlock(d)	spin_unlock(&d->lock)
-#define hci_dev_lock_bh(d)	spin_lock_bh(&d->lock)
-#define hci_dev_unlock_bh(d)	spin_unlock_bh(&d->lock)
+#define hci_dev_lock(d)		mutex_lock(&d->lock)
+#define hci_dev_unlock(d)	mutex_unlock(&d->lock)
 
 struct hci_dev *hci_dev_get(int index);
 struct hci_dev *hci_get_route(bdaddr_t *src, bdaddr_t *dst);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3131a99..d45783d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -876,7 +876,7 @@ int hci_get_conn_list(void __user *arg)
 
 	ci = cl->conn_info;
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 	list_for_each_entry(c, &hdev->conn_hash.list, list) {
 		bacpy(&(ci + n)->bdaddr, &c->dst);
 		(ci + n)->handle = c->handle;
@@ -887,7 +887,7 @@ int hci_get_conn_list(void __user *arg)
 		if (++n >= req.conn_num)
 			break;
 	}
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 
 	cl->dev_id = hdev->id;
 	cl->conn_num = n;
@@ -911,7 +911,7 @@ int hci_get_conn_info(struct hci_dev *hdev, void __user *arg)
 	if (copy_from_user(&req, arg, sizeof(req)))
 		return -EFAULT;
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_ba(hdev, req.type, &req.bdaddr);
 	if (conn) {
 		bacpy(&ci.bdaddr, &conn->dst);
@@ -921,7 +921,7 @@ int hci_get_conn_info(struct hci_dev *hdev, void __user *arg)
 		ci.state = conn->state;
 		ci.link_mode = conn->link_mode;
 	}
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 
 	if (!conn)
 		return -ENOENT;
@@ -937,11 +937,11 @@ int hci_get_auth_info(struct hci_dev *hdev, void __user *arg)
 	if (copy_from_user(&req, arg, sizeof(req)))
 		return -EFAULT;
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &req.bdaddr);
 	if (conn)
 		req.type = conn->auth_type;
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 
 	if (!conn)
 		return -ENOENT;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 223809f..279074c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -433,14 +433,14 @@ int hci_inquiry(void __user *arg)
 	if (!hdev)
 		return -ENODEV;
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 	if (inquiry_cache_age(hdev) > INQUIRY_CACHE_AGE_MAX ||
 				inquiry_cache_empty(hdev) ||
 				ir.flags & IREQ_CACHE_FLUSH) {
 		inquiry_cache_flush(hdev);
 		do_inquiry = 1;
 	}
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 
 	timeo = ir.length * msecs_to_jiffies(2000);
 
@@ -462,9 +462,9 @@ int hci_inquiry(void __user *arg)
 		goto done;
 	}
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 	ir.num_rsp = inquiry_cache_dump(hdev, max_rsp, buf);
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 
 	BT_DBG("num_rsp %d", ir.num_rsp);
 
@@ -541,9 +541,9 @@ int hci_dev_open(__u16 dev)
 		set_bit(HCI_UP, &hdev->flags);
 		hci_notify(hdev, HCI_DEV_UP);
 		if (!test_bit(HCI_SETUP, &hdev->flags)) {
-			hci_dev_lock_bh(hdev);
+			hci_dev_lock(hdev);
 			mgmt_powered(hdev, 1);
-			hci_dev_unlock_bh(hdev);
+			hci_dev_unlock(hdev);
 		}
 	} else {
 		/* Init failed, cleanup */
@@ -597,10 +597,10 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->flags))
 		cancel_delayed_work(&hdev->power_off);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 	inquiry_cache_flush(hdev);
 	hci_conn_hash_flush(hdev);
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 
 	hci_notify(hdev, HCI_DEV_DOWN);
 
@@ -637,9 +637,9 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	 * and no tasks are scheduled. */
 	hdev->close(hdev);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 	mgmt_powered(hdev, 0);
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 
 	/* Clear flags */
 	hdev->flags = 0;
@@ -682,10 +682,10 @@ int hci_dev_reset(__u16 dev)
 	skb_queue_purge(&hdev->rx_q);
 	skb_queue_purge(&hdev->cmd_q);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 	inquiry_cache_flush(hdev);
 	hci_conn_hash_flush(hdev);
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 
 	if (hdev->flush)
 		hdev->flush(hdev);
@@ -968,13 +968,13 @@ static void hci_discov_off(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, sizeof(scan), &scan);
 
 	hdev->discov_timeout = 0;
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 }
 
 int hci_uuids_clear(struct hci_dev *hdev)
@@ -1444,7 +1444,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	list_add_tail(&hdev->list, head);
 
 	atomic_set(&hdev->refcnt, 1);
-	spin_lock_init(&hdev->lock);
+	mutex_init(&hdev->lock);
 
 	hdev->flags = 0;
 	hdev->dev_flags = 0;
@@ -1559,9 +1559,9 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	if (!test_bit(HCI_INIT, &hdev->flags) &&
 					!test_bit(HCI_SETUP, &hdev->flags)) {
-		hci_dev_lock_bh(hdev);
+		hci_dev_lock(hdev);
 		mgmt_index_removed(hdev);
-		hci_dev_unlock_bh(hdev);
+		hci_dev_unlock(hdev);
 	}
 
 	/* mgmt_index_removed should take care of emptying the
@@ -1581,13 +1581,13 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	destroy_workqueue(hdev->workqueue);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 	hci_blacklist_clear(hdev);
 	hci_uuids_clear(hdev);
 	hci_link_keys_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
 	hci_adv_entries_clear(hdev);
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 
 	__hci_dev_put(hdev);
 }
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index f6afe3d..399be34 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -188,11 +188,11 @@ static int hci_sock_blacklist_add(struct hci_dev *hdev, void __user *arg)
 	if (copy_from_user(&bdaddr, arg, sizeof(bdaddr)))
 		return -EFAULT;
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	err = hci_blacklist_add(hdev, &bdaddr);
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 
 	return err;
 }
@@ -205,11 +205,11 @@ static int hci_sock_blacklist_del(struct hci_dev *hdev, void __user *arg)
 	if (copy_from_user(&bdaddr, arg, sizeof(bdaddr)))
 		return -EFAULT;
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	err = hci_blacklist_del(hdev, &bdaddr);
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 
 	return err;
 }
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index f8e6aa3..c3c1ec8 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -402,7 +402,7 @@ static int inquiry_cache_show(struct seq_file *f, void *p)
 	struct inquiry_cache *cache = &hdev->inq_cache;
 	struct inquiry_entry *e;
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	for (e = cache->list; e; e = e->next) {
 		struct inquiry_data *data = &e->data;
@@ -415,7 +415,7 @@ static int inquiry_cache_show(struct seq_file *f, void *p)
 			   data->rssi, data->ssp_mode, e->timestamp);
 	}
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 
 	return 0;
 }
@@ -437,12 +437,12 @@ static int blacklist_show(struct seq_file *f, void *p)
 	struct hci_dev *hdev = f->private;
 	struct bdaddr_list *b;
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	list_for_each_entry(b, &hdev->blacklist, list)
 		seq_printf(f, "%s\n", batostr(&b->bdaddr));
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 
 	return 0;
 }
@@ -481,12 +481,12 @@ static int uuids_show(struct seq_file *f, void *p)
 	struct hci_dev *hdev = f->private;
 	struct bt_uuid *uuid;
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	list_for_each_entry(uuid, &hdev->uuids, list)
 		print_bt_uuid(f, uuid->uuid);
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 
 	return 0;
 }
@@ -507,11 +507,11 @@ static int auto_accept_delay_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	hdev->auto_accept_delay = val;
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 
 	return 0;
 }
@@ -520,11 +520,11 @@ static int auto_accept_delay_get(void *data, u64 *val)
 {
 	struct hci_dev *hdev = data;
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	*val = hdev->auto_accept_delay;
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 
 	return 0;
 }
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 3c2d888..d478be1 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -795,11 +795,11 @@ static struct hci_conn *hidp_get_connection(struct hidp_session *session)
 	if (!hdev)
 		return NULL;
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (conn)
 		hci_conn_hold_device(conn);
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 014fdec..0369a9b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1171,7 +1171,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan)
 	if (!hdev)
 		return -EHOSTUNREACH;
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	auth_type = l2cap_get_auth_type(chan);
 
@@ -1214,7 +1214,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan)
 	err = 0;
 
 done:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7a23f21..ad4817c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -257,7 +257,7 @@ static int read_controller_info(struct sock *sk, u16 index)
 	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->flags))
 		cancel_delayed_work_sync(&hdev->power_off);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	set_bit(HCI_MGMT, &hdev->flags);
 
@@ -286,7 +286,7 @@ static int read_controller_info(struct sock *sk, u16 index)
 
 	memcpy(rp.name, hdev->dev_name, sizeof(hdev->dev_name));
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return cmd_complete(sk, index, MGMT_OP_READ_INFO, &rp, sizeof(rp));
@@ -394,7 +394,7 @@ static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		return cmd_status(sk, index, MGMT_OP_SET_POWERED,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	up = test_bit(HCI_UP, &hdev->flags);
 	if ((cp->val && up) || (!cp->val && !up)) {
@@ -422,7 +422,7 @@ static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	err = 0;
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
 }
@@ -449,7 +449,7 @@ static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
 		return cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE,
@@ -492,7 +492,7 @@ static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
 		hdev->discov_timeout = get_unaligned_le16(&cp->timeout);
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -520,7 +520,7 @@ static int set_connectable(struct sock *sk, u16 index, unsigned char *data,
 		return cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE,
@@ -557,7 +557,7 @@ static int set_connectable(struct sock *sk, u16 index, unsigned char *data,
 		mgmt_pending_remove(cmd);
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -612,7 +612,7 @@ static int set_pairable(struct sock *sk, u16 index, unsigned char *data,
 		return cmd_status(sk, index, MGMT_OP_SET_PAIRABLE,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (cp->val)
 		set_bit(HCI_PAIRABLE, &hdev->flags);
@@ -628,7 +628,7 @@ static int set_pairable(struct sock *sk, u16 index, unsigned char *data,
 	err = mgmt_event(MGMT_EV_PAIRABLE, hdev, &ev, sizeof(ev), sk);
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -827,7 +827,7 @@ static int add_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		return cmd_status(sk, index, MGMT_OP_ADD_UUID,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	uuid = kmalloc(sizeof(*uuid), GFP_ATOMIC);
 	if (!uuid) {
@@ -851,7 +851,7 @@ static int add_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	err = cmd_complete(sk, index, MGMT_OP_ADD_UUID, NULL, 0);
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -878,7 +878,7 @@ static int remove_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		return cmd_status(sk, index, MGMT_OP_REMOVE_UUID,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (memcmp(cp->uuid, bt_uuid_any, 16) == 0) {
 		err = hci_uuids_clear(hdev);
@@ -914,7 +914,7 @@ static int remove_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	err = cmd_complete(sk, index, MGMT_OP_REMOVE_UUID, NULL, 0);
 
 unlock:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -940,7 +940,7 @@ static int set_dev_class(struct sock *sk, u16 index, unsigned char *data,
 		return cmd_status(sk, index, MGMT_OP_SET_DEV_CLASS,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	hdev->major_class = cp->major;
 	hdev->minor_class = cp->minor;
@@ -950,7 +950,7 @@ static int set_dev_class(struct sock *sk, u16 index, unsigned char *data,
 	if (err == 0)
 		err = cmd_complete(sk, index, MGMT_OP_SET_DEV_CLASS, NULL, 0);
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -974,7 +974,7 @@ static int set_service_cache(struct sock *sk, u16 index,  unsigned char *data,
 		return cmd_status(sk, index, MGMT_OP_SET_SERVICE_CACHE,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	BT_DBG("hci%u enable %d", index, cp->enable);
 
@@ -995,7 +995,7 @@ static int set_service_cache(struct sock *sk, u16 index,  unsigned char *data,
 		cmd_status(sk, index, MGMT_OP_SET_SERVICE_CACHE, -err);
 
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1034,7 +1034,7 @@ static int load_link_keys(struct sock *sk, u16 index, unsigned char *data,
 	BT_DBG("hci%u debug_keys %u key_count %u", index, cp->debug_keys,
 								key_count);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	hci_link_keys_clear(hdev);
 
@@ -1054,7 +1054,7 @@ static int load_link_keys(struct sock *sk, u16 index, unsigned char *data,
 
 	cmd_complete(sk, index, MGMT_OP_LOAD_LINK_KEYS, NULL, 0);
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return 0;
@@ -1082,7 +1082,7 @@ static int remove_keys(struct sock *sk, u16 index, unsigned char *data,
 		return cmd_status(sk, index, MGMT_OP_REMOVE_KEYS,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	memset(&rp, 0, sizeof(rp));
 	bacpy(&rp.bdaddr, &cp->bdaddr);
@@ -1123,7 +1123,7 @@ unlock:
 	if (err < 0)
 		err = cmd_complete(sk, index, MGMT_OP_REMOVE_KEYS, &rp,
 								sizeof(rp));
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1151,7 +1151,7 @@ static int disconnect(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		return cmd_status(sk, index, MGMT_OP_DISCONNECT,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_DISCONNECT,
@@ -1189,7 +1189,7 @@ static int disconnect(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		mgmt_pending_remove(cmd);
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1231,7 +1231,7 @@ static int get_connections(struct sock *sk, u16 index)
 		return cmd_status(sk, index, MGMT_OP_GET_CONNECTIONS,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	count = 0;
 	list_for_each(p, &hdev->conn_hash.list) {
@@ -1263,7 +1263,7 @@ static int get_connections(struct sock *sk, u16 index)
 
 unlock:
 	kfree(rp);
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
 }
@@ -1311,7 +1311,7 @@ static int pin_code_reply(struct sock *sk, u16 index, unsigned char *data,
 		return cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY,
@@ -1354,7 +1354,7 @@ static int pin_code_reply(struct sock *sk, u16 index, unsigned char *data,
 		mgmt_pending_remove(cmd);
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1380,7 +1380,7 @@ static int pin_code_neg_reply(struct sock *sk, u16 index, unsigned char *data,
 		return cmd_status(sk, index, MGMT_OP_PIN_CODE_NEG_REPLY,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_NEG_REPLY,
@@ -1391,7 +1391,7 @@ static int pin_code_neg_reply(struct sock *sk, u16 index, unsigned char *data,
 	err = send_pin_code_neg_reply(sk, index, hdev, cp);
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1416,14 +1416,14 @@ static int set_io_capability(struct sock *sk, u16 index, unsigned char *data,
 		return cmd_status(sk, index, MGMT_OP_SET_IO_CAPABILITY,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	hdev->io_capability = cp->io_capability;
 
 	BT_DBG("%s IO capability set to 0x%02x", hdev->name,
 							hdev->io_capability);
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return cmd_complete(sk, index, MGMT_OP_SET_IO_CAPABILITY, NULL, 0);
@@ -1504,7 +1504,7 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		return cmd_status(sk, index, MGMT_OP_PAIR_DEVICE,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	sec_level = BT_SECURITY_MEDIUM;
 	if (cp->io_cap == 0x03)
@@ -1561,7 +1561,7 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	err = 0;
 
 unlock:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1580,7 +1580,7 @@ static int user_pairing_resp(struct sock *sk, u16 index, bdaddr_t *bdaddr,
 		return cmd_status(sk, index, mgmt_op,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, mgmt_op, MGMT_STATUS_NOT_POWERED);
@@ -1631,7 +1631,7 @@ static int user_pairing_resp(struct sock *sk, u16 index, bdaddr_t *bdaddr,
 		mgmt_pending_remove(cmd);
 
 done:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1719,7 +1719,7 @@ static int set_local_name(struct sock *sk, u16 index, unsigned char *data,
 		return cmd_status(sk, index, MGMT_OP_SET_LOCAL_NAME,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LOCAL_NAME, hdev, data, len);
 	if (!cmd) {
@@ -1734,7 +1734,7 @@ static int set_local_name(struct sock *sk, u16 index, unsigned char *data,
 		mgmt_pending_remove(cmd);
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1753,7 +1753,7 @@ static int read_local_oob_data(struct sock *sk, u16 index)
 		return cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
@@ -1784,7 +1784,7 @@ static int read_local_oob_data(struct sock *sk, u16 index)
 		mgmt_pending_remove(cmd);
 
 unlock:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1808,7 +1808,7 @@ static int add_remote_oob_data(struct sock *sk, u16 index, unsigned char *data,
 		return cmd_status(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	err = hci_add_remote_oob_data(hdev, &cp->bdaddr, cp->hash,
 								cp->randomizer);
@@ -1819,7 +1819,7 @@ static int add_remote_oob_data(struct sock *sk, u16 index, unsigned char *data,
 		err = cmd_complete(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA, NULL,
 									0);
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1843,7 +1843,7 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 		return cmd_status(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	err = hci_remove_remote_oob_data(hdev, &cp->bdaddr);
 	if (err < 0)
@@ -1853,7 +1853,7 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 		err = cmd_complete(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
 								NULL, 0);
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1878,7 +1878,7 @@ static int start_discovery(struct sock *sk, u16 index,
 		return cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
@@ -1897,7 +1897,7 @@ static int start_discovery(struct sock *sk, u16 index,
 		mgmt_pending_remove(cmd);
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1916,7 +1916,7 @@ static int stop_discovery(struct sock *sk, u16 index)
 		return cmd_status(sk, index, MGMT_OP_STOP_DISCOVERY,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_STOP_DISCOVERY, hdev, NULL, 0);
 	if (!cmd) {
@@ -1929,7 +1929,7 @@ static int stop_discovery(struct sock *sk, u16 index)
 		mgmt_pending_remove(cmd);
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1953,7 +1953,7 @@ static int block_device(struct sock *sk, u16 index, unsigned char *data,
 		return cmd_status(sk, index, MGMT_OP_BLOCK_DEVICE,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	err = hci_blacklist_add(hdev, &cp->bdaddr);
 	if (err < 0)
@@ -1963,7 +1963,7 @@ static int block_device(struct sock *sk, u16 index, unsigned char *data,
 		err = cmd_complete(sk, index, MGMT_OP_BLOCK_DEVICE,
 							NULL, 0);
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1987,7 +1987,7 @@ static int unblock_device(struct sock *sk, u16 index, unsigned char *data,
 		return cmd_status(sk, index, MGMT_OP_UNBLOCK_DEVICE,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	err = hci_blacklist_del(hdev, &cp->bdaddr);
 
@@ -1998,7 +1998,7 @@ static int unblock_device(struct sock *sk, u16 index, unsigned char *data,
 		err = cmd_complete(sk, index, MGMT_OP_UNBLOCK_DEVICE,
 								NULL, 0);
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index a324b00..725e10d 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -189,7 +189,7 @@ static int sco_connect(struct sock *sk)
 	if (!hdev)
 		return -EHOSTUNREACH;
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (lmp_esco_capable(hdev) && !disable_esco)
 		type = ESCO_LINK;
@@ -225,7 +225,7 @@ static int sco_connect(struct sock *sk)
 	}
 
 done:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
 }
-- 
1.7.6.4

