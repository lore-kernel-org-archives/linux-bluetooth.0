Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use struct delayed_work for HCI command timeout
Date: Mon, 16 Jun 2014 12:30:56 +0200
Message-Id: <1402914656-27769-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since the whole HCI command, event and data packet processing has been
migrated to use workqueues instead of tasklets, it makes sense to use
struct delayed_work instead of struct timer_list for the timeout
handling. This patch converts the hdev->cmd_timer to use workqueue
as well.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_core.c         | 17 +++++++++--------
 net/bluetooth/hci_event.c        |  4 ++--
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b386bf17e6c2..de3bb22e83f9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -273,7 +273,7 @@ struct hci_dev {
 
 	struct delayed_work	service_cache;
 
-	struct timer_list	cmd_timer;
+	struct delayed_work	cmd_timer;
 
 	struct work_struct	rx_work;
 	struct work_struct	cmd_work;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0a43cce9a914..9e0368b02a11 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2432,7 +2432,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	hci_req_lock(hdev);
 
 	if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
-		del_timer_sync(&hdev->cmd_timer);
+		cancel_delayed_work_sync(&hdev->cmd_timer);
 		hci_req_unlock(hdev);
 		return 0;
 	}
@@ -2488,7 +2488,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 
 	/* Drop last sent command */
 	if (hdev->sent_cmd) {
-		del_timer_sync(&hdev->cmd_timer);
+		cancel_delayed_work_sync(&hdev->cmd_timer);
 		kfree_skb(hdev->sent_cmd);
 		hdev->sent_cmd = NULL;
 	}
@@ -3205,9 +3205,10 @@ void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type)
 }
 
 /* HCI command timer function */
-static void hci_cmd_timeout(unsigned long arg)
+static void hci_cmd_timeout(struct work_struct *work)
 {
-	struct hci_dev *hdev = (void *) arg;
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    cmd_timer.work);
 
 	if (hdev->sent_cmd) {
 		struct hci_command_hdr *sent = (void *) hdev->sent_cmd->data;
@@ -3884,7 +3885,7 @@ struct hci_dev *hci_alloc_dev(void)
 
 	init_waitqueue_head(&hdev->req_wait_q);
 
-	setup_timer(&hdev->cmd_timer, hci_cmd_timeout, (unsigned long) hdev);
+	INIT_DELAYED_WORK(&hdev->cmd_timer, hci_cmd_timeout);
 
 	hci_init_sysfs(hdev);
 	discovery_init(hdev);
@@ -5287,10 +5288,10 @@ static void hci_cmd_work(struct work_struct *work)
 			atomic_dec(&hdev->cmd_cnt);
 			hci_send_frame(hdev, skb);
 			if (test_bit(HCI_RESET, &hdev->flags))
-				del_timer(&hdev->cmd_timer);
+				cancel_delayed_work(&hdev->cmd_timer);
 			else
-				mod_timer(&hdev->cmd_timer,
-					  jiffies + HCI_CMD_TIMEOUT);
+				schedule_delayed_work(&hdev->cmd_timer,
+						      HCI_CMD_TIMEOUT);
 		} else {
 			skb_queue_head(&hdev->cmd_q, skb);
 			queue_work(hdev->workqueue, &hdev->cmd_work);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 640c54ec1bd2..3d52be1d695d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2709,7 +2709,7 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (opcode != HCI_OP_NOP)
-		del_timer(&hdev->cmd_timer);
+		cancel_delayed_work(&hdev->cmd_timer);
 
 	hci_req_cmd_complete(hdev, opcode, status);
 
@@ -2800,7 +2800,7 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (opcode != HCI_OP_NOP)
-		del_timer(&hdev->cmd_timer);
+		cancel_delayed_work(&hdev->cmd_timer);
 
 	if (ev->status ||
 	    (hdev->sent_cmd && !bt_cb(hdev->sent_cmd)->req.event))
-- 
1.9.3

