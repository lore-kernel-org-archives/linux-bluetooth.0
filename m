Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 5/5] Bluetooth: prevent unneeded fragmentation in l2cap
Date: Thu,  1 Sep 2011 17:45:10 +0300
Message-Id: <1314888310-5337-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1314888310-5337-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1314888310-5337-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Calculate pdu length before creating I-frame. Otherwise if
conn->mtu - (headers) < remote_mps we get fragmented packets in
create_iframe_pdu function.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e445034..f481130 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1575,8 +1575,6 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct m
 	int err, count, hlen;
 	struct l2cap_hdr *lh;
 
-	BT_DBG("sk %p len %d", sk, (int)len);
-
 	if (!conn)
 		return ERR_PTR(-ENOTCONN);
 
@@ -1591,6 +1589,9 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct m
 	if (chan->fcs == L2CAP_FCS_CRC16)
 		hlen += L2CAP_FCS_SIZE;
 
+	BT_DBG("sk %p, msg %p, len %d, sdulen %d, hlen %d",
+		sk, msg, (int)len, (int)sdulen, hlen);
+
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 	skb = bt_skb_send_alloc(sk, count + hlen,
 			msg->msg_flags & MSG_DONTWAIT, &err);
@@ -1626,23 +1627,30 @@ static int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, si
 	struct sk_buff_head sar_queue;
 	u32 control;
 	size_t size = 0;
+	size_t pdu_len;
 
 	skb_queue_head_init(&sar_queue);
+	
 	control = __set_ctrl_sar(chan, L2CAP_SAR_START);
-	skb = l2cap_create_iframe_pdu(chan, msg, chan->remote_mps, control, len);
+
+	pdu_len = chan->conn->mtu;
+	pdu_len -= L2CAP_EXTENDED_HDR_SIZE + L2CAP_FCS_SIZE + L2CAP_SDULEN_SIZE;
+	pdu_len = min_t(size_t, pdu_len, chan->remote_mps);
+
+	skb = l2cap_create_iframe_pdu(chan, msg, pdu_len, control, len);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
 	__skb_queue_tail(&sar_queue, skb);
-	len -= chan->remote_mps;
-	size += chan->remote_mps;
+	len -= pdu_len;
+	size += pdu_len;
 
 	while (len > 0) {
 		size_t buflen;
 
-		if (len > chan->remote_mps) {
+		if (len > pdu_len) {
 			control = __set_ctrl_sar(chan, L2CAP_SAR_CONTINUE);
-			buflen = chan->remote_mps;
+			buflen = pdu_len;
 		} else {
 			control = __set_ctrl_sar(chan, L2CAP_SAR_END);
 			buflen = len;
@@ -3334,8 +3342,10 @@ static int l2cap_check_fcs(struct l2cap_chan *chan,  struct sk_buff *skb)
 		rcv_fcs = get_unaligned_le16(skb->data + skb->len);
 		our_fcs = crc16(0, skb->data - hdr_size, skb->len + hdr_size);
 
-		if (our_fcs != rcv_fcs)
+		if (our_fcs != rcv_fcs) {
+			BT_DBG("FCS check failed");
 			return -EBADMSG;
+		}
 	}
 	return 0;
 }
-- 
1.7.4.1

