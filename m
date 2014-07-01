Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Centralize looking up blocked devices to l2cap_recv_frame
Date: Tue,  1 Jul 2014 22:54:14 +0300
Message-Id: <1404244455-15651-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The ATT channel isn't the only one that we should ensure doesn't receive
data from blocked devices. SMP is another, and in general we don't want
data packets going to any of the various handlers. Therefore, add a
single check to the l2cap_recv_frame function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e203a5fdf874..904f0d0f6a47 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6874,9 +6874,6 @@ static void l2cap_att_channel(struct l2cap_conn *conn,
 
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
-	if (hci_blacklist_lookup(hcon->hdev, &hcon->dst, hcon->dst_type))
-		goto drop;
-
 	if (chan->imtu < skb->len)
 		goto drop;
 
@@ -6909,6 +6906,11 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		return;
 	}
 
+	if (hci_blacklist_lookup(hcon->hdev, &hcon->dst, hcon->dst_type)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	BT_DBG("len %d, cid 0x%4.4x", len, cid);
 
 	switch (cid) {
-- 
1.9.3

