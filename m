Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 14/14] Bluetooth: Fix missing retransmission action with RR(P=1)
Date: Sat,  5 Jun 2010 04:50:18 -0300
Message-Id: <1275724218-29453-15-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275724218-29453-14-git-send-email-gustavo@padovan.org>
References: <1275724218-29453-1-git-send-email-gustavo@padovan.org>
 <1275724218-29453-2-git-send-email-gustavo@padovan.org>
 <1275724218-29453-3-git-send-email-gustavo@padovan.org>
 <1275724218-29453-4-git-send-email-gustavo@padovan.org>
 <1275724218-29453-5-git-send-email-gustavo@padovan.org>
 <1275724218-29453-6-git-send-email-gustavo@padovan.org>
 <1275724218-29453-7-git-send-email-gustavo@padovan.org>
 <1275724218-29453-8-git-send-email-gustavo@padovan.org>
 <1275724218-29453-9-git-send-email-gustavo@padovan.org>
 <1275724218-29453-10-git-send-email-gustavo@padovan.org>
 <1275724218-29453-11-git-send-email-gustavo@padovan.org>
 <1275724218-29453-12-git-send-email-gustavo@padovan.org>
 <1275724218-29453-13-git-send-email-gustavo@padovan.org>
 <1275724218-29453-14-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

The Bluetooth SIG Profile Tuning Suite Software uses the CSA1 spec
to run the L2CAP tests. The new 3.0 spec has a missing
Retransmit-I-Frames action when the Remote side is Busy.
We still start the retransmission timer if Remote is Busy and unacked
frames > 0. We do everything we did before this change plus the
Retransmission of I-frames.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 4a737b2..1c35ff2 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3401,8 +3401,8 @@ static inline void l2cap_send_i_or_rr_or_rnr(struct sock *sk)
 		pi->conn_state &= ~L2CAP_CONN_SEND_FBIT;
 	}
 
-	if (pi->conn_state & L2CAP_CONN_REMOTE_BUSY && pi->unacked_frames > 0)
-		__mod_retrans_timer();
+	if (pi->conn_state & L2CAP_CONN_REMOTE_BUSY)
+		l2cap_retransmit_frames(sk);
 
 	spin_lock_bh(&pi->send_lock);
 	l2cap_ertm_send(sk);
-- 
1.7.1
