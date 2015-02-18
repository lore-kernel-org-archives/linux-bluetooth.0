Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] Bluetooth: Convert connect_cfm to be triggered through hci_cb
Date: Wed, 18 Feb 2015 14:53:57 +0200
Message-Id: <1424264038-32153-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1424264038-32153-1-git-send-email-johan.hedberg@gmail.com>
References: <1424264038-32153-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch moves all the connect_cfm callbacks to be based on the hci_cb
list. This means making l2cap_connect_cfm private to l2cap_core.c and
sco_connect_cb private to sco.c respectively. Since the hci_conn type
filtering isn't done any more on the wrapper level the callbacks
themselves need to check that they were passed a relevant type of
connection.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 40 ++++++++++++++++------------------------
 net/bluetooth/hci_conn.c         |  4 ++--
 net/bluetooth/hci_event.c        | 36 ++++++++++++++++++------------------
 net/bluetooth/l2cap_core.c       |  6 +++++-
 net/bluetooth/sco.c              | 15 ++++++++++++++-
 5 files changed, 55 insertions(+), 46 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4a2db5e62699..0f00f0e9f257 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -503,13 +503,11 @@ extern struct mutex hci_cb_list_lock;
 
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
-void l2cap_connect_cfm(struct hci_conn *hcon, u8 status);
 int l2cap_disconn_ind(struct hci_conn *hcon);
 void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason);
 int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
 
 int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
-void sco_connect_cfm(struct hci_conn *hcon, __u8 status);
 void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason);
 int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
 
@@ -1050,28 +1048,6 @@ static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	}
 }
 
-static inline void hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
-{
-	switch (conn->type) {
-	case ACL_LINK:
-	case LE_LINK:
-		l2cap_connect_cfm(conn, status);
-		break;
-
-	case SCO_LINK:
-	case ESCO_LINK:
-		sco_connect_cfm(conn, status);
-		break;
-
-	default:
-		BT_ERR("unknown link type %d", conn->type);
-		break;
-	}
-
-	if (conn->connect_cfm_cb)
-		conn->connect_cfm_cb(conn, status);
-}
-
 static inline int hci_proto_disconn_ind(struct hci_conn *conn)
 {
 	if (conn->type != ACL_LINK && conn->type != LE_LINK)
@@ -1112,12 +1088,28 @@ struct hci_cb {
 
 	char *name;
 
+	void (*connect_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*security_cfm)	(struct hci_conn *conn, __u8 status,
 								__u8 encrypt);
 	void (*key_change_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*role_switch_cfm)	(struct hci_conn *conn, __u8 status, __u8 role);
 };
 
+static inline void hci_connect_cfm(struct hci_conn *conn, __u8 status)
+{
+	struct hci_cb *cb;
+
+	mutex_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
+		if (cb->connect_cfm)
+			cb->connect_cfm(conn, status);
+	}
+	mutex_unlock(&hci_cb_list_lock);
+
+	if (conn->connect_cfm_cb)
+		conn->connect_cfm_cb(conn, status);
+}
+
 static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 {
 	struct hci_cb *cb;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e3263b61bcf3..e9206734e024 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -309,7 +309,7 @@ void hci_sco_setup(struct hci_conn *conn, __u8 status)
 		else
 			hci_add_sco(sco, conn->handle);
 	} else {
-		hci_proto_connect_cfm(sco, status);
+		hci_connect_cfm(sco, status);
 		hci_conn_del(sco);
 	}
 }
@@ -618,7 +618,7 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 	mgmt_connect_failed(hdev, &conn->dst, conn->type, conn->dst_type,
 			    status);
 
-	hci_proto_connect_cfm(conn, status);
+	hci_connect_cfm(conn, status);
 
 	hci_conn_del(conn);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a3fb094822b6..0b599129c64c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1537,7 +1537,7 @@ static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 		if (conn && conn->state == BT_CONNECT) {
 			if (status != 0x0c || conn->attempt > 2) {
 				conn->state = BT_CLOSED;
-				hci_proto_connect_cfm(conn, status);
+				hci_connect_cfm(conn, status);
 				hci_conn_del(conn);
 			} else
 				conn->state = BT_CONNECT2;
@@ -1581,7 +1581,7 @@ static void hci_cs_add_sco(struct hci_dev *hdev, __u8 status)
 		if (sco) {
 			sco->state = BT_CLOSED;
 
-			hci_proto_connect_cfm(sco, status);
+			hci_connect_cfm(sco, status);
 			hci_conn_del(sco);
 		}
 	}
@@ -1608,7 +1608,7 @@ static void hci_cs_auth_requested(struct hci_dev *hdev, __u8 status)
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
 	if (conn) {
 		if (conn->state == BT_CONFIG) {
-			hci_proto_connect_cfm(conn, status);
+			hci_connect_cfm(conn, status);
 			hci_conn_drop(conn);
 		}
 	}
@@ -1635,7 +1635,7 @@ static void hci_cs_set_conn_encrypt(struct hci_dev *hdev, __u8 status)
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
 	if (conn) {
 		if (conn->state == BT_CONFIG) {
-			hci_proto_connect_cfm(conn, status);
+			hci_connect_cfm(conn, status);
 			hci_conn_drop(conn);
 		}
 	}
@@ -1811,7 +1811,7 @@ static void hci_cs_read_remote_features(struct hci_dev *hdev, __u8 status)
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
 	if (conn) {
 		if (conn->state == BT_CONFIG) {
-			hci_proto_connect_cfm(conn, status);
+			hci_connect_cfm(conn, status);
 			hci_conn_drop(conn);
 		}
 	}
@@ -1838,7 +1838,7 @@ static void hci_cs_read_remote_ext_features(struct hci_dev *hdev, __u8 status)
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
 	if (conn) {
 		if (conn->state == BT_CONFIG) {
-			hci_proto_connect_cfm(conn, status);
+			hci_connect_cfm(conn, status);
 			hci_conn_drop(conn);
 		}
 	}
@@ -1873,7 +1873,7 @@ static void hci_cs_setup_sync_conn(struct hci_dev *hdev, __u8 status)
 		if (sco) {
 			sco->state = BT_CLOSED;
 
-			hci_proto_connect_cfm(sco, status);
+			hci_connect_cfm(sco, status);
 			hci_conn_del(sco);
 		}
 	}
@@ -2255,10 +2255,10 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_sco_setup(conn, ev->status);
 
 	if (ev->status) {
-		hci_proto_connect_cfm(conn, ev->status);
+		hci_connect_cfm(conn, ev->status);
 		hci_conn_del(conn);
 	} else if (ev->link_type != ACL_LINK)
-		hci_proto_connect_cfm(conn, ev->status);
+		hci_connect_cfm(conn, ev->status);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -2366,7 +2366,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			     &cp);
 	} else {
 		conn->state = BT_CONNECT2;
-		hci_proto_connect_cfm(conn, 0);
+		hci_connect_cfm(conn, 0);
 	}
 }
 
@@ -2501,7 +2501,7 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 				     &cp);
 		} else {
 			conn->state = BT_CONNECTED;
-			hci_proto_connect_cfm(conn, ev->status);
+			hci_connect_cfm(conn, ev->status);
 			hci_conn_drop(conn);
 		}
 	} else {
@@ -2629,12 +2629,12 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		if (test_bit(HCI_SC_ONLY, &hdev->dev_flags) &&
 		    (!test_bit(HCI_CONN_AES_CCM, &conn->flags) ||
 		     conn->key_type != HCI_LK_AUTH_COMBINATION_P256)) {
-			hci_proto_connect_cfm(conn, HCI_ERROR_AUTH_FAILURE);
+			hci_connect_cfm(conn, HCI_ERROR_AUTH_FAILURE);
 			hci_conn_drop(conn);
 			goto unlock;
 		}
 
-		hci_proto_connect_cfm(conn, ev->status);
+		hci_connect_cfm(conn, ev->status);
 		hci_conn_drop(conn);
 	} else
 		hci_encrypt_cfm(conn, ev->status, ev->encrypt);
@@ -2707,7 +2707,7 @@ static void hci_remote_features_evt(struct hci_dev *hdev,
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
-		hci_proto_connect_cfm(conn, ev->status);
+		hci_connect_cfm(conn, ev->status);
 		hci_conn_drop(conn);
 	}
 
@@ -3679,7 +3679,7 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev,
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
-		hci_proto_connect_cfm(conn, ev->status);
+		hci_connect_cfm(conn, ev->status);
 		hci_conn_drop(conn);
 	}
 
@@ -3738,7 +3738,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 		break;
 	}
 
-	hci_proto_connect_cfm(conn, ev->status);
+	hci_connect_cfm(conn, ev->status);
 	if (ev->status)
 		hci_conn_del(conn);
 
@@ -3849,7 +3849,7 @@ static void hci_key_refresh_complete_evt(struct hci_dev *hdev,
 		if (!ev->status)
 			conn->state = BT_CONNECTED;
 
-		hci_proto_connect_cfm(conn, ev->status);
+		hci_connect_cfm(conn, ev->status);
 		hci_conn_drop(conn);
 	} else {
 		hci_auth_cfm(conn, ev->status);
@@ -4512,7 +4512,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_debugfs_create_conn(conn);
 	hci_conn_add_sysfs(conn);
 
-	hci_proto_connect_cfm(conn, ev->status);
+	hci_connect_cfm(conn, ev->status);
 
 	params = hci_pend_le_action_lookup(&hdev->pend_le_conns, &conn->dst,
 					   conn->dst_type);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 424fcc5c4980..6e2c3bdda7d3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7252,13 +7252,16 @@ static struct l2cap_chan *l2cap_global_fixed_chan(struct l2cap_chan *c,
 	return NULL;
 }
 
-void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
+static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 {
 	struct hci_dev *hdev = hcon->hdev;
 	struct l2cap_conn *conn;
 	struct l2cap_chan *pchan;
 	u8 dst_type;
 
+	if (hcon->type != ACL_LINK && hcon->type != LE_LINK)
+		return;
+
 	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
 
 	if (status) {
@@ -7543,6 +7546,7 @@ drop:
 
 static struct hci_cb l2cap_cb = {
 	.name		= "L2CAP",
+	.connect_cfm	= l2cap_connect_cfm,
 	.security_cfm	= l2cap_security_cfm,
 };
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 76321b546e84..3c2e36f94b65 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1083,9 +1083,13 @@ int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	return lm;
 }
 
-void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
+static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 {
+	if (hcon->type != SCO_LINK && hcon->type != ESCO_LINK)
+		return;
+
 	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
+
 	if (!status) {
 		struct sco_conn *conn;
 
@@ -1122,6 +1126,11 @@ drop:
 	return 0;
 }
 
+static struct hci_cb sco_cb = {
+	.name		= "SCO",
+	.connect_cfm	= sco_connect_cfm,
+};
+
 static int sco_debugfs_show(struct seq_file *f, void *p)
 {
 	struct sock *sk;
@@ -1203,6 +1212,8 @@ int __init sco_init(void)
 
 	BT_INFO("SCO socket layer initialized");
 
+	hci_register_cb(&sco_cb);
+
 	if (IS_ERR_OR_NULL(bt_debugfs))
 		return 0;
 
@@ -1222,6 +1233,8 @@ void __exit sco_exit(void)
 
 	debugfs_remove(sco_debugfs);
 
+	hci_unregister_cb(&sco_cb);
+
 	bt_sock_unregister(BTPROTO_SCO);
 
 	proto_unregister(&sco_proto);
-- 
2.1.0

