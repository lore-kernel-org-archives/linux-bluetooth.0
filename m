Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Create generic queue_monitor_skb helper function
Date: Sun, 11 Jan 2015 19:33:32 -0800
Message-Id: <1421033613-31738-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hci_send_to_monitor function contains generic code for queueing the
packet into the receive queue of every monitor client. To avoid code
duplication, create a generic queue_monitor_skb function to interate
over all monitor sockets.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 51 +++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 026e84a80659..1987ea178b7d 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -216,10 +216,37 @@ void hci_send_to_control(struct sk_buff *skb, struct sock *skip_sk)
 	read_unlock(&hci_sk_list.lock);
 }
 
+static void queue_monitor_skb(struct sk_buff *skb)
+{
+	struct sock *sk;
+
+	BT_DBG("len %d", skb->len);
+
+	read_lock(&hci_sk_list.lock);
+
+	sk_for_each(sk, &hci_sk_list.head) {
+		struct sk_buff *nskb;
+
+		if (sk->sk_state != BT_BOUND)
+			continue;
+
+		if (hci_pi(sk)->channel != HCI_CHANNEL_MONITOR)
+			continue;
+
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (!nskb)
+			continue;
+
+		if (sock_queue_rcv_skb(sk, nskb))
+			kfree_skb(nskb);
+	}
+
+	read_unlock(&hci_sk_list.lock);
+}
+
 /* Send frame to monitor socket */
 void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct sock *sk;
 	struct sk_buff *skb_copy = NULL;
 	struct hci_mon_hdr *hdr;
 	__le16 opcode;
@@ -263,27 +290,7 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 	hdr->index = cpu_to_le16(hdev->id);
 	hdr->len = cpu_to_le16(skb->len);
 
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
-		nskb = skb_clone(skb_copy, GFP_ATOMIC);
-		if (!nskb)
-			continue;
-
-		if (sock_queue_rcv_skb(sk, nskb))
-			kfree_skb(nskb);
-	}
-
-	read_unlock(&hci_sk_list.lock);
-
+	queue_monitor_skb(skb_copy);
 	kfree_skb(skb_copy);
 }
 
-- 
2.1.0

