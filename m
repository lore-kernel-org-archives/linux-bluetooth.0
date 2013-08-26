Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Refactor raw socket filter into more readable code
Date: Sun, 25 Aug 2013 23:25:15 -0700
Message-Id: <1377498315-22523-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The handling of the raw socket filter is rather obscure code and it gets
in the way of future extensions. Instead of inline filtering in the raw
socket packet routine, refactor it into its own function.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 64 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 9bd7d95..c45ec25 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -66,6 +66,46 @@ static struct bt_sock_list hci_sk_list = {
 	.lock = __RW_LOCK_UNLOCKED(hci_sk_list.lock)
 };
 
+static bool is_filtered_packet(struct sock *sk, struct sk_buff *skb)
+{
+	struct hci_filter *flt;
+	int flt_type, flt_event;
+
+	/* Apply filter */
+	flt = &hci_pi(sk)->filter;
+
+	if (bt_cb(skb)->pkt_type == HCI_VENDOR_PKT)
+		flt_type = 0;
+	else
+		flt_type = bt_cb(skb)->pkt_type & HCI_FLT_TYPE_BITS;
+
+	if (!test_bit(flt_type, &flt->type_mask))
+		return true;
+
+	/* Extra filter for event packets only */
+	if (bt_cb(skb)->pkt_type != HCI_EVENT_PKT)
+		return false;
+
+	flt_event = (*(__u8 *)skb->data & HCI_FLT_EVENT_BITS);
+
+	if (!hci_test_bit(flt_event, &flt->event_mask))
+		return true;
+
+	/* Check filter only when opcode is set */
+	if (!flt->opcode)
+		return false;
+
+	if (flt_event == HCI_EV_CMD_COMPLETE &&
+	    flt->opcode != get_unaligned((__le16 *)(skb->data + 3)))
+		return true;
+
+	if (flt_event == HCI_EV_CMD_STATUS &&
+	    flt->opcode != get_unaligned((__le16 *)(skb->data + 4)))
+		return true;
+
+	return false;
+}
+
 /* Send frame to RAW socket */
 void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 {
@@ -77,7 +117,6 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 	read_lock(&hci_sk_list.lock);
 
 	sk_for_each(sk, &hci_sk_list.head) {
-		struct hci_filter *flt;
 		struct sk_buff *nskb;
 
 		if (sk->sk_state != BT_BOUND || hci_pi(sk)->hdev != hdev)
@@ -90,30 +129,9 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 		if (hci_pi(sk)->channel != HCI_CHANNEL_RAW)
 			continue;
 
-		/* Apply filter */
-		flt = &hci_pi(sk)->filter;
-
-		if (!test_bit((bt_cb(skb)->pkt_type == HCI_VENDOR_PKT) ?
-			      0 : (bt_cb(skb)->pkt_type & HCI_FLT_TYPE_BITS),
-			      &flt->type_mask))
+		if (is_filtered_packet(sk, skb))
 			continue;
 
-		if (bt_cb(skb)->pkt_type == HCI_EVENT_PKT) {
-			int evt = (*(__u8 *)skb->data & HCI_FLT_EVENT_BITS);
-
-			if (!hci_test_bit(evt, &flt->event_mask))
-				continue;
-
-			if (flt->opcode &&
-			    ((evt == HCI_EV_CMD_COMPLETE &&
-			      flt->opcode !=
-			      get_unaligned((__le16 *)(skb->data + 3))) ||
-			     (evt == HCI_EV_CMD_STATUS &&
-			      flt->opcode !=
-			      get_unaligned((__le16 *)(skb->data + 4)))))
-				continue;
-		}
-
 		if (!skb_copy) {
 			/* Create a private copy with headroom */
 			skb_copy = __pskb_copy(skb, 1, GFP_ATOMIC);
-- 
1.8.3.1

