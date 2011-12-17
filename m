Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 14/22] Bluetooth: Move command task to workqueue
Date: Sat, 17 Dec 2011 19:29:34 -0200
Message-Id: <1324157382-1815-15-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-14-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-5-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-6-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-7-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-8-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-9-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-10-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-11-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-12-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-13-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-14-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

As part of the moving on all the Bluetooth processing to Process context.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_core.c         |   22 +++++++++++-----------
 net/bluetooth/hci_event.c        |    4 ++--
 net/bluetooth/hci_sock.c         |    2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e832433..051fd7f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -196,7 +196,7 @@ struct hci_dev {
 	struct timer_list	cmd_timer;
 
 	struct work_struct	rx_work;
-	struct tasklet_struct	cmd_task;
+	struct work_struct	cmd_work;
 	struct tasklet_struct	tx_task;
 
 	struct sk_buff_head	rx_q;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7654777..405319e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -57,7 +57,7 @@
 int enable_hs;
 
 static void hci_rx_work(struct work_struct *work);
-static void hci_cmd_task(unsigned long arg);
+static void hci_cmd_work(struct work_struct *work);
 static void hci_tx_task(unsigned long arg);
 
 static DEFINE_MUTEX(hci_task_lock);
@@ -209,7 +209,7 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 		skb->dev = (void *) hdev;
 
 		skb_queue_tail(&hdev->cmd_q, skb);
-		tasklet_schedule(&hdev->cmd_task);
+		queue_work(hdev->workqueue, &hdev->cmd_work);
 	}
 	skb_queue_purge(&hdev->driver_init);
 
@@ -548,7 +548,7 @@ int hci_dev_open(__u16 dev)
 	} else {
 		/* Init failed, cleanup */
 		tasklet_kill(&hdev->tx_task);
-		tasklet_kill(&hdev->cmd_task);
+		flush_work(&hdev->cmd_work);
 		flush_work(&hdev->rx_work);
 
 		skb_queue_purge(&hdev->cmd_q);
@@ -617,8 +617,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
 
-	/* Kill cmd task and evt work */
-	tasklet_kill(&hdev->cmd_task);
+	/* flush cmd and rx  work */
+	flush_work(&hdev->cmd_work);
 	flush_work(&hdev->rx_work);
 
 	/* Drop queues */
@@ -1208,7 +1208,7 @@ static void hci_cmd_timer(unsigned long arg)
 
 	BT_ERR("%s command tx timeout", hdev->name);
 	atomic_set(&hdev->cmd_cnt, 1);
-	tasklet_schedule(&hdev->cmd_task);
+	queue_work(hdev->workqueue, &hdev->cmd_work);
 }
 
 struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
@@ -1459,8 +1459,8 @@ int hci_register_dev(struct hci_dev *hdev)
 	hdev->sniff_min_interval = 80;
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
+	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
 
-	tasklet_init(&hdev->cmd_task, hci_cmd_task,(unsigned long) hdev);
 	tasklet_init(&hdev->tx_task, hci_tx_task, (unsigned long) hdev);
 
 	skb_queue_head_init(&hdev->rx_q);
@@ -1923,7 +1923,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 		hdev->init_last_cmd = opcode;
 
 	skb_queue_tail(&hdev->cmd_q, skb);
-	tasklet_schedule(&hdev->cmd_task);
+	queue_work(hdev->workqueue, &hdev->cmd_work);
 
 	return 0;
 }
@@ -2561,9 +2561,9 @@ static void hci_rx_work(struct work_struct *work)
 	mutex_unlock(&hci_task_lock);
 }
 
-static void hci_cmd_task(unsigned long arg)
+static void hci_cmd_work(struct work_struct *work)
 {
-	struct hci_dev *hdev = (struct hci_dev *) arg;
+	struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_work);
 	struct sk_buff *skb;
 
 	BT_DBG("%s cmd %d", hdev->name, atomic_read(&hdev->cmd_cnt));
@@ -2587,7 +2587,7 @@ static void hci_cmd_task(unsigned long arg)
 				  jiffies + msecs_to_jiffies(HCI_CMD_TIMEOUT));
 		} else {
 			skb_queue_head(&hdev->cmd_q, skb);
-			tasklet_schedule(&hdev->cmd_task);
+			queue_work(hdev->workqueue, &hdev->cmd_work);
 		}
 	}
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 93ecb2d..23466bb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2112,7 +2112,7 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 	if (ev->ncmd) {
 		atomic_set(&hdev->cmd_cnt, 1);
 		if (!skb_queue_empty(&hdev->cmd_q))
-			tasklet_schedule(&hdev->cmd_task);
+			queue_work(hdev->workqueue, &hdev->cmd_work);
 	}
 }
 
@@ -2194,7 +2194,7 @@ static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
 		atomic_set(&hdev->cmd_cnt, 1);
 		if (!skb_queue_empty(&hdev->cmd_q))
-			tasklet_schedule(&hdev->cmd_task);
+			queue_work(hdev->workqueue, &hdev->cmd_work);
 	}
 }
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 399be34..d10a724 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -538,7 +538,7 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 			tasklet_schedule(&hdev->tx_task);
 		} else {
 			skb_queue_tail(&hdev->cmd_q, skb);
-			tasklet_schedule(&hdev->cmd_task);
+			queue_work(hdev->workqueue, &hdev->cmd_work);
 		}
 	} else {
 		if (!capable(CAP_NET_RAW)) {
-- 
1.7.6.4

