Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 2/5] Bluetooth: Fix unset of SrejActioned flag
Date: Sat,  3 Oct 2009 02:34:37 -0300
Message-Id: <1254548080-13478-2-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1254548080-13478-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1254548080-13478-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SrejActioned  is a flag that when set prevents local side to retransmit a
I-frame(the data frame) already retransmitted. The local entity can
retransmit again only when it receives a SREJ frame with the F-bit set.
SREJ frame - Selective Reject frame  - is sent when an entity wants the
retransmission of a specific I-frame that was lost or corrupted.
This bug can put ERTM in an unknown state once the entity can't
retransmit.
A frame with the Final bit set is expected when the local side sends a
frame with the Poll bit set due to a local busy condition or a
retransmission timer expired. (Receipt of P-bit shall always be replied by
a frame with the F-bit set).
pi->conn_state keeps informations about many ERTM flags including
SrejActioned.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index c709da0..a63fefe 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3434,7 +3434,7 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 		} else if (rx_control & L2CAP_CTRL_FINAL) {
 			if ((pi->conn_state & L2CAP_CONN_SREJ_ACT) &&
 					pi->srej_save_reqseq == tx_seq)
-				pi->srej_save_reqseq &= ~L2CAP_CONN_SREJ_ACT;
+				pi->conn_state &= ~L2CAP_CONN_SREJ_ACT;
 			else
 				l2cap_retransmit_frame(sk, tx_seq);
 		}
-- 
1.6.4.4

