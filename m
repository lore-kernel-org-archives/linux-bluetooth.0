Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH 1/2] Bluetooth: add virtual hci command
Date: Fri, 30 Oct 2015 20:47:40 -0700
Message-Id: <1446263261-1549-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds virtual HCI command HCI_OP_VIRT_LE_SCAN_DISABLED.
It's called virtual, because it'll never be sent to the controller.
It can be added to asynchronous hci_request, and when time comes for its
execution, it can do some logic and decide either to transform itself
into real packet, or send nothing.

Logic for HCI_OP_VIRT_LE_SCAN_DISABLED is as follows: if at time of
execution scan is disabled, do nothing. If scan is enabled, disable it.
It is needed because scan state migth change between moment when we
schedule command and execution time. Later patches will use this
new command to fix some error scenarios.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci.h      |  2 +
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 86 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0205b80..4253312 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1961,6 +1961,8 @@ struct hci_ev_si_security {
 	__u8     incoming;
 } __packed;
 
+#define HCI_OP_VIRT_LE_SCAN_DISABLE	0xFF0b
+
 /* ---- HCI Packet structures ---- */
 #define HCI_COMMAND_HDR_SIZE 3
 #define HCI_EVENT_HDR_SIZE   2
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1878d0a..4fcca8f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -322,6 +322,7 @@ struct hci_dev {
 	struct delayed_work	service_cache;
 
 	struct delayed_work	cmd_timer;
+	struct work_struct	cmd_timer_cancel;
 
 	struct work_struct	rx_work;
 	struct work_struct	cmd_work;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 83a6aac..b012059 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2623,6 +2623,15 @@ static void hci_cmd_timeout(struct work_struct *work)
 	queue_work(hdev->workqueue, &hdev->cmd_work);
 }
 
+static void hci_cmd_timeout_cancel(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    cmd_timer_cancel);
+
+	BT_DBG("%s cmd_timer canceled", hdev->name);
+	cancel_delayed_work(&hdev->cmd_timer);
+}
+
 struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
 					  bdaddr_t *bdaddr, u8 bdaddr_type)
 {
@@ -3304,6 +3313,7 @@ struct hci_dev *hci_alloc_dev(void)
 	init_waitqueue_head(&hdev->req_wait_q);
 
 	INIT_DELAYED_WORK(&hdev->cmd_timer, hci_cmd_timeout);
+	INIT_WORK(&hdev->cmd_timer_cancel, hci_cmd_timeout_cancel);
 
 	hci_init_sysfs(hdev);
 	discovery_init(hdev);
@@ -3594,12 +3604,88 @@ int hci_unregister_cb(struct hci_cb *cb)
 }
 EXPORT_SYMBOL(hci_unregister_cb);
 
+static void hci_virtual_frame_skip(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_command_hdr *hdr = (void *)skb->data;
+	hci_req_complete_t req_complete = NULL;
+	hci_req_complete_skb_t req_complete_skb = NULL;
+	int status = 0;
+	__u16 opcode;
+
+	BT_DBG("%s Skipping virtual packet 0x%4.4x", hdev->name,
+	       bt_cb(skb)->opcode);
+
+	/* Do cleanup similar to that in hci_cmd_status_evt */
+	if (!test_bit(HCI_RESET, &hdev->flags))
+		atomic_set(&hdev->cmd_cnt, 1);
+
+	opcode = __le16_to_cpu(hdr->opcode);
+
+	/* Indicate request completion */
+	hci_req_cmd_complete(hdev, opcode, 0, &req_complete, &req_complete_skb);
+
+	if (atomic_read(&hdev->cmd_cnt) && !skb_queue_empty(&hdev->cmd_q))
+		queue_work(hdev->workqueue, &hdev->cmd_work);
+
+	/* Do cleanup similar to that in hci_event_packet */
+	if (req_complete)
+		req_complete(hdev, status, opcode);
+	else if (req_complete_skb)
+		req_complete_skb(hdev, status, opcode, skb);
+
+	kfree_skb(skb);
+
+	/* There will be no packet really send to controller, there will be no
+	 * response that normally stops cmd_timer. cmd_timer was not scheduled
+	 * yet, but will be in hci_cmd_work. Make sure it'll be cancelled right
+	 * away.
+	 */
+	schedule_work(&hdev->cmd_timer_cancel);
+}
+
+static bool hci_transform_virtual_frame(struct hci_dev *hdev,
+					struct sk_buff *skb)
+{
+	struct hci_command_hdr *hdr = (void *)skb->data;
+
+	BT_DBG("%s Transforming virual packet 0x%4.4x", hdev->name,
+	       bt_cb(skb)->opcode);
+
+	switch (bt_cb(skb)->opcode) {
+	case HCI_OP_VIRT_LE_SCAN_DISABLE:
+		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
+			/* Transform virtual command into real one. It already
+			 * have proper size and data.
+			 */
+			hdr->opcode = cpu_to_le16(HCI_OP_LE_SET_SCAN_ENABLE);
+			bt_cb(skb)->opcode = HCI_OP_LE_SET_SCAN_ENABLE;
+		} else {
+			hci_virtual_frame_skip(hdev, skb);
+			return false;
+		}
+		break;
+	default:
+		BT_ERR("Unknown virtual command 0x%4.4x", bt_cb(skb)->opcode);
+		return false;
+	}
+
+	return true;
+}
+
 static void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	int err;
 
 	BT_DBG("%s type %d len %d", hdev->name, bt_cb(skb)->pkt_type, skb->len);
 
+	/* If it was virtual packet, transform it. If nothing is left after
+	 * transformation finish here. If it changed into real packet, send it
+	 */
+	if (bt_cb(skb)->pkt_type == HCI_COMMAND_PKT &&
+	    (bt_cb(skb)->opcode & 0xff00) == 0xff00 &&
+	    !hci_transform_virtual_frame(hdev, skb))
+		return;
+
 	/* Time stamp */
 	__net_timestamp(skb);
 
-- 
2.5.0

