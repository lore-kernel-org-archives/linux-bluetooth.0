Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Simplify packet copy in hci_send_to_monitor function
Date: Sun, 11 Jan 2015 19:33:31 -0800
Message-Id: <1421033613-31738-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Within the monitor functionality, the global atomic variable called
monitor_promisc ensures that no memory allocation happend when there
is actually no client listening. This means it is safe to just create
a copy of the skb since it is guaranteed that at least one client
exists. No extra checks needed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index e176a988625e..026e84a80659 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -221,6 +221,7 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct sock *sk;
 	struct sk_buff *skb_copy = NULL;
+	struct hci_mon_hdr *hdr;
 	__le16 opcode;
 
 	if (!atomic_read(&monitor_promisc))
@@ -251,6 +252,17 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	}
 
+	/* Create a private copy with headroom */
+	skb_copy = __pskb_copy_fclone(skb, HCI_MON_HDR_SIZE, GFP_ATOMIC, true);
+	if (!skb_copy)
+		return;
+
+	/* Put header before the data */
+	hdr = (void *) skb_push(skb_copy, HCI_MON_HDR_SIZE);
+	hdr->opcode = opcode;
+	hdr->index = cpu_to_le16(hdev->id);
+	hdr->len = cpu_to_le16(skb->len);
+
 	read_lock(&hci_sk_list.lock);
 
 	sk_for_each(sk, &hci_sk_list.head) {
@@ -262,22 +274,6 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 		if (hci_pi(sk)->channel != HCI_CHANNEL_MONITOR)
 			continue;
 
-		if (!skb_copy) {
-			struct hci_mon_hdr *hdr;
-
-			/* Create a private copy with headroom */
-			skb_copy = __pskb_copy_fclone(skb, HCI_MON_HDR_SIZE,
-						      GFP_ATOMIC, true);
-			if (!skb_copy)
-				continue;
-
-			/* Put header before the data */
-			hdr = (void *) skb_push(skb_copy, HCI_MON_HDR_SIZE);
-			hdr->opcode = opcode;
-			hdr->index = cpu_to_le16(hdev->id);
-			hdr->len = cpu_to_le16(skb->len);
-		}
-
 		nskb = skb_clone(skb_copy, GFP_ATOMIC);
 		if (!nskb)
 			continue;
-- 
2.1.0

