Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [RFC 2/7] Bluetooth: Use enhanced L2CAP header structure and symbolic values.
Date: Tue, 10 Aug 2010 12:14:59 -0700
Message-Id: <1281467704-5378-3-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>


Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 5e78c18..aa69c84 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1753,33 +1753,36 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *m
 {
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 	struct sk_buff *skb;
-	int err, count, hlen = L2CAP_HDR_SIZE + 2;
-	struct l2cap_hdr *lh;
+	int err, count, hlen = L2CAP_ENHANCED_HDR_SIZE;
+	struct l2cap_enhanced_hdr *lh;
 
-	BT_DBG("sk %p len %d", sk, (int)len);
+	BT_DBG("sk %p, msg %p, len %d, control %x, sdulen %d",
+		sk, msg, (int)len, control, (int)sdulen);
 
 	if (!conn)
 		return ERR_PTR(-ENOTCONN);
 
 	if (sdulen)
-		hlen += 2;
+		hlen += L2CAP_SDULEN_SIZE;
 
 	if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16)
-		hlen += 2;
+		hlen += L2CAP_FCS_SIZE;
 
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
+
 	skb = bt_skb_send_alloc(sk, count + hlen,
 			msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
-		return ERR_PTR(-ENOMEM);
+		return ERR_PTR(err);
 
 	/* Create L2CAP header */
-	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
+	lh = (struct l2cap_enhanced_hdr *) skb_put(skb,
+						L2CAP_ENHANCED_HDR_SIZE);
 	lh->cid = cpu_to_le16(l2cap_pi(sk)->dcid);
-	lh->len = cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
-	put_unaligned_le16(control, skb_put(skb, 2));
+	lh->len = cpu_to_le16(len + hlen - L2CAP_HDR_SIZE);
+	lh->control = cpu_to_le16(control);
 	if (sdulen)
-		put_unaligned_le16(sdulen, skb_put(skb, 2));
+		put_unaligned_le16(sdulen, skb_put(skb, L2CAP_SDULEN_SIZE));
 
 	err = l2cap_skbuff_fromiovec(sk, msg, len, count, skb);
 	if (unlikely(err < 0)) {
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
