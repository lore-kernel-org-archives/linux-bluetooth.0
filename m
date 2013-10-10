Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix potential double-frees of L2CAP skbs
Date: Thu, 10 Oct 2013 13:33:37 +0200
Message-Id: <1381404817-5645-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The l2cap_recv_frame function is expected to take ownership and
eventually free the skb passed to it. We need to ensure that the
conn->rx_skb pointer is no longer reachable when calling
l2cap_recv_frame so that no other function, such as l2cap_conn_del, may
think that it can free conn->rx_skb.

An actual situation when this can happen is when smp_sig_channel (called
from l2cap_recv_frame) fails and l2cap_conn_del gets called as a
consequence. The l2cap_conn_del function would then try to free
conn->rx_skb, but as the same skb was just passed to smp_sig_channel and
freed we get a double-free.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a9a7df6..06e7173 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6798,9 +6798,13 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		conn->rx_len -= skb->len;
 
 		if (!conn->rx_len) {
-			/* Complete frame received */
-			l2cap_recv_frame(conn, conn->rx_skb);
+			/* Complete frame received. l2cap_recv_frame
+			 * takes ownership of the skb so set the global
+			 * rx_skb pointer to NULL first.
+			 */
+			struct sk_buff *rx_skb = conn->rx_skb;
 			conn->rx_skb = NULL;
+			l2cap_recv_frame(conn, rx_skb);
 		}
 		break;
 	}
-- 
1.8.3.1

