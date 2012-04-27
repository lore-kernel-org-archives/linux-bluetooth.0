Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org
Cc: pkrystad@codeaurora.org,
	andrei.emeltchenko.news@gmail.com
Subject: [RFCv2 4/8] Bluetooth: Fix a redundant and problematic incoming MTU check
Date: Fri, 27 Apr 2012 16:50:51 -0700
Message-Id: <1335570655-30878-5-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1335570655-30878-1-git-send-email-mathewm@codeaurora.org>
References: <1335570655-30878-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

The L2CAP MTU for incoming data is verified differently depending on
the L2CAP mode, so the check is best performed in a mode-specific
context.  Checking the incoming MTU before HCI fragment reassembly is
a layer violation and assumes all bytes after the standard L2CAP
header are L2CAP data.

This approadch causes issues with unsegmented ERTM or streaming mode
frames, where there are additional enhanced or extended headers before
the data payload and possible FCS bytes after the data payload.  A
valid frame could be as many as 10 bytes larger than the MTU.

Removing this code is the best fix, because the MTU is checked later
on for all L2CAP data frames (connectionless, basic, ERTM, and
streaming).  This also gets rid of outdated locking (socket instead of
l2cap_chan) and an extra lookup of the channel ID.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5963cd2..e543b53 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4953,8 +4953,6 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 	if (!(flags & ACL_CONT)) {
 		struct l2cap_hdr *hdr;
-		struct l2cap_chan *chan;
-		u16 cid;
 		int len;
 
 		if (conn->rx_len) {
@@ -4974,7 +4972,6 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 		hdr = (struct l2cap_hdr *) skb->data;
 		len = __le16_to_cpu(hdr->len) + L2CAP_HDR_SIZE;
-		cid = __le16_to_cpu(hdr->cid);
 
 		if (len == skb->len) {
 			/* Complete frame received */
@@ -4991,23 +4988,6 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 			goto drop;
 		}
 
-		chan = l2cap_get_chan_by_scid(conn, cid);
-
-		if (chan && chan->sk) {
-			struct sock *sk = chan->sk;
-			lock_sock(sk);
-
-			if (chan->imtu < len - L2CAP_HDR_SIZE) {
-				BT_ERR("Frame exceeding recv MTU (len %d, "
-							"MTU %d)", len,
-							chan->imtu);
-				release_sock(sk);
-				l2cap_conn_unreliable(conn, ECOMM);
-				goto drop;
-			}
-			release_sock(sk);
-		}
-
 		/* Allocate skb for the complete frame (with header) */
 		conn->rx_skb = bt_skb_alloc(len, GFP_ATOMIC);
 		if (!conn->rx_skb)
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
