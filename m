Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] Bluetooth: Convert disconn_cfm to be triggered through hci_cb
Date: Wed, 18 Feb 2015 14:53:58 +0200
Message-Id: <1424264038-32153-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1424264038-32153-1-git-send-email-johan.hedberg@gmail.com>
References: <1424264038-32153-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch moves all the disconn_cfm callbacks to be based on the hci_cb
list. This means making l2cap_disconn_cfm private to l2cap_core.c and
sco_conn_cb private to sco.c respectively. Since the hci_conn type
filtering isn't done any more on the wrapper level the callbacks
themselves need to check that they were passed a relevant type of
connection.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 44 +++++++++++++++-------------------------
 net/bluetooth/hci_conn.c         |  2 +-
 net/bluetooth/hci_event.c        |  2 +-
 net/bluetooth/l2cap_core.c       |  6 +++++-
 net/bluetooth/sco.c              |  6 +++++-
 5 files changed, 28 insertions(+), 32 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0f00f0e9f257..a7bf77384464 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -504,11 +504,9 @@ extern struct mutex hci_cb_list_lock;
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
-void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason);
 int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
 
 int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
-void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason);
 int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
 
 /* ----- Inquiry cache ----- */
@@ -1056,32 +1054,6 @@ static inline int hci_proto_disconn_ind(struct hci_conn *conn)
 	return l2cap_disconn_ind(conn);
 }
 
-static inline void hci_proto_disconn_cfm(struct hci_conn *conn, __u8 reason)
-{
-	switch (conn->type) {
-	case ACL_LINK:
-	case LE_LINK:
-		l2cap_disconn_cfm(conn, reason);
-		break;
-
-	case SCO_LINK:
-	case ESCO_LINK:
-		sco_disconn_cfm(conn, reason);
-		break;
-
-	/* L2CAP would be handled for BREDR chan */
-	case AMP_LINK:
-		break;
-
-	default:
-		BT_ERR("unknown link type %d", conn->type);
-		break;
-	}
-
-	if (conn->disconn_cfm_cb)
-		conn->disconn_cfm_cb(conn, reason);
-}
-
 /* ----- HCI callbacks ----- */
 struct hci_cb {
 	struct list_head list;
@@ -1089,6 +1061,7 @@ struct hci_cb {
 	char *name;
 
 	void (*connect_cfm)	(struct hci_conn *conn, __u8 status);
+	void (*disconn_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*security_cfm)	(struct hci_conn *conn, __u8 status,
 								__u8 encrypt);
 	void (*key_change_cfm)	(struct hci_conn *conn, __u8 status);
@@ -1110,6 +1083,21 @@ static inline void hci_connect_cfm(struct hci_conn *conn, __u8 status)
 		conn->connect_cfm_cb(conn, status);
 }
 
+static inline void hci_disconn_cfm(struct hci_conn *conn, __u8 reason)
+{
+	struct hci_cb *cb;
+
+	mutex_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
+		if (cb->disconn_cfm)
+			cb->disconn_cfm(conn, reason);
+	}
+	mutex_unlock(&hci_cb_list_lock);
+
+	if (conn->disconn_cfm_cb)
+		conn->disconn_cfm_cb(conn, reason);
+}
+
 static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 {
 	struct hci_cb *cb;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e9206734e024..91ebb9cb31de 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1151,7 +1151,7 @@ void hci_conn_hash_flush(struct hci_dev *hdev)
 	list_for_each_entry_safe(c, n, &h->list, list) {
 		c->state = BT_CLOSED;
 
-		hci_proto_disconn_cfm(c, HCI_ERROR_LOCAL_HOST_TERM);
+		hci_disconn_cfm(c, HCI_ERROR_LOCAL_HOST_TERM);
 		hci_conn_del(c);
 	}
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0b599129c64c..e9b17b585ee8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2444,7 +2444,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	type = conn->type;
 
-	hci_proto_disconn_cfm(conn, ev->reason);
+	hci_disconn_cfm(conn, ev->reason);
 	hci_conn_del(conn);
 
 	/* Re-enable advertising if necessary, since it might
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6e2c3bdda7d3..91c682846bcf 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7324,8 +7324,11 @@ int l2cap_disconn_ind(struct hci_conn *hcon)
 	return conn->disc_reason;
 }
 
-void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
+static void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
 {
+	if (hcon->type != ACL_LINK && hcon->type != LE_LINK)
+		return;
+
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
 	l2cap_conn_del(hcon, bt_to_errno(reason));
@@ -7547,6 +7550,7 @@ drop:
 static struct hci_cb l2cap_cb = {
 	.name		= "L2CAP",
 	.connect_cfm	= l2cap_connect_cfm,
+	.disconn_cfm	= l2cap_disconn_cfm,
 	.security_cfm	= l2cap_security_cfm,
 };
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 3c2e36f94b65..b94c3151896e 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1100,8 +1100,11 @@ static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 		sco_conn_del(hcon, bt_to_errno(status));
 }
 
-void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
+static void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 {
+	if (hcon->type != SCO_LINK && hcon->type != ESCO_LINK)
+		return;
+
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
 	sco_conn_del(hcon, bt_to_errno(reason));
@@ -1129,6 +1132,7 @@ drop:
 static struct hci_cb sco_cb = {
 	.name		= "SCO",
 	.connect_cfm	= sco_connect_cfm,
+	.disconn_cfm	= sco_disconn_cfm,
 };
 
 static int sco_debugfs_show(struct seq_file *f, void *p)
-- 
2.1.0

