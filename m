Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2] Bluetooth: Add support for reusing the same hci_conn for LE links
Date: Tue,  7 Feb 2012 21:13:30 -0300
Message-Id: <1328660010-14247-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As most LE devices leave advertising mode when they enter the connected
state, we may want to "pass" that connection to other users.

The first user will be the pairing procedure, the connection is
established without an associated socket, after the pairing is
complete, userspace may want to discover via GATT what services the
newly bonded device has.

If userspace establishes the connection while the timeout still
hasn't expired, the connection will be re-used.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---

Changes: Rebased against current bluetooth-next.


 net/bluetooth/hci_conn.c   |   32 +++++++++++++++------------
 net/bluetooth/l2cap_core.c |   51 +++++++++++++++++++++++++++++--------------
 2 files changed, 52 insertions(+), 31 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b4ecdde..dd6700d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -524,23 +524,27 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 	BT_DBG("%s dst %s", hdev->name, batostr(dst));

 	if (type == LE_LINK) {
-		struct adv_entry *entry;
+		struct adv_entry *entry = NULL;

 		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
-		if (le)
-			return ERR_PTR(-EBUSY);
-
-		entry = hci_find_adv_entry(hdev, dst);
-		if (!entry)
-			return ERR_PTR(-EHOSTUNREACH);
-
-		le = hci_conn_add(hdev, LE_LINK, dst);
-		if (!le)
-			return ERR_PTR(-ENOMEM);
-
-		le->dst_type = entry->bdaddr_type;
+		if (!le) {
+			entry = hci_find_adv_entry(hdev, dst);
+			if (!entry)
+				return ERR_PTR(-EHOSTUNREACH);
+
+			le = hci_conn_add(hdev, LE_LINK, dst);
+			if (!le)
+				return ERR_PTR(-ENOMEM);
+
+			le->dst_type = entry->bdaddr_type;
+			le->pending_sec_level = sec_level;
+			le->sec_level = BT_SECURITY_LOW;
+			le->auth_type = auth_type;
+			hci_le_connect(le);
+		}

-		hci_le_connect(le);
+		le->pending_sec_level = sec_level;
+		le->auth_type = auth_type;

 		hci_conn_hold(le);

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f1a6b3c..eadee3a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -664,10 +664,32 @@ static inline int __l2cap_no_conn_pending(struct l2cap_chan *chan)
 	return !test_bit(CONF_CONNECT_PEND, &chan->conf_state);
 }

+static void l2cap_chan_ready(struct l2cap_chan *chan)
+{
+	struct sock *sk = chan->sk;
+	struct sock *parent = bt_sk(sk)->parent;
+
+	BT_DBG("sk %p, parent %p", sk, parent);
+
+	chan->conf_state = 0;
+	__clear_chan_timer(chan);
+
+	l2cap_state_change(chan, BT_CONNECTED);
+	sk->sk_state_change(sk);
+
+	if (parent)
+		parent->sk_data_ready(parent, 0);
+}
+
 static void l2cap_do_start(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;

+	if (conn->hcon->type == LE_LINK) {
+		l2cap_chan_ready(chan);
+		return;
+	}
+
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT) {
 		if (!(conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE))
 			return;
@@ -912,23 +934,6 @@ clean:
 	release_sock(parent);
 }

-static void l2cap_chan_ready(struct l2cap_chan *chan)
-{
-	struct sock *sk = chan->sk;
-	struct sock *parent = bt_sk(sk)->parent;
-
-	BT_DBG("sk %p, parent %p", sk, parent);
-
-	chan->conf_state = 0;
-	__clear_chan_timer(chan);
-
-	l2cap_state_change(chan, BT_CONNECTED);
-	sk->sk_state_change(sk);
-
-	if (parent)
-		parent->sk_data_ready(parent, 0);
-}
-
 static void l2cap_conn_ready(struct l2cap_conn *conn)
 {
 	struct l2cap_chan *chan;
@@ -1218,6 +1223,18 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
 		goto done;
 	}

+	if (hcon->type == LE_LINK) {
+		err = 0;
+
+		if (!list_empty(&conn->chan_l)) {
+			err = -EBUSY;
+			hci_conn_put(hcon);
+		}
+
+		if (err)
+			goto done;
+	}
+
 	/* Update source addr of the socket */
 	bacpy(src, conn->src);

--
1.7.8.1

