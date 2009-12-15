Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 1/1] Bluetooth: fix unset of RemoteBusy flag
Date: Tue, 15 Dec 2009 15:56:34 -0200
Message-Id: <1260899794-5107-1-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

RemoteBusy flag need to be unset before l2cap_ertm_send(), otherwise
l2cap_ertm_send() will return without sending packets because it checks
that flag before start sending.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 8a2b3d3..2a2da9d 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3469,8 +3469,8 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 					&& (pi->unacked_frames > 0))
 				__mod_retrans_timer();
 
-			l2cap_ertm_send(sk);
 			pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+			l2cap_ertm_send(sk);
 		}
 		break;
 
-- 
1.6.4.4
