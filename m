Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Peter Hurley <peter@hurleysoftware.com>
Date: Tue, 7 Jun 2011 16:20:41 -0400
Subject: [PATCH] Bluetooth: l2cap: removed erroneous NULL ACL packet handling
Message-ID: <1307478041.2651.3.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 3a1e7de889253732609efe80cc6cb465c0e8e7d4 Mon Sep 17 00:00:00 2001
From: Peter Hurley <peter@hurleysoftware.com>
Date: Tue, 7 Jun 2011 15:47:47 -0400
Subject: [PATCH] Bluetooth: l2cap: removed erroneous NULL ACL packet handling

A 0-length ACL continuation-fragment is a valid NULL packet. Remote
devices can use the FLOW indicator in the ACL packet header to
flow-control ACL packets without sending a payload.

>From the 2.1 spec, Vol 2, Part B, 6.6.2:
  "Real-time flow control shall be carried out at the packet level by
   the link controller via the flow bit in the packet header
   (see Section 6.4.3 on page 110). With the payload flow bit, traffic
   from the remote end can be controlled. It is allowed to generate and
   send an ACL packet with payload length zero irrespective of flow
   status. L2CAP start-fragment and continue-fragment indications
   (LLID=10 and LLID=01) also retain their meaning when the payload
   length is equal to zero (i.e. an empty start fragment shall not be
   sent in the middle of an on-going ACL-U packet transmission).
   It is always safe to send an ACL packet with length=0 and LLID=01."

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/l2cap.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 675614e..84b8134 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -4743,8 +4743,10 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
 		BT_DBG("Cont: frag len %d (expecting %d)", skb->len, conn->rx_len);
 
 		if (!conn->rx_len) {
-			BT_ERR("Unexpected continuation frame (len %d)", skb->len);
-			l2cap_conn_unreliable(conn, ECOMM);
+			/* A 0-length, continuation fragment is a NULL packet
+			 * (Core 2.1, Vol 2, Part B, 6.5.1.2, 6.4.3 & 6.6.2)
+			 * The remote device is likely controlling packet flow
+			 * with ACL payload header FLOW indicator. */
 			goto drop;
 		}
 
-- 
1.7.4.1

