Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 2/5] Bluetooth: Fix unset of SrejActioned flag
Date: Wed, 30 Sep 2009 20:44:18 -0300
Message-Id: <1254354262-27405-2-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1254354262-27405-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1254354262-27405-1-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

pi->conn_state keeps information about ERTM states vars. SrejActioned ( a
flag on pi->conn_state) prevents local side to retransmit I-frames already
retransmitted. This bug can put ERTM in an unknown state.

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
1.6.3.3
