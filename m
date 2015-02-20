Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Remove unnecessary queue_monitor_skb() function
Date: Fri, 20 Feb 2015 12:37:20 +0200
Message-Id: <1424428640-24697-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1424428640-24697-1-git-send-email-johan.hedberg@gmail.com>
References: <1424428640-24697-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that there's the general purpose hci_send_to_channel() API it will
do the exact same thing as queue_monitor_skb() when passed the monitor
HCI channel. This patch removes queue_monitor_skb() and replaces any
users of it with calls to hci_send_to_channel().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_sock.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index c35e4cd1ae48..780e6ba0389d 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -217,34 +217,6 @@ void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
 	read_unlock(&hci_sk_list.lock);
 }
 
-static void queue_monitor_skb(struct sk_buff *skb)
-{
-	struct sock *sk;
-
-	BT_DBG("len %d", skb->len);
-
-	read_lock(&hci_sk_list.lock);
-
-	sk_for_each(sk, &hci_sk_list.head) {
-		struct sk_buff *nskb;
-
-		if (sk->sk_state != BT_BOUND)
-			continue;
-
-		if (hci_pi(sk)->channel != HCI_CHANNEL_MONITOR)
-			continue;
-
-		nskb = skb_clone(skb, GFP_ATOMIC);
-		if (!nskb)
-			continue;
-
-		if (sock_queue_rcv_skb(sk, nskb))
-			kfree_skb(nskb);
-	}
-
-	read_unlock(&hci_sk_list.lock);
-}
-
 /* Send frame to monitor socket */
 void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 {
@@ -291,7 +263,7 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 	hdr->index = cpu_to_le16(hdev->id);
 	hdr->len = cpu_to_le16(skb->len);
 
-	queue_monitor_skb(skb_copy);
+	hci_send_to_channel(HCI_CHANNEL_MONITOR, skb_copy, NULL);
 	kfree_skb(skb_copy);
 }
 
@@ -398,7 +370,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event)
 
 		skb = create_monitor_event(hdev, event);
 		if (skb) {
-			queue_monitor_skb(skb);
+			hci_send_to_channel(HCI_CHANNEL_MONITOR, skb, NULL);
 			kfree_skb(skb);
 		}
 	}
-- 
2.1.0

