Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] bluetooth: replace list_for_each with list_for_each_entry whenever possible
Date: Tue,  1 Nov 2011 10:58:56 +0200
Message-Id: <1320137942-25780-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When all items in the list have the same type there is no much of a point
to use list_for_each except if you want to use the list pointer itself.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/bnep/core.c   |   13 +++--------
 net/bluetooth/cmtp/core.c   |   13 +++--------
 net/bluetooth/hci_conn.c    |   14 +++---------
 net/bluetooth/hci_core.c    |   46 +++++++++++-------------------------------
 net/bluetooth/hci_sysfs.c   |   18 +++-------------
 net/bluetooth/hidp/core.c   |    1 +
 net/bluetooth/mgmt.c        |   32 +++++++++--------------------
 net/bluetooth/rfcomm/core.c |   14 ++++--------
 net/bluetooth/rfcomm/tty.c  |   20 ++++++------------
 9 files changed, 51 insertions(+), 120 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 91bcd3a..a6cd856 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -65,15 +65,13 @@ static DECLARE_RWSEM(bnep_session_sem);
 static struct bnep_session *__bnep_get_session(u8 *dst)
 {
 	struct bnep_session *s;
-	struct list_head *p;
 
 	BT_DBG("");
 
-	list_for_each(p, &bnep_session_list) {
-		s = list_entry(p, struct bnep_session, list);
+	list_for_each_entry(s, &bnep_session_list, list)
 		if (!compare_ether_addr(dst, s->eh.h_source))
 			return s;
-	}
+
 	return NULL;
 }
 
@@ -667,17 +665,14 @@ static void __bnep_copy_ci(struct bnep_conninfo *ci, struct bnep_session *s)
 
 int bnep_get_connlist(struct bnep_connlist_req *req)
 {
-	struct list_head *p;
+	struct bnep_session *s;
 	int err = 0, n = 0;
 
 	down_read(&bnep_session_sem);
 
-	list_for_each(p, &bnep_session_list) {
-		struct bnep_session *s;
+	list_for_each_entry(s, &bnep_session_list, list) {
 		struct bnep_conninfo ci;
 
-		s = list_entry(p, struct bnep_session, list);
-
 		__bnep_copy_ci(&ci, s);
 
 		if (copy_to_user(req->ci, &ci, sizeof(ci))) {
diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index 7d00ddf..9e8940b 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -53,15 +53,13 @@ static LIST_HEAD(cmtp_session_list);
 static struct cmtp_session *__cmtp_get_session(bdaddr_t *bdaddr)
 {
 	struct cmtp_session *session;
-	struct list_head *p;
 
 	BT_DBG("");
 
-	list_for_each(p, &cmtp_session_list) {
-		session = list_entry(p, struct cmtp_session, list);
+	list_for_each_entry(session, &cmtp_session_list, list)
 		if (!bacmp(bdaddr, &session->bdaddr))
 			return session;
-	}
+
 	return NULL;
 }
 
@@ -431,19 +429,16 @@ int cmtp_del_connection(struct cmtp_conndel_req *req)
 
 int cmtp_get_connlist(struct cmtp_connlist_req *req)
 {
-	struct list_head *p;
+	struct cmtp_session *session;
 	int err = 0, n = 0;
 
 	BT_DBG("");
 
 	down_read(&cmtp_session_sem);
 
-	list_for_each(p, &cmtp_session_list) {
-		struct cmtp_session *session;
+	list_for_each_entry(session, &cmtp_session_list, list) {
 		struct cmtp_conninfo ci;
 
-		session = list_entry(p, struct cmtp_session, list);
-
 		__cmtp_copy_session(session, &ci);
 
 		if (copy_to_user(req->ci, &ci, sizeof(ci))) {
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c1c597e..6e98ff3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -453,16 +453,13 @@ int hci_conn_del(struct hci_conn *conn)
 struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 {
 	int use_src = bacmp(src, BDADDR_ANY);
-	struct hci_dev *hdev = NULL;
-	struct list_head *p;
+	struct hci_dev *hdev = NULL, *d;
 
 	BT_DBG("%s -> %s", batostr(src), batostr(dst));
 
 	read_lock_bh(&hci_dev_list_lock);
 
-	list_for_each(p, &hci_dev_list) {
-		struct hci_dev *d = list_entry(p, struct hci_dev, list);
-
+	list_for_each_entry(d, &hci_dev_list, list) {
 		if (!test_bit(HCI_UP, &d->flags) || test_bit(HCI_RAW, &d->flags))
 			continue;
 
@@ -855,10 +852,10 @@ EXPORT_SYMBOL(hci_conn_put_device);
 
 int hci_get_conn_list(void __user *arg)
 {
+	register struct hci_conn *c;
 	struct hci_conn_list_req req, *cl;
 	struct hci_conn_info *ci;
 	struct hci_dev *hdev;
-	struct list_head *p;
 	int n = 0, size, err;
 
 	if (copy_from_user(&req, arg, sizeof(req)))
@@ -882,10 +879,7 @@ int hci_get_conn_list(void __user *arg)
 	ci = cl->conn_info;
 
 	hci_dev_lock_bh(hdev);
-	list_for_each(p, &hdev->conn_hash.list) {
-		register struct hci_conn *c;
-		c = list_entry(p, struct hci_conn, list);
-
+	list_for_each_entry(c, &hdev->conn_hash.list, list) {
 		bacpy(&(ci + n)->bdaddr, &c->dst);
 		(ci + n)->handle = c->handle;
 		(ci + n)->type  = c->type;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fdcbf8f..412082d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -319,8 +319,7 @@ static void hci_linkpol_req(struct hci_dev *hdev, unsigned long opt)
  * Device is held on return. */
 struct hci_dev *hci_dev_get(int index)
 {
-	struct hci_dev *hdev = NULL;
-	struct list_head *p;
+	struct hci_dev *hdev = NULL, *d;
 
 	BT_DBG("%d", index);
 
@@ -328,8 +327,7 @@ struct hci_dev *hci_dev_get(int index)
 		return NULL;
 
 	read_lock(&hci_dev_list_lock);
-	list_for_each(p, &hci_dev_list) {
-		struct hci_dev *d = list_entry(p, struct hci_dev, list);
+	list_for_each_entry(d, &hci_dev_list, list) {
 		if (d->id == index) {
 			hdev = hci_dev_hold(d);
 			break;
@@ -794,9 +792,9 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 
 int hci_get_dev_list(void __user *arg)
 {
+	struct hci_dev *hdev;
 	struct hci_dev_list_req *dl;
 	struct hci_dev_req *dr;
-	struct list_head *p;
 	int n = 0, size, err;
 	__u16 dev_num;
 
@@ -815,11 +813,7 @@ int hci_get_dev_list(void __user *arg)
 	dr = dl->dev_req;
 
 	read_lock_bh(&hci_dev_list_lock);
-	list_for_each(p, &hci_dev_list) {
-		struct hci_dev *hdev;
-
-		hdev = list_entry(p, struct hci_dev, list);
-
+	list_for_each_entry(hdev, &hci_dev_list, list) {
 		hci_del_off_timer(hdev);
 
 		if (!test_bit(HCI_MGMT, &hdev->flags))
@@ -1008,16 +1002,11 @@ int hci_link_keys_clear(struct hci_dev *hdev)
 
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
-	struct list_head *p;
-
-	list_for_each(p, &hdev->link_keys) {
-		struct link_key *k;
-
-		k = list_entry(p, struct link_key, list);
+	struct link_key *k;
 
+	list_for_each_entry(k, &hdev->link_keys, list)
 		if (bacmp(bdaddr, &k->bdaddr) == 0)
 			return k;
-	}
 
 	return NULL;
 }
@@ -1280,16 +1269,11 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev,
 						bdaddr_t *bdaddr)
 {
-	struct list_head *p;
-
-	list_for_each(p, &hdev->blacklist) {
-		struct bdaddr_list *b;
-
-		b = list_entry(p, struct bdaddr_list, list);
+	struct bdaddr_list *b;
 
+	list_for_each_entry(b, &hdev->blacklist, list)
 		if (bacmp(bdaddr, &b->bdaddr) == 0)
 			return b;
-	}
 
 	return NULL;
 }
@@ -2033,16 +2017,12 @@ EXPORT_SYMBOL(hci_send_sco);
 static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int *quote)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct hci_conn *conn = NULL;
+	struct hci_conn *conn = NULL, *c;
 	int num = 0, min = ~0;
-	struct list_head *p;
 
 	/* We don't have to lock device here. Connections are always
 	 * added and removed with TX task disabled. */
-	list_for_each(p, &h->list) {
-		struct hci_conn *c;
-		c = list_entry(p, struct hci_conn, list);
-
+	list_for_each_entry(c, &h->list, list) {
 		if (c->type != type || skb_queue_empty(&c->data_q))
 			continue;
 
@@ -2091,14 +2071,12 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int
 static inline void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct list_head *p;
-	struct hci_conn  *c;
+	struct hci_conn *c;
 
 	BT_ERR("%s link tx timeout", hdev->name);
 
 	/* Kill stalled connections */
-	list_for_each(p, &h->list) {
-		c = list_entry(p, struct hci_conn, list);
+	list_for_each_entry(c, &h->list, list) {
 		if (c->type == type && c->sent) {
 			BT_ERR("%s killing stalled connection %s",
 				hdev->name, batostr(&c->dst));
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 1f9f876..f8e6aa3 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -435,17 +435,12 @@ static const struct file_operations inquiry_cache_fops = {
 static int blacklist_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
-	struct list_head *l;
+	struct bdaddr_list *b;
 
 	hci_dev_lock_bh(hdev);
 
-	list_for_each(l, &hdev->blacklist) {
-		struct bdaddr_list *b;
-
-		b = list_entry(l, struct bdaddr_list, list);
-
+	list_for_each_entry(b, &hdev->blacklist, list)
 		seq_printf(f, "%s\n", batostr(&b->bdaddr));
-	}
 
 	hci_dev_unlock_bh(hdev);
 
@@ -484,17 +479,12 @@ static void print_bt_uuid(struct seq_file *f, u8 *uuid)
 static int uuids_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
-	struct list_head *l;
+	struct bt_uuid *uuid;
 
 	hci_dev_lock_bh(hdev);
 
-	list_for_each(l, &hdev->uuids) {
-		struct bt_uuid *uuid;
-
-		uuid = list_entry(l, struct bt_uuid, list);
-
+	list_for_each_entry(uuid, &hdev->uuids, list)
 		print_bt_uuid(f, uuid->uuid);
-	}
 
 	hci_dev_unlock_bh(hdev);
 
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 217ef47..2efd6cc 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -88,6 +88,7 @@ static struct hidp_session *__hidp_get_session(bdaddr_t *bdaddr)
 		if (!bacmp(bdaddr, &session->bdaddr))
 			return session;
 	}
+
 	return NULL;
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9ffd7c3..7809aa9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -123,6 +123,7 @@ static int read_index_list(struct sock *sk)
 {
 	struct mgmt_rp_read_index_list *rp;
 	struct list_head *p;
+	struct hci_dev *d;
 	size_t rp_len;
 	u16 count;
 	int i, err;
@@ -146,9 +147,7 @@ static int read_index_list(struct sock *sk)
 	put_unaligned_le16(count, &rp->num_controllers);
 
 	i = 0;
-	list_for_each(p, &hci_dev_list) {
-		struct hci_dev *d = list_entry(p, struct hci_dev, list);
-
+	list_for_each_entry(d, &hci_dev_list, list) {
 		hci_del_off_timer(d);
 
 		set_bit(HCI_MGMT, &d->flags);
@@ -277,13 +276,9 @@ static void mgmt_pending_foreach(u16 opcode, int index,
 
 static struct pending_cmd *mgmt_pending_find(u16 opcode, int index)
 {
-	struct list_head *p;
-
-	list_for_each(p, &cmd_list) {
-		struct pending_cmd *cmd;
-
-		cmd = list_entry(p, struct pending_cmd, list);
+	struct pending_cmd *cmd;
 
+	list_for_each_entry(cmd, &cmd_list, list) {
 		if (cmd->opcode != opcode)
 			continue;
 
@@ -592,7 +587,7 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 	u16 eir_len = 0;
 	u16 uuid16_list[HCI_MAX_EIR_LENGTH / sizeof(u16)];
 	int i, truncated = 0;
-	struct list_head *p;
+	struct bt_uuid *uuid;
 	size_t name_len;
 
 	name_len = strlen(hdev->dev_name);
@@ -617,8 +612,7 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 	memset(uuid16_list, 0, sizeof(uuid16_list));
 
 	/* Group all UUID16 types */
-	list_for_each(p, &hdev->uuids) {
-		struct bt_uuid *uuid = list_entry(p, struct bt_uuid, list);
+	list_for_each_entry(uuid, &hdev->uuids, list) {
 		u16 uuid16;
 
 		uuid16 = get_uuid16(uuid->uuid);
@@ -1069,6 +1063,7 @@ static int get_connections(struct sock *sk, u16 index)
 {
 	struct mgmt_rp_get_connections *rp;
 	struct hci_dev *hdev;
+	struct hci_conn *c;
 	struct list_head *p;
 	size_t rp_len;
 	u16 count;
@@ -1097,11 +1092,8 @@ static int get_connections(struct sock *sk, u16 index)
 	put_unaligned_le16(count, &rp->conn_count);
 
 	i = 0;
-	list_for_each(p, &hdev->conn_hash.list) {
-		struct hci_conn *c = list_entry(p, struct hci_conn, list);
-
+	list_for_each_entry(c, &hdev->conn_hash.list, list)
 		bacpy(&rp->conn[i++], &c->dst);
-	}
 
 	err = cmd_complete(sk, index, MGMT_OP_GET_CONNECTIONS, rp, rp_len);
 
@@ -1270,13 +1262,9 @@ static int set_io_capability(struct sock *sk, u16 index, unsigned char *data,
 static inline struct pending_cmd *find_pairing(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
-	struct list_head *p;
-
-	list_for_each(p, &cmd_list) {
-		struct pending_cmd *cmd;
-
-		cmd = list_entry(p, struct pending_cmd, list);
+	struct pending_cmd *cmd;
 
+	list_for_each_entry(cmd, &cmd_list, list) {
 		if (cmd->opcode != MGMT_OP_PAIR_DEVICE)
 			continue;
 
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 38b618c..3d35eba 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -377,13 +377,11 @@ static void rfcomm_dlc_unlink(struct rfcomm_dlc *d)
 static struct rfcomm_dlc *rfcomm_dlc_get(struct rfcomm_session *s, u8 dlci)
 {
 	struct rfcomm_dlc *d;
-	struct list_head *p;
 
-	list_for_each(p, &s->dlcs) {
-		d = list_entry(p, struct rfcomm_dlc, list);
+	list_for_each_entry(d, &s->dlcs, list)
 		if (d->dlci == dlci)
 			return d;
-	}
+
 	return NULL;
 }
 
@@ -2115,15 +2113,13 @@ static struct hci_cb rfcomm_cb = {
 static int rfcomm_dlc_debugfs_show(struct seq_file *f, void *x)
 {
 	struct rfcomm_session *s;
-	struct list_head *pp, *p;
 
 	rfcomm_lock();
 
-	list_for_each(p, &session_list) {
-		s = list_entry(p, struct rfcomm_session, list);
-		list_for_each(pp, &s->dlcs) {
+	list_for_each_entry(s, &session_list, list) {
+		struct rfcomm_dlc *d;
+		list_for_each_entry(d, &s->dlcs, list) {
 			struct sock *sk = s->sock->sk;
-			struct rfcomm_dlc *d = list_entry(pp, struct rfcomm_dlc, list);
 
 			seq_printf(f, "%s %s %ld %d %d %d %d\n",
 						batostr(&bt_sk(sk)->src),
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index c258796..f6b2197 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -133,13 +133,10 @@ static inline void rfcomm_dev_put(struct rfcomm_dev *dev)
 static struct rfcomm_dev *__rfcomm_dev_get(int id)
 {
 	struct rfcomm_dev *dev;
-	struct list_head  *p;
 
-	list_for_each(p, &rfcomm_dev_list) {
-		dev = list_entry(p, struct rfcomm_dev, list);
+	list_for_each_entry(dev, &rfcomm_dev_list, list)
 		if (dev->id == id)
 			return dev;
-	}
 
 	return NULL;
 }
@@ -197,7 +194,7 @@ static DEVICE_ATTR(channel, S_IRUGO, show_channel, NULL);
 
 static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 {
-	struct rfcomm_dev *dev;
+	struct rfcomm_dev *dev, *entry;
 	struct list_head *head = &rfcomm_dev_list, *p;
 	int err = 0;
 
@@ -212,8 +209,8 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 	if (req->dev_id < 0) {
 		dev->id = 0;
 
-		list_for_each(p, &rfcomm_dev_list) {
-			if (list_entry(p, struct rfcomm_dev, list)->id != dev->id)
+		list_for_each_entry(entry, &rfcomm_dev_list, list) {
+			if (entry->id != dev->id)
 				break;
 
 			dev->id++;
@@ -222,9 +219,7 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 	} else {
 		dev->id = req->dev_id;
 
-		list_for_each(p, &rfcomm_dev_list) {
-			struct rfcomm_dev *entry = list_entry(p, struct rfcomm_dev, list);
-
+		list_for_each_entry(entry, &rfcomm_dev_list, list) {
 			if (entry->id == dev->id) {
 				err = -EADDRINUSE;
 				goto out;
@@ -455,9 +450,9 @@ static int rfcomm_release_dev(void __user *arg)
 
 static int rfcomm_get_dev_list(void __user *arg)
 {
+	struct rfcomm_dev *dev;
 	struct rfcomm_dev_list_req *dl;
 	struct rfcomm_dev_info *di;
-	struct list_head *p;
 	int n = 0, size, err;
 	u16 dev_num;
 
@@ -479,8 +474,7 @@ static int rfcomm_get_dev_list(void __user *arg)
 
 	read_lock_bh(&rfcomm_dev_lock);
 
-	list_for_each(p, &rfcomm_dev_list) {
-		struct rfcomm_dev *dev = list_entry(p, struct rfcomm_dev, list);
+	list_for_each_entry(dev, &rfcomm_dev_list, list) {
 		if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
 			continue;
 		(di + n)->id      = dev->id;
-- 
1.7.6.4

