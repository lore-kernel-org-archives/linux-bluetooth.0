Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 08/10] Bluetooth: Change acknowledgement to use the value of txWindow
Date: Tue, 30 Mar 2010 15:52:38 -0300
Message-Id: <1269975160-9994-8-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269975160-9994-7-git-send-email-padovan@profusion.mobi>
References: <1269373726-13209-20-git-send-email-padovan@profusion.mobi>
 <1269975160-9994-1-git-send-email-padovan@profusion.mobi>
 <1269975160-9994-2-git-send-email-padovan@profusion.mobi>
 <1269975160-9994-3-git-send-email-padovan@profusion.mobi>
 <1269975160-9994-4-git-send-email-padovan@profusion.mobi>
 <1269975160-9994-5-git-send-email-padovan@profusion.mobi>
 <1269975160-9994-6-git-send-email-padovan@profusion.mobi>
 <1269975160-9994-7-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Now that we can set the txWindow we need to change the acknowledgement
procedure to ack after each (pi->txWindow/6 + 1). The plus 1 is to avoid
the zero value.
It also renames pi->num_to_ack to a better name: pi->num_acked.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    3 +--
 net/bluetooth/l2cap.c         |    7 ++++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index fdbe8ee..44dd961 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -30,7 +30,6 @@
 #define L2CAP_DEFAULT_MIN_MTU		48
 #define L2CAP_DEFAULT_FLUSH_TO		0xffff
 #define L2CAP_DEFAULT_TX_WINDOW		63
-#define L2CAP_DEFAULT_NUM_TO_ACK        (L2CAP_DEFAULT_TX_WINDOW/5)
 #define L2CAP_DEFAULT_MAX_TX		3
 #define L2CAP_DEFAULT_RETRANS_TO	1000    /* 1 second */
 #define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
@@ -333,7 +332,7 @@ struct l2cap_pinfo {
 	__u8		frames_sent;
 	__u8		unacked_frames;
 	__u8		retry_count;
-	__u8		num_to_ack;
+	__u8		num_acked;
 	__u16		sdu_len;
 	__u16		partial_sdu_len;
 	struct sk_buff	*sdu;
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 79c9ac7..8a6d073 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2250,7 +2250,7 @@ static inline void l2cap_ertm_init(struct sock *sk)
 	l2cap_pi(sk)->expected_ack_seq = 0;
 	l2cap_pi(sk)->unacked_frames = 0;
 	l2cap_pi(sk)->buffer_seq = 0;
-	l2cap_pi(sk)->num_to_ack = 0;
+	l2cap_pi(sk)->num_acked = 0;
 	l2cap_pi(sk)->frames_sent = 0;
 
 	setup_timer(&l2cap_pi(sk)->retrans_timer,
@@ -3463,6 +3463,7 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 	u8 tx_seq = __get_txseq(rx_control);
 	u8 req_seq = __get_reqseq(rx_control);
 	u8 sar = rx_control >> L2CAP_CTRL_SAR_SHIFT;
+	int num_to_ack = (pi->tx_win/6) + 1;
 	int err = 0;
 
 	BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb->len);
@@ -3557,8 +3558,8 @@ expected:
 
 	__mod_ack_timer();
 
-	pi->num_to_ack = (pi->num_to_ack + 1) % L2CAP_DEFAULT_NUM_TO_ACK;
-	if (pi->num_to_ack == L2CAP_DEFAULT_NUM_TO_ACK - 1)
+	pi->num_acked = (pi->num_acked + 1) % num_to_ack;
+	if (pi->num_acked == num_to_ack - 1)
 		l2cap_send_ack(pi);
 
 	return 0;
-- 
1.6.4.4
