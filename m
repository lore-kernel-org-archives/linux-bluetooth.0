Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 6/8] Bluetooth: Add support for reusing the same hci_conn for LE links
Date: Thu, 10 Nov 2011 22:03:54 -0300
Message-Id: <1320973436-13399-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1320973436-13399-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1320973436-13399-1-git-send-email-vinicius.gomes@openbossa.org>
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
 net/bluetooth/hci_conn.c   |   27 +++++++++++----------
 net/bluetooth/l2cap_core.c |   53 +++++++++++++++++++++++++++++--------------
 2 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index de0b93e..0bc2771 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -502,23 +502,24 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 	BT_DBG("%s dst %s", hdev->name, batostr(dst));
 
 	if (type == LE_LINK) {
-		struct adv_entry *entry;
+		struct adv_entry *entry = NULL;
 
 		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
-		if (le)
-			return ERR_PTR(-EBUSY);
+		if (!le) {
+			entry = hci_find_adv_entry(hdev, dst);
+			if (!entry)
+				return ERR_PTR(-EHOSTUNREACH);
 
-		entry = hci_find_adv_entry(hdev, dst);
-		if (!entry)
-			return ERR_PTR(-EHOSTUNREACH);
+			le = hci_conn_add(hdev, LE_LINK, dst);
+			if (!le)
+				return ERR_PTR(-ENOMEM);
 
-		le = hci_conn_add(hdev, LE_LINK, dst);
-		if (!le)
-			return ERR_PTR(-ENOMEM);
-
-		le->dst_type = entry->bdaddr_type;
-
-		hci_le_connect(le);
+			le->dst_type = entry->bdaddr_type;
+			le->pending_sec_level = sec_level;
+			le->sec_level = BT_SECURITY_LOW;
+			le->auth_type = auth_type;
+			hci_le_connect(le);
+		}
 
 		hci_conn_hold(le);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1790ce3..19dc625 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -656,10 +656,32 @@ static inline int __l2cap_no_conn_pending(struct l2cap_chan *chan)
 	return !test_bit(CONF_CONNECT_PEND, &chan->conf_state);
 }
 
+static void l2cap_chan_ready(struct sock *sk)
+{
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
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
+		l2cap_chan_ready(chan->sk);
+		return;
+	}
+
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT) {
 		if (!(conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE))
 			return;
@@ -910,23 +932,6 @@ clean:
 	bh_unlock_sock(parent);
 }
 
-static void l2cap_chan_ready(struct sock *sk)
-{
-	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
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
@@ -1170,6 +1175,20 @@ int l2cap_chan_connect(struct l2cap_chan *chan)
 		goto done;
 	}
 
+	if (hcon->type == LE_LINK) {
+		err = 0;
+
+		read_lock(&conn->chan_lock);
+		if (!list_empty(&conn->chan_l)) {
+			err = -EBUSY;
+			hci_conn_put(hcon);
+		}
+		read_unlock(&conn->chan_lock);
+
+		if (err)
+			goto done;
+	}
+
 	/* Update source addr of the socket */
 	bacpy(src, conn->src);
 
-- 
1.7.7

