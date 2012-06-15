Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2] Bluetooth: Use %pMR BT addr print spec instead of batostr
Date: Fri, 15 Jun 2012 11:33:27 +0300
Message-Id: <1339749207-10203-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1339419200-581-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1339419200-581-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Clean up old unsafe batostr function and use %pMR print specifier
for printing Bluetooth addresses.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/bluetooth.h |    1 -
 net/bluetooth/bnep/core.c         |    3 +--
 net/bluetooth/cmtp/core.c         |    2 +-
 net/bluetooth/hci_conn.c          |    6 +++---
 net/bluetooth/hci_core.c          |   22 +++++++++++-----------
 net/bluetooth/hci_event.c         |   15 +++++++--------
 net/bluetooth/hci_sysfs.c         |   10 +++++-----
 net/bluetooth/hidp/core.c         |    6 ++++--
 net/bluetooth/l2cap_core.c        |   11 +++++------
 net/bluetooth/lib.c               |   14 --------------
 net/bluetooth/rfcomm/core.c       |   15 +++++++--------
 net/bluetooth/rfcomm/sock.c       |    9 ++++-----
 net/bluetooth/rfcomm/tty.c        |    6 +++---
 net/bluetooth/sco.c               |   12 ++++++------
 14 files changed, 57 insertions(+), 75 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 565d4be..d22686d 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -179,7 +179,6 @@ static inline void bacpy(bdaddr_t *dst, bdaddr_t *src)
 }
 
 void baswap(bdaddr_t *dst, bdaddr_t *src);
-char *batostr(bdaddr_t *ba);
 
 /* Common socket structures and functions */
 
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 4a6620b..a5b6397 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -182,8 +182,7 @@ static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len)
 			a2 = data;
 			data += ETH_ALEN;
 
-			BT_DBG("mc filter %s -> %s",
-				batostr((void *) a1), batostr((void *) a2));
+			BT_DBG("mc filter %pMR -> %pMR", a1, a2);
 
 			/* Iterate from a1 to a2 */
 			set_bit(bnep_mc_hash(a1), (ulong *) &s->mc_filter);
diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index 6c9c1fd..e0a6ebf 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -353,7 +353,7 @@ int cmtp_add_connection(struct cmtp_connadd_req *req, struct socket *sock)
 
 	BT_DBG("mtu %d", session->mtu);
 
-	sprintf(session->name, "%s", batostr(&bt_sk(sock->sk)->dst));
+	sprintf(session->name, "%pMR", &bt_sk(sock->sk)->dst);
 
 	session->sock  = sock;
 	session->state = BT_CONFIG;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2fcced3..858907f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -319,7 +319,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 {
 	struct hci_conn *conn;
 
-	BT_DBG("%s dst %s", hdev->name, batostr(dst));
+	BT_DBG("%s dst %pMR", hdev->name, dst);
 
 	conn = kzalloc(sizeof(struct hci_conn), GFP_KERNEL);
 	if (!conn)
@@ -436,7 +436,7 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 	int use_src = bacmp(src, BDADDR_ANY);
 	struct hci_dev *hdev = NULL, *d;
 
-	BT_DBG("%s -> %s", batostr(src), batostr(dst));
+	BT_DBG("%pMR -> %pMR", src, dst);
 
 	read_lock(&hci_dev_list_lock);
 
@@ -478,7 +478,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	struct hci_conn *sco;
 	struct hci_conn *le;
 
-	BT_DBG("%s dst %s", hdev->name, batostr(dst));
+	BT_DBG("%s dst %pMR", hdev->name, dst);
 
 	if (type == LE_LINK) {
 		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a2bdf93..5979452 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -405,7 +405,7 @@ struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev,
 	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *e;
 
-	BT_DBG("cache %p, %s", cache, batostr(bdaddr));
+	BT_DBG("cache %p, %pMR", cache, bdaddr);
 
 	list_for_each_entry(e, &cache->all, all) {
 		if (!bacmp(&e->data.bdaddr, bdaddr))
@@ -421,7 +421,7 @@ struct inquiry_entry *hci_inquiry_cache_lookup_unknown(struct hci_dev *hdev,
 	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *e;
 
-	BT_DBG("cache %p, %s", cache, batostr(bdaddr));
+	BT_DBG("cache %p, %pMR", cache, bdaddr);
 
 	list_for_each_entry(e, &cache->unknown, list) {
 		if (!bacmp(&e->data.bdaddr, bdaddr))
@@ -438,7 +438,7 @@ struct inquiry_entry *hci_inquiry_cache_lookup_resolve(struct hci_dev *hdev,
 	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *e;
 
-	BT_DBG("cache %p bdaddr %s state %d", cache, batostr(bdaddr), state);
+	BT_DBG("cache %p bdaddr %pMR state %d", cache, bdaddr, state);
 
 	list_for_each_entry(e, &cache->resolve, list) {
 		if (!bacmp(bdaddr, BDADDR_ANY) && e->name_state == state)
@@ -475,7 +475,7 @@ bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *ie;
 
-	BT_DBG("cache %p, %s", cache, batostr(&data->bdaddr));
+	BT_DBG("cache %p, %pMR", cache, &data->bdaddr);
 
 	if (ssp)
 		*ssp = data->ssp_mode;
@@ -1256,7 +1256,7 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 		list_add(&key->list, &hdev->link_keys);
 	}
 
-	BT_DBG("%s key for %s type %u", hdev->name, batostr(bdaddr), type);
+	BT_DBG("%s key for %pMR type %u", hdev->name, bdaddr, type);
 
 	/* Some buggy controller combinations generate a changed
 	 * combination key for legacy pairing even when there's no
@@ -1335,7 +1335,7 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	if (!key)
 		return -ENOENT;
 
-	BT_DBG("%s removing %s", hdev->name, batostr(bdaddr));
+	BT_DBG("%s removing %pMR", hdev->name, bdaddr);
 
 	list_del(&key->list);
 	kfree(key);
@@ -1351,7 +1351,7 @@ int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr)
 		if (bacmp(bdaddr, &k->bdaddr))
 			continue;
 
-		BT_DBG("%s removing %s", hdev->name, batostr(bdaddr));
+		BT_DBG("%s removing %pMR", hdev->name, bdaddr);
 
 		list_del(&k->list);
 		kfree(k);
@@ -1398,7 +1398,7 @@ int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	if (!data)
 		return -ENOENT;
 
-	BT_DBG("%s removing %s", hdev->name, batostr(bdaddr));
+	BT_DBG("%s removing %pMR", hdev->name, bdaddr);
 
 	list_del(&data->list);
 	kfree(data);
@@ -1437,7 +1437,7 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 	memcpy(data->hash, hash, sizeof(data->hash));
 	memcpy(data->randomizer, randomizer, sizeof(data->randomizer));
 
-	BT_DBG("%s for %s", hdev->name, batostr(bdaddr));
+	BT_DBG("%s for %pMR", hdev->name, bdaddr);
 
 	return 0;
 }
@@ -2305,8 +2305,8 @@ static void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 	/* Kill stalled connections */
 	list_for_each_entry_rcu(c, &h->list, list) {
 		if (c->type == type && c->sent) {
-			BT_ERR("%s killing stalled connection %s",
-			       hdev->name, batostr(&c->dst));
+			BT_ERR("%s killing stalled connection %pMR",
+			       hdev->name, &c->dst);
 			hci_acl_disconn(c, HCI_ERROR_REMOTE_USER_TERM);
 		}
 	}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1ba929c..f4c679b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1209,7 +1209,7 @@ static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
 
-	BT_DBG("%s bdaddr %s conn %p", hdev->name, batostr(&cp->bdaddr), conn);
+	BT_DBG("%s bdaddr %pMR conn %p", hdev->name, &cp->bdaddr, conn);
 
 	if (status) {
 		if (conn && conn->state == BT_CONNECT) {
@@ -1627,8 +1627,7 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
 
 	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->peer_addr);
 
-	BT_DBG("%s bdaddr %s conn %p", hdev->name, batostr(&cp->peer_addr),
-	       conn);
+	BT_DBG("%s bdaddr %pMR conn %p", hdev->name, &cp->peer_addr, conn);
 
 	if (status) {
 		if (conn && conn->state == BT_CONNECT) {
@@ -1818,7 +1817,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	struct hci_ev_conn_request *ev = (void *) skb->data;
 	int mask = hdev->link_mode;
 
-	BT_DBG("%s bdaddr %s type 0x%x", hdev->name, batostr(&ev->bdaddr),
+	BT_DBG("%s bdaddr %pMR type 0x%x", hdev->name, &ev->bdaddr,
 	       ev->link_type);
 
 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type);
@@ -2682,13 +2681,13 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	key = hci_find_link_key(hdev, &ev->bdaddr);
 	if (!key) {
-		BT_DBG("%s link key not found for %s", hdev->name,
-		       batostr(&ev->bdaddr));
+		BT_DBG("%s link key not found for %pMR", hdev->name,
+		       &ev->bdaddr);
 		goto not_found;
 	}
 
-	BT_DBG("%s found key type %u for %s", hdev->name, key->type,
-	       batostr(&ev->bdaddr));
+	BT_DBG("%s found key type %u for %pMR", hdev->name, key->type,
+	       &ev->bdaddr);
 
 	if (!test_bit(HCI_DEBUG_KEYS, &hdev->dev_flags) &&
 	    key->type == HCI_LK_DEBUG_COMBINATION) {
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index a20e61c..55cceee 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -38,7 +38,7 @@ static ssize_t show_link_address(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
 	struct hci_conn *conn = to_hci_conn(dev);
-	return sprintf(buf, "%s\n", batostr(&conn->dst));
+	return sprintf(buf, "%pMR\n", &conn->dst);
 }
 
 static ssize_t show_link_features(struct device *dev,
@@ -224,7 +224,7 @@ static ssize_t show_address(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct hci_dev *hdev = to_hci_dev(dev);
-	return sprintf(buf, "%s\n", batostr(&hdev->bdaddr));
+	return sprintf(buf, "%pMR\n", &hdev->bdaddr);
 }
 
 static ssize_t show_features(struct device *dev,
@@ -406,8 +406,8 @@ static int inquiry_cache_show(struct seq_file *f, void *p)
 
 	list_for_each_entry(e, &cache->all, all) {
 		struct inquiry_data *data = &e->data;
-		seq_printf(f, "%s %d %d %d 0x%.2x%.2x%.2x 0x%.4x %d %d %u\n",
-			   batostr(&data->bdaddr),
+		seq_printf(f, "%pMR %d %d %d 0x%.2x%.2x%.2x 0x%.4x %d %d %u\n",
+			   &data->bdaddr,
 			   data->pscan_rep_mode, data->pscan_period_mode,
 			   data->pscan_mode, data->dev_class[2],
 			   data->dev_class[1], data->dev_class[0],
@@ -440,7 +440,7 @@ static int blacklist_show(struct seq_file *f, void *p)
 	hci_dev_lock(hdev);
 
 	list_for_each_entry(b, &hdev->blacklist, list)
-		seq_printf(f, "%s\n", batostr(&b->bdaddr));
+		seq_printf(f, "%pMR\n", &b->bdaddr);
 
 	hci_dev_unlock(hdev);
 
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index ccd985d..001fc13 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -932,8 +932,10 @@ static int hidp_setup_hid(struct hidp_session *session,
 	hid->country = req->country;
 
 	strncpy(hid->name, req->name, 128);
-	strncpy(hid->phys, batostr(&bt_sk(session->ctrl_sock->sk)->src), 64);
-	strncpy(hid->uniq, batostr(&bt_sk(session->ctrl_sock->sk)->dst), 64);
+	snprintf(hid->phys, "%pMR", &bt_sk(session->ctrl_sock->sk)->src,
+		 sizeof(hid->phys);
+	snprintf(hid->uniq, "%pMR", &bt_sk(session->ctrl_sock->sk)->dst,
+		 sizeof(hid->uniq));
 
 	hid->dev.parent = &session->conn->dev;
 	hid->ll_driver = &hidp_hid_driver;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4ca8824..b8ad754 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1427,7 +1427,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	__u8 auth_type;
 	int err;
 
-	BT_DBG("%s -> %s (type %u) psm 0x%2.2x", batostr(src), batostr(dst),
+	BT_DBG("%pMR -> %pMR (type %u) psm 0x%2.2x", src, dst,
 	       dst_type, __le16_to_cpu(chan->psm));
 
 	hdev = hci_get_route(dst, src);
@@ -5287,7 +5287,7 @@ int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	int exact = 0, lm1 = 0, lm2 = 0;
 	struct l2cap_chan *c;
 
-	BT_DBG("hdev %s, bdaddr %s", hdev->name, batostr(bdaddr));
+	BT_DBG("hdev %s, bdaddr %pMR", hdev->name, bdaddr);
 
 	/* Find listening sockets and check their link_mode */
 	read_lock(&chan_list_lock);
@@ -5317,7 +5317,7 @@ int l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 {
 	struct l2cap_conn *conn;
 
-	BT_DBG("hcon %p bdaddr %s status %d", hcon, batostr(&hcon->dst), status);
+	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
 
 	if (!status) {
 		conn = l2cap_conn_add(hcon, status);
@@ -5577,9 +5577,8 @@ static int l2cap_debugfs_show(struct seq_file *f, void *p)
 	list_for_each_entry(c, &chan_list, global_l) {
 		struct sock *sk = c->sk;
 
-		seq_printf(f, "%s %s %d %d 0x%4.4x 0x%4.4x %d %d %d %d\n",
-					batostr(&bt_sk(sk)->src),
-					batostr(&bt_sk(sk)->dst),
+		seq_printf(f, "%pMR %pMR %d %d 0x%4.4x 0x%4.4x %d %d %d %d\n",
+					&bt_sk(sk)->src, &bt_sk(sk)->dst,
 					c->state, __le16_to_cpu(c->psm),
 					c->scid, c->dcid, c->imtu, c->omtu,
 					c->sec_level, c->mode);
diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index e1c9752..b3fbc73 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -41,20 +41,6 @@ void baswap(bdaddr_t *dst, bdaddr_t *src)
 }
 EXPORT_SYMBOL(baswap);
 
-char *batostr(bdaddr_t *ba)
-{
-	static char str[2][18];
-	static int i = 1;
-
-	i ^= 1;
-	sprintf(str[i], "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
-		ba->b[5], ba->b[4], ba->b[3],
-		ba->b[2], ba->b[1], ba->b[0]);
-
-	return str[i];
-}
-EXPORT_SYMBOL(batostr);
-
 /* Bluetooth error codes to Unix errno mapping */
 int bt_to_errno(__u16 code)
 {
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index c75107e..fb1d83d 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -377,8 +377,8 @@ static int __rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst,
 	int err = 0;
 	u8 dlci;
 
-	BT_DBG("dlc %p state %ld %s %s channel %d",
-			d, d->state, batostr(src), batostr(dst), channel);
+	BT_DBG("dlc %p state %ld %pMR -> %pMR channel %d",
+	       d, d->state, src, dst, channel);
 
 	if (channel < 1 || channel > 30)
 		return -EINVAL;
@@ -676,7 +676,7 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 	struct socket *sock;
 	struct sock *sk;
 
-	BT_DBG("%s %s", batostr(src), batostr(dst));
+	BT_DBG("%pMR -> %pMR", src, dst);
 
 	*err = rfcomm_l2sock_create(&sock);
 	if (*err < 0)
@@ -2125,11 +2125,10 @@ static int rfcomm_dlc_debugfs_show(struct seq_file *f, void *x)
 		list_for_each_entry(d, &s->dlcs, list) {
 			struct sock *sk = s->sock->sk;
 
-			seq_printf(f, "%s %s %ld %d %d %d %d\n",
-						batostr(&bt_sk(sk)->src),
-						batostr(&bt_sk(sk)->dst),
-						d->state, d->dlci, d->mtu,
-						d->rx_credits, d->tx_credits);
+			seq_printf(f, "%pMR %pMR %ld %d %d %d %d\n",
+				   &bt_sk(sk)->src, &bt_sk(sk)->dst,
+				   d->state, d->dlci, d->mtu,
+				   d->rx_credits, d->tx_credits);
 		}
 	}
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 7e1e596..cdfb990 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -334,7 +334,7 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
 	struct sock *sk = sock->sk;
 	int err = 0;
 
-	BT_DBG("sk %p %s", sk, batostr(&sa->rc_bdaddr));
+	BT_DBG("sk %p %pMR", sk, &sa->rc_bdaddr);
 
 	if (!addr || addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
@@ -973,10 +973,9 @@ static int rfcomm_sock_debugfs_show(struct seq_file *f, void *p)
 	read_lock(&rfcomm_sk_list.lock);
 
 	sk_for_each(sk, node, &rfcomm_sk_list.head) {
-		seq_printf(f, "%s %s %d %d\n",
-				batostr(&bt_sk(sk)->src),
-				batostr(&bt_sk(sk)->dst),
-				sk->sk_state, rfcomm_pi(sk)->channel);
+		seq_printf(f, "%pMR %pMR %d %d\n",
+			   &bt_sk(sk)->src, &bt_sk(sk)->dst,
+			   sk->sk_state, rfcomm_pi(sk)->channel);
 	}
 
 	read_unlock(&rfcomm_sk_list.lock);
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index cb96077..6baf64d 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -166,7 +166,7 @@ static struct device *rfcomm_get_device(struct rfcomm_dev *dev)
 static ssize_t show_address(struct device *tty_dev, struct device_attribute *attr, char *buf)
 {
 	struct rfcomm_dev *dev = dev_get_drvdata(tty_dev);
-	return sprintf(buf, "%s\n", batostr(&dev->dst));
+	return sprintf(buf, "%pMR\n", &dev->dst);
 }
 
 static ssize_t show_channel(struct device *tty_dev, struct device_attribute *attr, char *buf)
@@ -663,8 +663,8 @@ static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 	if (!dev)
 		return -ENODEV;
 
-	BT_DBG("dev %p dst %s channel %d opened %d", dev, batostr(&dev->dst),
-				dev->channel, dev->port.count);
+	BT_DBG("dev %p dst %pMR channel %d opened %d", dev, &dev->dst,
+	       dev->channel, dev->port.count);
 
 	spin_lock_irqsave(&dev->port.lock, flags);
 	if (++dev->port.count > 1) {
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 40bbe25..20680f2 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -163,7 +163,7 @@ static int sco_connect(struct sock *sk)
 	struct hci_dev  *hdev;
 	int err, type;
 
-	BT_DBG("%s -> %s", batostr(src), batostr(dst));
+	BT_DBG("%pMR -> %pMR", src, dst);
 
 	hdev = hci_get_route(dst, src);
 	if (!hdev)
@@ -451,7 +451,7 @@ static int sco_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
 	struct sock *sk = sock->sk;
 	int err = 0;
 
-	BT_DBG("sk %p %s", sk, batostr(&sa->sco_bdaddr));
+	BT_DBG("sk %p %pMR", sk, &sa->sco_bdaddr);
 
 	if (!addr || addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
@@ -894,7 +894,7 @@ int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	struct hlist_node *node;
 	int lm = 0;
 
-	BT_DBG("hdev %s, bdaddr %s", hdev->name, batostr(bdaddr));
+	BT_DBG("hdev %s, bdaddr %pMR", hdev->name, bdaddr);
 
 	/* Find listening sockets */
 	read_lock(&sco_sk_list.lock);
@@ -915,7 +915,7 @@ int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
 
 int sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 {
-	BT_DBG("hcon %p bdaddr %s status %d", hcon, batostr(&hcon->dst), status);
+	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
 	if (!status) {
 		struct sco_conn *conn;
 
@@ -963,8 +963,8 @@ static int sco_debugfs_show(struct seq_file *f, void *p)
 	read_lock(&sco_sk_list.lock);
 
 	sk_for_each(sk, node, &sco_sk_list.head) {
-		seq_printf(f, "%s %s %d\n", batostr(&bt_sk(sk)->src),
-			   batostr(&bt_sk(sk)->dst), sk->sk_state);
+		seq_printf(f, "%pMR %pMR %d\n", &bt_sk(sk)->src,
+			   &bt_sk(sk)->dst, sk->sk_state);
 	}
 
 	read_unlock(&sco_sk_list.lock);
-- 
1.7.9.5

