Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 04/14] Bluetooth: Check skb_clone return to avoid NULL dereference
Date: Sat,  5 Jun 2010 04:50:08 -0300
Message-Id: <1275724218-29453-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275724218-29453-4-git-send-email-gustavo@padovan.org>
References: <1275724218-29453-1-git-send-email-gustavo@padovan.org>
 <1275724218-29453-2-git-send-email-gustavo@padovan.org>
 <1275724218-29453-3-git-send-email-gustavo@padovan.org>
 <1275724218-29453-4-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

skb can be NULL and a Ooops can happen if we do not check for NULL.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index b08731d..27e69f6 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1335,6 +1335,8 @@ static int l2cap_streaming_send(struct sock *sk)
 
 	while ((skb = sk->sk_send_head)) {
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
+		if (!tx_skb)
+			break;
 
 		control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
 		control |= pi->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT;
@@ -1420,6 +1422,8 @@ static int l2cap_ertm_send(struct sock *sk)
 		}
 
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
+		if (!tx_skb)
+			break;
 
 		bt_cb(skb)->retries++;
 
-- 
1.7.1
