Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v3 1/5] Bluetooth: Move and rename hci_conn_accept
Date: Mon,  4 Feb 2013 14:56:24 +0100
Message-Id: <1359986188-24432-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since this function is only used by sco, move it from hci_event.c to
sco.c and rename to sco_conn_defer_accept.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
---
 include/net/bluetooth/hci_core.h |    1 -
 net/bluetooth/hci_event.c        |   36 ------------------------------------
 net/bluetooth/sco.c              |   38 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 90cf75a..f3be454 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -582,7 +582,6 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst);
 int hci_conn_del(struct hci_conn *conn);
 void hci_conn_hash_flush(struct hci_dev *hdev);
 void hci_conn_check_pending(struct hci_dev *hdev);
-void hci_conn_accept(struct hci_conn *conn, int mask);
 
 struct hci_chan *hci_chan_create(struct hci_conn *conn);
 void hci_chan_del(struct hci_chan *chan);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d4fcba6..3fd0212 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2095,42 +2095,6 @@ unlock:
 	hci_conn_check_pending(hdev);
 }
 
-void hci_conn_accept(struct hci_conn *conn, int mask)
-{
-	struct hci_dev *hdev = conn->hdev;
-
-	BT_DBG("conn %p", conn);
-
-	conn->state = BT_CONFIG;
-
-	if (!lmp_esco_capable(hdev)) {
-		struct hci_cp_accept_conn_req cp;
-
-		bacpy(&cp.bdaddr, &conn->dst);
-
-		if (lmp_rswitch_capable(hdev) && (mask & HCI_LM_MASTER))
-			cp.role = 0x00; /* Become master */
-		else
-			cp.role = 0x01; /* Remain slave */
-
-		hci_send_cmd(hdev, HCI_OP_ACCEPT_CONN_REQ, sizeof(cp), &cp);
-	} else /* lmp_esco_capable(hdev)) */ {
-		struct hci_cp_accept_sync_conn_req cp;
-
-		bacpy(&cp.bdaddr, &conn->dst);
-		cp.pkt_type = cpu_to_le16(conn->pkt_type);
-
-		cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
-		cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
-		cp.max_latency    = __constant_cpu_to_le16(0xffff);
-		cp.content_format = cpu_to_le16(hdev->voice_setting);
-		cp.retrans_effort = 0xff;
-
-		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
-			     sizeof(cp), &cp);
-	}
-}
-
 static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_conn_request *ev = (void *) skb->data;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index e435641..97177be6 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -654,6 +654,42 @@ static int sco_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 	return err;
 }
 
+static void sco_conn_defer_accept(struct hci_conn *conn, int mask)
+{
+	struct hci_dev *hdev = conn->hdev;
+
+	BT_DBG("conn %p", conn);
+
+	conn->state = BT_CONFIG;
+
+	if (!lmp_esco_capable(hdev)) {
+		struct hci_cp_accept_conn_req cp;
+
+		bacpy(&cp.bdaddr, &conn->dst);
+
+		if (lmp_rswitch_capable(hdev) && (mask & HCI_LM_MASTER))
+			cp.role = 0x00; /* Become master */
+		else
+			cp.role = 0x01; /* Remain slave */
+
+		hci_send_cmd(hdev, HCI_OP_ACCEPT_CONN_REQ, sizeof(cp), &cp);
+	} else /* lmp_esco_capable(hdev)) */ {
+		struct hci_cp_accept_sync_conn_req cp;
+
+		bacpy(&cp.bdaddr, &conn->dst);
+		cp.pkt_type = cpu_to_le16(conn->pkt_type);
+
+		cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
+		cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
+		cp.max_latency    = __constant_cpu_to_le16(0xffff);
+		cp.content_format = cpu_to_le16(hdev->voice_setting);
+		cp.retrans_effort = 0xff;
+
+		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
+			     sizeof(cp), &cp);
+	}
+}
+
 static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 			    struct msghdr *msg, size_t len, int flags)
 {
@@ -664,7 +700,7 @@ static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 
 	if (sk->sk_state == BT_CONNECT2 &&
 	    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
-		hci_conn_accept(pi->conn->hcon, 0);
+		sco_conn_defer_accept(pi->conn->hcon, 0);
 		sk->sk_state = BT_CONFIG;
 
 		release_sock(sk);
-- 
1.7.9.5

