Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: jprvita@profusion.mobi, gustavo@padovan.org, marcel@holtmann.org
Subject: [PATCH 05/13] Bluetooth: Fix ERTM vars increment
Date: Mon, 31 May 2010 14:02:44 -0300
Message-Id: <1275325372-5671-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1275325372-5671-4-git-send-email-padovan@profusion.mobi>
References: <1275325372-5671-1-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-2-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-3-git-send-email-padovan@profusion.mobi>
 <1275325372-5671-4-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

They should be modulo 64 ;)

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 27e69f6..a567614 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3745,7 +3745,7 @@ static void l2cap_check_srej_gap(struct sock *sk, u8 tx_seq)
 		l2cap_ertm_reassembly_sdu(sk, skb, control);
 		l2cap_pi(sk)->buffer_seq_srej =
 			(l2cap_pi(sk)->buffer_seq_srej + 1) % 64;
-		tx_seq++;
+		tx_seq = (tx_seq + 1) % 64;
 	}
 }
 
@@ -3781,10 +3781,11 @@ static void l2cap_send_srejframe(struct sock *sk, u8 tx_seq)
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
