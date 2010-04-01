Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 02/34] Bluetooth: Support case with F bit set under WAIT_F state.
Date: Thu,  1 Apr 2010 17:23:20 -0300
Message-Id: <1270153432-6477-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1270153432-6477-2-git-send-email-padovan@profusion.mobi>
References: <1270153432-6477-1-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-2-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On receipt of a F=1 under WAIT_F state ERTM shall stop monitor timer and
start retransmission timer (if there are unacked frames).

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 18328a4..ab3f0c4 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3356,6 +3356,13 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 
 	BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb->len);
 
+	if (L2CAP_CTRL_FINAL & rx_control) {
+		del_timer(&pi->monitor_timer);
+		if (pi->unacked_frames > 0)
+			__mod_retrans_timer();
+		pi->conn_state &= ~L2CAP_CONN_WAIT_F;
+	}
+
 	pi->expected_ack_seq = req_seq;
 	l2cap_drop_acked_frames(sk);
 
@@ -3445,6 +3452,13 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 
 	BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb->len);
 
+	if (L2CAP_CTRL_FINAL & rx_control) {
+		del_timer(&pi->monitor_timer);
+		if (pi->unacked_frames > 0)
+			__mod_retrans_timer();
+		pi->conn_state &= ~L2CAP_CONN_WAIT_F;
+	}
+
 	switch (rx_control & L2CAP_CTRL_SUPERVISE) {
 	case L2CAP_SUPER_RCV_READY:
 		if (rx_control & L2CAP_CTRL_POLL) {
@@ -3464,14 +3478,6 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 				l2cap_ertm_send(sk);
 			}
 
-			if (!(pi->conn_state & L2CAP_CONN_WAIT_F))
-				break;
-
-			pi->conn_state &= ~L2CAP_CONN_WAIT_F;
-			del_timer(&pi->monitor_timer);
-
-			if (pi->unacked_frames > 0)
-				__mod_retrans_timer();
 		} else {
 			pi->expected_ack_seq = tx_seq;
 			l2cap_drop_acked_frames(sk);
-- 
1.6.4.4
