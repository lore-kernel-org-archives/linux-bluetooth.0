Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 05/34] Bluetooth: Check if SDU size is greater than MTU on L2CAP
Date: Thu,  1 Apr 2010 17:23:23 -0300
Message-Id: <1270153432-6477-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1270153432-6477-5-git-send-email-padovan@profusion.mobi>
References: <1270153432-6477-1-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-2-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-3-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-4-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-5-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

After reassembly the SDU we need to check his size. It can't overflow
the MTU size.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index e78fc16..36fac64 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3269,15 +3269,19 @@ static int l2cap_sar_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 co
 		pi->conn_state &= ~L2CAP_CONN_SAR_SDU;
 		pi->partial_sdu_len += skb->len;
 
+		if (pi->partial_sdu_len > pi->imtu)
+			goto drop;
+
 		if (pi->partial_sdu_len == pi->sdu_len) {
 			_skb = skb_clone(pi->sdu, GFP_ATOMIC);
 			err = sock_queue_rcv_skb(sk, _skb);
 			if (err < 0)
 				kfree_skb(_skb);
 		}
-		kfree_skb(pi->sdu);
 		err = 0;
 
+drop:
+		kfree_skb(pi->sdu);
 		break;
 	}
 
-- 
1.6.4.4
