Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 2/2] Bluetooth: Initialize variables and timers for both channel's sides
Date: Mon,  7 Sep 2009 03:23:58 -0300
Message-Id: <1252304638-4898-2-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1252304638-4898-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1252304638-4898-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Needed by the ERTM duplex channel.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |   53 ++++++++++++++++++++++++++++++++----------------
 1 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 9d586fb..3f9d74b 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2169,6 +2169,20 @@ static void l2cap_add_conf_opt(void **ptr, u8 type, u8 len, unsigned long val)
 	*ptr += L2CAP_CONF_OPT_SIZE + len;
 }
 
+static inline void l2cap_ertm_init(struct sock *sk) {
+	l2cap_pi(sk)->expected_ack_seq = 0;
+	l2cap_pi(sk)->unacked_frames = 0;
+	l2cap_pi(sk)->buffer_seq = 0;
+	l2cap_pi(sk)->num_to_ack = 0;
+
+	setup_timer(&l2cap_pi(sk)->retrans_timer,
+			l2cap_retrans_timeout, (unsigned long) sk);
+	setup_timer(&l2cap_pi(sk)->monitor_timer,
+			l2cap_monitor_timeout, (unsigned long) sk);
+
+	__skb_queue_head_init(SREJ_QUEUE(sk));
+}
+
 static int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
 {
 	u32 local_feat_mask = l2cap_feat_mask;
@@ -2752,17 +2766,13 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 			l2cap_pi(sk)->fcs = L2CAP_FCS_CRC16;
 
 		sk->sk_state = BT_CONNECTED;
-		l2cap_pi(sk)->next_tx_seq = 0;
-		l2cap_pi(sk)->expected_ack_seq = 0;
-		l2cap_pi(sk)->unacked_frames = 0;
-
-		setup_timer(&l2cap_pi(sk)->retrans_timer,
-				l2cap_retrans_timeout, (unsigned long) sk);
-		setup_timer(&l2cap_pi(sk)->monitor_timer,
-				l2cap_monitor_timeout, (unsigned long) sk);
 
+		l2cap_pi(sk)->next_tx_seq = 0;
+		l2cap_pi(sk)->expected_tx_seq = 0;
 		__skb_queue_head_init(TX_QUEUE(sk));
-		__skb_queue_head_init(SREJ_QUEUE(sk));
+		if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM)
+			l2cap_ertm_init(sk);
+
 		l2cap_chan_ready(sk);
 		goto unlock;
 	}
@@ -2841,11 +2851,12 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 			l2cap_pi(sk)->fcs = L2CAP_FCS_CRC16;
 
 		sk->sk_state = BT_CONNECTED;
+		l2cap_pi(sk)->next_tx_seq = 0;
 		l2cap_pi(sk)->expected_tx_seq = 0;
-		l2cap_pi(sk)->buffer_seq = 0;
-		l2cap_pi(sk)->num_to_ack = 0;
 		__skb_queue_head_init(TX_QUEUE(sk));
-		__skb_queue_head_init(SREJ_QUEUE(sk));
+		if (l2cap_pi(sk)->mode ==  L2CAP_MODE_ERTM)
+			l2cap_ertm_init(sk);
+
 		l2cap_chan_ready(sk);
 	}
 
@@ -2877,9 +2888,12 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 	sk->sk_shutdown = SHUTDOWN_MASK;
 
 	skb_queue_purge(TX_QUEUE(sk));
-	skb_queue_purge(SREJ_QUEUE(sk));
-	del_timer(&l2cap_pi(sk)->retrans_timer);
-	del_timer(&l2cap_pi(sk)->monitor_timer);
+
+	if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM) {
+		skb_queue_purge(SREJ_QUEUE(sk));
+		del_timer(&l2cap_pi(sk)->retrans_timer);
+		del_timer(&l2cap_pi(sk)->monitor_timer);
+	}
 
 	l2cap_chan_del(sk, ECONNRESET);
 	bh_unlock_sock(sk);
@@ -2904,9 +2918,12 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 		return 0;
 
 	skb_queue_purge(TX_QUEUE(sk));
-	skb_queue_purge(SREJ_QUEUE(sk));
-	del_timer(&l2cap_pi(sk)->retrans_timer);
-	del_timer(&l2cap_pi(sk)->monitor_timer);
+
+	if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM) {
+		skb_queue_purge(SREJ_QUEUE(sk));
+		del_timer(&l2cap_pi(sk)->retrans_timer);
+		del_timer(&l2cap_pi(sk)->monitor_timer);
+	}
 
 	l2cap_chan_del(sk, 0);
 	bh_unlock_sock(sk);
-- 
1.6.3.3

