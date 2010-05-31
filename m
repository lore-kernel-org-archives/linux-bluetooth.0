Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: jprvita@profusion.mobi, gustavo@padovan.org, marcel@holtmann.org
Subject: [PATCH 13/13] Bluetooth: Add debug output to ERTM code
Date: Mon, 31 May 2010 14:02:52 -0300
Message-Id: <1275325372-5671-13-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1275325372-5671-12-git-send-email-padovan@profusion.mobi>
References: <1275325372-5671-1-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-2-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-3-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-4-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-5-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-6-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-7-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-8-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-9-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-10-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-11-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-12-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Use the dynamic debug to output info about ERTM protocol stuff.
The following script can be used to enable debug for ERTM:

DEBUGFS="/sys/kernel/debug/dynamic_debug/control"

echo -n 'func l2cap_send_disconn_req +p' > $DEBUGFS
echo -n 'func l2cap_monitor_timeout +p' > $DEBUGFS
echo -n 'func l2cap_retrans_timeout +p' > $DEBUGFS
echo -n 'func l2cap_busy_work  +p' > $DEBUGFS
echo -n 'func l2cap_push_rx_skb +p' > $DEBUGFS
echo -n 'func l2cap_data_channel_iframe +p' > $DEBUGFS
echo -n 'func l2cap_data_channel_rrframe +p' > $DEBUGFS
echo -n 'func l2cap_data_channel_rejframe +p' > $DEBUGFS
echo -n 'func l2cap_data_channel_srejframe +p' > $DEBUGFS
echo -n 'func l2cap_data_channel_rnrframe +p' > $DEBUGFS

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index fc0084b..ba980dc 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -453,6 +453,8 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct sock *sk, int
 {
 	struct l2cap_disconn_req req;
 
+	BT_DBG("sk %p", sk);
+
 	skb_queue_purge(TX_QUEUE(sk));
 
 	if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM) {
@@ -1302,6 +1304,8 @@ static void l2cap_monitor_timeout(unsigned long arg)
 {
 	struct sock *sk = (void *) arg;
 
+	BT_DBG("sk %p", sk);
+
 	bh_lock_sock(sk);
 	if (l2cap_pi(sk)->retry_count >= l2cap_pi(sk)->remote_max_tx) {
 		l2cap_send_disconn_req(l2cap_pi(sk)->conn, sk, ECONNABORTED);
@@ -1320,6 +1324,8 @@ static void l2cap_retrans_timeout(unsigned long arg)
 {
 	struct sock *sk = (void *) arg;
 
+	BT_DBG("sk %p", sk);
+
 	bh_lock_sock(sk);
 	l2cap_pi(sk)->retry_count = 1;
 	__mod_monitor_timer();
@@ -3631,6 +3637,8 @@ done:
 	pi->conn_state &= ~L2CAP_CONN_LOCAL_BUSY;
 	pi->conn_state &= ~L2CAP_CONN_RNR_SENT;
 
+	BT_DBG("sk %p, Exit local busy", sk);
+
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(sk_sleep(sk), &wait);
 
@@ -3655,6 +3663,8 @@ static int l2cap_push_rx_skb(struct sock *sk, struct sk_buff *skb, u16 control)
 	}
 
 	/* Busy Condition */
+	BT_DBG("sk %p, Enter local busy", sk);
+
 	pi->conn_state |= L2CAP_CONN_LOCAL_BUSY;
 	bt_cb(skb)->sar = control >> L2CAP_CTRL_SAR_SHIFT;
 	__skb_queue_tail(BUSY_QUEUE(sk), skb);
@@ -3833,7 +3843,8 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 	int num_to_ack = (pi->tx_win/6) + 1;
 	int err = 0;
 
-	BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb->len);
+	BT_DBG("sk %p len %d tx_seq %d rx_control 0x%4.4x", sk, skb->len, tx_seq,
+								rx_control);
 
 	if (L2CAP_CTRL_FINAL & rx_control &&
 			l2cap_pi(sk)->conn_state & L2CAP_CONN_WAIT_F) {
@@ -3878,6 +3889,7 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 				pi->buffer_seq = pi->buffer_seq_srej;
 				pi->conn_state &= ~L2CAP_CONN_SREJ_SENT;
 				l2cap_send_ack(pi);
+				BT_DBG("sk %p, Exit SREJ_SENT", sk);
 			}
 		} else {
 			struct srej_list *l;
@@ -3906,6 +3918,8 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 
 		pi->conn_state |= L2CAP_CONN_SREJ_SENT;
 
+		BT_DBG("sk %p, Enter SREJ", sk);
+
 		INIT_LIST_HEAD(SREJ_LIST(sk));
 		pi->buffer_seq_srej = pi->buffer_seq;
 
@@ -3959,6 +3973,9 @@ static inline void l2cap_data_channel_rrframe(struct sock *sk, u16 rx_control)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 
+	BT_DBG("sk %p, req_seq %d ctrl 0x%4.4x", sk, __get_reqseq(rx_control),
+						rx_control);
+
 	pi->expected_ack_seq = __get_reqseq(rx_control);
 	l2cap_drop_acked_frames(sk);
 
@@ -4004,6 +4021,8 @@ static inline void l2cap_data_channel_rejframe(struct sock *sk, u16 rx_control)
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	u8 tx_seq = __get_reqseq(rx_control);
 
+	BT_DBG("sk %p, req_seq %d ctrl 0x%4.4x", sk, tx_seq, rx_control);
+
 	pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
 
 	pi->expected_ack_seq = tx_seq;
@@ -4026,6 +4045,8 @@ static inline void l2cap_data_channel_srejframe(struct sock *sk, u16 rx_control)
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	u8 tx_seq = __get_reqseq(rx_control);
 
+	BT_DBG("sk %p, req_seq %d ctrl 0x%4.4x", sk, tx_seq, rx_control);
+
 	pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
 
 	if (rx_control & L2CAP_CTRL_POLL) {
@@ -4063,6 +4084,8 @@ static inline void l2cap_data_channel_rnrframe(struct sock *sk, u16 rx_control)
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	u8 tx_seq = __get_reqseq(rx_control);
 
+	BT_DBG("sk %p, req_seq %d ctrl 0x%4.4x", sk, tx_seq, rx_control);
+
 	pi->conn_state |= L2CAP_CONN_REMOTE_BUSY;
 	pi->expected_ack_seq = tx_seq;
 	l2cap_drop_acked_frames(sk);
-- 
1.6.4.4
