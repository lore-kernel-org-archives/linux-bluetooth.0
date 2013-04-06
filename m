Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v4 01/16] Bluetooth: rename hci_conn_put to hci_conn_drop
Date: Sat,  6 Apr 2013 20:28:37 +0200
Message-Id: <1365272932-571-2-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
 <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We use _get() and _put() for device ref-counting in the kernel. However,
hci_conn_put() is _not_ used for ref-counting, hence, rename it to
hci_conn_drop() so we can later fix ref-counting and introduce
hci_conn_put().

hci_conn_hold() and hci_conn_put() are currently used to manage how long a
connection should be held alive. When the last user drops the connection,
we spawn a delayed work that performs the disconnect. Obviously, this has
nothing to do with ref-counting for the _object_ but rather for the
keep-alive of the connection.

But we really _need_ proper ref-counting for the _object_ to allow
connection-users like rfcomm-tty, HIDP or others.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_conn.c         |  6 +++---
 net/bluetooth/hci_event.c        | 36 ++++++++++++++++++------------------
 net/bluetooth/l2cap_core.c       |  6 +++---
 net/bluetooth/mgmt.c             |  6 +++---
 net/bluetooth/sco.c              |  6 +++---
 net/bluetooth/smp.c              |  2 +-
 7 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d4e13bf..78ea9c7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -612,7 +612,7 @@ static inline void hci_conn_hold(struct hci_conn *conn)
 	cancel_delayed_work(&conn->disc_work);
 }
 
-static inline void hci_conn_put(struct hci_conn *conn)
+static inline void hci_conn_drop(struct hci_conn *conn)
 {
 	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b9f9016..30d7dfc 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -433,7 +433,7 @@ int hci_conn_del(struct hci_conn *conn)
 		struct hci_conn *acl = conn->link;
 		if (acl) {
 			acl->link = NULL;
-			hci_conn_put(acl);
+			hci_conn_drop(acl);
 		}
 	}
 
@@ -565,7 +565,7 @@ static struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type,
 	if (!sco) {
 		sco = hci_conn_add(hdev, type, dst);
 		if (!sco) {
-			hci_conn_put(acl);
+			hci_conn_drop(acl);
 			return ERR_PTR(-ENOMEM);
 		}
 	}
@@ -980,7 +980,7 @@ void hci_chan_del(struct hci_chan *chan)
 
 	synchronize_rcu();
 
-	hci_conn_put(conn);
+	hci_conn_drop(conn);
 
 	skb_queue_purge(&chan->data_q);
 	kfree(chan);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0a2b128..2cf28b1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1190,7 +1190,7 @@ static void hci_cs_auth_requested(struct hci_dev *hdev, __u8 status)
 	if (conn) {
 		if (conn->state == BT_CONFIG) {
 			hci_proto_connect_cfm(conn, status);
-			hci_conn_put(conn);
+			hci_conn_drop(conn);
 		}
 	}
 
@@ -1217,7 +1217,7 @@ static void hci_cs_set_conn_encrypt(struct hci_dev *hdev, __u8 status)
 	if (conn) {
 		if (conn->state == BT_CONFIG) {
 			hci_proto_connect_cfm(conn, status);
-			hci_conn_put(conn);
+			hci_conn_drop(conn);
 		}
 	}
 
@@ -1379,7 +1379,7 @@ static void hci_cs_read_remote_features(struct hci_dev *hdev, __u8 status)
 	if (conn) {
 		if (conn->state == BT_CONFIG) {
 			hci_proto_connect_cfm(conn, status);
-			hci_conn_put(conn);
+			hci_conn_drop(conn);
 		}
 	}
 
@@ -1406,7 +1406,7 @@ static void hci_cs_read_remote_ext_features(struct hci_dev *hdev, __u8 status)
 	if (conn) {
 		if (conn->state == BT_CONFIG) {
 			hci_proto_connect_cfm(conn, status);
-			hci_conn_put(conn);
+			hci_conn_drop(conn);
 		}
 	}
 
@@ -1860,7 +1860,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		} else {
 			conn->state = BT_CONNECT2;
 			hci_proto_connect_cfm(conn, 0);
-			hci_conn_put(conn);
+			hci_conn_drop(conn);
 		}
 	} else {
 		/* Connection rejected */
@@ -1967,14 +1967,14 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		} else {
 			conn->state = BT_CONNECTED;
 			hci_proto_connect_cfm(conn, ev->status);
-			hci_conn_put(conn);
+			hci_conn_drop(conn);
 		}
 	} else {
 		hci_auth_cfm(conn, ev->status);
 
 		hci_conn_hold(conn);
 		conn->disc_timeout = HCI_DISCONN_TIMEOUT;
-		hci_conn_put(conn);
+		hci_conn_drop(conn);
 	}
 
 	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags)) {
@@ -2058,7 +2058,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 		if (ev->status && conn->state == BT_CONNECTED) {
 			hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
-			hci_conn_put(conn);
+			hci_conn_drop(conn);
 			goto unlock;
 		}
 
@@ -2067,7 +2067,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 				conn->state = BT_CONNECTED;
 
 			hci_proto_connect_cfm(conn, ev->status);
-			hci_conn_put(conn);
+			hci_conn_drop(conn);
 		} else
 			hci_encrypt_cfm(conn, ev->status, ev->encrypt);
 	}
@@ -2142,7 +2142,7 @@ static void hci_remote_features_evt(struct hci_dev *hdev,
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
 		hci_proto_connect_cfm(conn, ev->status);
-		hci_conn_put(conn);
+		hci_conn_drop(conn);
 	}
 
 unlock:
@@ -2682,7 +2682,7 @@ static void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (conn->state == BT_CONNECTED) {
 		hci_conn_hold(conn);
 		conn->disc_timeout = HCI_PAIRING_TIMEOUT;
-		hci_conn_put(conn);
+		hci_conn_drop(conn);
 	}
 
 	if (!test_bit(HCI_PAIRABLE, &hdev->dev_flags))
@@ -2785,7 +2785,7 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		if (ev->key_type != HCI_LK_CHANGED_COMBINATION)
 			conn->key_type = ev->key_type;
 
-		hci_conn_put(conn);
+		hci_conn_drop(conn);
 	}
 
 	if (test_bit(HCI_LINK_KEYS, &hdev->dev_flags))
@@ -2954,7 +2954,7 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev,
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
 		hci_proto_connect_cfm(conn, ev->status);
-		hci_conn_put(conn);
+		hci_conn_drop(conn);
 	}
 
 unlock:
@@ -3087,7 +3087,7 @@ static void hci_key_refresh_complete_evt(struct hci_dev *hdev,
 
 	if (ev->status && conn->state == BT_CONNECTED) {
 		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
-		hci_conn_put(conn);
+		hci_conn_drop(conn);
 		goto unlock;
 	}
 
@@ -3096,13 +3096,13 @@ static void hci_key_refresh_complete_evt(struct hci_dev *hdev,
 			conn->state = BT_CONNECTED;
 
 		hci_proto_connect_cfm(conn, ev->status);
-		hci_conn_put(conn);
+		hci_conn_drop(conn);
 	} else {
 		hci_auth_cfm(conn, ev->status);
 
 		hci_conn_hold(conn);
 		conn->disc_timeout = HCI_DISCONN_TIMEOUT;
-		hci_conn_put(conn);
+		hci_conn_drop(conn);
 	}
 
 unlock:
@@ -3363,7 +3363,7 @@ static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
 		mgmt_auth_failed(hdev, &conn->dst, conn->type, conn->dst_type,
 				 ev->status);
 
-	hci_conn_put(conn);
+	hci_conn_drop(conn);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -3451,7 +3451,7 @@ static void hci_phy_link_complete_evt(struct hci_dev *hdev,
 
 	hci_conn_hold(hcon);
 	hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
-	hci_conn_put(hcon);
+	hci_conn_drop(hcon);
 
 	hci_conn_hold_device(hcon);
 	hci_conn_add_sysfs(hcon);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7c7e932..7cdb93c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -571,7 +571,7 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		chan->conn = NULL;
 
 		if (chan->chan_type != L2CAP_CHAN_CONN_FIX_A2MP)
-			hci_conn_put(conn->hcon);
+			hci_conn_drop(conn->hcon);
 
 		if (mgr && mgr->bredr_chan == chan)
 			mgr->bredr_chan = NULL;
@@ -1697,7 +1697,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 
 	conn = l2cap_conn_add(hcon, 0);
 	if (!conn) {
-		hci_conn_put(hcon);
+		hci_conn_drop(hcon);
 		err = -ENOMEM;
 		goto done;
 	}
@@ -1707,7 +1707,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 
 		if (!list_empty(&conn->chan_l)) {
 			err = -EBUSY;
-			hci_conn_put(hcon);
+			hci_conn_drop(hcon);
 		}
 
 		if (err)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 03e7e73..34ba164 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2131,7 +2131,7 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
 	conn->security_cfm_cb = NULL;
 	conn->disconn_cfm_cb = NULL;
 
-	hci_conn_put(conn);
+	hci_conn_drop(conn);
 
 	mgmt_pending_remove(cmd);
 }
@@ -2222,7 +2222,7 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	if (conn->connect_cfm_cb) {
-		hci_conn_put(conn);
+		hci_conn_drop(conn);
 		err = cmd_complete(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
 				   MGMT_STATUS_BUSY, &rp, sizeof(rp));
 		goto unlock;
@@ -2231,7 +2231,7 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	cmd = mgmt_pending_add(sk, MGMT_OP_PAIR_DEVICE, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
-		hci_conn_put(conn);
+		hci_conn_drop(conn);
 		goto unlock;
 	}
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index d919d11..9909eec 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -185,7 +185,7 @@ static int sco_connect(struct sock *sk)
 
 	conn = sco_conn_add(hcon);
 	if (!conn) {
-		hci_conn_put(hcon);
+		hci_conn_drop(hcon);
 		err = -ENOMEM;
 		goto done;
 	}
@@ -353,7 +353,7 @@ static void __sco_sock_close(struct sock *sk)
 		if (sco_pi(sk)->conn->hcon) {
 			sk->sk_state = BT_DISCONN;
 			sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
-			hci_conn_put(sco_pi(sk)->conn->hcon);
+			hci_conn_drop(sco_pi(sk)->conn->hcon);
 			sco_pi(sk)->conn->hcon = NULL;
 		} else
 			sco_chan_del(sk, ECONNRESET);
@@ -882,7 +882,7 @@ static void sco_chan_del(struct sock *sk, int err)
 		sco_conn_unlock(conn);
 
 		if (conn->hcon)
-			hci_conn_put(conn->hcon);
+			hci_conn_drop(conn->hcon);
 	}
 
 	sk->sk_state = BT_CLOSED;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 5abefb1..b2296d3 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -522,7 +522,7 @@ void smp_chan_destroy(struct l2cap_conn *conn)
 	kfree(smp);
 	conn->smp_chan = NULL;
 	conn->hcon->smp_conn = NULL;
-	hci_conn_put(conn->hcon);
+	hci_conn_drop(conn->hcon);
 }
 
 int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
-- 
1.8.2

