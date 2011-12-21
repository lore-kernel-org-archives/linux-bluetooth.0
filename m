Return-Path: <cyrus@holtmann.org>
From: Ulisses Furquim <ulisses@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi
Subject: [PATCH 2/2] Bluetooth: Make HCI call directly into SCO and L2CAP event functions
Date: Tue, 20 Dec 2011 23:18:22 -0200
Message-Id: <1324430302-3002-2-git-send-email-ulisses@profusion.mobi>
In-Reply-To: <1324430302-3002-1-git-send-email-ulisses@profusion.mobi>
References: <1324430302-3002-1-git-send-email-ulisses@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The struct hci_proto and all related register/unregister and dispatching
code was removed. HCI core code now call directly the SCO and L2CAP
event functions.

Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
---
 include/net/bluetooth/hci_core.h |  107 +++++++++-----------------------------
 net/bluetooth/hci_core.c         |   59 ++-------------------
 net/bluetooth/l2cap_core.c       |   38 ++-----------
 net/bluetooth/sco.c              |   27 ++--------
 4 files changed, 39 insertions(+), 192 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 25c161a..0be536e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -28,10 +28,6 @@
 #include <linux/interrupt.h>
 #include <net/bluetooth/hci.h>
 
-/* HCI upper protocols */
-#define HCI_PROTO_L2CAP	0
-#define HCI_PROTO_SCO	1
-
 /* HCI priority */
 #define HCI_PRIO_MAX	7
 
@@ -330,12 +326,24 @@ struct hci_chan {
 	unsigned int	sent;
 };
 
-extern struct hci_proto *hci_proto[];
 extern struct list_head hci_dev_list;
 extern struct list_head hci_cb_list;
 extern rwlock_t hci_dev_list_lock;
 extern rwlock_t hci_cb_list_lock;
 
+/* ----- HCI interface to upper protocols ----- */
+extern int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
+extern int l2cap_connect_cfm(struct hci_conn *hcon, u8 status);
+extern int l2cap_disconn_ind(struct hci_conn *hcon);
+extern int l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason);
+extern int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt);
+extern int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
+
+extern int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 type);
+extern int sco_connect_cfm(struct hci_conn *hcon, __u8 status);
+extern int sco_disconn_cfm(struct hci_conn *hcon, __u8 reason);
+extern int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
+
 /* ----- Inquiry cache ----- */
 #define INQUIRY_CACHE_AGE_MAX   (HZ*30)   /* 30 seconds */
 #define INQUIRY_ENTRY_AGE_MAX   (HZ*60)   /* 60 seconds */
@@ -677,53 +685,21 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_host_le_capable(dev)   ((dev)->extfeatures[0] & LMP_HOST_LE)
 
 /* ----- HCI protocols ----- */
-struct hci_proto {
-	char		*name;
-	unsigned int	id;
-	unsigned long	flags;
-
-	void		*priv;
-
-	int (*connect_ind)	(struct hci_dev *hdev, bdaddr_t *bdaddr,
-								__u8 type);
-	int (*connect_cfm)	(struct hci_conn *conn, __u8 status);
-	int (*disconn_ind)	(struct hci_conn *conn);
-	int (*disconn_cfm)	(struct hci_conn *conn, __u8 reason);
-	int (*recv_acldata)	(struct hci_conn *conn, struct sk_buff *skb,
-								__u16 flags);
-	int (*recv_scodata)	(struct hci_conn *conn, struct sk_buff *skb);
-	int (*security_cfm)	(struct hci_conn *conn, __u8 status,
-								__u8 encrypt);
-};
-
 static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
 								__u8 type)
 {
-	register struct hci_proto *hp;
 	int mask = 0;
 
-	hp = hci_proto[HCI_PROTO_L2CAP];
-	if (hp && hp->connect_ind)
-		mask |= hp->connect_ind(hdev, bdaddr, type);
-
-	hp = hci_proto[HCI_PROTO_SCO];
-	if (hp && hp->connect_ind)
-		mask |= hp->connect_ind(hdev, bdaddr, type);
+	mask |= l2cap_connect_ind(hdev, bdaddr, type);
+	mask |= sco_connect_ind(hdev, bdaddr, type);
 
 	return mask;
 }
 
 static inline void hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
 {
-	register struct hci_proto *hp;
-
-	hp = hci_proto[HCI_PROTO_L2CAP];
-	if (hp && hp->connect_cfm)
-		hp->connect_cfm(conn, status);
-
-	hp = hci_proto[HCI_PROTO_SCO];
-	if (hp && hp->connect_cfm)
-		hp->connect_cfm(conn, status);
+	l2cap_connect_cfm(conn, status);
+	sco_connect_cfm(conn, status);
 
 	if (conn->connect_cfm_cb)
 		conn->connect_cfm_cb(conn, status);
@@ -731,31 +707,14 @@ static inline void hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
 
 static inline int hci_proto_disconn_ind(struct hci_conn *conn)
 {
-	register struct hci_proto *hp;
-	int reason = HCI_ERROR_REMOTE_USER_TERM;
-
-	hp = hci_proto[HCI_PROTO_L2CAP];
-	if (hp && hp->disconn_ind)
-		reason = hp->disconn_ind(conn);
-
-	hp = hci_proto[HCI_PROTO_SCO];
-	if (hp && hp->disconn_ind)
-		reason = hp->disconn_ind(conn);
-
-	return reason;
+	/* no sco_disconn_ind */
+	return l2cap_disconn_ind(conn);
 }
 
 static inline void hci_proto_disconn_cfm(struct hci_conn *conn, __u8 reason)
 {
-	register struct hci_proto *hp;
-
-	hp = hci_proto[HCI_PROTO_L2CAP];
-	if (hp && hp->disconn_cfm)
-		hp->disconn_cfm(conn, reason);
-
-	hp = hci_proto[HCI_PROTO_SCO];
-	if (hp && hp->disconn_cfm)
-		hp->disconn_cfm(conn, reason);
+	l2cap_disconn_cfm(conn, reason);
+	sco_disconn_cfm(conn, reason);
 
 	if (conn->disconn_cfm_cb)
 		conn->disconn_cfm_cb(conn, reason);
@@ -763,7 +722,6 @@ static inline void hci_proto_disconn_cfm(struct hci_conn *conn, __u8 reason)
 
 static inline void hci_proto_auth_cfm(struct hci_conn *conn, __u8 status)
 {
-	register struct hci_proto *hp;
 	__u8 encrypt;
 
 	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend))
@@ -771,13 +729,8 @@ static inline void hci_proto_auth_cfm(struct hci_conn *conn, __u8 status)
 
 	encrypt = (conn->link_mode & HCI_LM_ENCRYPT) ? 0x01 : 0x00;
 
-	hp = hci_proto[HCI_PROTO_L2CAP];
-	if (hp && hp->security_cfm)
-		hp->security_cfm(conn, status, encrypt);
-
-	hp = hci_proto[HCI_PROTO_SCO];
-	if (hp && hp->security_cfm)
-		hp->security_cfm(conn, status, encrypt);
+	l2cap_security_cfm(conn, status, encrypt);
+	/* no sco_security_cfm */
 
 	if (conn->security_cfm_cb)
 		conn->security_cfm_cb(conn, status);
@@ -786,23 +739,13 @@ static inline void hci_proto_auth_cfm(struct hci_conn *conn, __u8 status)
 static inline void hci_proto_encrypt_cfm(struct hci_conn *conn, __u8 status,
 								__u8 encrypt)
 {
-	register struct hci_proto *hp;
-
-	hp = hci_proto[HCI_PROTO_L2CAP];
-	if (hp && hp->security_cfm)
-		hp->security_cfm(conn, status, encrypt);
-
-	hp = hci_proto[HCI_PROTO_SCO];
-	if (hp && hp->security_cfm)
-		hp->security_cfm(conn, status, encrypt);
+	l2cap_security_cfm(conn, status, encrypt);
+	/* no sco_security_cfm */
 
 	if (conn->security_cfm_cb)
 		conn->security_cfm_cb(conn, status);
 }
 
-int hci_register_proto(struct hci_proto *hproto);
-int hci_unregister_proto(struct hci_proto *hproto);
-
 /* ----- HCI callbacks ----- */
 struct hci_cb {
 	struct list_head list;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fea8dad..22c8331 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -69,10 +69,6 @@ DEFINE_RWLOCK(hci_dev_list_lock);
 LIST_HEAD(hci_cb_list);
 DEFINE_RWLOCK(hci_cb_list_lock);
 
-/* HCI protocols */
-#define HCI_MAX_PROTO	2
-struct hci_proto *hci_proto[HCI_MAX_PROTO];
-
 /* HCI notifiers list */
 static ATOMIC_NOTIFIER_HEAD(hci_notifier);
 
@@ -1830,43 +1826,6 @@ EXPORT_SYMBOL(hci_recv_stream_fragment);
 
 /* ---- Interface to upper protocols ---- */
 
-/* Register/Unregister protocols. */
-int hci_register_proto(struct hci_proto *hp)
-{
-	int err = 0;
-
-	BT_DBG("%p name %s id %d", hp, hp->name, hp->id);
-
-	if (hp->id >= HCI_MAX_PROTO)
-		return -EINVAL;
-
-	if (!hci_proto[hp->id])
-		hci_proto[hp->id] = hp;
-	else
-		err = -EEXIST;
-
-	return err;
-}
-EXPORT_SYMBOL(hci_register_proto);
-
-int hci_unregister_proto(struct hci_proto *hp)
-{
-	int err = 0;
-
-	BT_DBG("%p name %s id %d", hp, hp->name, hp->id);
-
-	if (hp->id >= HCI_MAX_PROTO)
-		return -EINVAL;
-
-	if (hci_proto[hp->id])
-		hci_proto[hp->id] = NULL;
-	else
-		err = -ENOENT;
-
-	return err;
-}
-EXPORT_SYMBOL(hci_unregister_proto);
-
 int hci_register_cb(struct hci_cb *cb)
 {
 	BT_DBG("%p name %s", cb, cb->name);
@@ -2470,16 +2429,11 @@ static inline void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 
 	if (conn) {
-		register struct hci_proto *hp;
-
 		hci_conn_enter_active_mode(conn, BT_POWER_FORCE_ACTIVE_OFF);
 
 		/* Send to upper protocol */
-		hp = hci_proto[HCI_PROTO_L2CAP];
-		if (hp && hp->recv_acldata) {
-			hp->recv_acldata(conn, skb, flags);
-			return;
-		}
+		l2cap_recv_acldata(conn, skb, flags);
+		return;
 	} else {
 		BT_ERR("%s ACL packet for unknown connection handle %d",
 			hdev->name, handle);
@@ -2508,14 +2462,9 @@ static inline void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 
 	if (conn) {
-		register struct hci_proto *hp;
-
 		/* Send to upper protocol */
-		hp = hci_proto[HCI_PROTO_SCO];
-		if (hp && hp->recv_scodata) {
-			hp->recv_scodata(conn, skb);
-			return;
-		}
+		sco_recv_scodata(conn, skb);
+		return;
 	} else {
 		BT_ERR("%s SCO packet for unknown connection handle %d",
 			hdev->name, handle);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a898285..3ef32f5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4413,7 +4413,7 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 
 /* ---- L2CAP interface with lower layer (HCI) ---- */
 
-static int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
+int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 {
 	int exact = 0, lm1 = 0, lm2 = 0;
 	struct l2cap_chan *c;
@@ -4447,7 +4447,7 @@ static int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 	return exact ? lm1 : lm2;
 }
 
-static int l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
+int l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 {
 	struct l2cap_conn *conn;
 
@@ -4466,7 +4466,7 @@ static int l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 	return 0;
 }
 
-static int l2cap_disconn_ind(struct hci_conn *hcon)
+int l2cap_disconn_ind(struct hci_conn *hcon)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
 
@@ -4478,7 +4478,7 @@ static int l2cap_disconn_ind(struct hci_conn *hcon)
 	return conn->disc_reason;
 }
 
-static int l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
+int l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
 {
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
@@ -4507,7 +4507,7 @@ static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
 	}
 }
 
-static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
+int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
 	struct l2cap_chan *chan;
@@ -4607,7 +4607,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 	return 0;
 }
 
-static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
+int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
 
@@ -4754,17 +4754,6 @@ static const struct file_operations l2cap_debugfs_fops = {
 
 static struct dentry *l2cap_debugfs;
 
-static struct hci_proto l2cap_hci_proto = {
-	.name		= "L2CAP",
-	.id		= HCI_PROTO_L2CAP,
-	.connect_ind	= l2cap_connect_ind,
-	.connect_cfm	= l2cap_connect_cfm,
-	.disconn_ind	= l2cap_disconn_ind,
-	.disconn_cfm	= l2cap_disconn_cfm,
-	.security_cfm	= l2cap_security_cfm,
-	.recv_acldata	= l2cap_recv_acldata
-};
-
 int __init l2cap_init(void)
 {
 	int err;
@@ -4773,13 +4762,6 @@ int __init l2cap_init(void)
 	if (err < 0)
 		return err;
 
-	err = hci_register_proto(&l2cap_hci_proto);
-	if (err < 0) {
-		BT_ERR("L2CAP protocol registration failed");
-		bt_sock_unregister(BTPROTO_L2CAP);
-		goto error;
-	}
-
 	if (bt_debugfs) {
 		l2cap_debugfs = debugfs_create_file("l2cap", 0444,
 					bt_debugfs, NULL, &l2cap_debugfs_fops);
@@ -4788,19 +4770,11 @@ int __init l2cap_init(void)
 	}
 
 	return 0;
-
-error:
-	l2cap_cleanup_sockets();
-	return err;
 }
 
 void l2cap_exit(void)
 {
 	debugfs_remove(l2cap_debugfs);
-
-	if (hci_unregister_proto(&l2cap_hci_proto) < 0)
-		BT_ERR("L2CAP protocol unregistration failed");
-
 	l2cap_cleanup_sockets();
 }
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 725e10d..4c428b5 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -893,7 +893,7 @@ done:
 }
 
 /* ----- SCO interface with lower layer (HCI) ----- */
-static int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 type)
+int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 type)
 {
 	register struct sock *sk;
 	struct hlist_node *node;
@@ -921,7 +921,7 @@ static int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 type)
 	return lm;
 }
 
-static int sco_connect_cfm(struct hci_conn *hcon, __u8 status)
+int sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 {
 	BT_DBG("hcon %p bdaddr %s status %d", hcon, batostr(&hcon->dst), status);
 
@@ -940,7 +940,7 @@ static int sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 	return 0;
 }
 
-static int sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
+int sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 {
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
@@ -952,7 +952,7 @@ static int sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 	return 0;
 }
 
-static int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
+int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
 {
 	struct sco_conn *conn = hcon->sco_data;
 
@@ -1028,15 +1028,6 @@ static const struct net_proto_family sco_sock_family_ops = {
 	.create	= sco_sock_create,
 };
 
-static struct hci_proto sco_hci_proto = {
-	.name		= "SCO",
-	.id		= HCI_PROTO_SCO,
-	.connect_ind	= sco_connect_ind,
-	.connect_cfm	= sco_connect_cfm,
-	.disconn_cfm	= sco_disconn_cfm,
-	.recv_scodata	= sco_recv_scodata
-};
-
 int __init sco_init(void)
 {
 	int err;
@@ -1051,13 +1042,6 @@ int __init sco_init(void)
 		goto error;
 	}
 
-	err = hci_register_proto(&sco_hci_proto);
-	if (err < 0) {
-		BT_ERR("SCO protocol registration failed");
-		bt_sock_unregister(BTPROTO_SCO);
-		goto error;
-	}
-
 	if (bt_debugfs) {
 		sco_debugfs = debugfs_create_file("sco", 0444,
 					bt_debugfs, NULL, &sco_debugfs_fops);
@@ -1081,9 +1065,6 @@ void __exit sco_exit(void)
 	if (bt_sock_unregister(BTPROTO_SCO) < 0)
 		BT_ERR("SCO socket unregistration failed");
 
-	if (hci_unregister_proto(&sco_hci_proto) < 0)
-		BT_ERR("SCO protocol unregistration failed");
-
 	proto_unregister(&sco_proto);
 }
 
-- 
1.7.8.rc4

