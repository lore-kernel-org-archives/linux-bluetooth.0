Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Replace send_monitor_event with queue_monitor_skb
Date: Sun, 11 Jan 2015 19:33:33 -0800
Message-Id: <1421033613-31738-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The send_monitor_event function is essentially the same as the newly
introduced queue_monitor_skb. So instead of having duplicated code,
replace send_monitor_event with queue_monitor_skb.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 1987ea178b7d..1d65c5be7c82 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -294,34 +294,6 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 	kfree_skb(skb_copy);
 }
 
-static void send_monitor_event(struct sk_buff *skb)
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
 static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
 {
 	struct hci_mon_hdr *hdr;
@@ -425,7 +397,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event)
 
 		skb = create_monitor_event(hdev, event);
 		if (skb) {
-			send_monitor_event(skb);
+			queue_monitor_skb(skb);
 			kfree_skb(skb);
 		}
 	}
-- 
2.1.0

