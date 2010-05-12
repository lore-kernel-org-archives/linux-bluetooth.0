Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [l2cap 1/6] Bluetooth: Tweaks to l2cap_send_i_or_rr_or_rnr() flow
Date: Wed, 12 May 2010 00:05:53 -0300
Message-Id: <1273633558-10576-1-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1273513181-28258-2-git-send-email-gustavo@padovan.org>
References: <1273513181-28258-2-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

l2cap_send_sframe() already set the F-bit if we set L2CAP_CONN_SEND_FBIT
and unset L2CAP_CONN_SEND_FBIT after send the F-bit.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index e8c8f8b..a7e14c0 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3364,10 +3364,9 @@ static inline void l2cap_send_i_or_rr_or_rnr(struct sock *sk)
 	control |= pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 
 	if (pi->conn_state & L2CAP_CONN_LOCAL_BUSY) {
-		control |= L2CAP_SUPER_RCV_NOT_READY | L2CAP_CTRL_FINAL;
+		control |= L2CAP_SUPER_RCV_NOT_READY;
 		l2cap_send_sframe(pi, control);
 		pi->conn_state |= L2CAP_CONN_RNR_SENT;
-		pi->conn_state &= ~L2CAP_CONN_SEND_FBIT;
 	}
 
 	if (pi->conn_state & L2CAP_CONN_REMOTE_BUSY && pi->unacked_frames > 0)
-- 
1.6.4.4
