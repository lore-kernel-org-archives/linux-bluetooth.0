Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Use new hci_skb_pkt_* wrappers for core packet handling
Date: Thu,  5 Nov 2015 07:10:00 +0100
Message-Id: <1446703801-30566-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The new hci_skb_pkt_* wrappers only help if they are used consistently
in the Bluetooth subsystem. So first convert the core packet handling.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c    | 23 ++++++++++++-----------
 net/bluetooth/hci_request.c |  4 ++--
 net/bluetooth/hci_sock.c    | 38 +++++++++++++++++++-------------------
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 97734cab2538..db26cbd1cd9d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3566,7 +3566,7 @@ int hci_reset_dev(struct hci_dev *hdev)
 	if (!skb)
 		return -ENOMEM;
 
-	bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
+	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
 	memcpy(skb_put(skb, 3), hw_err, 3);
 
 	/* Send Hardware Error to upper stack */
@@ -3583,9 +3583,9 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 		return -ENXIO;
 	}
 
-	if (bt_cb(skb)->pkt_type != HCI_EVENT_PKT &&
-	    bt_cb(skb)->pkt_type != HCI_ACLDATA_PKT &&
-	    bt_cb(skb)->pkt_type != HCI_SCODATA_PKT) {
+	if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT &&
+	    hci_skb_pkt_type(skb) != HCI_ACLDATA_PKT &&
+	    hci_skb_pkt_type(skb) != HCI_SCODATA_PKT) {
 		kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -3607,7 +3607,7 @@ EXPORT_SYMBOL(hci_recv_frame);
 int hci_recv_diag(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	/* Mark as diagnostic packet */
-	bt_cb(skb)->pkt_type = HCI_DIAG_PKT;
+	hci_skb_pkt_type(skb) = HCI_DIAG_PKT;
 
 	/* Time stamp */
 	__net_timestamp(skb);
@@ -3649,7 +3649,8 @@ static void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	int err;
 
-	BT_DBG("%s type %d len %d", hdev->name, bt_cb(skb)->pkt_type, skb->len);
+	BT_DBG("%s type %d len %d", hdev->name, hci_skb_pkt_type(skb),
+	       skb->len);
 
 	/* Time stamp */
 	__net_timestamp(skb);
@@ -3762,7 +3763,7 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
 	skb->len = skb_headlen(skb);
 	skb->data_len = 0;
 
-	bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
+	hci_skb_pkt_type(skb) = HCI_ACLDATA_PKT;
 
 	switch (hdev->dev_type) {
 	case HCI_BREDR:
@@ -3802,7 +3803,7 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
 		do {
 			skb = list; list = list->next;
 
-			bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
+			hci_skb_pkt_type(skb) = HCI_ACLDATA_PKT;
 			hci_add_acl_hdr(skb, conn->handle, flags);
 
 			BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
@@ -3840,7 +3841,7 @@ void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
 	skb_reset_transport_header(skb);
 	memcpy(skb_transport_header(skb), &hdr, HCI_SCO_HDR_SIZE);
 
-	bt_cb(skb)->pkt_type = HCI_SCODATA_PKT;
+	hci_skb_pkt_type(skb) = HCI_SCODATA_PKT;
 
 	skb_queue_tail(&conn->data_q, skb);
 	queue_work(hdev->workqueue, &hdev->tx_work);
@@ -4499,7 +4500,7 @@ static void hci_rx_work(struct work_struct *work)
 
 		if (test_bit(HCI_INIT, &hdev->flags)) {
 			/* Don't process data packets in this states. */
-			switch (bt_cb(skb)->pkt_type) {
+			switch (hci_skb_pkt_type(skb)) {
 			case HCI_ACLDATA_PKT:
 			case HCI_SCODATA_PKT:
 				kfree_skb(skb);
@@ -4508,7 +4509,7 @@ static void hci_rx_work(struct work_struct *work)
 		}
 
 		/* Process frame */
-		switch (bt_cb(skb)->pkt_type) {
+		switch (hci_skb_pkt_type(skb)) {
 		case HCI_EVENT_PKT:
 			BT_DBG("%s Event packet", hdev->name);
 			hci_event_packet(hdev, skb);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 981f8a202c27..bdb170995966 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -98,8 +98,8 @@ struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 
 	BT_DBG("skb len %d", skb->len);
 
-	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
-	bt_cb(skb)->hci.opcode = opcode;
+	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
+	hci_skb_opcode(skb) = opcode;
 
 	return skb;
 }
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 8a091beafa9b..ec07cd92e220 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -120,13 +120,13 @@ static bool is_filtered_packet(struct sock *sk, struct sk_buff *skb)
 	/* Apply filter */
 	flt = &hci_pi(sk)->filter;
 
-	flt_type = bt_cb(skb)->pkt_type & HCI_FLT_TYPE_BITS;
+	flt_type = hci_skb_pkt_type(skb) & HCI_FLT_TYPE_BITS;
 
 	if (!test_bit(flt_type, &flt->type_mask))
 		return true;
 
 	/* Extra filter for event packets only */
-	if (bt_cb(skb)->pkt_type != HCI_EVENT_PKT)
+	if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT)
 		return false;
 
 	flt_event = (*(__u8 *)skb->data & HCI_FLT_EVENT_BITS);
@@ -170,19 +170,19 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 			continue;
 
 		if (hci_pi(sk)->channel == HCI_CHANNEL_RAW) {
-			if (bt_cb(skb)->pkt_type != HCI_COMMAND_PKT &&
-			    bt_cb(skb)->pkt_type != HCI_EVENT_PKT &&
-			    bt_cb(skb)->pkt_type != HCI_ACLDATA_PKT &&
-			    bt_cb(skb)->pkt_type != HCI_SCODATA_PKT)
+			if (hci_skb_pkt_type(skb) != HCI_COMMAND_PKT &&
+			    hci_skb_pkt_type(skb) != HCI_EVENT_PKT &&
+			    hci_skb_pkt_type(skb) != HCI_ACLDATA_PKT &&
+			    hci_skb_pkt_type(skb) != HCI_SCODATA_PKT)
 				continue;
 			if (is_filtered_packet(sk, skb))
 				continue;
 		} else if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
 			if (!bt_cb(skb)->incoming)
 				continue;
-			if (bt_cb(skb)->pkt_type != HCI_EVENT_PKT &&
-			    bt_cb(skb)->pkt_type != HCI_ACLDATA_PKT &&
-			    bt_cb(skb)->pkt_type != HCI_SCODATA_PKT)
+			if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT &&
+			    hci_skb_pkt_type(skb) != HCI_ACLDATA_PKT &&
+			    hci_skb_pkt_type(skb) != HCI_SCODATA_PKT)
 				continue;
 		} else {
 			/* Don't send frame to other channel types */
@@ -196,7 +196,7 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 				continue;
 
 			/* Put type byte before the data */
-			memcpy(skb_push(skb_copy, 1), &bt_cb(skb)->pkt_type, 1);
+			memcpy(skb_push(skb_copy, 1), &hci_skb_pkt_type(skb), 1);
 		}
 
 		nskb = skb_clone(skb_copy, GFP_ATOMIC);
@@ -262,7 +262,7 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("hdev %p len %d", hdev, skb->len);
 
-	switch (bt_cb(skb)->pkt_type) {
+	switch (hci_skb_pkt_type(skb)) {
 	case HCI_COMMAND_PKT:
 		opcode = cpu_to_le16(HCI_MON_COMMAND_PKT);
 		break;
@@ -447,7 +447,7 @@ static void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data)
 	bt_cb(skb)->incoming = 1;
 	__net_timestamp(skb);
 
-	bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
+	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
 	hci_send_to_sock(hdev, skb);
 	kfree_skb(skb);
 }
@@ -1230,7 +1230,7 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto drop;
 	}
 
-	bt_cb(skb)->pkt_type = *((unsigned char *) skb->data);
+	hci_skb_pkt_type(skb) = *((unsigned char *) skb->data);
 	skb_pull(skb, 1);
 
 	if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
@@ -1239,16 +1239,16 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		 *
 		 * However check that the packet type is valid.
 		 */
-		if (bt_cb(skb)->pkt_type != HCI_COMMAND_PKT &&
-		    bt_cb(skb)->pkt_type != HCI_ACLDATA_PKT &&
-		    bt_cb(skb)->pkt_type != HCI_SCODATA_PKT) {
+		if (hci_skb_pkt_type(skb) != HCI_COMMAND_PKT &&
+		    hci_skb_pkt_type(skb) != HCI_ACLDATA_PKT &&
+		    hci_skb_pkt_type(skb) != HCI_SCODATA_PKT) {
 			err = -EINVAL;
 			goto drop;
 		}
 
 		skb_queue_tail(&hdev->raw_q, skb);
 		queue_work(hdev->workqueue, &hdev->tx_work);
-	} else if (bt_cb(skb)->pkt_type == HCI_COMMAND_PKT) {
+	} else if (hci_skb_pkt_type(skb) == HCI_COMMAND_PKT) {
 		u16 opcode = get_unaligned_le16(skb->data);
 		u16 ogf = hci_opcode_ogf(opcode);
 		u16 ocf = hci_opcode_ocf(opcode);
@@ -1282,8 +1282,8 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto drop;
 		}
 
-		if (bt_cb(skb)->pkt_type != HCI_ACLDATA_PKT &&
-		    bt_cb(skb)->pkt_type != HCI_SCODATA_PKT) {
+		if (hci_skb_pkt_type(skb) != HCI_ACLDATA_PKT &&
+		    hci_skb_pkt_type(skb) != HCI_SCODATA_PKT) {
 			err = -EINVAL;
 			goto drop;
 		}
-- 
2.5.0

