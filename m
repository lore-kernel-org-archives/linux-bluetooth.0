Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [l2cap 4/6] Bluetooth: Fix ERTM vars increment
Date: Wed, 12 May 2010 00:05:56 -0300
Message-Id: <1273633558-10576-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1273633558-10576-3-git-send-email-padovan@profusion.mobi>
References: <1273513181-28258-2-git-send-email-gustavo@padovan.org>
 <1273633558-10576-1-git-send-email-padovan@profusion.mobi>
 <1273633558-10576-2-git-send-email-padovan@profusion.mobi>
 <1273633558-10576-3-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

They should be modulo 64 ;)

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 784bbed..6b5226d 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3746,7 +3746,7 @@ static void l2cap_check_srej_gap(struct sock *sk, u8 tx_seq)
 		l2cap_ertm_reassembly_sdu(sk, skb, control);
 		l2cap_pi(sk)->buffer_seq_srej =
 			(l2cap_pi(sk)->buffer_seq_srej + 1) % 64;
-		tx_seq++;
+		tx_seq = (tx_seq + 1) % 64;
 	}
 }
 
@@ -3782,10 +3782,11 @@ static void l2cap_send_srejframe(struct sock *sk, u8 tx_seq)
 		l2cap_send_sframe(pi, control);
 
 		new = kzalloc(sizeof(struct srej_list), GFP_ATOMIC);
-		new->tx_seq = pi->expected_tx_seq++;
+		new->tx_seq = pi->expected_tx_seq;
+		pi->expected_tx_seq = (pi->expected_tx_seq + 1) % 64;
 		list_add_tail(&new->list, SREJ_LIST(sk));
 	}
-	pi->expected_tx_seq++;
+	pi->expected_tx_seq = (pi->expected_tx_seq + 1) % 64;
 }
 
 static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, struct sk_buff *skb)
-- 
1.6.4.4
