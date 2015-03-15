Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/5] Bluetooth: Provide hci_send_to_flagged_channel helper function
Date: Sat, 14 Mar 2015 17:01:58 -0700
Message-Id: <1426377721-735-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hci_send_to_flagged_channel helper function can be used to send
packets to all channels that have a certain HCI socket flag set.

This is especially useful for managment events that are limited to
sockets that have first enabled certain functionality. This allows
for filtering of events without confusing existing users.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_sock.c         | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6afbf5b014a1..d38f6e426e84 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1285,6 +1285,8 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
 void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
 void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
 			 struct sock *skip_sk);
+void hci_send_to_flagged_channel(unsigned short channel, struct sk_buff *skb,
+				 int flag);
 void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb);
 
 void hci_sock_dev_event(struct hci_dev *hdev, int event);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index bf5365c49c9c..174a353a7dcf 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -231,6 +231,39 @@ void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
 	read_unlock(&hci_sk_list.lock);
 }
 
+/* Send frame to sockets with specific channel flag set */
+void hci_send_to_flagged_channel(unsigned short channel, struct sk_buff *skb,
+				 int flag)
+{
+	struct sock *sk;
+
+	BT_DBG("channel %u len %d", channel, skb->len);
+
+	read_lock(&hci_sk_list.lock);
+
+	sk_for_each(sk, &hci_sk_list.head) {
+		struct sk_buff *nskb;
+
+		if (!test_bit(flag, &hci_pi(sk)->flags))
+			continue;
+
+		if (sk->sk_state != BT_BOUND)
+			continue;
+
+		if (hci_pi(sk)->channel != channel)
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
-- 
2.1.0

