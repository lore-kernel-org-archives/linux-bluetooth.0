Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 30/34] Bluetooth: Make hci_send_acl() void
Date: Thu,  1 Apr 2010 17:23:48 -0300
Message-Id: <1270153432-6477-31-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1270153432-6477-30-git-send-email-padovan@profusion.mobi>
References: <1270153432-6477-1-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-2-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-3-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-4-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-5-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-6-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-7-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-8-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-9-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-10-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-11-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-12-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-13-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-14-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-15-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-16-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-17-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-18-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-19-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-20-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-21-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-22-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-23-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-24-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-25-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-26-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-27-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-28-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-29-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-30-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

hci_send_acl can't fail, so we can make it void. This patch changes
that and all the funcions that use hci_send_acl().

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_core.c         |    4 +-
 net/bluetooth/l2cap.c            |   67 +++++++++++++-------------------------
 3 files changed, 26 insertions(+), 47 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ce3c99e..21ff787 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -636,7 +636,7 @@ int hci_register_notifier(struct notifier_block *nb);
 int hci_unregister_notifier(struct notifier_block *nb);
 
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
-int hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags);
+void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags);
 int hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
 
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4ad2319..cc8074b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1260,7 +1260,7 @@ static void hci_add_acl_hdr(struct sk_buff *skb, __u16 handle, __u16 flags)
 	hdr->dlen   = cpu_to_le16(len);
 }
 
-int hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
+void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct sk_buff *list;
@@ -1303,7 +1303,7 @@ int hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
 
 	tasklet_schedule(&hdev->tx_task);
 
-	return 0;
+	return;
 }
 EXPORT_SYMBOL(hci_send_acl);
 
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index d5a34a5..12a93af 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -326,19 +326,19 @@ static inline u8 l2cap_get_ident(struct l2cap_conn *conn)
 	return id;
 }
 
-static inline int l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *data)
+static inline void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *data)
 {
 	struct sk_buff *skb = l2cap_build_cmd(conn, code, ident, len, data);
 
 	BT_DBG("code 0x%2.2x", code);
 
 	if (!skb)
-		return -ENOMEM;
+		return;
 
-	return hci_send_acl(conn->hcon, skb, 0);
+	hci_send_acl(conn->hcon, skb, 0);
 }
 
-static inline int l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
+static inline void l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
 {
 	struct sk_buff *skb;
 	struct l2cap_hdr *lh;
@@ -365,7 +365,7 @@ static inline int l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
 
 	skb = bt_skb_alloc(count, GFP_ATOMIC);
 	if (!skb)
-		return -ENOMEM;
+		return;
 
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
 	lh->len = cpu_to_le16(hlen - L2CAP_HDR_SIZE);
@@ -377,10 +377,10 @@ static inline int l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
 		put_unaligned_le16(fcs, skb_put(skb, 2));
 	}
 
-	return hci_send_acl(pi->conn->hcon, skb, 0);
+	hci_send_acl(pi->conn->hcon, skb, 0);
 }
 
-static inline int l2cap_send_rr_or_rnr(struct l2cap_pinfo *pi, u16 control)
+static inline void l2cap_send_rr_or_rnr(struct l2cap_pinfo *pi, u16 control)
 {
 	if (pi->conn_state & L2CAP_CONN_LOCAL_BUSY)
 		control |= L2CAP_SUPER_RCV_NOT_READY;
@@ -389,7 +389,7 @@ static inline int l2cap_send_rr_or_rnr(struct l2cap_pinfo *pi, u16 control)
 
 	control |= pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 
-	return l2cap_send_sframe(pi, control);
+	l2cap_send_sframe(pi, control);
 }
 
 static void l2cap_do_start(struct sock *sk)
@@ -1277,18 +1277,13 @@ static void l2cap_drop_acked_frames(struct sock *sk)
 	return;
 }
 
-static inline int l2cap_do_send(struct sock *sk, struct sk_buff *skb)
+static inline void l2cap_do_send(struct sock *sk, struct sk_buff *skb)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	int err;
 
 	BT_DBG("sk %p, skb %p len %d", sk, skb, skb->len);
 
-	err = hci_send_acl(pi->conn->hcon, skb, 0);
-	if (err < 0)
-		kfree_skb(skb);
-
-	return err;
+	hci_send_acl(pi->conn->hcon, skb, 0);
 }
 
 static int l2cap_streaming_send(struct sock *sk)
@@ -1296,7 +1291,6 @@ static int l2cap_streaming_send(struct sock *sk)
 	struct sk_buff *skb, *tx_skb;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	u16 control, fcs;
-	int err;
 
 	while ((skb = sk->sk_send_head)) {
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
@@ -1310,11 +1304,7 @@ static int l2cap_streaming_send(struct sock *sk)
 			put_unaligned_le16(fcs, tx_skb->data + tx_skb->len - 2);
 		}
 
-		err = l2cap_do_send(sk, tx_skb);
-		if (err < 0) {
-			l2cap_send_disconn_req(pi->conn, sk);
-			return err;
-		}
+		l2cap_do_send(sk, tx_skb);
 
 		pi->next_tx_seq = (pi->next_tx_seq + 1) % 64;
 
@@ -1334,7 +1324,6 @@ static int l2cap_retransmit_frame(struct sock *sk, u8 tx_seq)
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct sk_buff *skb, *tx_skb;
 	u16 control, fcs;
-	int err;
 
 	skb = skb_peek(TX_QUEUE(sk));
 	do {
@@ -1363,11 +1352,7 @@ static int l2cap_retransmit_frame(struct sock *sk, u8 tx_seq)
 			put_unaligned_le16(fcs, tx_skb->data + tx_skb->len - 2);
 		}
 
-		err = l2cap_do_send(sk, tx_skb);
-		if (err < 0) {
-			l2cap_send_disconn_req(pi->conn, sk);
-			return err;
-		}
+		l2cap_do_send(sk, tx_skb);
 		break;
 	} while(1);
 	return 0;
@@ -1378,7 +1363,7 @@ static int l2cap_ertm_send(struct sock *sk)
 	struct sk_buff *skb, *tx_skb;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	u16 control, fcs;
-	int err, nsent = 0;
+	int nsent = 0;
 
 	if (pi->conn_state & L2CAP_CONN_WAIT_F)
 		return 0;
@@ -1411,11 +1396,8 @@ static int l2cap_ertm_send(struct sock *sk)
 			put_unaligned_le16(fcs, skb->data + tx_skb->len - 2);
 		}
 
-		err = l2cap_do_send(sk, tx_skb);
-		if (err < 0) {
-			l2cap_send_disconn_req(pi->conn, sk);
-			return err;
-		}
+		l2cap_do_send(sk, tx_skb);
+
 		__mod_retrans_timer();
 
 		bt_cb(skb)->tx_seq = pi->next_tx_seq;
@@ -1435,7 +1417,7 @@ static int l2cap_ertm_send(struct sock *sk)
 	return nsent;
 }
 
-static int l2cap_send_ack(struct l2cap_pinfo *pi)
+static void l2cap_send_ack(struct l2cap_pinfo *pi)
 {
 	struct sock *sk = (struct sock *)pi;
 	u16 control = 0;
@@ -1444,15 +1426,15 @@ static int l2cap_send_ack(struct l2cap_pinfo *pi)
 
 	if (pi->conn_state & L2CAP_CONN_LOCAL_BUSY) {
 		control |= L2CAP_SUPER_RCV_NOT_READY;
-		return l2cap_send_sframe(pi, control);
+		l2cap_send_sframe(pi, control);
+		return;
 	} else if (l2cap_ertm_send(sk) == 0) {
 		control |= L2CAP_SUPER_RCV_READY;
-		return l2cap_send_sframe(pi, control);
+		l2cap_send_sframe(pi, control);
 	}
-	return 0;
 }
 
-static int l2cap_send_srejtail(struct sock *sk)
+static void l2cap_send_srejtail(struct sock *sk)
 {
 	struct srej_list *tail;
 	u16 control;
@@ -1464,8 +1446,6 @@ static int l2cap_send_srejtail(struct sock *sk)
 	control |= tail->tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 
 	l2cap_send_sframe(l2cap_pi(sk), control);
-
-	return 0;
 }
 
 static inline int l2cap_skbuff_fromiovec(struct sock *sk, struct msghdr *msg, int len, int count, struct sk_buff *skb)
@@ -1675,7 +1655,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 	/* Connectionless channel */
 	if (sk->sk_type == SOCK_DGRAM) {
 		skb = l2cap_create_connless_pdu(sk, msg, len);
-		err = l2cap_do_send(sk, skb);
+		l2cap_do_send(sk, skb);
 		goto done;
 	}
 
@@ -1694,9 +1674,8 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 			goto done;
 		}
 
-		err = l2cap_do_send(sk, skb);
-		if (!err)
-			err = len;
+		l2cap_do_send(sk, skb);
+		err = len;
 		break;
 
 	case L2CAP_MODE_ERTM:
-- 
1.6.4.4
