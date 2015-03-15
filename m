Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 07/14] Bluetooth: Consolidate socket channel sending function back into one
Date: Sat, 14 Mar 2015 19:27:59 -0700
Message-Id: <1426386486-15962-7-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the introduction of trusted socket flag for control and monitor
channels, it is now possible to use a single function for sending
packets to these sockets. And with that consolidate the handling.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  4 +---
 net/bluetooth/hci_sock.c         | 45 ++++++++--------------------------------
 net/bluetooth/mgmt.c             | 34 +++++++-----------------------
 3 files changed, 17 insertions(+), 66 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d38f6e426e84..859005c9a8fc 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1284,9 +1284,7 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
 /* ----- HCI Sockets ----- */
 void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
 void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
-			 struct sock *skip_sk);
-void hci_send_to_flagged_channel(unsigned short channel, struct sk_buff *skb,
-				 int flag);
+			 int flag, struct sock *skip_sk);
 void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb);
 
 void hci_sock_dev_event(struct hci_dev *hdev, int event);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 54118868b3f6..e7f463f6fd69 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -199,7 +199,7 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 
 /* Send frame to sockets with specific channel */
 void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
-			 struct sock *skip_sk)
+			 int flag, struct sock *skip_sk)
 {
 	struct sock *sk;
 
@@ -210,41 +210,12 @@ void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
 	sk_for_each(sk, &hci_sk_list.head) {
 		struct sk_buff *nskb;
 
-		/* Skip the original socket */
-		if (sk == skip_sk)
-			continue;
-
-		if (sk->sk_state != BT_BOUND)
-			continue;
-
-		if (hci_pi(sk)->channel != channel)
-			continue;
-
-		nskb = skb_clone(skb, GFP_ATOMIC);
-		if (!nskb)
+		/* Ignore socket without the flag set */
+		if (!test_bit(flag, &hci_pi(sk)->flags))
 			continue;
 
-		if (sock_queue_rcv_skb(sk, nskb))
-			kfree_skb(nskb);
-	}
-
-	read_unlock(&hci_sk_list.lock);
-}
-
-/* Send frame to sockets with specific channel flag set */
-void hci_send_to_flagged_channel(unsigned short channel, struct sk_buff *skb,
-				 int flag)
-{
-	struct sock *sk;
-
-	BT_DBG("channel %u len %d", channel, skb->len);
-
-	read_lock(&hci_sk_list.lock);
-
-	sk_for_each(sk, &hci_sk_list.head) {
-		struct sk_buff *nskb;
-
-		if (!test_bit(flag, &hci_pi(sk)->flags))
+		/* Skip the original socket */
+		if (sk == skip_sk)
 			continue;
 
 		if (sk->sk_state != BT_BOUND)
@@ -310,7 +281,8 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 	hdr->index = cpu_to_le16(hdev->id);
 	hdr->len = cpu_to_le16(skb->len);
 
-	hci_send_to_channel(HCI_CHANNEL_MONITOR, skb_copy, NULL);
+	hci_send_to_channel(HCI_CHANNEL_MONITOR, skb_copy,
+			    HCI_SOCK_TRUSTED, NULL);
 	kfree_skb(skb_copy);
 }
 
@@ -417,7 +389,8 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event)
 
 		skb = create_monitor_event(hdev, event);
 		if (skb) {
-			hci_send_to_channel(HCI_CHANNEL_MONITOR, skb, NULL);
+			hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
+					    HCI_SOCK_TRUSTED, NULL);
 			kfree_skb(skb);
 		}
 	}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index eb0211b6cfa9..bd65f7630725 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -224,7 +224,7 @@ static u8 mgmt_status(u8 hci_status)
 
 static int mgmt_send_event(u16 event, struct hci_dev *hdev,
 			   unsigned short channel, void *data, u16 data_len,
-			   struct sock *skip_sk)
+			   int flag, struct sock *skip_sk)
 {
 	struct sk_buff *skb;
 	struct mgmt_hdr *hdr;
@@ -247,44 +247,24 @@ static int mgmt_send_event(u16 event, struct hci_dev *hdev,
 	/* Time stamp */
 	__net_timestamp(skb);
 
-	hci_send_to_channel(channel, skb, skip_sk);
+	hci_send_to_channel(channel, skb, flag, skip_sk);
 	kfree_skb(skb);
 
 	return 0;
 }
 
-static int mgmt_index_event(u16 event, struct hci_dev *hdev,
-			    void *data, u16 data_len, int flag)
+static int mgmt_index_event(u16 event, struct hci_dev *hdev, void *data,
+			    u16 len, int flag)
 {
-	struct sk_buff *skb;
-	struct mgmt_hdr *hdr;
-
-	skb = alloc_skb(sizeof(*hdr) + data_len, GFP_KERNEL);
-	if (!skb)
-		return -ENOMEM;
-
-	hdr = (void *) skb_put(skb, sizeof(*hdr));
-	hdr->opcode = cpu_to_le16(event);
-	hdr->index = cpu_to_le16(hdev->id);
-	hdr->len = cpu_to_le16(data_len);
-
-	if (data)
-		memcpy(skb_put(skb, data_len), data, data_len);
-
-	/* Time stamp */
-	__net_timestamp(skb);
-
-	hci_send_to_flagged_channel(HCI_CHANNEL_CONTROL, skb, flag);
-	kfree_skb(skb);
-
-	return 0;
+	return mgmt_send_event(event, hdev, HCI_CHANNEL_CONTROL, data, len,
+			       flag, NULL);
 }
 
 static int mgmt_event(u16 event, struct hci_dev *hdev, void *data, u16 len,
 		      struct sock *skip_sk)
 {
 	return mgmt_send_event(event, hdev, HCI_CHANNEL_CONTROL, data, len,
-			       skip_sk);
+			       HCI_SOCK_TRUSTED, skip_sk);
 }
 
 static int mgmt_cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
-- 
2.1.0

