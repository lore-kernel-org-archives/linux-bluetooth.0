Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 0/4] EWS support last chunks
Date: Fri, 14 Oct 2011 14:03:11 +0300
Message-Id: <1318590195-2259-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This is rework of 4 patches not applied because of issues in
"Bluetooth: EWS: handling different Control fields" patch.
Cumulative change is:

__________________________________________________________

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 7a2d3b3..0252008 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -743,23 +743,8 @@ static inline __u32 __get_control(struct l2cap_chan *chan, void *p)
 		return get_unaligned_le16(p);
 }
 
-static inline __u32 __get_control_pull(struct l2cap_chan *chan,
-		struct sk_buff *skb, void *p)
-{
-	__u32 ctrl;
-
-	if (test_bit(FLAG_EXT_CTRL, &chan->flags)) {
-		ctrl = get_unaligned_le32(p);
-		skb_pull(skb, 4);
-	} else {
-		ctrl = get_unaligned_le16(p);
-		skb_pull(skb, 2);
-	}
-
-	return ctrl;
-}
-
-static inline void __put_control(struct l2cap_chan *chan, __u32 control, void *p)
+static inline void __put_control(struct l2cap_chan *chan, __u32 control,
+								void *p)
 {
 	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
 		return put_unaligned_le32(control, p);
@@ -767,12 +752,12 @@ static inline void __put_control(struct l2cap_chan *chan, __u32 control, void *p
 		return put_unaligned_le16(control, p);
 }
 
-static inline void __put_control_put(struct l2cap_chan *chan, __u32 control, void *p)
+static inline __u8 __get_ctrl_size(struct l2cap_chan *chan)
 {
 	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
-		return put_unaligned_le32(control, skb_put(p, 4));
+		return L2CAP_EXT_HDR_SIZE - L2CAP_HDR_SIZE;
 	else
-		return put_unaligned_le16(control, skb_put(p, 2));
+		return L2CAP_ENH_HDR_SIZE - L2CAP_HDR_SIZE;
 }
 
 extern int disable_ertm;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3efd197..5fb293d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -583,6 +583,7 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u32 control)
 	struct l2cap_conn *conn = chan->conn;
 	int count, hlen;
 	u8 flags;
+	unsigned char *data;
 
 	if (chan->state != BT_CONNECTED)
 		return;
@@ -615,7 +616,8 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u32 control)
 	lh->len = cpu_to_le16(hlen - L2CAP_HDR_SIZE);
 	lh->cid = cpu_to_le16(chan->dcid);
 
-	__put_control_put(chan, control, skb);
+	data = skb_put(skb, __get_ctrl_size(chan));
+	__put_control(chan, control, data);
 
 	if (chan->fcs == L2CAP_FCS_CRC16) {
 		u16 fcs = crc16(0, (u8 *)lh, count - L2CAP_FCS_SIZE);
@@ -1586,6 +1588,7 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 	struct sk_buff *skb;
 	int err, count, hlen;
 	struct l2cap_hdr *lh;
+	unsigned char *data;
 
 	BT_DBG("sk %p len %d", sk, (int)len);
 
@@ -1614,7 +1617,8 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 	lh->cid = cpu_to_le16(chan->dcid);
 	lh->len = cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
 
-	__put_control_put(chan, control, skb);
+	data = skb_put(skb, __get_ctrl_size(chan));
+	__put_control(chan, control, data);
 
 	if (sdulen)
 		put_unaligned_le16(sdulen, skb_put(skb, L2CAP_SDULEN_SIZE));
@@ -4005,7 +4009,8 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 	u16 req_seq;
 	int len, next_tx_seq_offset, req_seq_offset;
 
-	control = __get_control_pull(chan, skb, skb->data);
+	control = __get_control(chan, skb->data);
+	skb_pull(skb, __get_ctrl_size(chan));
 	len = skb->len;
 
 	/*
@@ -4110,7 +4115,8 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		goto done;
 
 	case L2CAP_MODE_STREAMING:
-		control = __get_control_pull(chan, skb, skb->data);
+		control = __get_control(chan, skb->data);
+		skb_pull(skb, __get_ctrl_size(chan));
 		len = skb->len;
 
 		if (l2cap_check_fcs(chan, skb))
________________________________________________________________

Andrei Emeltchenko (4):
  Bluetooth: EWS: handling different Control fields
  Bluetooth: EWS: support extended seq numbers
  Bluetooth: EWS: remove magic numbers in l2cap
  Bluetooth: EWS: fix max_pdu calculation

 include/net/bluetooth/bluetooth.h |    2 +-
 include/net/bluetooth/l2cap.h     |   45 +++++++
 net/bluetooth/l2cap_core.c        |  250 ++++++++++++++++++++----------------
 3 files changed, 185 insertions(+), 112 deletions(-)

-- 
1.7.4.1

