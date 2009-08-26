Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 1/3] Bluetooth: Ack packets when receiving RR-frames(Fbit=1)
Date: Wed, 26 Aug 2009 04:04:01 -0300
Message-Id: <1251270243-28832-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implement the Recv ReqSeqAndFBit event when a RR frame with F bit set is
received.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>

	utime
---
 net/bluetooth/l2cap.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index e5847c5..0a36c61 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3348,9 +3348,13 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 	case L2CAP_SUPER_RCV_READY:
 		if (rx_control & L2CAP_CTRL_POLL) {
 			u16 control = L2CAP_CTRL_FINAL;
-			control |= L2CAP_SUPER_RCV_READY;
+			control |= L2CAP_SUPER_RCV_READY |
+				(pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT);
 			l2cap_send_sframe(l2cap_pi(sk), control);
 		} else if (rx_control & L2CAP_CTRL_FINAL) {
+			pi->expected_ack_seq = tx_seq;
+			l2cap_drop_acked_frames(sk);
+
 			if (!(pi->conn_state & L2CAP_CONN_WAIT_F))
 				break;
 
-- 
1.6.3.3

