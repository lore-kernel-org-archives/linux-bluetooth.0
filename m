Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Process HCI events in a workqueue instead of a tasklet
Date: Sun,  8 Aug 2010 23:06:53 -0400
Message-Id: <1281323213-30907-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |    2 +
 net/bluetooth/hci_core.c         |   58 ++++++++++++++++++++++++++++++++-----
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e17849e..005f9ce 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -109,12 +109,14 @@ struct hci_dev {
 
 	struct workqueue_struct	*workqueue;
 
+	struct work_struct	evt_work;
 	struct tasklet_struct	cmd_task;
 	struct tasklet_struct	rx_task;
 	struct tasklet_struct	tx_task;
 
 	struct sk_buff_head	rx_q;
 	struct sk_buff_head	raw_q;
+	struct sk_buff_head	evt_q;
 	struct sk_buff_head	cmd_q;
 
 	struct sk_buff		*sent_cmd;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8b4baac..7e3fc60 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -50,6 +50,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+static void hci_evt_work(struct work_struct *work);
 static void hci_cmd_task(unsigned long arg);
 static void hci_rx_task(unsigned long arg);
 static void hci_tx_task(unsigned long arg);
@@ -521,7 +522,9 @@ int hci_dev_open(__u16 dev)
 		tasklet_kill(&hdev->rx_task);
 		tasklet_kill(&hdev->tx_task);
 		tasklet_kill(&hdev->cmd_task);
+		cancel_work_sync(&hdev->evt_work);
 
+		skb_queue_purge(&hdev->evt_q);
 		skb_queue_purge(&hdev->cmd_q);
 		skb_queue_purge(&hdev->rx_q);
 
@@ -570,6 +573,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		hdev->flush(hdev);
 
 	/* Reset device */
+	skb_queue_purge(&hdev->evt_q);
 	skb_queue_purge(&hdev->cmd_q);
 	atomic_set(&hdev->cmd_cnt, 1);
 	if (!test_bit(HCI_RAW, &hdev->flags)) {
@@ -579,11 +583,13 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
 
-	/* Kill cmd task */
+	/* Kill cmd task and evt work */
 	tasklet_kill(&hdev->cmd_task);
+	cancel_work_sync(&hdev->evt_work);
 
 	/* Drop queues */
 	skb_queue_purge(&hdev->rx_q);
+	skb_queue_purge(&hdev->evt_q);
 	skb_queue_purge(&hdev->cmd_q);
 	skb_queue_purge(&hdev->raw_q);
 
@@ -634,6 +640,7 @@ int hci_dev_reset(__u16 dev)
 
 	/* Drop queues */
 	skb_queue_purge(&hdev->rx_q);
+	skb_queue_purge(&hdev->evt_q);
 	skb_queue_purge(&hdev->cmd_q);
 
 	hci_dev_lock_bh(hdev);
@@ -905,11 +912,14 @@ int hci_register_dev(struct hci_dev *hdev)
 	hdev->sniff_max_interval = 800;
 	hdev->sniff_min_interval = 80;
 
+	INIT_WORK(&hdev->evt_work, hci_evt_work);
+
 	tasklet_init(&hdev->cmd_task, hci_cmd_task,(unsigned long) hdev);
 	tasklet_init(&hdev->rx_task, hci_rx_task, (unsigned long) hdev);
 	tasklet_init(&hdev->tx_task, hci_tx_task, (unsigned long) hdev);
 
 	skb_queue_head_init(&hdev->rx_q);
+	skb_queue_head_init(&hdev->evt_q);
 	skb_queue_head_init(&hdev->cmd_q);
 	skb_queue_head_init(&hdev->raw_q);
 
@@ -1022,9 +1032,19 @@ int hci_recv_frame(struct sk_buff *skb)
 	/* Time stamp */
 	__net_timestamp(skb);
 
-	/* Queue frame for rx task */
-	skb_queue_tail(&hdev->rx_q, skb);
-	tasklet_schedule(&hdev->rx_task);
+	switch (bt_cb(skb)->pkt_type) {
+	case HCI_EVENT_PKT:
+		/* Queue frame for event processing */
+		skb_queue_tail(&hdev->evt_q, skb);
+		queue_work(hdev->workqueue, &hdev->evt_work);
+		break;
+
+	default:
+		/* Queue frame for rx task */
+		skb_queue_tail(&hdev->rx_q, skb);
+		tasklet_schedule(&hdev->rx_task);
+		break;
+	}
 
 	return 0;
 }
@@ -1614,10 +1634,6 @@ static void hci_rx_task(unsigned long arg)
 
 		/* Process frame */
 		switch (bt_cb(skb)->pkt_type) {
-		case HCI_EVENT_PKT:
-			hci_event_packet(hdev, skb);
-			break;
-
 		case HCI_ACLDATA_PKT:
 			BT_DBG("%s ACL data packet", hdev->name);
 			hci_acldata_packet(hdev, skb);
@@ -1663,3 +1679,29 @@ static void hci_cmd_task(unsigned long arg)
 		}
 	}
 }
+
+static void hci_evt_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev, evt_work);
+	struct sk_buff *skb;
+
+	BT_DBG("%s", hdev->name);
+
+	read_lock(&hci_task_lock);
+
+	while ((skb = skb_dequeue(&hdev->evt_q))) {
+		if (atomic_read(&hdev->promisc)) {
+			/* Send copy to the sockets */
+			hci_send_to_sock(hdev, skb);
+		}
+
+		if (test_bit(HCI_RAW, &hdev->flags)) {
+			kfree_skb(skb);
+			continue;
+		}
+
+		hci_event_packet(hdev, skb);
+	}
+
+	read_unlock(&hci_task_lock);
+}
-- 
1.6.6.1

