Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Move skb->dev assignment for hdev->send into central place
Date: Thu, 10 Oct 2013 13:26:27 -0700
Message-Id: <1381436787-50948-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The assignement of skb->dev is done all over the place. So it makes it
hard to eventually get rid of it. Move it all in one central place so
it gets assigned right before calling hdev->send driver callback.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 25 ++++++++++---------------
 net/bluetooth/hci_sock.c |  2 --
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 593b4ef..925bd47 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2697,10 +2697,8 @@ int hci_unregister_cb(struct hci_cb *cb)
 }
 EXPORT_SYMBOL(hci_unregister_cb);
 
-static int hci_send_frame(struct sk_buff *skb)
+static int hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
-
 	if (!hdev) {
 		kfree_skb(skb);
 		return -ENODEV;
@@ -2722,6 +2720,8 @@ static int hci_send_frame(struct sk_buff *skb)
 	/* Get rid of skb owner, prior to sending to the driver. */
 	skb_orphan(skb);
 
+	skb->dev = (void *) hdev;
+
 	return hdev->send(skb);
 }
 
@@ -2785,7 +2785,6 @@ static struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode,
 	BT_DBG("skb len %d", skb->len);
 
 	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
-	skb->dev = (void *) hdev;
 
 	return skb;
 }
@@ -2929,7 +2928,6 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
 		do {
 			skb = list; list = list->next;
 
-			skb->dev = (void *) hdev;
 			bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
 			hci_add_acl_hdr(skb, conn->handle, flags);
 
@@ -2948,8 +2946,6 @@ void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags)
 
 	BT_DBG("%s chan %p flags 0x%4.4x", hdev->name, chan, flags);
 
-	skb->dev = (void *) hdev;
-
 	hci_queue_acl(chan, &chan->data_q, skb, flags);
 
 	queue_work(hdev->workqueue, &hdev->tx_work);
@@ -2970,7 +2966,6 @@ void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
 	skb_reset_transport_header(skb);
 	memcpy(skb_transport_header(skb), &hdr, HCI_SCO_HDR_SIZE);
 
-	skb->dev = (void *) hdev;
 	bt_cb(skb)->pkt_type = HCI_SCODATA_PKT;
 
 	skb_queue_tail(&conn->data_q, skb);
@@ -3235,7 +3230,7 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 			hci_conn_enter_active_mode(chan->conn,
 						   bt_cb(skb)->force_active);
 
-			hci_send_frame(skb);
+			hci_send_frame(hdev, skb);
 			hdev->acl_last_tx = jiffies;
 
 			hdev->acl_cnt--;
@@ -3287,7 +3282,7 @@ static void hci_sched_acl_blk(struct hci_dev *hdev)
 			hci_conn_enter_active_mode(chan->conn,
 						   bt_cb(skb)->force_active);
 
-			hci_send_frame(skb);
+			hci_send_frame(hdev, skb);
 			hdev->acl_last_tx = jiffies;
 
 			hdev->block_cnt -= blocks;
@@ -3340,7 +3335,7 @@ static void hci_sched_sco(struct hci_dev *hdev)
 	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(skb);
+			hci_send_frame(hdev, skb);
 
 			conn->sent++;
 			if (conn->sent == ~0)
@@ -3364,7 +3359,7 @@ static void hci_sched_esco(struct hci_dev *hdev)
 						     &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(skb);
+			hci_send_frame(hdev, skb);
 
 			conn->sent++;
 			if (conn->sent == ~0)
@@ -3406,7 +3401,7 @@ static void hci_sched_le(struct hci_dev *hdev)
 
 			skb = skb_dequeue(&chan->data_q);
 
-			hci_send_frame(skb);
+			hci_send_frame(hdev, skb);
 			hdev->le_last_tx = jiffies;
 
 			cnt--;
@@ -3442,7 +3437,7 @@ static void hci_tx_work(struct work_struct *work)
 
 	/* Send next queued raw (unknown type) packet */
 	while ((skb = skb_dequeue(&hdev->raw_q)))
-		hci_send_frame(skb);
+		hci_send_frame(hdev, skb);
 }
 
 /* ----- HCI RX task (incoming data processing) ----- */
@@ -3688,7 +3683,7 @@ static void hci_cmd_work(struct work_struct *work)
 		hdev->sent_cmd = skb_clone(skb, GFP_KERNEL);
 		if (hdev->sent_cmd) {
 			atomic_dec(&hdev->cmd_cnt);
-			hci_send_frame(skb);
+			hci_send_frame(hdev, skb);
 			if (test_bit(HCI_RESET, &hdev->flags))
 				del_timer(&hdev->cmd_timer);
 			else
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 3beaa05..97f96eb 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -387,7 +387,6 @@ static void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data)
 	__net_timestamp(skb);
 
 	bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
-	skb->dev = (void *) hdev;
 	hci_send_to_sock(hdev, skb);
 	kfree_skb(skb);
 }
@@ -942,7 +941,6 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 
 	bt_cb(skb)->pkt_type = *((unsigned char *) skb->data);
 	skb_pull(skb, 1);
-	skb->dev = (void *) hdev;
 
 	if (hci_pi(sk)->channel == HCI_CHANNEL_RAW &&
 	    bt_cb(skb)->pkt_type == HCI_COMMAND_PKT) {
-- 
1.8.3.1

