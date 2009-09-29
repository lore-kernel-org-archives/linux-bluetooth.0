Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 3/7] Bluetooth: Fix unset of SrejActioned flag
Date: Tue, 29 Sep 2009 01:42:25 -0300
Message-Id: <1254199349-19713-3-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1254199349-19713-2-git-send-email-gustavo@las.ic.unicamp.br>
References: <1254199349-19713-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1254199349-19713-2-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

pi->conn_state is the right place to set states

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 3f9d74b..658e27c 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3433,7 +3433,7 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
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
