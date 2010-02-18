Return-Path: <cyrus@holtmann.org>
From: Tomas Winkler <tomas.winkler@intel.com>
To: marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Cc: guy.cohen@intel.com, ron.rindjunsky@intel.com, Gregory Paskar <greogry.paskar@intel.com>
Subject: [bluetooth-next 1/1] bluetooth: handle device reset event
Date: Thu, 18 Feb 2010 11:40:07 +0200
Message-Id: <1266486007-25015-1-git-send-email-tomas.winkler@intel.com>
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gregory Paskar <greogry.paskar@intel.com>

A bluetooth device experiencing hardware failure may issue
a HARDWARE_ERROR hci event. The reaction to this event is device
reset flow implemented in following sequence.

1. Notify: HCI_DEV_DOWN
2. Reinitialize internal structures.
3. Call driver flush function
4. Send HCI reset request to the device.
5. Send HCI init sequence reset to the device.
6. Notify HCI_DEV_UP.

Signed-off-by: Gregory Paskar <greogry.paskar@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Ron Rindjunsky <ron.rindjunsky@intel.com>
---
 include/net/bluetooth/hci.h      |    5 ++++
 include/net/bluetooth/hci_core.h |    2 +
 net/bluetooth/hci_core.c         |   40 +++++++++++++++++++++++++++++++++++++-
 net/bluetooth/hci_event.c        |    3 ++
 4 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ed3aea1..cd23eb4 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -691,6 +691,11 @@ struct hci_ev_cmd_status {
 	__le16   opcode;
 } __attribute__ ((packed));
 
+#define HCI_EV_HARDWARE_ERROR 0x10
+struct hci_ev_hw_error {
+	__u8     hw_code;
+} __attribute__ ((packed));
+
 #define HCI_EV_ROLE_CHANGE		0x12
 struct hci_ev_role_change {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7b86094..d2b1cba 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -110,6 +110,8 @@ struct hci_dev {
 	struct tasklet_struct	rx_task;
 	struct tasklet_struct	tx_task;
 
+	struct work_struct 	hw_err_work;
+
 	struct sk_buff_head	rx_q;
 	struct sk_buff_head	raw_q;
 	struct sk_buff_head	cmd_q;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 94ba349..6002439 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -834,6 +834,44 @@ static int hci_rfkill_set_block(void *data, bool blocked)
 	return 0;
 }
 
+static void hci_device_hw_error(struct hci_dev *hdev)
+{
+	hci_req_lock(hdev);
+	clear_bit(HCI_UP, &hdev->flags);
+	hci_notify(hdev, HCI_DEV_DOWN);
+	tasklet_disable(&hdev->tx_task);
+	skb_queue_purge(&hdev->rx_q);
+	skb_queue_purge(&hdev->cmd_q);
+	hci_dev_lock_bh(hdev);
+	inquiry_cache_flush(hdev);
+	hci_conn_hash_flush(hdev);
+	hci_dev_unlock_bh(hdev);
+	if (hdev->flush)
+		hdev->flush(hdev);
+	atomic_set(&hdev->cmd_cnt, 1);
+	hdev->acl_cnt = 0;
+	hdev->sco_cnt = 0;
+	hci_reset_req(hdev, 0);
+	atomic_set(&hdev->cmd_cnt, 1);
+	hci_init_req(hdev, 0);
+	tasklet_enable(&hdev->tx_task);
+	set_bit(HCI_UP, &hdev->flags);
+	hci_notify(hdev, HCI_DEV_UP);
+	hci_req_unlock(hdev);
+}
+
+
+static void hci_hw_err_work(struct work_struct *ws)
+{
+	struct hci_dev *hdev;
+	hdev = container_of(ws, struct hci_dev, hw_err_work);
+	if (!hdev) {
+		BT_DBG("%s: hci_hw_error_worker: hdev = NULL ", hdev->name);
+		return;
+	}
+	hci_device_hw_error(hdev);
+}
+
 static const struct rfkill_ops hci_rfkill_ops = {
 	.set_block = hci_rfkill_set_block,
 };
@@ -903,7 +941,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	tasklet_init(&hdev->cmd_task, hci_cmd_task,(unsigned long) hdev);
 	tasklet_init(&hdev->rx_task, hci_rx_task, (unsigned long) hdev);
 	tasklet_init(&hdev->tx_task, hci_tx_task, (unsigned long) hdev);
-
+	INIT_WORK(&hdev->hw_err_work, hci_hw_err_work);
 	skb_queue_head_init(&hdev->rx_q);
 	skb_queue_head_init(&hdev->cmd_q);
 	skb_queue_head_init(&hdev->raw_q);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 28517ba..e8f48cc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1953,6 +1953,9 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	case HCI_EV_REMOTE_HOST_FEATURES:
 		hci_remote_host_features_evt(hdev, skb);
 		break;
+	case HCI_EV_HARDWARE_ERROR:
+		schedule_work(&hdev->hw_err_work);
+		break;
 
 	default:
 		BT_DBG("%s event 0x%x", hdev->name, event);
-- 
1.6.0.6

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
