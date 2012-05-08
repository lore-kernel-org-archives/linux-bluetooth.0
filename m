Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 2/3] Bluetooth: Replace unsafe batostr() calls with ba2str()
Date: Tue,  8 May 2012 15:28:25 +0200
Message-Id: <1336483706-1533-2-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1336483706-1533-1-git-send-email-dh.herrmann@googlemail.com>
References: <1336483706-1533-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

batostr() is not thread-safe so we _must_ use ba2str() in all un-protected
paths (which is pretty everywhere in our source).

All places where BT_DBG() is used we call ba2str() as parameter so the
static buffer is unused if debug is disabled during compilation and gcc
should be clever enough to remove the buffers.

Reported-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 net/bluetooth/bnep/core.c   |    4 +++-
 net/bluetooth/cmtp/core.c   |    3 ++-
 net/bluetooth/hci_conn.c    |    9 ++++++---
 net/bluetooth/hci_core.c    |   32 ++++++++++++++++++++++----------
 net/bluetooth/hci_event.c   |   17 +++++++++++------
 net/bluetooth/hci_sysfs.c   |   14 ++++++++++----
 net/bluetooth/hidp/core.c   |    4 ++--
 net/bluetooth/l2cap_core.c  |   23 ++++++++++++++---------
 net/bluetooth/rfcomm/core.c |   15 +++++++++------
 net/bluetooth/rfcomm/sock.c |   10 ++++++----
 net/bluetooth/rfcomm/tty.c  |   10 +++++++---
 net/bluetooth/sco.c         |   20 ++++++++++++++------
 12 files changed, 106 insertions(+), 55 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index a779ec7..03a3cb3 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -166,6 +166,7 @@ static int bnep_ctrl_set_netfilter(struct bnep_session *s, __be16 *data, int len
 static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len)
 {
 	int n;
+	char babuf1[BDADDR_STRLEN], babuf2[BDADDR_STRLEN];
 
 	if (len < 2)
 		return -EILSEQ;
@@ -200,7 +201,8 @@ static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len)
 			data += ETH_ALEN;
 
 			BT_DBG("mc filter %s -> %s",
-				batostr((void *) a1), batostr((void *) a2));
+				ba2str((void *) a1, babuf1),
+				ba2str((void *) a2, babuf2));
 
 			/* Iterate from a1 to a2 */
 			set_bit(bnep_mc_hash(a1), (ulong *) &s->mc_filter);
diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index 6c9c1fd..30d437f 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -331,6 +331,7 @@ int cmtp_add_connection(struct cmtp_connadd_req *req, struct socket *sock)
 {
 	struct cmtp_session *session, *s;
 	int i, err;
+	char babuf[BDADDR_STRLEN];
 
 	BT_DBG("");
 
@@ -353,7 +354,7 @@ int cmtp_add_connection(struct cmtp_connadd_req *req, struct socket *sock)
 
 	BT_DBG("mtu %d", session->mtu);
 
-	sprintf(session->name, "%s", batostr(&bt_sk(sock->sk)->dst));
+	ba2str(&bt_sk(sock->sk)->dst, session->name);
 
 	session->sock  = sock;
 	session->state = BT_CONFIG;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3f18a6e..bc7e3a2 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -333,8 +333,9 @@ static void hci_conn_auto_accept(unsigned long arg)
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 {
 	struct hci_conn *conn;
+	char babuf[BDADDR_STRLEN];
 
-	BT_DBG("%s dst %s", hdev->name, batostr(dst));
+	BT_DBG("%s dst %s", hdev->name, ba2str(dst, babuf));
 
 	conn = kzalloc(sizeof(struct hci_conn), GFP_KERNEL);
 	if (!conn)
@@ -448,8 +449,9 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 {
 	int use_src = bacmp(src, BDADDR_ANY);
 	struct hci_dev *hdev = NULL, *d;
+	char babuf1[BDADDR_STRLEN], babuf2[BDADDR_STRLEN];
 
-	BT_DBG("%s -> %s", batostr(src), batostr(dst));
+	BT_DBG("%s -> %s", ba2str(src, babuf1), ba2str(dst, babuf2));
 
 	read_lock(&hci_dev_list_lock);
 
@@ -489,8 +491,9 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	struct hci_conn *acl;
 	struct hci_conn *sco;
 	struct hci_conn *le;
+	char babuf[BDADDR_STRLEN];
 
-	BT_DBG("%s dst %s", hdev->name, batostr(dst));
+	BT_DBG("%s dst %s", hdev->name, ba2str(dst, babuf));
 
 	if (type == LE_LINK) {
 		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a492b374..e9735d3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -421,8 +421,9 @@ struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *b
 {
 	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *e;
+	char babuf[BDADDR_STRLEN];
 
-	BT_DBG("cache %p, %s", cache, batostr(bdaddr));
+	BT_DBG("cache %p, %s", cache, ba2str(bdaddr, babuf));
 
 	list_for_each_entry(e, &cache->all, all) {
 		if (!bacmp(&e->data.bdaddr, bdaddr))
@@ -437,8 +438,9 @@ struct inquiry_entry *hci_inquiry_cache_lookup_unknown(struct hci_dev *hdev,
 {
 	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *e;
+	char babuf[BDADDR_STRLEN];
 
-	BT_DBG("cache %p, %s", cache, batostr(bdaddr));
+	BT_DBG("cache %p, %s", cache, ba2str(bdaddr, babuf));
 
 	list_for_each_entry(e, &cache->unknown, list) {
 		if (!bacmp(&e->data.bdaddr, bdaddr))
@@ -454,8 +456,10 @@ struct inquiry_entry *hci_inquiry_cache_lookup_resolve(struct hci_dev *hdev,
 {
 	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *e;
+	char babuf[BDADDR_STRLEN];
 
-	BT_DBG("cache %p bdaddr %s state %d", cache, batostr(bdaddr), state);
+	BT_DBG("cache %p bdaddr %s state %d", cache, ba2str(bdaddr, babuf),
+	       state);
 
 	list_for_each_entry(e, &cache->resolve, list) {
 		if (!bacmp(bdaddr, BDADDR_ANY) && e->name_state == state)
@@ -491,8 +495,9 @@ bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 {
 	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *ie;
+	char babuf[BDADDR_STRLEN];
 
-	BT_DBG("cache %p, %s", cache, batostr(&data->bdaddr));
+	BT_DBG("cache %p, %s", cache, ba2str(&data->bdaddr, babuf));
 
 	if (ssp)
 		*ssp = data->ssp_mode;
@@ -1264,6 +1269,7 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 	struct link_key *key, *old_key;
 	u8 old_key_type;
 	bool persistent;
+	char babuf[BDADDR_STRLEN];
 
 	old_key = hci_find_link_key(hdev, bdaddr);
 	if (old_key) {
@@ -1277,7 +1283,8 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 		list_add(&key->list, &hdev->link_keys);
 	}
 
-	BT_DBG("%s key for %s type %u", hdev->name, batostr(bdaddr), type);
+	BT_DBG("%s key for %s type %u", hdev->name, ba2str(bdaddr, babuf),
+	       type);
 
 	/* Some buggy controller combinations generate a changed
 	 * combination key for legacy pairing even when there's no
@@ -1352,12 +1359,13 @@ int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct link_key *key;
+	char babuf[BDADDR_STRLEN];
 
 	key = hci_find_link_key(hdev, bdaddr);
 	if (!key)
 		return -ENOENT;
 
-	BT_DBG("%s removing %s", hdev->name, batostr(bdaddr));
+	BT_DBG("%s removing %s", hdev->name, ba2str(bdaddr, babuf));
 
 	list_del(&key->list);
 	kfree(key);
@@ -1368,12 +1376,13 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct smp_ltk *k, *tmp;
+	char babuf[BDADDR_STRLEN];
 
 	list_for_each_entry_safe(k, tmp, &hdev->long_term_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr))
 			continue;
 
-		BT_DBG("%s removing %s", hdev->name, batostr(bdaddr));
+		BT_DBG("%s removing %s", hdev->name, ba2str(bdaddr, babuf));
 
 		list_del(&k->list);
 		kfree(k);
@@ -1407,12 +1416,13 @@ struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
 int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct oob_data *data;
+	char babuf[BDADDR_STRLEN];
 
 	data = hci_find_remote_oob_data(hdev, bdaddr);
 	if (!data)
 		return -ENOENT;
 
-	BT_DBG("%s removing %s", hdev->name, batostr(bdaddr));
+	BT_DBG("%s removing %s", hdev->name, ba2str(bdaddr, babuf));
 
 	list_del(&data->list);
 	kfree(data);
@@ -1436,6 +1446,7 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 			    u8 *randomizer)
 {
 	struct oob_data *data;
+	char babuf[BDADDR_STRLEN];
 
 	data = hci_find_remote_oob_data(hdev, bdaddr);
 
@@ -1451,7 +1462,7 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 	memcpy(data->hash, hash, sizeof(data->hash));
 	memcpy(data->randomizer, randomizer, sizeof(data->randomizer));
 
-	BT_DBG("%s for %s", hdev->name, batostr(bdaddr));
+	BT_DBG("%s for %s", hdev->name, ba2str(bdaddr, babuf));
 
 	return 0;
 }
@@ -2303,6 +2314,7 @@ static inline void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn *c;
+	char babuf[BDADDR_STRLEN];
 
 	BT_ERR("%s link tx timeout", hdev->name);
 
@@ -2312,7 +2324,7 @@ static inline void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 	list_for_each_entry_rcu(c, &h->list, list) {
 		if (c->type == type && c->sent) {
 			BT_ERR("%s killing stalled connection %s",
-				hdev->name, batostr(&c->dst));
+				hdev->name, ba2str(&c->dst, babuf));
 			hci_acl_disconn(c, 0x13);
 		}
 	}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b739baf..de65863 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1207,6 +1207,7 @@ static inline void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 {
 	struct hci_cp_create_conn *cp;
 	struct hci_conn *conn;
+	char babuf[BDADDR_STRLEN];
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
@@ -1218,7 +1219,8 @@ static inline void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
 
-	BT_DBG("%s bdaddr %s conn %p", hdev->name, batostr(&cp->bdaddr), conn);
+	BT_DBG("%s bdaddr %s conn %p", hdev->name, ba2str(&cp->bdaddr, babuf),
+	       conn);
 
 	if (status) {
 		if (conn && conn->state == BT_CONNECT) {
@@ -1626,6 +1628,7 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
 {
 	struct hci_cp_le_create_conn *cp;
 	struct hci_conn *conn;
+	char babuf[BDADDR_STRLEN];
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
@@ -1637,8 +1640,8 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
 
 	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->peer_addr);
 
-	BT_DBG("%s bdaddr %s conn %p", hdev->name, batostr(&cp->peer_addr),
-		conn);
+	BT_DBG("%s bdaddr %s conn %p", hdev->name,
+	       ba2str(&cp->peer_addr, babuf), conn);
 
 	if (status) {
 		if (conn && conn->state == BT_CONNECT) {
@@ -1827,9 +1830,10 @@ static inline void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *sk
 {
 	struct hci_ev_conn_request *ev = (void *) skb->data;
 	int mask = hdev->link_mode;
+	char babuf[BDADDR_STRLEN];
 
 	BT_DBG("%s bdaddr %s type 0x%x", hdev->name,
-					batostr(&ev->bdaddr), ev->link_type);
+	       ba2str(&ev->bdaddr, babuf), ev->link_type);
 
 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type);
 
@@ -2671,6 +2675,7 @@ static inline void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff
 	struct hci_cp_link_key_reply cp;
 	struct hci_conn *conn;
 	struct link_key *key;
+	char babuf[BDADDR_STRLEN];
 
 	BT_DBG("%s", hdev->name);
 
@@ -2682,12 +2687,12 @@ static inline void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff
 	key = hci_find_link_key(hdev, &ev->bdaddr);
 	if (!key) {
 		BT_DBG("%s link key not found for %s", hdev->name,
-							batostr(&ev->bdaddr));
+		       ba2str(&ev->bdaddr, babuf));
 		goto not_found;
 	}
 
 	BT_DBG("%s found key type %u for %s", hdev->name, key->type,
-							batostr(&ev->bdaddr));
+	       ba2str(&ev->bdaddr, babuf));
 
 	if (!test_bit(HCI_DEBUG_KEYS, &hdev->dev_flags) &&
 				key->type == HCI_LK_DEBUG_COMBINATION) {
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 937f318..e457ea3 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -40,7 +40,9 @@ static ssize_t show_link_type(struct device *dev, struct device_attribute *attr,
 static ssize_t show_link_address(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct hci_conn *conn = to_hci_conn(dev);
-	return sprintf(buf, "%s\n", batostr(&conn->dst));
+	char babuf[BDADDR_STRLEN];
+
+	return sprintf(buf, "%s\n", ba2str(&conn->dst, babuf));
 }
 
 static ssize_t show_link_features(struct device *dev, struct device_attribute *attr, char *buf)
@@ -220,7 +222,9 @@ static ssize_t show_class(struct device *dev, struct device_attribute *attr, cha
 static ssize_t show_address(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct hci_dev *hdev = to_hci_dev(dev);
-	return sprintf(buf, "%s\n", batostr(&hdev->bdaddr));
+	char babuf[BDADDR_STRLEN];
+
+	return sprintf(buf, "%s\n", ba2str(&hdev->bdaddr, babuf));
 }
 
 static ssize_t show_features(struct device *dev, struct device_attribute *attr, char *buf)
@@ -384,13 +388,14 @@ static int inquiry_cache_show(struct seq_file *f, void *p)
 	struct hci_dev *hdev = f->private;
 	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *e;
+	char babuf[BDADDR_STRLEN];
 
 	hci_dev_lock(hdev);
 
 	list_for_each_entry(e, &cache->all, all) {
 		struct inquiry_data *data = &e->data;
 		seq_printf(f, "%s %d %d %d 0x%.2x%.2x%.2x 0x%.4x %d %d %u\n",
-			   batostr(&data->bdaddr),
+			   ba2str(&data->bdaddr, babuf),
 			   data->pscan_rep_mode, data->pscan_period_mode,
 			   data->pscan_mode, data->dev_class[2],
 			   data->dev_class[1], data->dev_class[0],
@@ -419,11 +424,12 @@ static int blacklist_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
 	struct bdaddr_list *b;
+	char babuf[BDADDR_STRLEN];
 
 	hci_dev_lock(hdev);
 
 	list_for_each_entry(b, &hdev->blacklist, list)
-		seq_printf(f, "%s\n", batostr(&b->bdaddr));
+		seq_printf(f, "%s\n", ba2str(&b->bdaddr, babuf));
 
 	hci_dev_unlock(hdev);
 
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index d478be1..9625272 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -950,8 +950,8 @@ static int hidp_setup_hid(struct hidp_session *session,
 	hid->country = req->country;
 
 	strncpy(hid->name, req->name, 128);
-	strncpy(hid->phys, batostr(&bt_sk(session->ctrl_sock->sk)->src), 64);
-	strncpy(hid->uniq, batostr(&bt_sk(session->ctrl_sock->sk)->dst), 64);
+	ba2str(&bt_sk(session->ctrl_sock->sk)->src, hid->phys);
+	ba2str(&bt_sk(session->ctrl_sock->sk)->dst, hid->uniq);
 
 	hid->dev.parent = &session->conn->dev;
 	hid->ll_driver = &hidp_hid_driver;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 66a1a55..c91e24f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1396,9 +1396,10 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	struct hci_dev *hdev;
 	__u8 auth_type;
 	int err;
+	char babuf1[BDADDR_STRLEN], babuf2[BDADDR_STRLEN];
 
-	BT_DBG("%s -> %s (type %u) psm 0x%2.2x", batostr(src), batostr(dst),
-	       dst_type, __le16_to_cpu(chan->psm));
+	BT_DBG("%s -> %s (type %u) psm 0x%2.2x", ba2str(src, babuf1),
+	       ba2str(dst, babuf2), dst_type, __le16_to_cpu(chan->psm));
 
 	hdev = hci_get_route(dst, src);
 	if (!hdev)
@@ -4794,8 +4795,9 @@ int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	int exact = 0, lm1 = 0, lm2 = 0;
 	struct l2cap_chan *c;
+	char babuf[BDADDR_STRLEN];
 
-	BT_DBG("hdev %s, bdaddr %s", hdev->name, batostr(bdaddr));
+	BT_DBG("hdev %s, bdaddr %s", hdev->name, ba2str(bdaddr, babuf));
 
 	/* Find listening sockets and check their link_mode */
 	read_lock(&chan_list_lock);
@@ -4824,8 +4826,10 @@ int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
 int l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 {
 	struct l2cap_conn *conn;
+	char babuf[BDADDR_STRLEN];
 
-	BT_DBG("hcon %p bdaddr %s status %d", hcon, batostr(&hcon->dst), status);
+	BT_DBG("hcon %p bdaddr %s status %d", hcon, ba2str(&hcon->dst, babuf),
+	       status);
 
 	if (!status) {
 		conn = l2cap_conn_add(hcon, status);
@@ -5082,6 +5086,7 @@ drop:
 static int l2cap_debugfs_show(struct seq_file *f, void *p)
 {
 	struct l2cap_chan *c;
+	char babuf1[BDADDR_STRLEN], babuf2[BDADDR_STRLEN];
 
 	read_lock(&chan_list_lock);
 
@@ -5089,11 +5094,11 @@ static int l2cap_debugfs_show(struct seq_file *f, void *p)
 		struct sock *sk = c->sk;
 
 		seq_printf(f, "%s %s %d %d 0x%4.4x 0x%4.4x %d %d %d %d\n",
-					batostr(&bt_sk(sk)->src),
-					batostr(&bt_sk(sk)->dst),
-					c->state, __le16_to_cpu(c->psm),
-					c->scid, c->dcid, c->imtu, c->omtu,
-					c->sec_level, c->mode);
+			   ba2str(&bt_sk(sk)->src, babuf1),
+			   ba2str(&bt_sk(sk)->dst, babuf2),
+			   c->state, __le16_to_cpu(c->psm),
+			   c->scid, c->dcid, c->imtu, c->omtu,
+			   c->sec_level, c->mode);
 	}
 
 	read_unlock(&chan_list_lock);
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 8a60238..8dc2ad9 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -390,9 +390,10 @@ static int __rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst,
 	struct rfcomm_session *s;
 	int err = 0;
 	u8 dlci;
+	char babuf1[BDADDR_STRLEN], babuf2[BDADDR_STRLEN];
 
 	BT_DBG("dlc %p state %ld %s %s channel %d",
-			d, d->state, batostr(src), batostr(dst), channel);
+	       d, d->state, ba2str(src, babuf1), ba2str(dst, babuf2), channel);
 
 	if (channel < 1 || channel > 30)
 		return -EINVAL;
@@ -689,8 +690,9 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 	struct sockaddr_l2 addr;
 	struct socket *sock;
 	struct sock *sk;
+	char babuf1[BDADDR_STRLEN], babuf2[BDADDR_STRLEN];
 
-	BT_DBG("%s %s", batostr(src), batostr(dst));
+	BT_DBG("%s %s", ba2str(src, babuf1), ba2str(dst, babuf2));
 
 	*err = rfcomm_l2sock_create(&sock);
 	if (*err < 0)
@@ -2131,6 +2133,7 @@ static struct hci_cb rfcomm_cb = {
 static int rfcomm_dlc_debugfs_show(struct seq_file *f, void *x)
 {
 	struct rfcomm_session *s;
+	char babuf1[BDADDR_STRLEN], babuf2[BDADDR_STRLEN];
 
 	rfcomm_lock();
 
@@ -2140,10 +2143,10 @@ static int rfcomm_dlc_debugfs_show(struct seq_file *f, void *x)
 			struct sock *sk = s->sock->sk;
 
 			seq_printf(f, "%s %s %ld %d %d %d %d\n",
-						batostr(&bt_sk(sk)->src),
-						batostr(&bt_sk(sk)->dst),
-						d->state, d->dlci, d->mtu,
-						d->rx_credits, d->tx_credits);
+				   ba2str(&bt_sk(sk)->src, babuf1),
+				   ba2str(&bt_sk(sk)->dst, babuf2),
+				   d->state, d->dlci, d->mtu,
+				   d->rx_credits, d->tx_credits);
 		}
 	}
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index a55a43e..149fc89 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -351,8 +351,9 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
 	struct sockaddr_rc *sa = (struct sockaddr_rc *) addr;
 	struct sock *sk = sock->sk;
 	int err = 0;
+	char babuf[BDADDR_STRLEN];
 
-	BT_DBG("sk %p %s", sk, batostr(&sa->rc_bdaddr));
+	BT_DBG("sk %p %s", sk, ba2str(&sa->rc_bdaddr, babuf));
 
 	if (!addr || addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
@@ -982,14 +983,15 @@ static int rfcomm_sock_debugfs_show(struct seq_file *f, void *p)
 {
 	struct sock *sk;
 	struct hlist_node *node;
+	char babuf1[BDADDR_STRLEN], babuf2[BDADDR_STRLEN];
 
 	read_lock(&rfcomm_sk_list.lock);
 
 	sk_for_each(sk, node, &rfcomm_sk_list.head) {
 		seq_printf(f, "%s %s %d %d\n",
-				batostr(&bt_sk(sk)->src),
-				batostr(&bt_sk(sk)->dst),
-				sk->sk_state, rfcomm_pi(sk)->channel);
+			   ba2str(&bt_sk(sk)->src, babuf1),
+			   ba2str(&bt_sk(sk)->dst, babuf2),
+			   sk->sk_state, rfcomm_pi(sk)->channel);
 	}
 
 	read_unlock(&rfcomm_sk_list.lock);
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 4bf54b3..bbbbd19 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -181,7 +181,9 @@ static struct device *rfcomm_get_device(struct rfcomm_dev *dev)
 static ssize_t show_address(struct device *tty_dev, struct device_attribute *attr, char *buf)
 {
 	struct rfcomm_dev *dev = dev_get_drvdata(tty_dev);
-	return sprintf(buf, "%s\n", batostr(&dev->dst));
+	char babuf[BDADDR_STRLEN];
+
+	return sprintf(buf, "%s\n", ba2str(&dev->dst, babuf));
 }
 
 static ssize_t show_channel(struct device *tty_dev, struct device_attribute *attr, char *buf)
@@ -672,6 +674,7 @@ static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 	struct rfcomm_dev *dev;
 	struct rfcomm_dlc *dlc;
 	int err, id;
+	char babuf[BDADDR_STRLEN];
 
 	id = tty->index;
 
@@ -685,8 +688,9 @@ static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 	if (!dev)
 		return -ENODEV;
 
-	BT_DBG("dev %p dst %s channel %d opened %d", dev, batostr(&dev->dst),
-				dev->channel, atomic_read(&dev->opened));
+	BT_DBG("dev %p dst %s channel %d opened %d", dev,
+	       ba2str(&dev->dst, babuf), dev->channel,
+	       atomic_read(&dev->opened));
 
 	if (atomic_inc_return(&dev->opened) > 1)
 		return 0;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index cbdd313..8f083f0 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -179,8 +179,9 @@ static int sco_connect(struct sock *sk)
 	struct hci_conn *hcon;
 	struct hci_dev  *hdev;
 	int err, type;
+	char babuf1[BDADDR_STRLEN], babuf2[BDADDR_STRLEN];
 
-	BT_DBG("%s -> %s", batostr(src), batostr(dst));
+	BT_DBG("%s -> %s", ba2str(src, babuf1), ba2str(dst, babuf2));
 
 	hdev = hci_get_route(dst, src);
 	if (!hdev)
@@ -467,8 +468,9 @@ static int sco_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
 	struct sockaddr_sco *sa = (struct sockaddr_sco *) addr;
 	struct sock *sk = sock->sk;
 	int err = 0;
+	char babuf[BDADDR_STRLEN];
 
-	BT_DBG("sk %p %s", sk, batostr(&sa->sco_bdaddr));
+	BT_DBG("sk %p %s", sk, ba2str(&sa->sco_bdaddr, babuf));
 
 	if (!addr || addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
@@ -910,8 +912,9 @@ int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	register struct sock *sk;
 	struct hlist_node *node;
 	int lm = 0;
+	char babuf[BDADDR_STRLEN];
 
-	BT_DBG("hdev %s, bdaddr %s", hdev->name, batostr(bdaddr));
+	BT_DBG("hdev %s, bdaddr %s", hdev->name, ba2str(bdaddr, babuf));
 
 	/* Find listening sockets */
 	read_lock(&sco_sk_list.lock);
@@ -932,7 +935,11 @@ int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
 
 int sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 {
-	BT_DBG("hcon %p bdaddr %s status %d", hcon, batostr(&hcon->dst), status);
+	char babuf[BDADDR_STRLEN];
+
+	BT_DBG("hcon %p bdaddr %s status %d", hcon, ba2str(&hcon->dst, babuf),
+	       status);
+
 	if (!status) {
 		struct sco_conn *conn;
 
@@ -976,12 +983,13 @@ static int sco_debugfs_show(struct seq_file *f, void *p)
 {
 	struct sock *sk;
 	struct hlist_node *node;
+	char babuf1[BDADDR_STRLEN], babuf2[BDADDR_STRLEN];
 
 	read_lock(&sco_sk_list.lock);
 
 	sk_for_each(sk, node, &sco_sk_list.head) {
-		seq_printf(f, "%s %s %d\n", batostr(&bt_sk(sk)->src),
-				batostr(&bt_sk(sk)->dst), sk->sk_state);
+		seq_printf(f, "%s %s %d\n", ba2str(&bt_sk(sk)->src, babuf1),
+			   ba2str(&bt_sk(sk)->dst, babuf2), sk->sk_state);
 	}
 
 	read_unlock(&sco_sk_list.lock);
-- 
1.7.10.1
