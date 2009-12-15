Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 1/1] Bluetooth: Ack I-frames before retransmit missing packet
Date: Tue, 15 Dec 2009 20:13:27 -0200
Message-Id: <1260915207-10338-1-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

Moving the Ack to before l2cap_retransmit_frame() we can avoid the case
where txWindow is full and the packet can't be retransmited.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 2a2da9d..bb79946 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3505,9 +3505,9 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 		pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
 
 		if (rx_control & L2CAP_CTRL_POLL) {
-			l2cap_retransmit_frame(sk, tx_seq);
 			pi->expected_ack_seq = tx_seq;
 			l2cap_drop_acked_frames(sk);
+			l2cap_retransmit_frame(sk, tx_seq);
 			l2cap_ertm_send(sk);
 			if (pi->conn_state & L2CAP_CONN_WAIT_F) {
 				pi->srej_save_reqseq = tx_seq;
-- 
1.6.4.4
