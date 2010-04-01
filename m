Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 09/34] Bluetooth: Add Recv RR (P=0)(F=0) for SREJ_SENT state on ERTM
Date: Thu,  1 Apr 2010 17:23:27 -0300
Message-Id: <1270153432-6477-10-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1270153432-6477-9-git-send-email-padovan@profusion.mobi>
References: <1270153432-6477-1-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-2-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-3-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-4-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-5-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-6-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-7-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-8-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-9-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

This finishes the implementation of Recv RR (P=0)(F=0) for the Enhanced
Retransmission Mode on L2CAP.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 2e1884b..4dd130d 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3509,7 +3509,10 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 				__mod_retrans_timer();
 
 			pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
-			l2cap_ertm_send(sk);
+			if (pi->conn_state & L2CAP_CONN_SREJ_SENT)
+				l2cap_send_ack(pi);
+			else
+				l2cap_ertm_send(sk);
 		}
 		break;
 
-- 
1.6.4.4
