Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] Bluetooth: Split sending for HCI raw and control sockets
Date: Mon, 20 Feb 2012 11:58:34 +0100
Message-Id: <1329735520-23539-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The sending functions for HCI raw and control sockets have nothing in
common except that they iterate over the socket list. Split them into
two so they can do their job more efficient. In addition the code becomes
more readable.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |    4 +-
 net/bluetooth/hci_core.c         |    4 +-
 net/bluetooth/hci_event.c        |    2 +-
 net/bluetooth/hci_sock.c         |   51 +++++++++++++++++++++++++++++---------
 net/bluetooth/mgmt.c             |    2 +-
 5 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2aafeb3..9209e4c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -953,8 +953,8 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
 void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data);
 
 /* ----- HCI Sockets ----- */
-void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb,
-							struct sock *skip_sk);
+void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
+void hci_send_to_control(struct sk_buff *skb, struct sock *skip_sk);
 
 /* Management interface */
 #define MGMT_ADDR_BREDR			0x00
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fabca08..638fa8c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2131,7 +2131,7 @@ static int hci_send_frame(struct sk_buff *skb)
 		/* Time stamp */
 		__net_timestamp(skb);
 
-		hci_send_to_sock(hdev, skb, NULL);
+		hci_send_to_sock(hdev, skb);
 	}
 
 	/* Get rid of skb owner, prior to sending to the driver. */
@@ -2818,7 +2818,7 @@ static void hci_rx_work(struct work_struct *work)
 	while ((skb = skb_dequeue(&hdev->rx_q))) {
 		if (atomic_read(&hdev->promisc)) {
 			/* Send copy to the sockets */
-			hci_send_to_sock(hdev, skb, NULL);
+			hci_send_to_sock(hdev, skb);
 		}
 
 		if (test_bit(HCI_RAW, &hdev->flags)) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 04fb1f0..e69db4a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3571,7 +3571,7 @@ void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data)
 
 	bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
 	skb->dev = (void *) hdev;
-	hci_send_to_sock(hdev, skb, NULL);
+	hci_send_to_sock(hdev, skb);
 	kfree_skb(skb);
 }
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 43a0491..d3381f9 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -85,8 +85,7 @@ static struct bt_sock_list hci_sk_list = {
 };
 
 /* Send frame to RAW socket */
-void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb,
-							struct sock *skip_sk)
+void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct sock *sk;
 	struct hlist_node *node;
@@ -94,13 +93,11 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb,
 	BT_DBG("hdev %p len %d", hdev, skb->len);
 
 	read_lock(&hci_sk_list.lock);
+
 	sk_for_each(sk, node, &hci_sk_list.head) {
 		struct hci_filter *flt;
 		struct sk_buff *nskb;
 
-		if (sk == skip_sk)
-			continue;
-
 		if (sk->sk_state != BT_BOUND || hci_pi(sk)->hdev != hdev)
 			continue;
 
@@ -108,12 +105,9 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb,
 		if (skb->sk == sk)
 			continue;
 
-		if (bt_cb(skb)->channel != hci_pi(sk)->channel)
+		if (hci_pi(sk)->channel != HCI_CHANNEL_RAW)
 			continue;
 
-		if (bt_cb(skb)->channel == HCI_CHANNEL_CONTROL)
-			goto clone;
-
 		/* Apply filter */
 		flt = &hci_pi(sk)->filter;
 
@@ -137,18 +131,51 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb,
 				continue;
 		}
 
-clone:
 		nskb = skb_clone(skb, GFP_KERNEL);
 		if (!nskb)
 			continue;
 
 		/* Put type byte before the data */
-		if (bt_cb(skb)->channel == HCI_CHANNEL_RAW)
-			memcpy(skb_push(nskb, 1), &bt_cb(nskb)->pkt_type, 1);
+		memcpy(skb_push(nskb, 1), &bt_cb(nskb)->pkt_type, 1);
+
+		if (sock_queue_rcv_skb(sk, nskb))
+			kfree_skb(nskb);
+	}
+
+	read_unlock(&hci_sk_list.lock);
+}
+
+/* Send frame to control socket */
+void hci_send_to_control(struct sk_buff *skb, struct sock *skip_sk)
+{
+	struct sock *sk;
+	struct hlist_node *node;
+
+	BT_DBG("len %d", skb->len);
+
+	read_lock(&hci_sk_list.lock);
+
+	sk_for_each(sk, node, &hci_sk_list.head) {
+		struct sk_buff *nskb;
+
+		/* Skip the original socket */
+		if (sk == skip_sk)
+			continue;
+
+		if (sk->sk_state != BT_BOUND)
+			continue;
+
+		if (hci_pi(sk)->channel != HCI_CHANNEL_CONTROL)
+			continue;
+
+		nskb = skb_clone(skb, GFP_KERNEL);
+		if (!nskb)
+			continue;
 
 		if (sock_queue_rcv_skb(sk, nskb))
 			kfree_skb(nskb);
 	}
+
 	read_unlock(&hci_sk_list.lock);
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 18d593f..1695d04 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -924,7 +924,7 @@ static int mgmt_event(u16 event, struct hci_dev *hdev, void *data,
 	if (data)
 		memcpy(skb_put(skb, data_len), data, data_len);
 
-	hci_send_to_sock(NULL, skb, skip_sk);
+	hci_send_to_control(skb, skip_sk);
 	kfree_skb(skb);
 
 	return 0;
-- 
1.7.7.6

