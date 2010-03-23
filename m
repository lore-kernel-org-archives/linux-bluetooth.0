Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi, ulisses@profusion.mobi
Subject: [PATCH 14/19] Bluetooth: Group the ack of I-frames into l2cap_data_channel_rrframe()
Date: Tue, 23 Mar 2010 16:48:41 -0300
Message-Id: <1269373726-13209-15-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269373726-13209-14-git-send-email-padovan@profusion.mobi>
References: <1269373726-13209-1-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-2-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-3-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-4-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-5-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-6-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-7-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-8-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-9-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-10-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-11-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-12-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-13-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-14-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

It also fix a bug: we weren't acknowledging I-frames when P=1.
Note that when F=1 we are acknowledging packets before setting
RemoteBusy to False. The spec says we should do that in the opposite
order, but acknowledment of packets doesn't care about RemoteBusy flag
so we can do that in the order we want.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index f966ed3..d6667fa 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3490,7 +3490,9 @@ expected:
 static inline void l2cap_data_channel_rrframe(struct sock *sk, u16 rx_control)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	u8 tx_seq = __get_reqseq(rx_control);
+
+	pi->expected_ack_seq = __get_reqseq(rx_control);
+	l2cap_drop_acked_frames(sk);
 
 	if (rx_control & L2CAP_CTRL_POLL) {
 		l2cap_send_i_or_rr_or_rnr(sk);
@@ -3498,8 +3500,6 @@ static inline void l2cap_data_channel_rrframe(struct sock *sk, u16 rx_control)
 
 	} else if (rx_control & L2CAP_CTRL_FINAL) {
 		pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
-		pi->expected_ack_seq = tx_seq;
-		l2cap_drop_acked_frames(sk);
 
 		if (pi->conn_state & L2CAP_CONN_REJ_ACT)
 			pi->conn_state &= ~L2CAP_CONN_REJ_ACT;
@@ -3510,9 +3510,6 @@ static inline void l2cap_data_channel_rrframe(struct sock *sk, u16 rx_control)
 		}
 
 	} else {
-		pi->expected_ack_seq = tx_seq;
-		l2cap_drop_acked_frames(sk);
-
 		if ((pi->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
 				(pi->unacked_frames > 0))
 			__mod_retrans_timer();
-- 
1.6.4.4
