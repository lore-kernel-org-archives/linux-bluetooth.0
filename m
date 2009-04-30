Return-Path: <cyrus@holtmann.org>
From: ngh@isomerica.net
To: linux-bluetooth@vger.kernel.org
Cc: Nathan Holstein <nathan@lampreynetworks.com>
Subject: [PATCH] Add #defines and data structures for enhanced L2CAP
Date: Wed, 29 Apr 2009 21:44:44 -0400
Message-Id: <1241055885-12250-1-git-send-email-ngh@isomerica.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Nathan Holstein <nathan@lampreynetworks.com>

This patch #defines many constants used for implementation of Enhanced
Retranmission and Streaming modes within L2CAP.

This also adds the necessary members to the socket data structures to support
the additional modes.
---
 include/net/bluetooth/bluetooth.h |    3 +-
 include/net/bluetooth/l2cap.h     |  118 ++++++++++++++++++++++++++++++++++---
 net/bluetooth/l2cap.c             |   17 ++++-
 3 files changed, 124 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 3ad5390..f532e2d 100644
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
index 300b63f..3770fb6 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -1,4 +1,4 @@
-/* 
+/*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
 
@@ -12,13 +12,13 @@
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
    IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
-   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES 
-   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN 
-   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF 
+   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
+   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 
-   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS, 
-   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS 
+   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
+   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
    SOFTWARE IS DISCLAIMED.
 */
 
@@ -26,12 +26,29 @@
 #define __L2CAP_H
 
 /* L2CAP defaults */
-#define L2CAP_DEFAULT_MTU	672
-#define L2CAP_DEFAULT_FLUSH_TO	0xFFFF
+#define L2CAP_DEFAULT_MTU		672
+#define L2CAP_DEFAULT_FLUSH_TO		0xFFFF
+#define L2CAP_DEFAULT_RX_WINDOW		1
+#define L2CAP_DEFAULT_MAX_RECEIVE	1
+#define L2CAP_DEFAULT_RETRANS_TIMEOUT	300    /* 300 milliseconds */
+#define L2CAP_DEFAULT_MONITOR_TIMEOUT	1000   /* 1 second */
+#define L2CAP_DEFAULT_MAX_RX_APDU	0xFFF7
 
 #define L2CAP_CONN_TIMEOUT	(40000) /* 40 seconds */
 #define L2CAP_INFO_TIMEOUT	(4000)  /*  4 seconds */
 
+#define L2CAP_FCS_GENERATOR	((u16)0xA001)
+
+/* L2CAP feature bits */
+#define L2CAP_FEATURE_FLOW	0x00000001
+#define L2CAP_FEATURE_RETRANS	0x00000002
+#define L2CAP_FEATURE_QOS	0x00000004
+#define L2CAP_FEATURE_E_RETRANS	0x00000008
+#define L2CAP_FEATURE_STREAM	0x00000010
+#define L2CAP_FEATURE_FCS	0x00000020
+#define L2CAP_FEATURE_FIX_CHAN	0x00000080
+#define L2CAP_FEATURE_RESERVED	0x80000000
+
 /* L2CAP socket address */
 struct sockaddr_l2 {
 	sa_family_t	l2_family;
@@ -76,6 +93,66 @@ struct l2cap_conninfo {
 #define L2CAP_INFO_REQ    0x0a
 #define L2CAP_INFO_RSP    0x0b
 
+/* L2CAP Control Field bit masks */
+#define L2CAP_CONTROL_SAR_MASK		0xC000
+#define L2CAP_CONTROL_REQSEQ_MASK	0x3F00
+#define L2CAP_CONTROL_TXSEQ_MASK	0x007E
+#define L2CAP_CONTROL_RETRANS_MASK	0x0080
+#define L2CAP_CONTROL_FINAL_MASK	0x0080
+#define L2CAP_CONTROL_POLL_MASK		0x0010
+#define L2CAP_CONTROL_SUPERVISE_MASK	0x000C
+#define L2CAP_CONTROL_TYPE_MASK		0x0001 /* I- or S-Frame */
+
+#define L2CAP_CONTROL_TXSEQ_SHIFT	1
+#define L2CAP_CONTROL_REQSEQ_SHIFT	8
+
+#define L2CAP_SEQ_NUM_INC(seq) ((seq) = (seq + 1) % 64)
+
+static inline u8 l2cap_control_txseq(u16 control)
+{
+	return (control & L2CAP_CONTROL_TXSEQ_MASK) >>
+			L2CAP_CONTROL_TXSEQ_SHIFT;
+}
+
+static inline u8 l2cap_control_reqseq(u16 control)
+{
+	return (control & L2CAP_CONTROL_REQSEQ_MASK) >>
+			L2CAP_CONTROL_REQSEQ_SHIFT;
+}
+
+static inline u16 l2cap_txseq_to_reqseq(u16 control)
+{
+	return (control & L2CAP_CONTROL_TXSEQ_MASK) <<
+			(L2CAP_CONTROL_REQSEQ_SHIFT - L2CAP_CONTROL_TXSEQ_SHIFT);
+}
+
+static inline int l2cap_is_I_frame(u16 control)
+{
+	return !(control & L2CAP_CONTROL_TYPE_MASK);
+}
+
+static inline int l2cap_is_S_frame(u16 control)
+{
+	return (control & L2CAP_CONTROL_TYPE_MASK);
+}
+
+/* L2CAP Segmentation and Reassembly */
+#define L2CAP_SAR_UNSEGMENTED	0x0000
+#define L2CAP_SAR_SDU_START	0x4000
+#define L2CAP_SAR_SDU_END	0x8000
+#define L2CAP_SAR_SDU_CONTINUE	0xC000
+
+/* L2CAP Supervisory Function */
+#define L2CAP_SUPER_RCV_READY		0x0000
+#define L2CAP_SUPER_REJECT		0x0004
+#define L2CAP_SUPER_RCV_NOT_READY	0x0008
+#define L2CAP_SUPER_SELECT_REJECT	0x000C
+
+/* L2CAP Optional FCS */
+#define L2CAP_FCS_DISABLE	0x00
+#define L2CAP_FCS_ENABLE	0x01
+#define L2CAP_FCS_DEFAULT	L2CAP_FCS_ENABLE
+
 /* L2CAP structures */
 struct l2cap_hdr {
 	__le16     len;
@@ -149,12 +226,14 @@ struct l2cap_conf_opt {
 } __attribute__ ((packed));
 #define L2CAP_CONF_OPT_SIZE	2
 
-#define L2CAP_CONF_HINT		0x80
+#define L2CAP_CONF_HINT		((u8)0x80)
+#define L2CAP_CONF_MIN_MTU	48
 
 #define L2CAP_CONF_MTU		0x01
 #define L2CAP_CONF_FLUSH_TO	0x02
 #define L2CAP_CONF_QOS		0x03
 #define L2CAP_CONF_RFC		0x04
+#define L2CAP_CONF_FCS		0x05
 
 #define L2CAP_CONF_MAX_SIZE	22
 
@@ -170,6 +249,8 @@ struct l2cap_conf_rfc {
 #define L2CAP_MODE_BASIC	0x00
 #define L2CAP_MODE_RETRANS	0x01
 #define L2CAP_MODE_FLOWCTL	0x02
+#define L2CAP_MODE_ENH_RETRANS	0x03
+#define L2CAP_MODE_STREAMING	0x04
 
 struct l2cap_disconn_req {
 	__le16     dcid;
@@ -259,10 +340,29 @@ struct l2cap_pinfo {
 	__u8		conf_state;
 	__u8		conf_retry;
 
+	__u8		tx_seq;
+	__u8		req_seq;
+
+	__u8		fcs;
+
 	__u8		ident;
 
 	__le16		sport;
 
+	__u8		mode;
+	__u8		txwin_size;
+	__u8		remote_tx_win;
+	__u8		remote_max_tx;
+	__u16		retrans_timeout;
+	__u16		monitor_timeout;
+	__u16		max_pdu_size;
+
+	__u16		sdu_next;
+	__u16		sdu_len;
+
+	struct timer_list	 retrans_timer;
+	struct timer_list	 monitor_timer;
+	struct sk_buff		*tx_buf;
 	struct l2cap_conn	*conn;
 	struct sock		*next_c;
 	struct sock		*prev_c;
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index f6a82f2..31b1cbc 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -52,7 +52,8 @@
 
 #define VERSION "2.13"
 
-static u32 l2cap_feat_mask = 0x0080;
+static u32 l2cap_feat_mask =
+	L2CAP_FEATURE_FIX_CHAN;
 static u8 l2cap_fixed_chan[8] = { 0x02, };
 
 static const struct proto_ops l2cap_sock_ops;
@@ -718,12 +719,20 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
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
+		pi->fcs = L2CAP_FCS_DEFAULT;
+		if (sk->sk_type == SOCK_STREAM)
+			pi->mode = L2CAP_MODE_ENH_RETRANS;
+		else
+			pi->mode = L2CAP_MODE_BASIC;
+
 	}
 
 	/* Default config options */
@@ -770,7 +779,7 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol)
 
 	sock->state = SS_UNCONNECTED;
 
-	if (sock->type != SOCK_SEQPACKET &&
+	if (sock->type != SOCK_SEQPACKET && sock->type != SOCK_STREAM &&
 			sock->type != SOCK_DGRAM && sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
 
@@ -1747,7 +1756,7 @@ static int l2cap_parse_conf_req(struct sock *sk, void *data)
 		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
 
 		hint  = type & L2CAP_CONF_HINT;
-		type &= 0x7f;
+		type &= ~L2CAP_CONF_HINT;
 
 		switch (type) {
 		case L2CAP_CONF_MTU:
@@ -2244,7 +2253,7 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 	if (type == L2CAP_IT_FEAT_MASK) {
 		conn->feat_mask = get_unaligned_le32(rsp->data);
 
-		if (conn->feat_mask & 0x0080) {
+		if (conn->feat_mask & L2CAP_FEATURE_FIX_CHAN) {
 			struct l2cap_info_req req;
 			req.type = cpu_to_le16(L2CAP_IT_FIXED_CHAN);
 
-- 
1.6.0.6

