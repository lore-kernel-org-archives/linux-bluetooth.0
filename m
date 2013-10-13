Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Provide msg_name callback for L2CAP connectionless channels
Date: Sun, 13 Oct 2013 12:55:29 -0700
Message-Id: <1381694129-51112-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The L2CAP connectionless channels use SOCK_DGRAM and recvmsg() and need
to receive the remote BD_ADDR and PSM information via msg_name from
the recvmsg() system call.

So in case the L2CAP socket is for connectionless channels, provide
a msg_name callback that can update the data. Also store the remote
BD_ADDR and PSM in the SKB so it can be extracted later on.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h |  2 ++
 net/bluetooth/l2cap_core.c        |  4 ++++
 net/bluetooth/l2cap_sock.c        | 15 ++++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 896aad8..bf2ddff 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -284,6 +284,8 @@ struct bt_skb_cb {
 	__u8 force_active;
 	struct l2cap_ctrl control;
 	struct hci_req_ctrl req;
+	bdaddr_t bdaddr;
+	__le16 psm;
 };
 #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 769c379..f6b5f94 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6459,6 +6459,10 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 	if (chan->imtu < skb->len)
 		goto drop;
 
+	/* Store remote BD_ADDR and PSM for msg_name */
+	bacpy(&bt_cb(skb)->bdaddr, &conn->hcon->dst);
+	bt_cb(skb)->psm = psm;
+
 	if (!chan->ops->recv(chan, skb))
 		return;
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 8fe9f49..f1b462f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1137,6 +1137,19 @@ static void l2cap_sock_destruct(struct sock *sk)
 	skb_queue_purge(&sk->sk_write_queue);
 }
 
+static void l2cap_skb_msg_name(struct sk_buff *skb, void *msg_name,
+			       int *msg_namelen)
+{
+	struct sockaddr_l2 *la = (struct sockaddr_l2 *) msg_name;
+
+	memset(la, 0, sizeof(struct sockaddr_l2));
+	la->l2_family = AF_BLUETOOTH;
+	la->l2_psm = bt_cb(skb)->psm;
+	bacpy(&la->l2_bdaddr, &bt_cb(skb)->bdaddr);
+
+	*msg_namelen = sizeof(struct sockaddr_l2);
+}
+
 static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 {
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
@@ -1163,13 +1176,13 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 
 		security_sk_clone(parent, sk);
 	} else {
-
 		switch (sk->sk_type) {
 		case SOCK_RAW:
 			chan->chan_type = L2CAP_CHAN_RAW;
 			break;
 		case SOCK_DGRAM:
 			chan->chan_type = L2CAP_CHAN_CONN_LESS;
+			bt_sk(sk)->skb_msg_name = l2cap_skb_msg_name;
 			break;
 		case SOCK_SEQPACKET:
 		case SOCK_STREAM:
-- 
1.8.3.1

