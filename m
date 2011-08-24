Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Wed, 24 Aug 2011 10:05:09 -0400
Subject: [RFC v3 4/4] Bluetooth: l2cap: fix NULL ACL packet handling
Message-ID: <1314194709.2219.17.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A 0-length ACL continuation-fragment is a valid NULL packet. Remote
devices can use the FLOW indicator in the ACL packet header to
flow-control ACL packets without sending a payload.

Track as a connection stat instead of logging.
---

v2 ensure the fragment is 0-length
v3 use new hci_conn.stats rather than hci_dev.stat

 net/bluetooth/l2cap_core.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2969ef0..67a3342 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4120,6 +4120,14 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
 		BT_DBG("Cont: frag len %d (expecting %d)", skb->len, conn->rx_len);
 
 		if (!conn->rx_len) {
+			/* A 0-length, continuation fragment is a NULL packet
+			 * (Core 2.1, Vol 2, Part B, 6.5.1.2, 6.4.3 & 6.6.2)
+			 * The remote device is likely controlling packet flow
+			 * with ACL payload header FLOW indicator. */
+			if (!skb->len) {
+				hcon->stats.null_rx++;
+				goto drop;
+			}
 			BT_ERR("Unexpected continuation frame (len %d)", skb->len);
 			l2cap_conn_unreliable(conn, ECOMM);
 			goto drop;
-- 
1.7.4.1

