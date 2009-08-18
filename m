Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 6/8] Bluetooth: Add support to FCS Option on L2CAP
Date: Mon, 17 Aug 2009 23:53:48 -0300
Message-Id: <1250564030-13684-6-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1250564030-13684-5-git-send-email-gustavo@las.ic.unicamp.br>
References: <1250564030-13684-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1250564030-13684-2-git-send-email-gustavo@las.ic.unicamp.br>
 <1250564030-13684-3-git-send-email-gustavo@las.ic.unicamp.br>
 <1250564030-13684-4-git-send-email-gustavo@las.ic.unicamp.br>
 <1250564030-13684-5-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implement CRC16 check for L2CAP packets. FCS is used by Streaming Mode and
Enhanced Retransmission Mode and is a extra check for the packet content.
CRC16 is the default, L2CAP won't use FCS only when both side send a "No
FCS" request.

Initially based on a patch from Nathan Holstein <nathan@lampreynetworks.com>

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 include/net/bluetooth/l2cap.h |    2 +
 net/bluetooth/l2cap.c         |  101 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 97 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 33aea42..abb1b56 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -54,6 +54,7 @@ struct l2cap_options {
 	__u16 imtu;
 	__u16 flush_to;
 	__u8  mode;
+	__u8  fcs;
 };
 
 #define L2CAP_CONNINFO	0x02
@@ -348,6 +349,7 @@ struct l2cap_pinfo {
 #define L2CAP_CONF_MTU_DONE       0x08
 #define L2CAP_CONF_MODE_DONE      0x10
 #define L2CAP_CONF_CONNECT_PEND   0x20
+#define L2CAP_CONF_NO_FCS_RECV    0x40
 #define L2CAP_CONF_STATE2_DEVICE  0x80
 
 #define L2CAP_CONF_MAX_CONF_REQ 2
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index d4bf045..353422b 100644
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
 
@@ -1247,7 +1256,7 @@ static int l2cap_streaming_send(struct sock *sk)
 {
 	struct sk_buff *skb, *tx_skb;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	u16 control;
+	u16 control, fcs;
 	int err;
 
 	while ((skb = sk->sk_send_head)) {
@@ -1257,6 +1266,11 @@ static int l2cap_streaming_send(struct sock *sk)
 		control |= pi->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT;
 		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
+		if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16) {
+			fcs = crc16(0, (u8 *)tx_skb->data, tx_skb->len - 2);
+			put_unaligned_le16(fcs, tx_skb->data + tx_skb->len - 2);
+		}
+
 		err = l2cap_do_send(sk, tx_skb);
 		if (err < 0) {
 			l2cap_send_disconn_req(pi->conn, sk);
@@ -1280,7 +1294,7 @@ static int l2cap_ertm_send(struct sock *sk)
 {
 	struct sk_buff *skb, *tx_skb;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	u16 control;
+	u16 control, fcs;
 	int err;
 
 	if (pi->conn_state & L2CAP_CONN_WAIT_ACK)
@@ -1303,6 +1317,11 @@ static int l2cap_ertm_send(struct sock *sk)
 		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
 
+		if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16) {
+			fcs = crc16(0, (u8 *)skb->data, tx_skb->len - 2);
+			put_unaligned_le16(fcs, skb->data + tx_skb->len - 2);
+		}
+
 		err = l2cap_do_send(sk, tx_skb);
 		if (err < 0) {
 			l2cap_send_disconn_req(pi->conn, sk);
@@ -1426,6 +1445,9 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *m
 	if (sdulen)
 		hlen += 2;
 
+	if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16)
+		hlen += 2;
+
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 	skb = bt_skb_send_alloc(sk, count + hlen,
 			msg->msg_flags & MSG_DONTWAIT, &err);
@@ -1446,6 +1468,9 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *m
 		return ERR_PTR(err);
 	}
 
+	if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16)
+		put_unaligned_le16(0, skb_put(skb, 2));
+
 	bt_cb(skb)->retries = 0;
 	return skb;
 }
@@ -1631,6 +1656,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		opts.omtu     = l2cap_pi(sk)->omtu;
 		opts.flush_to = l2cap_pi(sk)->flush_to;
 		opts.mode     = l2cap_pi(sk)->mode;
+		opts.fcs      = l2cap_pi(sk)->fcs;
 
 		len = min_t(unsigned int, sizeof(opts), optlen);
 		if (copy_from_user((char *) &opts, optval, len)) {
@@ -1641,6 +1667,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		l2cap_pi(sk)->imtu = opts.imtu;
 		l2cap_pi(sk)->omtu = opts.omtu;
 		l2cap_pi(sk)->mode = opts.mode;
+		l2cap_pi(sk)->fcs  = opts.fcs;
 		break;
 
 	case L2CAP_LM:
@@ -1754,6 +1781,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 		opts.omtu     = l2cap_pi(sk)->omtu;
 		opts.flush_to = l2cap_pi(sk)->flush_to;
 		opts.mode     = l2cap_pi(sk)->mode;
+		opts.fcs      = l2cap_pi(sk)->fcs;
 
 		len = min_t(unsigned int, len, sizeof(opts));
 		if (copy_to_user(optval, (char *) &opts, len))
@@ -2152,6 +2180,15 @@ done:
 
 		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
 					sizeof(rfc), (unsigned long) &rfc);
+
+		if (!(pi->conn->feat_mask & L2CAP_FEAT_FCS))
+			break;
+
+		if (pi->fcs == L2CAP_FCS_NONE ||
+				pi->conf_state & L2CAP_CONF_NO_FCS_RECV) {
+			pi->fcs = L2CAP_FCS_NONE;
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, pi->fcs);
+		}
 		break;
 
 	case L2CAP_MODE_STREAMING:
@@ -2164,6 +2201,15 @@ done:
 
 		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
 					sizeof(rfc), (unsigned long) &rfc);
+
+		if (!(pi->conn->feat_mask & L2CAP_FEAT_FCS))
+			break;
+
+		if (pi->fcs == L2CAP_FCS_NONE ||
+				pi->conf_state & L2CAP_CONF_NO_FCS_RECV) {
+			pi->fcs = L2CAP_FCS_NONE;
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, pi->fcs);
+		}
 		break;
 	}
 
@@ -2215,6 +2261,12 @@ static int l2cap_parse_conf_req(struct sock *sk, void *data)
 				memcpy(&rfc, (void *) val, olen);
 			break;
 
+		case L2CAP_CONF_FCS:
+			if (val == L2CAP_FCS_NONE)
+				pi->conf_state |= L2CAP_CONF_NO_FCS_RECV;
+
+			break;
+
 		default:
 			if (hint)
 				break;
@@ -2636,6 +2688,10 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		goto unlock;
 
 	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_INPUT_DONE) {
+		if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_NO_FCS_RECV)
+				|| l2cap_pi(sk)->fcs != L2CAP_FCS_NONE)
+			l2cap_pi(sk)->fcs = L2CAP_FCS_CRC16;
+
 		sk->sk_state = BT_CONNECTED;
 		l2cap_pi(sk)->next_tx_seq = 0;
 		l2cap_pi(sk)->expected_ack_seq = 0;
@@ -2720,6 +2776,10 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	l2cap_pi(sk)->conf_state |= L2CAP_CONF_INPUT_DONE;
 
 	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_OUTPUT_DONE) {
+		if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_NO_FCS_RECV)
+				|| l2cap_pi(sk)->fcs != L2CAP_FCS_NONE)
+			l2cap_pi(sk)->fcs = L2CAP_FCS_CRC16;
+
 		sk->sk_state = BT_CONNECTED;
 		l2cap_pi(sk)->expected_tx_seq = 0;
 		l2cap_pi(sk)->num_to_ack = 0;
@@ -2807,7 +2867,8 @@ static inline int l2cap_information_req(struct l2cap_conn *conn, struct l2cap_cm
 		rsp->type   = cpu_to_le16(L2CAP_IT_FEAT_MASK);
 		rsp->result = cpu_to_le16(L2CAP_IR_SUCCESS);
 		if (enable_ertm)
-			feat_mask |= L2CAP_FEAT_ERTM | L2CAP_FEAT_STREAMING;
+			feat_mask |= L2CAP_FEAT_ERTM | L2CAP_FEAT_STREAMING
+				 | L2CAP_FEAT_FCS;
 		put_unaligned(cpu_to_le32(feat_mask), (__le32 *) rsp->data);
 		l2cap_send_cmd(conn, cmd->ident,
 					L2CAP_INFO_RSP, sizeof(buf), buf);
@@ -2959,6 +3020,22 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn, struct sk_buff *sk
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
+
 static int l2cap_sar_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 control)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
@@ -3169,6 +3246,9 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (__is_sar_start(control))
 			len -= 2;
 
+		if (pi->fcs == L2CAP_FCS_CRC16)
+			len -= 2;
+
 		/*
 		 * We can just drop the corrupted I-frame here.
 		 * Receiver will miss it and start proper recovery
@@ -3177,6 +3257,9 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (len > L2CAP_DEFAULT_MAX_PDU_SIZE)
 			goto drop;
 
+		if (l2cap_check_fcs(pi, skb))
+			goto drop;
+
 		if (__is_iframe(control))
 			err = l2cap_data_channel_iframe(sk, control, skb);
 		else
@@ -3194,9 +3277,15 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
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

