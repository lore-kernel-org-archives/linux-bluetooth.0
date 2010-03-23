Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi, ulisses@profusion.mobi
Subject: [PATCH 16/19] Bluetooth: Finish implementation for Rec RR (P=1) on ERTM
Date: Tue, 23 Mar 2010 16:48:43 -0300
Message-Id: <1269373726-13209-17-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269373726-13209-16-git-send-email-padovan@profusion.mobi>
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
 <1269373726-13209-15-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-16-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Now the code handles the case under SREJ_SENT state.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 9546f59..85f97b9 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3495,8 +3495,17 @@ static inline void l2cap_data_channel_rrframe(struct sock *sk, u16 rx_control)
 	l2cap_drop_acked_frames(sk);
 
 	if (rx_control & L2CAP_CTRL_POLL) {
-		l2cap_send_i_or_rr_or_rnr(sk);
-		pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+		if (pi->conn_state & L2CAP_CONN_SREJ_SENT) {
+			if ((pi->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
+					(pi->unacked_frames > 0))
+				__mod_retrans_timer();
+
+			pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+			l2cap_send_srejtail(sk);
+		} else {
+			l2cap_send_i_or_rr_or_rnr(sk);
+			pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
+		}
 
 	} else if (rx_control & L2CAP_CTRL_FINAL) {
 		pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
-- 
1.6.4.4
