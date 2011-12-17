Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Subject: [RFC 01/22] Bluetooth: Process recv path in a workqueue instead of a tasklet
Date: Sat, 17 Dec 2011 19:29:21 -0200
Message-Id: <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcel Holtmann <marcel@holtmann.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/hci_core.h |    3 ++-
 net/bluetooth/hci_core.c         |   22 ++++++++++++----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6a1ac2c..1e28be4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -194,8 +194,9 @@ struct hci_dev {
 	struct delayed_work	discov_off;
 
 	struct timer_list	cmd_timer;
+
+	struct work_struct	rx_work;
 	struct tasklet_struct	cmd_task;
-	struct tasklet_struct	rx_task;
 	struct tasklet_struct	tx_task;
 
 	struct sk_buff_head	rx_q;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 700d0ab..223809f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -56,8 +56,8 @@
 
 int enable_hs;
 
+static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_task(unsigned long arg);
-static void hci_rx_task(unsigned long arg);
 static void hci_tx_task(unsigned long arg);
 
 static DEFINE_RWLOCK(hci_task_lock);
@@ -547,9 +547,9 @@ int hci_dev_open(__u16 dev)
 		}
 	} else {
 		/* Init failed, cleanup */
-		tasklet_kill(&hdev->rx_task);
 		tasklet_kill(&hdev->tx_task);
 		tasklet_kill(&hdev->cmd_task);
+		flush_work(&hdev->rx_work);
 
 		skb_queue_purge(&hdev->cmd_q);
 		skb_queue_purge(&hdev->rx_q);
@@ -586,7 +586,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	}
 
 	/* Kill RX and TX tasks */
-	tasklet_kill(&hdev->rx_task);
+	cancel_work_sync(&hdev->rx_work);
 	tasklet_kill(&hdev->tx_task);
 
 	if (hdev->discov_timeout > 0) {
@@ -617,8 +617,9 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
 
-	/* Kill cmd task */
+	/* Kill cmd task and evt work */
 	tasklet_kill(&hdev->cmd_task);
+	flush_work(&hdev->rx_work);
 
 	/* Drop queues */
 	skb_queue_purge(&hdev->rx_q);
@@ -1456,8 +1457,9 @@ int hci_register_dev(struct hci_dev *hdev)
 	hdev->sniff_max_interval = 800;
 	hdev->sniff_min_interval = 80;
 
-	tasklet_init(&hdev->cmd_task, hci_cmd_task, (unsigned long) hdev);
-	tasklet_init(&hdev->rx_task, hci_rx_task, (unsigned long) hdev);
+	INIT_WORK(&hdev->rx_work, hci_rx_work);
+
+	tasklet_init(&hdev->cmd_task, hci_cmd_task,(unsigned long) hdev);
 	tasklet_init(&hdev->tx_task, hci_tx_task, (unsigned long) hdev);
 
 	skb_queue_head_init(&hdev->rx_q);
@@ -1623,9 +1625,8 @@ int hci_recv_frame(struct sk_buff *skb)
 	/* Time stamp */
 	__net_timestamp(skb);
 
-	/* Queue frame for rx task */
 	skb_queue_tail(&hdev->rx_q, skb);
-	tasklet_schedule(&hdev->rx_task);
+	queue_work(hdev->workqueue, &hdev->rx_work);
 
 	return 0;
 }
@@ -2486,9 +2487,9 @@ static inline void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
-static void hci_rx_task(unsigned long arg)
+static void hci_rx_work(struct work_struct *work)
 {
-	struct hci_dev *hdev = (struct hci_dev *) arg;
+	struct hci_dev *hdev = container_of(work, struct hci_dev, rx_work);
 	struct sk_buff *skb;
 
 	BT_DBG("%s", hdev->name);
@@ -2519,6 +2520,7 @@ static void hci_rx_task(unsigned long arg)
 		/* Process frame */
 		switch (bt_cb(skb)->pkt_type) {
 		case HCI_EVENT_PKT:
+			BT_DBG("%s Event packet", hdev->name);
 			hci_event_packet(hdev, skb);
 			break;
 
-- 
1.7.6.4
