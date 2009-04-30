Return-Path: <cyrus@holtmann.org>
From: ngh@isomerica.net
To: linux-bluetooth@vger.kernel.org
Cc: Nathan Holstein <nathan@lampreynetworks.com>
Subject: [PATCH 02/10] Add support for sending enhanced L2CAP data
Date: Thu, 30 Apr 2009 17:16:39 -0400
Message-Id: <1241126207-19996-3-git-send-email-ngh@isomerica.net>
In-Reply-To: <1241126207-19996-1-git-send-email-ngh@isomerica.net>
References: <1241126207-19996-1-git-send-email-ngh@isomerica.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Nathan Holstein <nathan@lampreynetworks.com>

When functioning in Enhanced Retransmission or Streaming mode, the complexity
of an L2CAP SDU is greatly increased.  This patch splits the control stream of
the original l2cap_sock_sendmsg() function dependent upon the socket's mode.

Previously, l2cap_do_send() did the work of copying data from an iovec into a
sk_buff.  Since both Basic and Enhanced modes need this functionality, a new
function, l2cap_skbuff_fromiovec() was added to do this work.

Signed-off-by: Nathan Holstein <nathan@lampreynetworks.com>
---
 include/net/bluetooth/bluetooth.h |    3 +-
 include/net/bluetooth/l2cap.h     |    8 ++
 net/bluetooth/l2cap.c             |  139 ++++++++++++++++++++++++++++++++----
 3 files changed, 133 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 5d005e6..a18b2d1 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -144,8 +144,9 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock);
 struct bt_skb_cb {
 	__u8 pkt_type;
 	__u8 incoming;
+	__u8 tx_seq;
 };
-#define bt_cb(skb) ((struct bt_skb_cb *)(skb->cb)) 
+#define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
 
 static inline struct sk_buff *bt_skb_alloc(unsigned int len, gfp_t how)
 {
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 21e84fb..e67b1ff 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -101,6 +101,8 @@ struct l2cap_conninfo {
 #define L2CAP_CONTROL_TXSEQ_SHIFT	1
 #define L2CAP_CONTROL_REQSEQ_SHIFT	8
 
+#define L2CAP_SEQ_NUM_INC(seq) ((seq) = (seq + 1) % 64)
+
 /* L2CAP Segmentation and Reassembly */
 #define L2CAP_SAR_UNSEGMENTED	0x0000
 #define L2CAP_SAR_SDU_START	0x4000
@@ -295,16 +297,22 @@ struct l2cap_pinfo {
 	__u8            sec_level;
 	__u8		role_switch;
 	__u8            force_reliable;
+	__u8		fcs;
+	__u8		mode;
 
 	__u8		conf_req[64];
 	__u8		conf_len;
 	__u8		conf_state;
 	__u8		conf_retry;
 
+        __u8		tx_seq;
+        __u8		req_seq;
+
 	__u8		ident;
 
 	__le16		sport;
 
+        struct sk_buff		*tx_buf;
 	struct l2cap_conn	*conn;
 	struct sock		*next_c;
 	struct sock		*prev_c;
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 31901be..7255c97 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -41,6 +41,7 @@
 #include <linux/list.h>
 #include <linux/device.h>
 #include <linux/uaccess.h>
+#include <linux/crc16.h>
 #include <net/sock.h>
 
 #include <asm/system.h>
@@ -718,12 +719,19 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		pi->sec_level = l2cap_pi(parent)->sec_level;
 		pi->role_switch = l2cap_pi(parent)->role_switch;
 		pi->force_reliable = l2cap_pi(parent)->force_reliable;
+		pi->fcs = l2cap_pi(parent)->fcs;
+		pi->mode = l2cap_pi(parent)->mode;
 	} else {
 		pi->imtu = L2CAP_DEFAULT_MTU;
 		pi->omtu = 0;
 		pi->sec_level = BT_SECURITY_LOW;
 		pi->role_switch = 0;
 		pi->force_reliable = 0;
+		pi->fcs = L2CAP_FCS_CRC16;
+		if (sk->sk_type == SOCK_STREAM)
+			pi->mode = L2CAP_MODE_ERTM;
+		else
+			pi->mode = L2CAP_MODE_BASIC;
 	}
 
 	/* Default config options */
@@ -1116,24 +1124,59 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *l
 	return 0;
 }
 
-static inline int l2cap_do_send(struct sock *sk, struct msghdr *msg, int len)
+static inline int l2cap_do_send(struct sock *sk, struct sk_buff *skb)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	int err;
+
+	BT_DBG("sk %p, skb %p len %d", sk, skb, skb->len);
+
+	if (pi->tx_buf) {
+		err = -EAGAIN;
+		goto fail;
+	}
+
+	pi->tx_buf = skb;
+	err = hci_send_acl(pi->conn->hcon, skb, 0);
+	if (unlikely(err) < 0) {
+		pi->tx_buf = 0;
+		goto fail;
+	}
+
+	return 0;
+
+fail:
+	kfree_skb(skb);
+	return err;
+}
+
+static int l2cap_skbuff_fromiovec(
+		struct sock *sk,		/* the socket */
+		struct msghdr *msg,		/* data to send */
+		u16 *control,			/* if != 0, ptr to control value */
+		u16 sdu_len,			/* if != 0, fragmented SDU */
+		int len,			/* the data length in the PDU */
+		struct sk_buff **out_skb)	/* the resulting sk_buff */
 {
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 	struct sk_buff *skb, **frag;
-	int err, hlen, count, sent = 0;
+	int err, count, hlen=0, sent=0, fcs=0;
 	struct l2cap_hdr *lh;
 
 	BT_DBG("sk %p len %d", sk, len);
 
 	/* First fragment (with L2CAP header) */
 	if (sk->sk_type == SOCK_DGRAM)
-		hlen = L2CAP_HDR_SIZE + 2;
-	else
-		hlen = L2CAP_HDR_SIZE;
-
-	count = min_t(unsigned int, (conn->mtu - hlen), len);
-
-	skb = bt_skb_send_alloc(sk, hlen + count,
+		hlen += 2;
+	if (control)
+		hlen += 2;
+	if (sdu_len)
+		hlen += 2;
+	if (l2cap_pi(sk)->fcs)
+		hlen += 2;
+
+	count = min_t(unsigned int, conn->mtu - hlen, len);
+	skb = bt_skb_send_alloc(sk, count + hlen + L2CAP_HDR_SIZE,
 			msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
 		return err;
@@ -1141,16 +1184,27 @@ static inline int l2cap_do_send(struct sock *sk, struct msghdr *msg, int len)
 	/* Create L2CAP header */
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
 	lh->cid = cpu_to_le16(l2cap_pi(sk)->dcid);
-	lh->len = cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
+	lh->len = cpu_to_le16(len + hlen);
 
 	if (sk->sk_type == SOCK_DGRAM)
 		put_unaligned(l2cap_pi(sk)->psm, (__le16 *) skb_put(skb, 2));
+	else {
+		if (control)
+			put_unaligned(*control, (__le16 *) skb_put(skb, 2));
+		if (sdu_len)
+			put_unaligned(sdu_len, (__le16 *) skb_put(skb, 2));
+	}
 
 	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count)) {
 		err = -EFAULT;
 		goto fail;
 	}
 
+	if (l2cap_pi(sk)->fcs) {
+		fcs = crc16(0, (u8 *)lh, count + hlen + L2CAP_HDR_SIZE - 2);
+		put_unaligned(fcs, (__le16 *) skb_put(skb, 2));
+	}
+
 	sent += count;
 	len  -= count;
 
@@ -1168,15 +1222,18 @@ static inline int l2cap_do_send(struct sock *sk, struct msghdr *msg, int len)
 			goto fail;
 		}
 
+		if (l2cap_pi(sk)->fcs) {
+			u16 fcs = crc16(0, skb->data, count);
+			put_unaligned(fcs, (__le16 *) skb_put(skb, 2));
+		}
+
 		sent += count;
 		len  -= count;
 
 		frag = &(*frag)->next;
 	}
-	err = hci_send_acl(conn->hcon, skb, 0);
-	if (err < 0)
-		goto fail;
 
+	*out_skb = skb;
 	return sent;
 
 fail:
@@ -1184,9 +1241,36 @@ fail:
 	return err;
 }
 
+static inline int l2cap_create_enhanced_sdu(struct sock *sk, struct msghdr *msg, size_t len, struct sk_buff **skb)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	u8 tx_seq = pi->tx_seq;
+	u16 control = tx_seq << L2CAP_CONTROL_TXSEQ_SHIFT;
+	u16 omtu = (pi->fcs) ? pi->omtu - 2 : pi->omtu;
+	int err;
+
+	BT_DBG("sk %p, len %d", sk, (int)len);
+
+	/* Entire SDU fits into one PDU */
+	if (len <= omtu) {
+		err = l2cap_skbuff_fromiovec(sk, msg, &control, 0, len, skb);
+		if (unlikely(err < 0))
+			return err;
+		L2CAP_SEQ_NUM_INC(pi->tx_seq);
+		bt_cb(*skb)->tx_seq = tx_seq;
+	}
+	else {
+		/* Segmentation added later */
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	int err = 0;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
@@ -1199,16 +1283,39 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 		return -EOPNOTSUPP;
 
 	/* Check outgoing MTU */
-	if (sk->sk_type != SOCK_RAW && len > l2cap_pi(sk)->omtu)
+	if ((sk->sk_type != SOCK_RAW || pi->mode == L2CAP_MODE_BASIC) &&
+			len > l2cap_pi(sk)->omtu)
 		return -EINVAL;
 
 	lock_sock(sk);
 
-	if (sk->sk_state == BT_CONNECTED)
-		err = l2cap_do_send(sk, msg, len);
+	if (sk->sk_state == BT_CONNECTED) {
+		struct sk_buff *skb = 0;
+
+		switch (pi->mode) {
+		case L2CAP_MODE_BASIC:
+			err = l2cap_skbuff_fromiovec(sk, msg, 0, 0, len, &skb);
+			break;
+
+		case L2CAP_MODE_ERTM:
+		case L2CAP_MODE_STREAM:
+			err = l2cap_create_enhanced_sdu(sk, msg, len, &skb);
+			break;
+
+		default:
+			BT_DBG("bad state %1.1x", pi->mode);
+			err = -EINVAL;
+		}
+
+		if (err < 0)
+			goto done;
+		if (!(err = l2cap_do_send(sk, skb)))
+			err = len;
+	}
 	else
 		err = -ENOTCONN;
 
+done:
 	release_sock(sk);
 	return err;
 }
-- 
1.6.0.6

