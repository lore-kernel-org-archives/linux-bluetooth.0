Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 18/34] Bluetooth: Add timer to Acknowledge I-frames
Date: Thu,  1 Apr 2010 17:23:36 -0300
Message-Id: <1270153432-6477-19-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1270153432-6477-18-git-send-email-padovan@profusion.mobi>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

We ack I-frames on each txWindow/5 I-frames received, but if the sender
stop to send I-frames and it's not a txWindow multiple we can leave some
frames unacked.
So I added a timer to ack I-frames on this case. The timer expires in
200ms.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    4 ++++
 net/bluetooth/l2cap.c         |   15 +++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d9c20c3..48f10f4 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -35,6 +35,7 @@
 #define L2CAP_DEFAULT_RETRANS_TO	1000    /* 1 second */
 #define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
 #define L2CAP_DEFAULT_MAX_PDU_SIZE	672
+#define L2CAP_DEFAULT_ACK_TO		200
 
 #define L2CAP_CONN_TIMEOUT	(40000) /* 40 seconds */
 #define L2CAP_INFO_TIMEOUT	(4000)  /*  4 seconds */
@@ -348,6 +349,7 @@ struct l2cap_pinfo {
 
 	struct timer_list	retrans_timer;
 	struct timer_list	monitor_timer;
+	struct timer_list	ack_timer;
 	struct sk_buff_head	tx_queue;
 	struct sk_buff_head	srej_queue;
 	struct srej_list	srej_l;
@@ -382,6 +384,8 @@ struct l2cap_pinfo {
 		jiffies +  msecs_to_jiffies(L2CAP_DEFAULT_RETRANS_TO));
 #define __mod_monitor_timer() mod_timer(&l2cap_pi(sk)->monitor_timer, \
 		jiffies + msecs_to_jiffies(L2CAP_DEFAULT_MONITOR_TO));
+#define __mod_ack_timer() mod_timer(&l2cap_pi(sk)->ack_timer, \
+		jiffies + msecs_to_jiffies(L2CAP_DEFAULT_ACK_TO));
 
 static inline int l2cap_tx_window_full(struct sock *sk)
 {
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index b431dc5..0dc7b95 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2230,6 +2230,15 @@ static void l2cap_add_conf_opt(void **ptr, u8 type, u8 len, unsigned long val)
 	*ptr += L2CAP_CONF_OPT_SIZE + len;
 }
 
+static void l2cap_ack_timeout(unsigned long arg)
+{
+	struct sock *sk = (void *) arg;
+
+	bh_lock_sock(sk);
+	l2cap_send_ack(l2cap_pi(sk));
+	bh_unlock_sock(sk);
+}
+
 static inline void l2cap_ertm_init(struct sock *sk)
 {
 	l2cap_pi(sk)->expected_ack_seq = 0;
@@ -2242,6 +2251,8 @@ static inline void l2cap_ertm_init(struct sock *sk)
 			l2cap_retrans_timeout, (unsigned long) sk);
 	setup_timer(&l2cap_pi(sk)->monitor_timer,
 			l2cap_monitor_timeout, (unsigned long) sk);
+	setup_timer(&l2cap_pi(sk)->ack_timer,
+			l2cap_ack_timeout, (unsigned long) sk);
 
 	__skb_queue_head_init(SREJ_QUEUE(sk));
 }
@@ -2970,6 +2981,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 		skb_queue_purge(SREJ_QUEUE(sk));
 		del_timer(&l2cap_pi(sk)->retrans_timer);
 		del_timer(&l2cap_pi(sk)->monitor_timer);
+		del_timer(&l2cap_pi(sk)->ack_timer);
 	}
 
 	l2cap_chan_del(sk, ECONNRESET);
@@ -3000,6 +3012,7 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 		skb_queue_purge(SREJ_QUEUE(sk));
 		del_timer(&l2cap_pi(sk)->retrans_timer);
 		del_timer(&l2cap_pi(sk)->monitor_timer);
+		del_timer(&l2cap_pi(sk)->ack_timer);
 	}
 
 	l2cap_chan_del(sk, 0);
@@ -3487,6 +3500,8 @@ expected:
 	if (err < 0)
 		return err;
 
+	__mod_ack_timer();
+
 	pi->num_to_ack = (pi->num_to_ack + 1) % L2CAP_DEFAULT_NUM_TO_ACK;
 	if (pi->num_to_ack == L2CAP_DEFAULT_NUM_TO_ACK - 1)
 		l2cap_send_ack(pi);
-- 
1.6.4.4
