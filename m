Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 15/16] Bluetooth: EWS: remove magic numbers in l2cap
Date: Tue, 11 Oct 2011 13:37:55 +0300
Message-Id: <1318329476-30153-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove magic numbers for FCS, SDU LEN and PSM LEN
when calculating packet payload.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   46 ++++++++++++++++++++++++-------------------
 1 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2f1cd92..a703301 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -578,7 +578,7 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u32 control)
 		hlen = L2CAP_ENH_HDR_SIZE;
 
 	if (chan->fcs == L2CAP_FCS_CRC16)
-		hlen += 2;
+		hlen += L2CAP_FCS_SIZE;
 
 	BT_DBG("chan %p, control 0x%8.8x", chan, control);
 
@@ -603,8 +603,8 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u32 control)
 	__put_control_put(chan, control, skb);
 
 	if (chan->fcs == L2CAP_FCS_CRC16) {
-		u16 fcs = crc16(0, (u8 *)lh, count - 2);
-		put_unaligned_le16(fcs, skb_put(skb, 2));
+		u16 fcs = crc16(0, (u8 *)lh, count - L2CAP_FCS_SIZE);
+		put_unaligned_le16(fcs, skb_put(skb, L2CAP_FCS_SIZE));
 	}
 
 	if (lmp_no_flush_capable(conn->hcon->hdev))
@@ -1282,8 +1282,10 @@ static void l2cap_streaming_send(struct l2cap_chan *chan)
 		__put_control(chan, control, skb->data + L2CAP_HDR_SIZE);
 
 		if (chan->fcs == L2CAP_FCS_CRC16) {
-			fcs = crc16(0, (u8 *)skb->data, skb->len - 2);
-			put_unaligned_le16(fcs, skb->data + skb->len - 2);
+			fcs = crc16(0, (u8 *)skb->data,
+						skb->len - L2CAP_FCS_SIZE);
+			put_unaligned_le16(fcs,
+					skb->data + skb->len - L2CAP_FCS_SIZE);
 		}
 
 		l2cap_do_send(chan, skb);
@@ -1332,8 +1334,10 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u16 tx_seq)
 	__put_control(chan, control, tx_skb->data + L2CAP_HDR_SIZE);
 
 	if (chan->fcs == L2CAP_FCS_CRC16) {
-		fcs = crc16(0, (u8 *)tx_skb->data, tx_skb->len - 2);
-		put_unaligned_le16(fcs, tx_skb->data + tx_skb->len - 2);
+		fcs = crc16(0, (u8 *)tx_skb->data,
+						tx_skb->len - L2CAP_FCS_SIZE);
+		put_unaligned_le16(fcs,
+				tx_skb->data + tx_skb->len - L2CAP_FCS_SIZE);
 	}
 
 	l2cap_do_send(chan, tx_skb);
@@ -1373,8 +1377,10 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 		__put_control(chan, control, tx_skb->data + L2CAP_HDR_SIZE);
 
 		if (chan->fcs == L2CAP_FCS_CRC16) {
-			fcs = crc16(0, (u8 *)skb->data, tx_skb->len - 2);
-			put_unaligned_le16(fcs, skb->data + tx_skb->len - 2);
+			fcs = crc16(0, (u8 *)skb->data,
+						tx_skb->len - L2CAP_FCS_SIZE);
+			put_unaligned_le16(fcs, skb->data +
+						tx_skb->len - L2CAP_FCS_SIZE);
 		}
 
 		l2cap_do_send(chan, tx_skb);
@@ -1484,7 +1490,7 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan, struct
 	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
-	int err, count, hlen = L2CAP_HDR_SIZE + 2;
+	int err, count, hlen = L2CAP_HDR_SIZE + L2CAP_PSMLEN_SIZE;
 	struct l2cap_hdr *lh;
 
 	BT_DBG("sk %p len %d", sk, (int)len);
@@ -1559,10 +1565,10 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 		hlen = L2CAP_ENH_HDR_SIZE;
 
 	if (sdulen)
-		hlen += 2;
+		hlen += L2CAP_SDULEN_SIZE;
 
 	if (chan->fcs == L2CAP_FCS_CRC16)
-		hlen += 2;
+		hlen += L2CAP_FCS_SIZE;
 
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 	skb = bt_skb_send_alloc(sk, count + hlen,
@@ -1578,7 +1584,7 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 	__put_control_put(chan, control, skb);
 
 	if (sdulen)
-		put_unaligned_le16(sdulen, skb_put(skb, 2));
+		put_unaligned_le16(sdulen, skb_put(skb, L2CAP_SDULEN_SIZE));
 
 	err = l2cap_skbuff_fromiovec(sk, msg, len, count, skb);
 	if (unlikely(err < 0)) {
@@ -1587,7 +1593,7 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 	}
 
 	if (chan->fcs == L2CAP_FCS_CRC16)
-		put_unaligned_le16(0, skb_put(skb, 2));
+		put_unaligned_le16(0, skb_put(skb, L2CAP_FCS_SIZE));
 
 	bt_cb(skb)->retries = 0;
 	return skb;
@@ -3128,7 +3134,7 @@ static int l2cap_check_fcs(struct l2cap_chan *chan,  struct sk_buff *skb)
 		hdr_size = L2CAP_ENH_HDR_SIZE;
 
 	if (chan->fcs == L2CAP_FCS_CRC16) {
-		skb_trim(skb, skb->len - 2);
+		skb_trim(skb, skb->len - L2CAP_FCS_SIZE);
 		rcv_fcs = get_unaligned_le16(skb->data + skb->len);
 		our_fcs = crc16(0, skb->data - hdr_size, skb->len + hdr_size);
 
@@ -3238,7 +3244,7 @@ static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u3
 			break;
 
 		chan->sdu_len = get_unaligned_le16(skb->data);
-		skb_pull(skb, 2);
+		skb_pull(skb, L2CAP_SDULEN_SIZE);
 
 		if (chan->sdu_len > chan->imtu) {
 			err = -EMSGSIZE;
@@ -3730,10 +3736,10 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 
 	if (__is_sar_start(chan, control) && !__is_sframe(chan, control))
-		len -= 2;
+		len -= L2CAP_SDULEN_SIZE;
 
 	if (chan->fcs == L2CAP_FCS_CRC16)
-		len -= 2;
+		len -= L2CAP_FCS_SIZE;
 
 	if (len > chan->mps) {
 		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
@@ -3830,10 +3836,10 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 			goto drop;
 
 		if (__is_sar_start(chan, control))
-			len -= 2;
+			len -= L2CAP_SDULEN_SIZE;
 
 		if (chan->fcs == L2CAP_FCS_CRC16)
-			len -= 2;
+			len -= L2CAP_FCS_SIZE;
 
 		if (len > chan->mps || len < 0 || __is_sframe(chan, control))
 			goto drop;
-- 
1.7.4.1

