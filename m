Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 4/5] Bluetooth: remove magic numbers in l2cap
Date: Tue, 30 Aug 2011 10:18:40 +0300
Message-Id: <1314688721-16742-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1314688721-16742-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1314688721-16742-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove magic numbers for FCS and SDU LEN

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   40 +++++++++++++++++++++++-----------------
 1 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7e67f9b..274b60c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -599,7 +599,7 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u32 control)
 		hlen = L2CAP_ENHANCED_HDR_SIZE;
 
 	if (chan->fcs == L2CAP_FCS_CRC16)
-		hlen += 2;
+		hlen += L2CAP_FCS_SIZE;
 
 	BT_DBG("chan %p, control 0x%8.8x", chan, control);
 
@@ -624,8 +624,8 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u32 control)
 	__put_control_put(chan->ext_ctrl, control, skb);
 
 	if (chan->fcs == L2CAP_FCS_CRC16) {
-		u16 fcs = crc16(0, (u8 *)lh, count - 2);
-		put_unaligned_le16(fcs, skb_put(skb, 2));
+		u16 fcs = crc16(0, (u8 *)lh, count - L2CAP_FCS_SIZE);
+		put_unaligned_le16(fcs, skb_put(skb, L2CAP_FCS_SIZE));
 	}
 
 	if (lmp_no_flush_capable(conn->hcon->hdev))
@@ -1299,8 +1299,10 @@ static void l2cap_streaming_send(struct l2cap_chan *chan)
 				skb->data + L2CAP_HDR_SIZE);
 
 		if (chan->fcs == L2CAP_FCS_CRC16) {
-			fcs = crc16(0, (u8 *)skb->data, skb->len - 2);
-			put_unaligned_le16(fcs, skb->data + skb->len - 2);
+			fcs = crc16(0, (u8 *)skb->data,
+					skb->len - L2CAP_FCS_SIZE);
+			put_unaligned_le16(fcs,
+					skb->data + skb->len - L2CAP_FCS_SIZE);
 		}
 
 		l2cap_do_send(chan, skb);
@@ -1349,8 +1351,10 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u16 tx_seq)
 	__put_control(chan->ext_ctrl, control, tx_skb->data + L2CAP_HDR_SIZE);
 
 	if (chan->fcs == L2CAP_FCS_CRC16) {
-		fcs = crc16(0, (u8 *)tx_skb->data, tx_skb->len - 2);
-		put_unaligned_le16(fcs, tx_skb->data + tx_skb->len - 2);
+		fcs = crc16(0, (u8 *)tx_skb->data,
+				tx_skb->len - L2CAP_FCS_SIZE);
+		put_unaligned_le16(fcs,
+				tx_skb->data + tx_skb->len - L2CAP_FCS_SIZE);
 	}
 
 	l2cap_do_send(chan, tx_skb);
@@ -1392,8 +1396,10 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 				tx_skb->data + L2CAP_HDR_SIZE);
 
 		if (chan->fcs == L2CAP_FCS_CRC16) {
-			fcs = crc16(0, (u8 *)skb->data, tx_skb->len - 2);
-			put_unaligned_le16(fcs, skb->data + tx_skb->len - 2);
+			fcs = crc16(0, (u8 *)skb->data,
+					tx_skb->len - L2CAP_FCS_SIZE);
+			put_unaligned_le16(fcs, skb->data +
+					tx_skb->len - L2CAP_FCS_SIZE);
 		}
 
 		l2cap_do_send(chan, tx_skb);
@@ -1576,10 +1582,10 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct m
 		hlen = L2CAP_ENHANCED_HDR_SIZE;
 
 	if (sdulen)
-		hlen += 2;
+		hlen += L2CAP_SDULEN_SIZE;
 
 	if (chan->fcs == L2CAP_FCS_CRC16)
-		hlen += 2;
+		hlen += L2CAP_FCS_SIZE;
 
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 	skb = bt_skb_send_alloc(sk, count + hlen,
@@ -1595,7 +1601,7 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct m
 	__put_control_put(chan->ext_ctrl, control, skb);
 
 	if (sdulen)
-		put_unaligned_le16(sdulen, skb_put(skb, 2));
+		put_unaligned_le16(sdulen, skb_put(skb, L2CAP_SDULEN_SIZE));
 
 	err = l2cap_skbuff_fromiovec(sk, msg, len, count, skb);
 	if (unlikely(err < 0)) {
@@ -1604,7 +1610,7 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct m
 	}
 
 	if (chan->fcs == L2CAP_FCS_CRC16)
-		put_unaligned_le16(0, skb_put(skb, 2));
+		put_unaligned_le16(0, skb_put(skb, L2CAP_FCS_SIZE));
 
 	bt_cb(skb)->retries = 0;
 	return skb;
@@ -3339,7 +3345,7 @@ static int l2cap_check_fcs(struct l2cap_chan *chan,  struct sk_buff *skb)
 		hdr_size = L2CAP_ENHANCED_HDR_SIZE;
 
 	if (chan->fcs == L2CAP_FCS_CRC16) {
-		skb_trim(skb, skb->len - 2);
+		skb_trim(skb, skb->len - L2CAP_FCS_SIZE);
 		rcv_fcs = get_unaligned_le16(skb->data + skb->len);
 		our_fcs = crc16(0, skb->data - hdr_size, skb->len + hdr_size);
 
@@ -3449,7 +3455,7 @@ static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u3
 			break;
 
 		chan->sdu_len = get_unaligned_le16(skb->data);
-		skb_pull(skb, 2);
+		skb_pull(skb, L2CAP_SDULEN_SIZE);
 
 		if (chan->sdu_len > chan->imtu) {
 			err = -EMSGSIZE;
@@ -3946,7 +3952,7 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 		len -= L2CAP_SDULEN_SIZE;
 
 	if (chan->fcs == L2CAP_FCS_CRC16)
-		len -= 2;
+		len -= L2CAP_FCS_SIZE;
 
 	if (len > chan->mps) {
 		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
@@ -4046,7 +4052,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 			len -= L2CAP_SDULEN_SIZE;
 
 		if (chan->fcs == L2CAP_FCS_CRC16)
-			len -= 2;
+			len -= L2CAP_FCS_SIZE;
 
 		if (len > chan->mps || len < 0 || __is_sframe(chan->ext_ctrl,
 					control))
-- 
1.7.4.1

