Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Restrict blocked device check in l2cap_recv_frame to LE
Date: Sun,  6 Jul 2014 11:03:36 +0300
Message-Id: <1404633816-10624-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

BR/EDR has the connection request and connection request rejection, but
LE doesn't have anything similar. We still request LE connections to
blocked devices to be disconnected but it's possible that ACL data slips
through before that. The check in l2cap_recv_frame really only needs to
be for LE and not BR/EDR because of this.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index dbef22d644e2..f1f544a12c3c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6914,7 +6914,11 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		return;
 	}
 
-	if (hci_blacklist_lookup(hcon->hdev, &hcon->dst,
+	/* Since we can't actively block incoming LE connections we must
+	 * at least ensure that we ignore incoming data from them.
+	 */
+	if (hcon->type == LE_LINK &&
+	    hci_blacklist_lookup(hcon->hdev, &hcon->dst,
 				 bdaddr_type(hcon, hcon->dst_type))) {
 		kfree_skb(skb);
 		return;
-- 
1.9.3

