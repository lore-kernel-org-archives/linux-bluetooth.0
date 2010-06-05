Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@profusion.mobi>
Subject: [PATCH 13/14] Bluetooth: Fix SREJ_QUEUE corruption
Date: Sat,  5 Jun 2010 04:50:17 -0300
Message-Id: <1275724218-29453-14-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275724218-29453-13-git-send-email-gustavo@padovan.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

From: João Paulo Rechi Vita <jprvita@profusion.mobi>

Since all TxSeq values are modulo, we can't compare them directly. We
have to compare their offset inside the TxWindow instead.

Signed-off-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 59c4690..4a737b2 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3418,6 +3418,8 @@ static inline void l2cap_send_i_or_rr_or_rnr(struct sock *sk)
 static int l2cap_add_to_srej_queue(struct sock *sk, struct sk_buff *skb, u8 tx_seq, u8 sar)
 {
 	struct sk_buff *next_skb;
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	int tx_seq_offset, next_tx_seq_offset;
 
 	bt_cb(skb)->tx_seq = tx_seq;
 	bt_cb(skb)->sar = sar;
@@ -3428,11 +3430,20 @@ static int l2cap_add_to_srej_queue(struct sock *sk, struct sk_buff *skb, u8 tx_s
 		return 0;
 	}
 
+	tx_seq_offset = (tx_seq - pi->buffer_seq) % 64;
+	if (tx_seq_offset < 0)
+		tx_seq_offset += 64;
+
 	do {
 		if (bt_cb(next_skb)->tx_seq == tx_seq)
 			return -EINVAL;
 
-		if (bt_cb(next_skb)->tx_seq > tx_seq) {
+		next_tx_seq_offset = (bt_cb(next_skb)->tx_seq -
+						pi->buffer_seq) % 64;
+		if (next_tx_seq_offset < 0)
+			next_tx_seq_offset += 64;
+
+		if (next_tx_seq_offset > tx_seq_offset) {
 			__skb_queue_before(SREJ_QUEUE(sk), next_skb, skb);
 			return 0;
 		}
-- 
1.7.1
