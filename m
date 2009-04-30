Return-Path: <cyrus@holtmann.org>
From: ngh@isomerica.net
To: linux-bluetooth@vger.kernel.org
Cc: Nathan Holstein <nathan@lampreynetworks.com>
Subject: [PATCH 07/10] Check the FCS of a received L2CAP packet.
Date: Thu, 30 Apr 2009 17:16:44 -0400
Message-Id: <1241126207-19996-8-git-send-email-ngh@isomerica.net>
In-Reply-To: <1241126207-19996-1-git-send-email-ngh@isomerica.net>
References: <1241126207-19996-1-git-send-email-ngh@isomerica.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Nathan Holstein <nathan@lampreynetworks.com>

When in Enhanced Retransmission or Streaming modes, L2CAP supports an optional
16 bit CRC to validate a packet.  This patch checks incoming SDUs for a correct
FCS.

Signed-off-by: Nathan Holstein <nathan@lampreynetworks.com>
---
 net/bluetooth/l2cap.c |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index b2c8dd7..ad96ce7 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -53,7 +53,7 @@
 
 #define VERSION "2.13"
 
-static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
+static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN | L2CAP_FEAT_FCS;
 static u8 l2cap_fixed_chan[8] = { 0x02, };
 
 static const struct proto_ops l2cap_sock_ops;
@@ -2563,6 +2563,34 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn, struct sk_buff *sk
 	kfree_skb(skb);
 }
 
+static int l2cap_check_fcs(struct l2cap_pinfo *pi, struct l2cap_hdr *lh, struct sk_buff *skb)
+{
+	u16 our_fcs = 0;
+	u16 rcv_fcs;
+
+	if (lh->len != skb->len)
+		return -1;
+
+	if (pi->fcs)
+	{
+		if (lh->len < 4)
+			return -1;
+
+		/* Remove the FCS bytes from data */
+		skb->len -= 2;
+		rcv_fcs = get_unaligned((__le16 *) skb->data + skb->len);
+		/* Include the header in the FCS */
+		our_fcs = crc16(0, skb->data - 4, skb->len);
+
+		if (our_fcs != rcv_fcs)
+			return 0;
+	}
+	else if (lh->len < 2)
+		return -1;
+
+	return 0;
+}
+
 static inline int l2cap_data_channel_i_frame(struct sock *sk, u16 rx_control, struct sk_buff *skb)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
@@ -2620,6 +2648,19 @@ static inline int l2cap_data_channel_enhanced(struct sock *sk, struct l2cap_hdr
 
 	BT_DBG("sk %p skb %p", sk, skb);
 
+	if (l2cap_check_fcs(pi, lh, skb))
+	{
+		BT_DBG("failed fcs");
+		control = pi->req_seq | L2CAP_CONTROL_TYPE_MASK |
+				L2CAP_SUPER_REJECT;
+		if (!l2cap_send_sframe(pi, control))
+		{
+			/* TODO:
+			 * set an error state, disconnect */
+		}
+		return -1;
+	}
+
 	control = get_unaligned((__le16 *) skb->data);
 	skb_pull(skb, 2);
 
@@ -2643,6 +2684,9 @@ static int l2cap_data_channel_streaming(struct sock *sk, struct l2cap_hdr *lh, s
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	u16 control;
 
+	if (l2cap_check_fcs(pi, lh, skb))
+		return -1;
+
 	control = get_unaligned((__le16 *) skb->data);
 	skb_pull(skb, 2);
 
-- 
1.6.0.6

