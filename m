Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [l2cap 3/6] Bluetooth: Check skb_clone return to avoid NULL dereference
Date: Wed, 12 May 2010 00:05:55 -0300
Message-Id: <1273633558-10576-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1273633558-10576-2-git-send-email-padovan@profusion.mobi>
References: <1273513181-28258-2-git-send-email-gustavo@padovan.org>
 <1273633558-10576-1-git-send-email-padovan@profusion.mobi>
 <1273633558-10576-2-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 93667ac..784bbed 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1337,6 +1337,8 @@ static int l2cap_streaming_send(struct sock *sk)
 
 	while ((skb = sk->sk_send_head)) {
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
+		if (!tx_skb)
+			break;
 
 		control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
 		control |= pi->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT;
@@ -1422,6 +1424,8 @@ static int l2cap_ertm_send(struct sock *sk)
 		}
 
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
+		if (!tx_skb)
+			break;
 
 		bt_cb(skb)->retries++;
 
-- 
1.6.4.4
