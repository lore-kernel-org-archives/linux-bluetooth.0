Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 15/22] Bluetooth: convert tx_task to workqueue
Date: Sat, 17 Dec 2011 19:29:35 -0200
Message-Id: <1324157382-1815-16-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-15-git-send-email-padovan@profusion.mobi>
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
 <1324157382-1815-15-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

This should simplify Bluetooth core processing a lot.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_core.c         |   18 ++++++++----------
 net/bluetooth/hci_event.c        |    6 +-----
 net/bluetooth/hci_sock.c         |    4 ++--
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 051fd7f..5d1bb51 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -197,7 +197,7 @@ struct hci_dev {
 
 	struct work_struct	rx_work;
 	struct work_struct	cmd_work;
-	struct tasklet_struct	tx_task;
+	struct work_struct	tx_work;
 
 	struct sk_buff_head	rx_q;
 	struct sk_buff_head	raw_q;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 405319e..fbc7968 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -58,7 +58,7 @@ int enable_hs;
 
 static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_work(struct work_struct *work);
-static void hci_tx_task(unsigned long arg);
+static void hci_tx_work(struct work_struct *work);
 
 static DEFINE_MUTEX(hci_task_lock);
 
@@ -547,7 +547,7 @@ int hci_dev_open(__u16 dev)
 		}
 	} else {
 		/* Init failed, cleanup */
-		tasklet_kill(&hdev->tx_task);
+		flush_work(&hdev->tx_work);
 		flush_work(&hdev->cmd_work);
 		flush_work(&hdev->rx_work);
 
@@ -587,7 +587,6 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 
 	/* Kill RX and TX tasks */
 	cancel_work_sync(&hdev->rx_work);
-	tasklet_kill(&hdev->tx_task);
 
 	if (hdev->discov_timeout > 0) {
 		cancel_delayed_work(&hdev->discov_off);
@@ -620,6 +619,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	/* flush cmd and rx  work */
 	flush_work(&hdev->cmd_work);
 	flush_work(&hdev->rx_work);
+	flush_work(&hdev->tx_work);
 
 	/* Drop queues */
 	skb_queue_purge(&hdev->rx_q);
@@ -673,7 +673,6 @@ int hci_dev_reset(__u16 dev)
 		return -ENODEV;
 
 	hci_req_lock(hdev);
-	tasklet_disable(&hdev->tx_task);
 
 	if (!test_bit(HCI_UP, &hdev->flags))
 		goto done;
@@ -698,7 +697,6 @@ int hci_dev_reset(__u16 dev)
 					msecs_to_jiffies(HCI_INIT_TIMEOUT));
 
 done:
-	tasklet_enable(&hdev->tx_task);
 	hci_req_unlock(hdev);
 	hci_dev_put(hdev);
 	return ret;
@@ -1460,8 +1458,8 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
+	INIT_WORK(&hdev->tx_work, hci_tx_work);
 
-	tasklet_init(&hdev->tx_task, hci_tx_task, (unsigned long) hdev);
 
 	skb_queue_head_init(&hdev->rx_q);
 	skb_queue_head_init(&hdev->cmd_q);
@@ -2013,7 +2011,7 @@ void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags)
 
 	hci_queue_acl(conn, &chan->data_q, skb, flags);
 
-	tasklet_schedule(&hdev->tx_task);
+	queue_work(hdev->workqueue, &hdev->tx_work);
 }
 EXPORT_SYMBOL(hci_send_acl);
 
@@ -2036,7 +2034,7 @@ void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
 	bt_cb(skb)->pkt_type = HCI_SCODATA_PKT;
 
 	skb_queue_tail(&conn->data_q, skb);
-	tasklet_schedule(&hdev->tx_task);
+	queue_work(hdev->workqueue, &hdev->tx_work);
 }
 EXPORT_SYMBOL(hci_send_sco);
 
@@ -2400,9 +2398,9 @@ static inline void hci_sched_le(struct hci_dev *hdev)
 		hci_prio_recalculate(hdev, LE_LINK);
 }
 
-static void hci_tx_task(unsigned long arg)
+static void hci_tx_work(struct work_struct *work)
 {
-	struct hci_dev *hdev = (struct hci_dev *) arg;
+	struct hci_dev *hdev = container_of(work, struct hci_dev, tx_work);
 	struct sk_buff *skb;
 
 	mutex_lock(&hci_task_lock);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 23466bb..74f7583 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2239,8 +2239,6 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 		return;
 	}
 
-	tasklet_disable(&hdev->tx_task);
-
 	for (i = 0, ptr = (__le16 *) skb->data; i < ev->num_hndl; i++) {
 		struct hci_conn *conn;
 		__u16  handle, count;
@@ -2274,9 +2272,7 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 		}
 	}
 
-	tasklet_schedule(&hdev->tx_task);
-
-	tasklet_enable(&hdev->tx_task);
+	queue_work(hdev->workqueue, &hdev->tx_work);
 }
 
 static inline void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index d10a724..cd06406 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -535,7 +535,7 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 
 		if (test_bit(HCI_RAW, &hdev->flags) || (ogf == 0x3f)) {
 			skb_queue_tail(&hdev->raw_q, skb);
-			tasklet_schedule(&hdev->tx_task);
+			queue_work(hdev->workqueue, &hdev->tx_work);
 		} else {
 			skb_queue_tail(&hdev->cmd_q, skb);
 			queue_work(hdev->workqueue, &hdev->cmd_work);
@@ -547,7 +547,7 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 		}
 
 		skb_queue_tail(&hdev->raw_q, skb);
-		tasklet_schedule(&hdev->tx_task);
+		queue_work(hdev->workqueue, &hdev->tx_work);
 	}
 
 	err = len;
-- 
1.7.6.4

