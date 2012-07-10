Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: debug: Correct types specifiers for L2CAP
Date: Tue, 10 Jul 2012 15:27:49 +0300
Message-Id: <1341923271-14222-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1341923271-14222-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1341923271-14222-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Avoid unneeded type conversion by correcting type specifiers in debug
statements for L2CAP.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   52 ++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5dd7a76..9fbac57 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1655,7 +1655,7 @@ static void l2cap_streaming_send(struct l2cap_chan *chan,
 
 		l2cap_do_send(chan, skb);
 
-		BT_DBG("Sent txseq %d", (int)control->txseq);
+		BT_DBG("Sent txseq %u", control->txseq);
 
 		chan->next_tx_seq = __next_seq(chan, chan->next_tx_seq);
 		chan->frames_sent++;
@@ -1720,11 +1720,11 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 			chan->tx_send_head = skb_queue_next(&chan->tx_q, skb);
 
 		l2cap_do_send(chan, tx_skb);
-		BT_DBG("Sent txseq %d", (int)control->txseq);
+		BT_DBG("Sent txseq %u", control->txseq);
 	}
 
-	BT_DBG("Sent %d, %d unacked, %d in ERTM queue", sent,
-	       (int) chan->unacked_frames, skb_queue_len(&chan->tx_q));
+	BT_DBG("Sent %d, %u unacked, %u in ERTM queue", sent,
+	       chan->unacked_frames, skb_queue_len(&chan->tx_q));
 
 	return sent;
 }
@@ -1882,7 +1882,7 @@ static void l2cap_send_ack(struct l2cap_chan *chan)
 		threshold += threshold << 1;
 		threshold >>= 2;
 
-		BT_DBG("frames_to_ack %d, threshold %d", (int)frames_to_ack,
+		BT_DBG("frames_to_ack %u, threshold %d", frames_to_ack,
 		       threshold);
 
 		if (frames_to_ack >= threshold) {
@@ -1944,15 +1944,15 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
 }
 
 static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
-						struct msghdr *msg, size_t len,
-						u32 priority)
+						 struct msghdr *msg, size_t len,
+						 u32 priority)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
 	int err, count, hlen = L2CAP_HDR_SIZE + L2CAP_PSMLEN_SIZE;
 	struct l2cap_hdr *lh;
 
-	BT_DBG("chan %p len %d priority %u", chan, (int)len, priority);
+	BT_DBG("chan %p len %zu priority %u", chan, len, priority);
 
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 
@@ -1978,15 +1978,15 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
 }
 
 static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
-						struct msghdr *msg, size_t len,
-						u32 priority)
+					      struct msghdr *msg, size_t len,
+					      u32 priority)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
 	int err, count;
 	struct l2cap_hdr *lh;
 
-	BT_DBG("chan %p len %d", chan, (int)len);
+	BT_DBG("chan %p len %zu", chan, len);
 
 	count = min_t(unsigned int, (conn->mtu - L2CAP_HDR_SIZE), len);
 
@@ -2011,15 +2011,15 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
 }
 
 static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
-						struct msghdr *msg, size_t len,
-						u16 sdulen)
+					       struct msghdr *msg, size_t len,
+					       u16 sdulen)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
 	int err, count, hlen;
 	struct l2cap_hdr *lh;
 
-	BT_DBG("chan %p len %d", chan, (int)len);
+	BT_DBG("chan %p len %zu", chan, len);
 
 	if (!conn)
 		return ERR_PTR(-ENOTCONN);
@@ -2073,7 +2073,7 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
 	size_t pdu_len;
 	u8 sar;
 
-	BT_DBG("chan %p, msg %p, len %d", chan, msg, (int)len);
+	BT_DBG("chan %p, msg %p, len %zu", chan, msg, len);
 
 	/* It is critical that ERTM PDUs fit in a single HCI fragment,
 	 * so fragmented skbs are not used.  The HCI layer's handling
@@ -2217,7 +2217,7 @@ static void l2cap_send_srej(struct l2cap_chan *chan, u16 txseq)
 	struct l2cap_ctrl control;
 	u16 seq;
 
-	BT_DBG("chan %p, txseq %d", chan, txseq);
+	BT_DBG("chan %p, txseq %u", chan, txseq);
 
 	memset(&control, 0, sizeof(control));
 	control.sframe = 1;
@@ -2257,7 +2257,7 @@ static void l2cap_send_srej_list(struct l2cap_chan *chan, u16 txseq)
 	u16 initial_head;
 	u16 seq;
 
-	BT_DBG("chan %p, txseq %d", chan, txseq);
+	BT_DBG("chan %p, txseq %u", chan, txseq);
 
 	memset(&control, 0, sizeof(control));
 	control.sframe = 1;
@@ -2282,12 +2282,12 @@ static void l2cap_process_reqseq(struct l2cap_chan *chan, u16 reqseq)
 	struct sk_buff *acked_skb;
 	u16 ackseq;
 
-	BT_DBG("chan %p, reqseq %d", chan, reqseq);
+	BT_DBG("chan %p, reqseq %u", chan, reqseq);
 
 	if (chan->unacked_frames == 0 || reqseq == chan->expected_ack_seq)
 		return;
 
-	BT_DBG("expected_ack_seq %d, unacked_frames %d",
+	BT_DBG("expected_ack_seq %u, unacked_frames %u",
 	       chan->expected_ack_seq, chan->unacked_frames);
 
 	for (ackseq = chan->expected_ack_seq; ackseq != reqseq;
@@ -2306,7 +2306,7 @@ static void l2cap_process_reqseq(struct l2cap_chan *chan, u16 reqseq)
 	if (chan->unacked_frames == 0)
 		__clear_retrans_timer(chan);
 
-	BT_DBG("unacked_frames %d", (int) chan->unacked_frames);
+	BT_DBG("unacked_frames %u", chan->unacked_frames);
 }
 
 static void l2cap_abort_rx_srej_sent(struct l2cap_chan *chan)
@@ -2532,16 +2532,16 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 }
 
 /* ---- L2CAP signalling commands ---- */
-static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
-				u8 code, u8 ident, u16 dlen, void *data)
+static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn, u8 code,
+				       u8 ident, u16 dlen, void *data)
 {
 	struct sk_buff *skb, **frag;
 	struct l2cap_cmd_hdr *cmd;
 	struct l2cap_hdr *lh;
 	int len, count;
 
-	BT_DBG("conn %p, code 0x%2.2x, ident 0x%2.2x, len %d",
-			conn, code, ident, dlen);
+	BT_DBG("conn %p, code 0x%2.2x, ident 0x%2.2x, len %u",
+	       conn, code, ident, dlen);
 
 	len = L2CAP_HDR_SIZE + L2CAP_CMD_HDR_SIZE + dlen;
 	count = min_t(unsigned int, conn->mtu, len);
@@ -2624,7 +2624,7 @@ static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen, unsigned
 		break;
 	}
 
-	BT_DBG("type 0x%2.2x len %d val 0x%lx", *type, opt->len, *val);
+	BT_DBG("type 0x%2.2x len %u val 0x%lx", *type, opt->len, *val);
 	return len;
 }
 
@@ -2632,7 +2632,7 @@ static void l2cap_add_conf_opt(void **ptr, u8 type, u8 len, unsigned long val)
 {
 	struct l2cap_conf_opt *opt = *ptr;
 
-	BT_DBG("type 0x%2.2x len %d val 0x%lx", type, len, val);
+	BT_DBG("type 0x%2.2x len %u val 0x%lx", type, len, val);
 
 	opt->type = type;
 	opt->len  = len;
-- 
1.7.9.5

