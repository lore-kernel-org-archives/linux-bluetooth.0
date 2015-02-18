Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] Bluetooth: Convert L2CAP security callback to use hci_cb
Date: Wed, 18 Feb 2015 14:53:56 +0200
Message-Id: <1424264038-32153-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1424264038-32153-1-git-send-email-johan.hedberg@gmail.com>
References: <1424264038-32153-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's no reason to have the custom hci_proto_auth/encrypt_cfm helpers
when the hci_cb list works equally well. This patch adds L2CAP to the
hci_cb list and makes l2cap_security_cfm a private function of
l2cap_core.c.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 40 ++++++----------------------------------
 net/bluetooth/l2cap_core.c       | 14 ++++++++++----
 2 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 137a18226975..4a2db5e62699 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -506,7 +506,6 @@ int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 void l2cap_connect_cfm(struct hci_conn *hcon, u8 status);
 int l2cap_disconn_ind(struct hci_conn *hcon);
 void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason);
-int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt);
 int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
 
 int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
@@ -1107,35 +1106,6 @@ static inline void hci_proto_disconn_cfm(struct hci_conn *conn, __u8 reason)
 		conn->disconn_cfm_cb(conn, reason);
 }
 
-static inline void hci_proto_auth_cfm(struct hci_conn *conn, __u8 status)
-{
-	__u8 encrypt;
-
-	if (conn->type != ACL_LINK && conn->type != LE_LINK)
-		return;
-
-	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
-		return;
-
-	encrypt = test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x00;
-	l2cap_security_cfm(conn, status, encrypt);
-
-	if (conn->security_cfm_cb)
-		conn->security_cfm_cb(conn, status);
-}
-
-static inline void hci_proto_encrypt_cfm(struct hci_conn *conn, __u8 status,
-								__u8 encrypt)
-{
-	if (conn->type != ACL_LINK && conn->type != LE_LINK)
-		return;
-
-	l2cap_security_cfm(conn, status, encrypt);
-
-	if (conn->security_cfm_cb)
-		conn->security_cfm_cb(conn, status);
-}
-
 /* ----- HCI callbacks ----- */
 struct hci_cb {
 	struct list_head list;
@@ -1153,8 +1123,6 @@ static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 	struct hci_cb *cb;
 	__u8 encrypt;
 
-	hci_proto_auth_cfm(conn, status);
-
 	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
 		return;
 
@@ -1166,6 +1134,9 @@ static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 			cb->security_cfm(conn, status, encrypt);
 	}
 	mutex_unlock(&hci_cb_list_lock);
+
+	if (conn->security_cfm_cb)
+		conn->security_cfm_cb(conn, status);
 }
 
 static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status,
@@ -1179,14 +1150,15 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status,
 	if (conn->pending_sec_level > conn->sec_level)
 		conn->sec_level = conn->pending_sec_level;
 
-	hci_proto_encrypt_cfm(conn, status, encrypt);
-
 	mutex_lock(&hci_cb_list_lock);
 	list_for_each_entry(cb, &hci_cb_list, list) {
 		if (cb->security_cfm)
 			cb->security_cfm(conn, status, encrypt);
 	}
 	mutex_unlock(&hci_cb_list_lock);
+
+	if (conn->security_cfm_cb)
+		conn->security_cfm_cb(conn, status);
 }
 
 static inline void hci_key_change_cfm(struct hci_conn *conn, __u8 status)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ec6f78e481dc..424fcc5c4980 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7345,13 +7345,13 @@ static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
 	}
 }
 
-int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
+static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
 	struct l2cap_chan *chan;
 
 	if (!conn)
-		return 0;
+		return;
 
 	BT_DBG("conn %p status 0x%2.2x encrypt %u", conn, status, encrypt);
 
@@ -7434,8 +7434,6 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 	}
 
 	mutex_unlock(&conn->chan_lock);
-
-	return 0;
 }
 
 int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
@@ -7543,6 +7541,11 @@ drop:
 	return 0;
 }
 
+static struct hci_cb l2cap_cb = {
+	.name		= "L2CAP",
+	.security_cfm	= l2cap_security_cfm,
+};
+
 static int l2cap_debugfs_show(struct seq_file *f, void *p)
 {
 	struct l2cap_chan *c;
@@ -7584,6 +7587,8 @@ int __init l2cap_init(void)
 	if (err < 0)
 		return err;
 
+	hci_register_cb(&l2cap_cb);
+
 	if (IS_ERR_OR_NULL(bt_debugfs))
 		return 0;
 
@@ -7601,6 +7606,7 @@ int __init l2cap_init(void)
 void l2cap_exit(void)
 {
 	debugfs_remove(l2cap_debugfs);
+	hci_unregister_cb(&l2cap_cb);
 	l2cap_cleanup_sockets();
 }
 
-- 
2.1.0

