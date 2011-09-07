Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 3/5] Bluetooth: EWS: support extended seq numbers
Date: Wed,  7 Sep 2011 17:05:12 +0300
Message-Id: <1315404314-12045-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1315404314-12045-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1315404314-12045-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds support for extended sequence numbers found in
extended control fields.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/bluetooth.h |    2 +-
 include/net/bluetooth/l2cap.h     |   17 ++++++++++
 net/bluetooth/l2cap_core.c        |   63 +++++++++++++++++-------------------
 net/bluetooth/l2cap_sock.c        |    1 +
 4 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index e727555..fb1acb3 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -158,7 +158,7 @@ struct bt_skb_cb {
 	__u8 pkt_type;
 	__u8 incoming;
 	__u16 expect;
-	__u8 tx_seq;
+	__u16 tx_seq;
 	__u8 retries;
 	__u8 sar;
 	unsigned short channel;
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5395984..27bd105 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -384,6 +384,7 @@ struct l2cap_chan {
 	__u8		fcs;
 
 	__u16		tx_win;
+	__u16		tx_win_max;
 	__u8		max_tx;
 	__u16		retrans_timeout;
 	__u16		monitor_timeout;
@@ -550,6 +551,22 @@ enum {
 		L2CAP_DEFAULT_ACK_TO);
 #define __clear_ack_timer(c) l2cap_clear_timer(c, &c->ack_timer)
 
+static inline int __seq_offset(struct l2cap_chan *chan, __u16 seq1, __u16 seq2)
+{
+	int offset;
+
+	offset = (seq1 - seq2) % (chan->tx_win_max + 1);
+	if (offset < 0)
+		offset += (chan->tx_win_max + 1);
+
+	return offset;
+}
+
+static inline __u16 __next_seq(struct l2cap_chan *chan, __u16 seq)
+{
+	return (seq + 1) % (chan->tx_win_max + 1);
+}
+
 static inline int l2cap_tx_window_full(struct l2cap_chan *ch)
 {
 	int sub;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index aae92df..cd61509 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1296,7 +1296,7 @@ static void l2cap_streaming_send(struct l2cap_chan *chan)
 
 		l2cap_do_send(chan, skb);
 
-		chan->next_tx_seq = (chan->next_tx_seq + 1) % 64;
+		chan->next_tx_seq = __next_seq(chan, chan->next_tx_seq);
 	}
 }
 
@@ -1390,7 +1390,8 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 		__set_retrans_timer(chan);
 
 		bt_cb(skb)->tx_seq = chan->next_tx_seq;
-		chan->next_tx_seq = (chan->next_tx_seq + 1) % 64;
+
+		chan->next_tx_seq = __next_seq(chan, chan->next_tx_seq);
 
 		if (bt_cb(skb)->retries == 1)
 			chan->unacked_frames++;
@@ -1940,13 +1941,16 @@ static inline void l2cap_txwin_setup(struct l2cap_chan *chan)
 			__l2cap_ews_supported(chan)) {
 		/* use extended control field */
 		set_bit(FLAG_EXT_CTRL, &chan->flags);
+		chan->tx_win_max = L2CAP_DEFAULT_MAX_EXT_WINDOW;
+
 		if (chan->tx_win > L2CAP_DEFAULT_MAX_EXT_WINDOW)
 			chan->tx_win = L2CAP_DEFAULT_MAX_EXT_WINDOW;
 	} else {
+		clear_bit(FLAG_EXT_CTRL, &chan->flags);
+		chan->tx_win_max = L2CAP_DEFAULT_MAX_TX_WINDOW;
+
 		if (chan->tx_win > L2CAP_DEFAULT_MAX_TX_WINDOW)
 			chan->tx_win = L2CAP_DEFAULT_MAX_TX_WINDOW;
-
-		clear_bit(FLAG_EXT_CTRL, &chan->flags);
 	}
 }
 
@@ -2153,6 +2157,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
 		case L2CAP_CONF_EWS:
 			set_bit(FLAG_EXT_CTRL, &chan->flags);
 			chan->remote_tx_win = val;
+			chan->tx_win_max = L2CAP_DEFAULT_MAX_EXT_WINDOW;
 			set_bit(CONF_EWS_RECV, &chan->conf_state);
 			break;
 
@@ -3346,18 +3351,14 @@ static int l2cap_add_to_srej_queue(struct l2cap_chan *chan, struct sk_buff *skb,
 		return 0;
 	}
 
-	tx_seq_offset = (tx_seq - chan->buffer_seq) % 64;
-	if (tx_seq_offset < 0)
-		tx_seq_offset += 64;
+	tx_seq_offset = __seq_offset(chan, tx_seq, chan->buffer_seq);
 
 	do {
 		if (bt_cb(next_skb)->tx_seq == tx_seq)
 			return -EINVAL;
 
-		next_tx_seq_offset = (bt_cb(next_skb)->tx_seq -
-						chan->buffer_seq) % 64;
-		if (next_tx_seq_offset < 0)
-			next_tx_seq_offset += 64;
+		next_tx_seq_offset = __seq_offset(chan,
+				bt_cb(next_skb)->tx_seq, chan->buffer_seq);
 
 		if (next_tx_seq_offset > tx_seq_offset) {
 			__skb_queue_before(&chan->srej_q, next_skb, skb);
@@ -3547,9 +3548,8 @@ static void l2cap_check_srej_gap(struct l2cap_chan *chan, u16 tx_seq)
 			break;
 		}
 
-		chan->buffer_seq_srej =
-			(chan->buffer_seq_srej + 1) % 64;
-		tx_seq = (tx_seq + 1) % 64;
+		chan->buffer_seq_srej = __next_seq(chan, chan->buffer_seq_srej);
+		tx_seq = __next_seq(chan, tx_seq);
 	}
 }
 
@@ -3584,10 +3584,13 @@ static void l2cap_send_srejframe(struct l2cap_chan *chan, u16 tx_seq)
 
 		new = kzalloc(sizeof(struct srej_list), GFP_ATOMIC);
 		new->tx_seq = chan->expected_tx_seq;
-		chan->expected_tx_seq = (chan->expected_tx_seq + 1) % 64;
+
+		chan->expected_tx_seq = __next_seq(chan, chan->expected_tx_seq);
+
 		list_add_tail(&new->list, &chan->srej_l);
 	}
-	chan->expected_tx_seq = (chan->expected_tx_seq + 1) % 64;
+
+	chan->expected_tx_seq = __next_seq(chan, chan->expected_tx_seq);
 }
 
 static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u32 rx_control, struct sk_buff *skb)
@@ -3613,9 +3616,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u32 rx_cont
 	chan->expected_ack_seq = req_seq;
 	l2cap_drop_acked_frames(chan);
 
-	tx_seq_offset = (tx_seq - chan->buffer_seq) % 64;
-	if (tx_seq_offset < 0)
-		tx_seq_offset += 64;
+	tx_seq_offset = __seq_offset(chan, tx_seq, chan->buffer_seq);
 
 	/* invalid tx_seq */
 	if (tx_seq_offset >= chan->tx_win) {
@@ -3663,10 +3664,8 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u32 rx_cont
 			l2cap_send_srejframe(chan, tx_seq);
 		}
 	} else {
-		expected_tx_seq_offset =
-			(chan->expected_tx_seq - chan->buffer_seq) % 64;
-		if (expected_tx_seq_offset < 0)
-			expected_tx_seq_offset += 64;
+		expected_tx_seq_offset = __seq_offset(chan,
+				chan->expected_tx_seq, chan->buffer_seq);
 
 		/* duplicated tx_seq */
 		if (tx_seq_offset < expected_tx_seq_offset)
@@ -3691,7 +3690,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u32 rx_cont
 	return 0;
 
 expected:
-	chan->expected_tx_seq = (chan->expected_tx_seq + 1) % 64;
+	chan->expected_tx_seq = __next_seq(chan, chan->expected_tx_seq);
 
 	if (test_bit(CONN_SREJ_SENT, &chan->conn_state)) {
 		bt_cb(skb)->tx_seq = tx_seq;
@@ -3701,7 +3700,8 @@ expected:
 	}
 
 	err = l2cap_reassemble_sdu(chan, skb, rx_control);
-	chan->buffer_seq = (chan->buffer_seq + 1) % 64;
+	chan->buffer_seq = __next_seq(chan, chan->buffer_seq);
+
 	if (err < 0) {
 		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
 		return err;
@@ -3916,14 +3916,11 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 
 	req_seq = __get_reqseq(chan, control);
-	req_seq_offset = (req_seq - chan->expected_ack_seq) % 64;
-	if (req_seq_offset < 0)
-		req_seq_offset += 64;
 
-	next_tx_seq_offset =
-		(chan->next_tx_seq - chan->expected_ack_seq) % 64;
-	if (next_tx_seq_offset < 0)
-		next_tx_seq_offset += 64;
+	req_seq_offset = __seq_offset(chan, req_seq, chan->expected_ack_seq);
+
+	next_tx_seq_offset = __seq_offset(chan, chan->next_tx_seq,
+			chan->expected_ack_seq);
 
 	/* check for invalid req-seq */
 	if (req_seq_offset > next_tx_seq_offset) {
@@ -4028,7 +4025,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 			/* TODO: Notify userland of missing data */
 		}
 
-		chan->expected_tx_seq = (tx_seq + 1) % 64;
+		chan->expected_tx_seq = __next_seq(chan, tx_seq);
 
 		if (l2cap_reassemble_sdu(chan, skb, control) == -EMSGSIZE)
 			l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index d6a4f63..bf343aa 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -969,6 +969,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 
 	/* Default config options */
 	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
+	chan->tx_win_max = L2CAP_DEFAULT_MAX_TX_WINDOW;
 
 	chan->data = sk;
 	chan->ops = &l2cap_chan_ops;
-- 
1.7.4.1

