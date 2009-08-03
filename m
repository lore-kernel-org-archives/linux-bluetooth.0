Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 7/7] Bluetooth: Add support to FCS Option on L2CAP
Date: Mon,  3 Aug 2009 02:41:33 -0300
Message-Id: <1249278093-725-7-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1249278093-725-6-git-send-email-gustavo@las.ic.unicamp.br>
References: <1249278093-725-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1249278093-725-2-git-send-email-gustavo@las.ic.unicamp.br>
 <1249278093-725-3-git-send-email-gustavo@las.ic.unicamp.br>
 <1249278093-725-4-git-send-email-gustavo@las.ic.unicamp.br>
 <1249278093-725-5-git-send-email-gustavo@las.ic.unicamp.br>
 <1249278093-725-6-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

Implement crc16 check for L2CAP packets. FCS is used by Streaming Mode
and Enhanced Retransmission Mode and is a extra check for the packet
content.
Linux will always use FCS when both sides support it.

Initially based on a patch from Nathan Holstein <nathan@lampreynetworks.com>

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |   77 +++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 5969f7a..de06837 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -41,6 +41,7 @@
 #include <linux/list.h>
 #include <linux/device.h>
 #include <linux/uaccess.h>
+#include <linux/crc16.h>
 #include <net/sock.h>
 
 #include <asm/system.h>
@@ -338,11 +339,14 @@ static inline int l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
 	struct sk_buff *skb;
 	struct l2cap_hdr *lh;
 	struct l2cap_conn *conn = pi->conn;
-	int count;
+	int count, hlen = L2CAP_HDR_SIZE + 2;
+
+	if (pi->fcs == L2CAP_FCS_CRC16)
+		hlen += 2;
 
 	BT_DBG("pi %p, control 0x%2.2x", pi, control);
 
-	count = min_t(unsigned int, conn->mtu, L2CAP_HDR_SIZE + 2);
+	count = min_t(unsigned int, conn->mtu, hlen);
 	control |= L2CAP_CTRL_FRAME_TYPE;
 
 	skb = bt_skb_alloc(count, GFP_ATOMIC);
@@ -350,10 +354,15 @@ static inline int l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
 		return -ENOMEM;
 
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
-	lh->len = cpu_to_le16(2);
+	lh->len = cpu_to_le16(hlen - L2CAP_HDR_SIZE);
 	lh->cid = cpu_to_le16(pi->dcid);
 	put_unaligned_le16(control, skb_put(skb, 2));
 
+	if (pi->fcs == L2CAP_FCS_CRC16) {
+		u16 fcs = crc16(0, (u8 *)lh, count - 2);
+		put_unaligned_le16(fcs, skb_put(skb, 2));
+	}
+
 	return hci_send_acl(pi->conn->hcon, skb, 0);
 }
 
@@ -756,7 +765,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		pi->imtu = L2CAP_DEFAULT_MTU;
 		pi->omtu = 0;
 		pi->mode = L2CAP_MODE_BASIC;
-		pi->fcs  = L2CAP_FCS_CRC16;
+		pi->fcs  = L2CAP_FCS_NONE;
 		pi->sec_level = BT_SECURITY_LOW;
 		pi->role_switch = 0;
 		pi->force_reliable = 0;
@@ -1249,7 +1258,7 @@ static int l2cap_streaming_send(struct sock *sk)
 {
 	struct sk_buff *skb, *tx_skb;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	u16 *control;
+	u16 *control, *fcs;
 	int err;
 
 	while ((skb = sk->sk_send_head)) {
@@ -1259,6 +1268,11 @@ static int l2cap_streaming_send(struct sock *sk)
 		*control |= cpu_to_le16(
 				pi->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
 
+		if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16) {
+			fcs = (u16 *)(skb->data + skb->len - 2);
+			*fcs = crc16(0, (u8 *)skb->data, skb->len - 2);
+		}
+
 		err = l2cap_do_send(sk, tx_skb);
 		if (err < 0) {
 			l2cap_send_disconn_req(pi->conn, sk);
@@ -1282,7 +1296,7 @@ static int l2cap_ertm_send(struct sock *sk)
 {
 	struct sk_buff *skb, *tx_skb;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	u16 *control;
+	u16 *control, *fcs;
 	int err;
 
 	if (pi->conn_state & L2CAP_CONN_WAIT_ACK)
@@ -1304,6 +1318,11 @@ static int l2cap_ertm_send(struct sock *sk)
 				(pi->req_seq << L2CAP_CTRL_REQSEQ_SHIFT)
 				| (pi->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT));
 
+		if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16) {
+			fcs = (u16 *)(skb->data + skb->len - 2);
+			*fcs = crc16(0, (u8 *)skb->data, skb->len - 2);
+		}
+
 		err = l2cap_do_send(sk, tx_skb);
 		if (err < 0) {
 			l2cap_send_disconn_req(pi->conn, sk);
@@ -1428,6 +1447,9 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *m
 	if (sdulen)
 		hlen += 2;
 
+	if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16)
+		hlen += 2;
+
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 	skb = bt_skb_send_alloc(sk, count + hlen,
 			msg->msg_flags & MSG_DONTWAIT, &err);
@@ -1448,6 +1470,9 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *m
 		return ERR_PTR(err);
 	}
 
+	if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16)
+		put_unaligned_le16(0, skb_put(skb, 2));
+
 	bt_cb(skb)->retries = 0;
 	return skb;
 }
@@ -2270,11 +2295,12 @@ done:
 
 		switch (rfc.mode) {
 		case L2CAP_MODE_BASIC:
-			pi->fcs = L2CAP_FCS_NONE;
 			pi->conf_state |= L2CAP_CONF_MODE_DONE;
 			break;
 
 		case L2CAP_MODE_ERTM:
+			if (pi->conn->feat_mask & L2CAP_FEAT_FCS)
+				pi->fcs = L2CAP_FCS_CRC16;
 			pi->remote_tx_win = rfc.txwin_size;
 			pi->remote_max_tx = rfc.max_transmit;
 			pi->max_pdu_size = rfc.max_pdu_size;
@@ -2286,6 +2312,8 @@ done:
 			break;
 
 		case L2CAP_MODE_STREAMING:
+			if (pi->conn->feat_mask & L2CAP_FEAT_FCS)
+				pi->fcs = L2CAP_FCS_CRC16;
 			pi->remote_tx_win = rfc.txwin_size;
 			pi->max_pdu_size = rfc.max_pdu_size;
 
@@ -2362,12 +2390,16 @@ static int l2cap_parse_conf_rsp(struct sock *sk, void *rsp, int len, void *data,
 	if (*result == L2CAP_CONF_SUCCESS) {
 		switch (rfc.mode) {
 		case L2CAP_MODE_ERTM:
+			if (pi->conn->feat_mask & L2CAP_FEAT_FCS)
+				pi->fcs = L2CAP_FCS_CRC16;
 			pi->remote_tx_win   = rfc.txwin_size;
 			pi->retrans_timeout = rfc.retrans_timeout;
 			pi->monitor_timeout = rfc.monitor_timeout;
 			pi->max_pdu_size    = le16_to_cpu(rfc.max_pdu_size);
 			break;
 		case L2CAP_MODE_STREAMING:
+			if (pi->conn->feat_mask & L2CAP_FEAT_FCS)
+				pi->fcs = L2CAP_FCS_CRC16;
 			pi->max_pdu_size    = le16_to_cpu(rfc.max_pdu_size);
 			break;
 		}
@@ -2810,7 +2842,8 @@ static inline int l2cap_information_req(struct l2cap_conn *conn, struct l2cap_cm
 		rsp->type   = cpu_to_le16(L2CAP_IT_FEAT_MASK);
 		rsp->result = cpu_to_le16(L2CAP_IR_SUCCESS);
 		if (enable_ertm)
-			feat_mask |= L2CAP_FEAT_ERTM | L2CAP_FEAT_STREAMING;
+			feat_mask |= L2CAP_FEAT_ERTM | L2CAP_FEAT_STREAMING
+				 | L2CAP_FEAT_FCS;
 		put_unaligned(cpu_to_le32(feat_mask), (__le32 *) rsp->data);
 		l2cap_send_cmd(conn, cmd->ident,
 					L2CAP_INFO_RSP, sizeof(buf), buf);
@@ -2862,6 +2895,7 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 
 			l2cap_conn_start(conn);
 		}
+
 	} else if (type == L2CAP_IT_FIXED_CHAN) {
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
 		conn->info_ident = 0;
@@ -2961,6 +2995,21 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn, struct sk_buff *sk
 
 	kfree_skb(skb);
 }
+static int l2cap_check_fcs(struct l2cap_pinfo *pi,  struct sk_buff *skb)
+{
+	u16 our_fcs, rcv_fcs;
+	int hdr_size = L2CAP_HDR_SIZE + 2;
+
+	if (pi->fcs == L2CAP_FCS_CRC16) {
+		skb_trim(skb, skb->len - 2);
+		rcv_fcs = get_unaligned_le16(skb->data + skb->len);
+		our_fcs = crc16(0, skb->data - hdr_size, skb->len + hdr_size);
+
+		if (our_fcs != rcv_fcs)
+			return -EINVAL;
+	}
+	return 0;
+}
 
 static int l2cap_sar_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 control, u8 txseq)
 {
@@ -3170,6 +3219,9 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (__is_sar_start(control))
 			len -= 2;
 
+		if (pi->fcs == L2CAP_FCS_CRC16)
+			len -= 2;
+
 		/*
 		 * We can just drop the corrupted I-frame here.
 		 * Receiver will miss it and start proper recovery
@@ -3178,6 +3230,9 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (len > L2CAP_DEFAULT_MAX_PDU_SIZE)
 			goto drop;
 
+		if (l2cap_check_fcs(pi, skb))
+			goto drop;
+
 		if (__is_iframe(control))
 			err = l2cap_data_channel_iframe(sk, control, skb);
 		else
@@ -3195,9 +3250,15 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (__is_sar_start(control))
 			len -= 2;
 
+		if (pi->fcs == L2CAP_FCS_CRC16)
+			len -= 2;
+
 		if (len > L2CAP_DEFAULT_MAX_PDU_SIZE || __is_sframe(control))
 			goto drop;
 
+		if (l2cap_check_fcs(pi, skb))
+			goto drop;
+
 		tx_seq = __get_txseq(control);
 
 		if (pi->expected_tx_seq == tx_seq)
-- 
1.6.3.3
