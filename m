Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Centralize looking up blocked devices to l2cap_recv_frame
Date: Wed,  2 Jul 2014 09:36:21 +0300
Message-Id: <1404282982-26114-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The ATT channel isn't the only one that we should ensure doesn't receive
data from blocked devices. SMP is another, and in general we don't want
data packets going to any of the various handlers. Therefore, add a
single check to the l2cap_recv_frame function.

The patch fixes at the same time the use of a correct address type. The
blacklist stores the values with the user space facing triple type
wheras hci_conn->dst_type uses the HCI address type (0x00 or 0x01).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 058b3b2b59b5..a6e276204ae9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6878,9 +6878,6 @@ static void l2cap_att_channel(struct l2cap_conn *conn,
 
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
-	if (hci_blacklist_lookup(hcon->hdev, &hcon->dst, hcon->dst_type))
-		goto drop;
-
 	if (chan->imtu < skb->len)
 		goto drop;
 
@@ -6913,6 +6910,12 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		return;
 	}
 
+	if (hci_blacklist_lookup(hcon->hdev, &hcon->dst,
+				 bdaddr_type(hcon, hcon->dst_type))) {
+		kfree_skb(skb);
+		return;
+	}
+
 	BT_DBG("len %d, cid 0x%4.4x", len, cid);
 
 	switch (cid) {
-- 
1.9.3

