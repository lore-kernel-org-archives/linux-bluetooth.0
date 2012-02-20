Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] Bluetooth: Fix issue with shared SKB between HCI raw socket and driver
Date: Mon, 20 Feb 2012 11:58:40 +0100
Message-Id: <1329735520-23539-8-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Any HCI raw socket gets a copy of each SKB that is either received or
send via the Bluetooth subsystem. The raw socket uses SKB clones to
send out data, but the problem is that it needs to add an extra packet
type byte in front of it. And some drivers need to also add an extra
header before submitting the packet.

So far this all worked magically fine since all of the drivers and the
raw sockets are adding the same byte at the same location. But that is
by pure coincidence. Since the data of cloned SKBs is shared, this means
that the raw socket and driver kept writing into the shared data area.

To fix this the only safe way is if the HCI raw socket creates a copy of
the SKB before sending it out. To not always copy all SKBs around, the
copy is only created once and only after any of the HCI filter checks
succeeded.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 1b47d71..73068c2 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -89,6 +89,7 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct sock *sk;
 	struct hlist_node *node;
+	struct sk_buff *skb_copy = NULL;
 
 	BT_DBG("hdev %p len %d", hdev, skb->len);
 
@@ -131,18 +132,27 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 				continue;
 		}
 
-		nskb = skb_clone(skb, GFP_KERNEL);
+		if (!skb_copy) {
+			/* Create a private copy with headroom */
+			skb_copy = __pskb_copy(skb, 1, GFP_KERNEL);
+			if (!skb_copy)
+				continue;
+
+			/* Put type byte before the data */
+			memcpy(skb_push(skb_copy, 1), &bt_cb(skb)->pkt_type, 1);
+		}
+
+		nskb = skb_clone(skb_copy, GFP_KERNEL);
 		if (!nskb)
 			continue;
 
-		/* Put type byte before the data */
-		memcpy(skb_push(nskb, 1), &bt_cb(nskb)->pkt_type, 1);
-
 		if (sock_queue_rcv_skb(sk, nskb))
 			kfree_skb(nskb);
 	}
 
 	read_unlock(&hci_sk_list.lock);
+
+	kfree_skb(skb_copy);
 }
 
 /* Send frame to control socket */
-- 
1.7.7.6

