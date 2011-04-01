Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/15] Bluetooth: Move SDU related vars to struct l2cap_chan
Date: Fri,  1 Apr 2011 19:33:15 -0300
Message-Id: <1301697200-2446-11-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1301697200-2446-10-git-send-email-padovan@profusion.mobi>
References: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-2-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-3-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-4-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-5-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-6-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-7-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-8-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-9-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-10-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As part of the moving channel stuff to l2cap_chan.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    8 ++--
 net/bluetooth/l2cap_core.c    |   74 ++++++++++++++++++++--------------------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 041213b..19d613b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -298,6 +298,10 @@ struct l2cap_chan {
 	__u8		unacked_frames;
 	__u8		retry_count;
 	__u8		num_acked;
+	__u16		sdu_len;
+	__u16		partial_sdu_len;
+	struct sk_buff	*sdu;
+
 
 	struct list_head list;
 };
@@ -364,10 +368,6 @@ struct l2cap_pinfo {
 
 	__u8		conf_state;
 
-	__u16		sdu_len;
-	__u16		partial_sdu_len;
-	struct sk_buff	*sdu;
-
 	__u8		tx_win;
 	__u8		max_tx;
 	__u8		remote_tx_win;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 97a6b34..9f59147 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2876,13 +2876,13 @@ static int l2cap_ertm_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *sk
 		if (chan->conn_state & L2CAP_CONN_SAR_SDU)
 			goto drop;
 
-		pi->sdu_len = get_unaligned_le16(skb->data);
+		chan->sdu_len = get_unaligned_le16(skb->data);
 
-		if (pi->sdu_len > pi->imtu)
+		if (chan->sdu_len > pi->imtu)
 			goto disconnect;
 
-		pi->sdu = bt_skb_alloc(pi->sdu_len, GFP_ATOMIC);
-		if (!pi->sdu)
+		chan->sdu = bt_skb_alloc(chan->sdu_len, GFP_ATOMIC);
+		if (!chan->sdu)
 			return -ENOMEM;
 
 		/* pull sdu_len bytes only after alloc, because of Local Busy
@@ -2890,24 +2890,24 @@ static int l2cap_ertm_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *sk
 		 * only once, i.e., when alloc does not fail */
 		skb_pull(skb, 2);
 
-		memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
+		memcpy(skb_put(chan->sdu, skb->len), skb->data, skb->len);
 
 		chan->conn_state |= L2CAP_CONN_SAR_SDU;
-		pi->partial_sdu_len = skb->len;
+		chan->partial_sdu_len = skb->len;
 		break;
 
 	case L2CAP_SDU_CONTINUE:
 		if (!(chan->conn_state & L2CAP_CONN_SAR_SDU))
 			goto disconnect;
 
-		if (!pi->sdu)
+		if (!chan->sdu)
 			goto disconnect;
 
-		pi->partial_sdu_len += skb->len;
-		if (pi->partial_sdu_len > pi->sdu_len)
+		chan->partial_sdu_len += skb->len;
+		if (chan->partial_sdu_len > chan->sdu_len)
 			goto drop;
 
-		memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
+		memcpy(skb_put(chan->sdu, skb->len), skb->data, skb->len);
 
 		break;
 
@@ -2915,22 +2915,22 @@ static int l2cap_ertm_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *sk
 		if (!(chan->conn_state & L2CAP_CONN_SAR_SDU))
 			goto disconnect;
 
-		if (!pi->sdu)
+		if (!chan->sdu)
 			goto disconnect;
 
 		if (!(chan->conn_state & L2CAP_CONN_SAR_RETRY)) {
-			pi->partial_sdu_len += skb->len;
+			chan->partial_sdu_len += skb->len;
 
-			if (pi->partial_sdu_len > pi->imtu)
+			if (chan->partial_sdu_len > pi->imtu)
 				goto drop;
 
-			if (pi->partial_sdu_len != pi->sdu_len)
+			if (chan->partial_sdu_len != chan->sdu_len)
 				goto drop;
 
-			memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
+			memcpy(skb_put(chan->sdu, skb->len), skb->data, skb->len);
 		}
 
-		_skb = skb_clone(pi->sdu, GFP_ATOMIC);
+		_skb = skb_clone(chan->sdu, GFP_ATOMIC);
 		if (!_skb) {
 			chan->conn_state |= L2CAP_CONN_SAR_RETRY;
 			return -ENOMEM;
@@ -2946,7 +2946,7 @@ static int l2cap_ertm_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *sk
 		chan->conn_state &= ~L2CAP_CONN_SAR_RETRY;
 		chan->conn_state &= ~L2CAP_CONN_SAR_SDU;
 
-		kfree_skb(pi->sdu);
+		kfree_skb(chan->sdu);
 		break;
 	}
 
@@ -2954,8 +2954,8 @@ static int l2cap_ertm_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *sk
 	return 0;
 
 drop:
-	kfree_skb(pi->sdu);
-	pi->sdu = NULL;
+	kfree_skb(chan->sdu);
+	chan->sdu = NULL;
 
 disconnect:
 	l2cap_send_disconn_req(pi->conn, chan->sk, ECONNRESET);
@@ -3105,7 +3105,7 @@ static int l2cap_streaming_reassembly_sdu(struct l2cap_chan *chan, struct sk_buf
 	switch (control & L2CAP_CTRL_SAR) {
 	case L2CAP_SDU_UNSEGMENTED:
 		if (chan->conn_state & L2CAP_CONN_SAR_SDU) {
-			kfree_skb(pi->sdu);
+			kfree_skb(chan->sdu);
 			break;
 		}
 
@@ -3117,28 +3117,28 @@ static int l2cap_streaming_reassembly_sdu(struct l2cap_chan *chan, struct sk_buf
 
 	case L2CAP_SDU_START:
 		if (chan->conn_state & L2CAP_CONN_SAR_SDU) {
-			kfree_skb(pi->sdu);
+			kfree_skb(chan->sdu);
 			break;
 		}
 
-		pi->sdu_len = get_unaligned_le16(skb->data);
+		chan->sdu_len = get_unaligned_le16(skb->data);
 		skb_pull(skb, 2);
 
-		if (pi->sdu_len > pi->imtu) {
+		if (chan->sdu_len > pi->imtu) {
 			err = -EMSGSIZE;
 			break;
 		}
 
-		pi->sdu = bt_skb_alloc(pi->sdu_len, GFP_ATOMIC);
-		if (!pi->sdu) {
+		chan->sdu = bt_skb_alloc(chan->sdu_len, GFP_ATOMIC);
+		if (!chan->sdu) {
 			err = -ENOMEM;
 			break;
 		}
 
-		memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
+		memcpy(skb_put(chan->sdu, skb->len), skb->data, skb->len);
 
 		chan->conn_state |= L2CAP_CONN_SAR_SDU;
-		pi->partial_sdu_len = skb->len;
+		chan->partial_sdu_len = skb->len;
 		err = 0;
 		break;
 
@@ -3146,11 +3146,11 @@ static int l2cap_streaming_reassembly_sdu(struct l2cap_chan *chan, struct sk_buf
 		if (!(chan->conn_state & L2CAP_CONN_SAR_SDU))
 			break;
 
-		memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
+		memcpy(skb_put(chan->sdu, skb->len), skb->data, skb->len);
 
-		pi->partial_sdu_len += skb->len;
-		if (pi->partial_sdu_len > pi->sdu_len)
-			kfree_skb(pi->sdu);
+		chan->partial_sdu_len += skb->len;
+		if (chan->partial_sdu_len > chan->sdu_len)
+			kfree_skb(chan->sdu);
 		else
 			err = 0;
 
@@ -3160,16 +3160,16 @@ static int l2cap_streaming_reassembly_sdu(struct l2cap_chan *chan, struct sk_buf
 		if (!(chan->conn_state & L2CAP_CONN_SAR_SDU))
 			break;
 
-		memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
+		memcpy(skb_put(chan->sdu, skb->len), skb->data, skb->len);
 
 		chan->conn_state &= ~L2CAP_CONN_SAR_SDU;
-		pi->partial_sdu_len += skb->len;
+		chan->partial_sdu_len += skb->len;
 
-		if (pi->partial_sdu_len > pi->imtu)
+		if (chan->partial_sdu_len > pi->imtu)
 			goto drop;
 
-		if (pi->partial_sdu_len == pi->sdu_len) {
-			_skb = skb_clone(pi->sdu, GFP_ATOMIC);
+		if (chan->partial_sdu_len == chan->sdu_len) {
+			_skb = skb_clone(chan->sdu, GFP_ATOMIC);
 			err = sock_queue_rcv_skb(chan->sk, _skb);
 			if (err < 0)
 				kfree_skb(_skb);
@@ -3177,7 +3177,7 @@ static int l2cap_streaming_reassembly_sdu(struct l2cap_chan *chan, struct sk_buf
 		err = 0;
 
 drop:
-		kfree_skb(pi->sdu);
+		kfree_skb(chan->sdu);
 		break;
 	}
 
-- 
1.7.4.1

