Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi, ulisses@profusion.mobi
Subject: [PATCH 6/7] Bluetooth: Implement missing parts of the Invalid Frame Detection
Date: Wed, 14 Apr 2010 16:41:51 -0300
Message-Id: <1271274112-7806-7-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1271274112-7806-6-git-send-email-padovan@profusion.mobi>
References: <1271274112-7806-1-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-2-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-3-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-4-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-5-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-6-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

There is a plenty of situation where ERTM shall close the channel, this
commit treats the cases regarding Invalid Frame Detection.
It create one reassembly SDU function for ERTM and other for Streaming
Mode to make the Invalid Frame Detection handling less complex.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |  119 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 112 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 0e24ee3..1f66541 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3317,12 +3317,111 @@ static void l2cap_add_to_srej_queue(struct sock *sk, struct sk_buff *skb, u8 tx_
 	__skb_queue_tail(SREJ_QUEUE(sk), skb);
 }
 
-static int l2cap_sar_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 control)
+static int l2cap_ertm_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 control)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sk_buff *_skb;
+	int err = 0;
+
+	switch (control & L2CAP_CTRL_SAR) {
+	case L2CAP_SDU_UNSEGMENTED:
+		if (pi->conn_state & L2CAP_CONN_SAR_SDU)
+			goto drop;
+
+		err = sock_queue_rcv_skb(sk, skb);
+		if (!err)
+			return err;
+
+		break;
+
+	case L2CAP_SDU_START:
+		if (pi->conn_state & L2CAP_CONN_SAR_SDU)
+			goto drop;
+
+		pi->sdu_len = get_unaligned_le16(skb->data);
+		skb_pull(skb, 2);
+
+		if (pi->sdu_len > pi->imtu)
+			goto disconnect;
+
+		pi->sdu = bt_skb_alloc(pi->sdu_len, GFP_ATOMIC);
+		if (!pi->sdu) {
+			err = -ENOMEM;
+			break;
+		}
+
+		memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
+
+		pi->conn_state |= L2CAP_CONN_SAR_SDU;
+		pi->partial_sdu_len = skb->len;
+		break;
+
+	case L2CAP_SDU_CONTINUE:
+		if (!(pi->conn_state & L2CAP_CONN_SAR_SDU))
+			goto disconnect;
+
+		if (!pi->sdu)
+			goto disconnect;
+
+		memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
+
+		pi->partial_sdu_len += skb->len;
+		if (pi->partial_sdu_len > pi->sdu_len)
+			goto drop;
+
+		break;
+
+	case L2CAP_SDU_END:
+		if (!(pi->conn_state & L2CAP_CONN_SAR_SDU))
+			goto disconnect;
+
+		if (!pi->sdu)
+			goto disconnect;
+
+		memcpy(skb_put(pi->sdu, skb->len), skb->data, skb->len);
+
+		pi->conn_state &= ~L2CAP_CONN_SAR_SDU;
+		pi->partial_sdu_len += skb->len;
+
+		if (pi->partial_sdu_len > pi->imtu)
+			goto drop;
+
+		if (pi->partial_sdu_len != pi->sdu_len)
+			goto drop;
+
+		_skb = skb_clone(pi->sdu, GFP_ATOMIC);
+		err = sock_queue_rcv_skb(sk, _skb);
+		if (err < 0)
+			kfree_skb(_skb);
+
+		kfree_skb(pi->sdu);
+		break;
+	}
+
+	kfree_skb(skb);
+	return err;
+
+drop:
+	kfree_skb(pi->sdu);
+	pi->sdu = NULL;
+
+disconnect:
+	l2cap_send_disconn_req(pi->conn, sk);
+	kfree_skb(skb);
+	return 0;
+}
+
+static int l2cap_streaming_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 control)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct sk_buff *_skb;
 	int err = -EINVAL;
 
+	/*
+	 * TODO: We have to notify the userland if some data is lost with the
+	 * Streaming Mode.
+	 */
+
 	switch (control & L2CAP_CTRL_SAR) {
 	case L2CAP_SDU_UNSEGMENTED:
 		if (pi->conn_state & L2CAP_CONN_SAR_SDU) {
@@ -3417,7 +3516,7 @@ static void l2cap_check_srej_gap(struct sock *sk, u8 tx_seq)
 
 		skb = skb_dequeue(SREJ_QUEUE(sk));
 		control |= bt_cb(skb)->sar << L2CAP_CTRL_SAR_SHIFT;
-		l2cap_sar_reassembly_sdu(sk, skb, control);
+		l2cap_ertm_reassembly_sdu(sk, skb, control);
 		l2cap_pi(sk)->buffer_seq_srej =
 			(l2cap_pi(sk)->buffer_seq_srej + 1) % 64;
 		tx_seq++;
@@ -3558,7 +3657,7 @@ expected:
 
 	pi->buffer_seq = (pi->buffer_seq + 1) % 64;
 
-	err = l2cap_sar_reassembly_sdu(sk, skb, rx_control);
+	err = l2cap_ertm_reassembly_sdu(sk, skb, rx_control);
 	if (err < 0)
 		return err;
 
@@ -3786,20 +3885,26 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		 * Receiver will miss it and start proper recovery
 		 * procedures and ask retransmission.
 		 */
-		if (len > pi->mps)
+		if (len > pi->mps) {
+			l2cap_send_disconn_req(pi->conn, sk);
 			goto drop;
+		}
 
 		if (l2cap_check_fcs(pi, skb))
 			goto drop;
 
 		if (__is_iframe(control)) {
-			if (len < 4)
+			if (len < 4){
+				l2cap_send_disconn_req(pi->conn, sk);
 				goto drop;
+			}
 
 			l2cap_data_channel_iframe(sk, control, skb);
 		} else {
-			if (len != 0)
+			if (len != 0) {
+				l2cap_send_disconn_req(pi->conn, sk);
 				goto drop;
+			}
 
 			l2cap_data_channel_sframe(sk, control, skb);
 		}
@@ -3830,7 +3935,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		else
 			pi->expected_tx_seq = (tx_seq + 1) % 64;
 
-		l2cap_sar_reassembly_sdu(sk, skb, control);
+		l2cap_streaming_reassembly_sdu(sk, skb, control);
 
 		goto done;
 
-- 
1.6.4.4
