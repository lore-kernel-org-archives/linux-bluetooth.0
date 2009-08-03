Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 6/7] Bluetooth: Enable Streaming Mode on L2CAP
Date: Mon,  3 Aug 2009 02:41:32 -0300
Message-Id: <1249278093-725-6-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1249278093-725-5-git-send-email-gustavo@las.ic.unicamp.br>
References: <1249278093-725-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1249278093-725-2-git-send-email-gustavo@las.ic.unicamp.br>
 <1249278093-725-3-git-send-email-gustavo@las.ic.unicamp.br>
 <1249278093-725-4-git-send-email-gustavo@las.ic.unicamp.br>
 <1249278093-725-5-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

Streaming Mode is helpful for the Bluetooth Streaming profiles, such as
A2DP. It's doesn't have any error control and flow control.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |   82 +++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 12b8c2e..5969f7a 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1245,6 +1245,39 @@ static inline int l2cap_do_send(struct sock *sk, struct sk_buff *skb)
 	return err;
 }
 
+static int l2cap_streaming_send(struct sock *sk)
+{
+	struct sk_buff *skb, *tx_skb;
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	u16 *control;
+	int err;
+
+	while ((skb = sk->sk_send_head)) {
+		tx_skb = skb_clone(skb, GFP_ATOMIC);
+
+		control = (u16 *)(skb->data + L2CAP_HDR_SIZE);
+		*control |= cpu_to_le16(
+				pi->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
+
+		err = l2cap_do_send(sk, tx_skb);
+		if (err < 0) {
+			l2cap_send_disconn_req(pi->conn, sk);
+			return err;
+		}
+
+		pi->next_tx_seq = (pi->next_tx_seq + 1) % 64;
+
+		if (skb_queue_is_last(TX_QUEUE(sk), skb))
+			sk->sk_send_head = NULL;
+		else
+			sk->sk_send_head = skb_queue_next(TX_QUEUE(sk), skb);
+
+		skb = skb_dequeue(TX_QUEUE(sk));
+		kfree_skb(skb);
+	}
+	return 0;
+}
+
 static int l2cap_ertm_send(struct sock *sk)
 {
 	struct sk_buff *skb, *tx_skb;
@@ -1383,7 +1416,7 @@ static struct sk_buff *l2cap_create_basic_pdu(struct sock *sk, struct msghdr *ms
 	return skb;
 }
 
-static struct sk_buff *l2cap_create_ertm_pdu(struct sock *sk, struct msghdr *msg, size_t len, u16 control, u16 sdulen)
+static struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *msg, size_t len, u16 control, u16 sdulen)
 {
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 	struct sk_buff *skb;
@@ -1429,7 +1462,7 @@ static inline int l2cap_sar_segment_sdu(struct sock *sk, struct msghdr *msg, siz
 
 	__skb_queue_head_init(&sar_queue);
 	control = L2CAP_SDU_START;
-	skb = l2cap_create_ertm_pdu(sk, msg, pi->max_pdu_size, control, len);
+	skb = l2cap_create_iframe_pdu(sk, msg, pi->max_pdu_size, control, len);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1449,7 +1482,7 @@ static inline int l2cap_sar_segment_sdu(struct sock *sk, struct msghdr *msg, siz
 			buflen = len;
 		}
 
-		skb = l2cap_create_ertm_pdu(sk, msg, buflen, control, 0);
+		skb = l2cap_create_iframe_pdu(sk, msg, buflen, control, 0);
 		if (IS_ERR(skb)) {
 			skb_queue_purge(&sar_queue);
 			return PTR_ERR(skb);
@@ -1518,10 +1551,11 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 		break;
 
 	case L2CAP_MODE_ERTM:
+	case L2CAP_MODE_STREAMING:
 		/* Entire SDU fits into one PDU */
 		if (len <= pi->max_pdu_size) {
 			control = L2CAP_SDU_UNSEGMENTED;
-			skb = l2cap_create_ertm_pdu(sk, msg, len, control, 0);
+			skb = l2cap_create_iframe_pdu(sk, msg, len, control, 0);
 			if (IS_ERR(skb)) {
 				err = PTR_ERR(skb);
 				goto done;
@@ -1537,7 +1571,11 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 				goto done;
 		}
 
-		err = l2cap_ertm_send(sk);
+		if (pi->mode == L2CAP_MODE_STREAMING)
+			err = l2cap_streaming_send(sk);
+		else
+			err = l2cap_ertm_send(sk);
+
 		if (!err)
 			err = len;
 		break;
@@ -2051,7 +2089,7 @@ static int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
 {
 	u32 local_feat_mask = l2cap_feat_mask;
 	if (enable_ertm)
-		local_feat_mask |= L2CAP_FEAT_ERTM;
+		local_feat_mask |= L2CAP_FEAT_ERTM | L2CAP_FEAT_STREAMING;
 
 	switch (mode) {
 	case L2CAP_MODE_ERTM:
@@ -2772,7 +2810,7 @@ static inline int l2cap_information_req(struct l2cap_conn *conn, struct l2cap_cm
 		rsp->type   = cpu_to_le16(L2CAP_IT_FEAT_MASK);
 		rsp->result = cpu_to_le16(L2CAP_IR_SUCCESS);
 		if (enable_ertm)
-			feat_mask |= L2CAP_FEAT_ERTM;
+			feat_mask |= L2CAP_FEAT_ERTM | L2CAP_FEAT_STREAMING;
 		put_unaligned(cpu_to_le32(feat_mask), (__le32 *) rsp->data);
 		l2cap_send_cmd(conn, cmd->ident,
 					L2CAP_INFO_RSP, sizeof(buf), buf);
@@ -3092,7 +3130,9 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk_buff *skb)
 {
 	struct sock *sk;
+	struct l2cap_pinfo *pi;
 	u16 control, len;
+	u8 tx_seq;
 	int err;
 
 	sk = l2cap_get_chan_by_scid(&conn->chan_list, cid);
@@ -3101,19 +3141,21 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		goto drop;
 	}
 
+	pi = l2cap_pi(sk);
+
 	BT_DBG("sk %p, len %d", sk, skb->len);
 
 	if (sk->sk_state != BT_CONNECTED)
 		goto drop;
 
-	switch (l2cap_pi(sk)->mode) {
+	switch (pi->mode) {
 	case L2CAP_MODE_BASIC:
 		/* If socket recv buffers overflows we drop data here
 		 * which is *bad* because L2CAP has to be reliable.
 		 * But we don't have any other choice. L2CAP doesn't
 		 * provide flow control mechanism. */
 
-		if (l2cap_pi(sk)->imtu < skb->len)
+		if (pi->imtu < skb->len)
 			goto drop;
 
 		if (!sock_queue_rcv_skb(sk, skb))
@@ -3145,6 +3187,28 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 			goto done;
 		break;
 
+	case L2CAP_MODE_STREAMING:
+		control = get_unaligned_le16(skb->data);
+		skb_pull(skb, 2);
+		len = skb->len;
+
+		if (__is_sar_start(control))
+			len -= 2;
+
+		if (len > L2CAP_DEFAULT_MAX_PDU_SIZE || __is_sframe(control))
+			goto drop;
+
+		tx_seq = __get_txseq(control);
+
+		if (pi->expected_tx_seq == tx_seq)
+			pi->expected_tx_seq = (pi->expected_tx_seq + 1) % 64;
+		else
+			pi->expected_tx_seq = tx_seq + 1;
+
+		err = l2cap_sar_reassembly_sdu(sk, skb, control, tx_seq);
+
+		goto done;
+
 	default:
 		BT_DBG("sk %p: bad mode 0x%2.2x", sk, l2cap_pi(sk)->mode);
 		break;
-- 
1.6.3.3
