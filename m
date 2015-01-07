Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v6 2/3] Bluetooth: Add le_scan_restart
Date: Wed,  7 Jan 2015 05:10:53 -0800
Message-Id: <1420636254-25626-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1420636254-25626-1-git-send-email-jpawlowski@google.com>
References: <1420636254-25626-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently there is no way to restart le scan, and it's needed in
service scan method. The way it work: it disable, and then enable le
scan on controller. During this restart marker is set to make sure we
won't remove disable scan work from workqueue.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 44 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |  8 +++++---
 net/bluetooth/hci_request.c      | 12 +++++++++--
 net/bluetooth/hci_request.h      |  2 ++
 5 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 89f4e3c..2ea1f46 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -349,6 +349,7 @@ struct hci_dev {
 	unsigned long		dev_flags;
 
 	struct delayed_work	le_scan_disable;
+	struct delayed_work	le_scan_restart;
 
 	__s8			adv_tx_power;
 	__u8			adv_data[HCI_MAX_AD_LENGTH];
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bc5486e..9635cd8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1608,6 +1608,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		cancel_delayed_work(&hdev->service_cache);
 
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
+	cancel_delayed_work_sync(&hdev->le_scan_restart);
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		cancel_delayed_work_sync(&hdev->rpa_expired);
@@ -2818,6 +2819,8 @@ static void le_scan_disable_work(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
+	cancel_delayed_work_sync(&hdev->le_scan_restart);
+
 	hci_req_init(&req, hdev);
 
 	hci_req_add_le_scan_disable(&req);
@@ -2827,6 +2830,46 @@ static void le_scan_disable_work(struct work_struct *work)
 		BT_ERR("Disable LE scanning request failed: err %d", err);
 }
 
+static void le_scan_restart_work_complete(struct hci_dev *hdev, u8 status)
+{
+	BT_DBG("%s", hdev->name);
+
+	if (status)
+		BT_ERR("Failed to restart LE scan: status %d", status);
+}
+
+static void le_scan_restart_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    le_scan_restart.work);
+	struct hci_request req;
+	struct hci_cp_le_set_scan_enable cp_dis, cp;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	/* If controller is not scanning we are done. */
+	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		return;
+
+	hci_req_init(&req, hdev);
+
+	memset(&cp_dis, 0, sizeof(cp_dis));
+	cp_dis.enable = LE_SCAN_DISABLE;
+	hci_req_add_ev_marker(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp_dis),
+			      &cp_dis, 0, true);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = LE_SCAN_ENABLE;
+	cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+	hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+
+	err = hci_req_run(&req, le_scan_restart_work_complete);
+
+	if (err)
+		BT_ERR("Restart LE scan request failed: err %d", err);
+}
+
 /* Copy the Identity Address of the controller.
  *
  * If the controller has a public BD_ADDR, then by default use that one.
@@ -2922,6 +2965,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
+	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
 
 	skb_queue_head_init(&hdev->rx_q);
 	skb_queue_head_init(&hdev->cmd_q);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0881efd..9f3f1a9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1176,10 +1176,12 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 					  d->last_adv_data_len, NULL, 0);
 		}
 
-		/* Cancel this timer so that we don't try to disable scanning
-		 * when it's already disabled.
+		/* If marker is set, don't cancel this timer, because we're just
+		 * restarting scan. Otherwise cancel it so that we don't try to
+		 * disable scanning when it's already disabled.
 		 */
-		cancel_delayed_work(&hdev->le_scan_disable);
+		if (!bt_cb(hdev->sent_cmd)->req.marker)
+			cancel_delayed_work(&hdev->le_scan_disable);
 
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 324c641..626bc99 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -93,8 +93,8 @@ struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 }
 
 /* Queue a command to an asynchronous HCI request */
-void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
-		    const void *param, u8 event)
+void hci_req_add_ev_marker(struct hci_request *req, u16 opcode, u32 plen,
+			   const void *param, u8 event, bool marker)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct sk_buff *skb;
@@ -119,10 +119,18 @@ void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
 		bt_cb(skb)->req.start = true;
 
 	bt_cb(skb)->req.event = event;
+	bt_cb(skb)->req.marker = marker;
 
 	skb_queue_tail(&req->cmd_q, skb);
 }
 
+/* Queue a command to an asynchronous HCI request */
+void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
+		    const void *param, u8 event)
+{
+	hci_req_add_ev_marker(req, opcode, plen, param, event, false);
+}
+
 void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
 		 const void *param)
 {
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index adf074d..2baa534 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -36,6 +36,8 @@ void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
 		 const void *param);
 void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
 		    const void *param, u8 event);
+void hci_req_add_ev_marker(struct hci_request *req, u16 opcode, u32 plen,
+			   const void *param, u8 event, bool marker);
 void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
 
 struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
-- 
2.2.0.rc0.207.ga3a616c

