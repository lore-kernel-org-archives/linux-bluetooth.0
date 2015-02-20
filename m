Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Rename hci_send_to_control to hci_send_to_channel
Date: Fri, 20 Feb 2015 12:37:19 +0200
Message-Id: <1424428640-24697-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hci_send_to_control() can be made more general purpose with a small
change of passing the desired HCI channel as a parameter to it. This
allows using it for the monitor channel as well as e.g. 6lowpan in the
future.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 3 ++-
 net/bluetooth/hci_sock.c         | 7 ++++---
 net/bluetooth/mgmt.c             | 3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a7bf77384464..a831c8ad10f1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1265,7 +1265,8 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
 
 /* ----- HCI Sockets ----- */
 void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
-void hci_send_to_control(struct sk_buff *skb, struct sock *skip_sk);
+void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
+			 struct sock *skip_sk);
 void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb);
 
 void hci_sock_dev_event(struct hci_dev *hdev, int event);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 1d65c5be7c82..c35e4cd1ae48 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -183,8 +183,9 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 	kfree_skb(skb_copy);
 }
 
-/* Send frame to control socket */
-void hci_send_to_control(struct sk_buff *skb, struct sock *skip_sk)
+/* Send frame to sockets with specific channel */
+void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
+			 struct sock *skip_sk)
 {
 	struct sock *sk;
 
@@ -202,7 +203,7 @@ void hci_send_to_control(struct sk_buff *skb, struct sock *skip_sk)
 		if (sk->sk_state != BT_BOUND)
 			continue;
 
-		if (hci_pi(sk)->channel != HCI_CHANNEL_CONTROL)
+		if (hci_pi(sk)->channel != channel)
 			continue;
 
 		nskb = skb_clone(skb, GFP_ATOMIC);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3a1b537c9aa6..d5d46e7676f1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -29,6 +29,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/hci_sock.h>
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/mgmt.h>
 
@@ -242,7 +243,7 @@ static int mgmt_event(u16 event, struct hci_dev *hdev, void *data, u16 data_len,
 	/* Time stamp */
 	__net_timestamp(skb);
 
-	hci_send_to_control(skb, skip_sk);
+	hci_send_to_channel(HCI_CHANNEL_CONTROL, skb, skip_sk);
 	kfree_skb(skb);
 
 	return 0;
-- 
2.1.0

