Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add 'sync' specifier to synchronous request APIs
Date: Tue, 10 Nov 2015 09:39:13 +0200
Message-Id: <1447141153-28021-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To make it clear which HCI request APIs target specifically
synchronous requests, add 'sync' to the API names.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c    | 28 ++++++++++++++--------------
 net/bluetooth/hci_request.c |  6 +++---
 net/bluetooth/hci_request.h |  6 +++---
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a164da04c50d..5739f3b95922 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -92,14 +92,14 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 	if (enable == hci_dev_test_flag(hdev, HCI_DUT_MODE))
 		return -EALREADY;
 
-	hci_req_lock(hdev);
+	hci_req_sync_lock(hdev);
 	if (enable)
 		skb = __hci_cmd_sync(hdev, HCI_OP_ENABLE_DUT_MODE, 0, NULL,
 				     HCI_CMD_TIMEOUT);
 	else
 		skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
 				     HCI_CMD_TIMEOUT);
-	hci_req_unlock(hdev);
+	hci_req_sync_unlock(hdev);
 
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
@@ -156,9 +156,9 @@ static ssize_t vendor_diag_write(struct file *file, const char __user *user_buf,
 	    !test_bit(HCI_RUNNING, &hdev->flags))
 		goto done;
 
-	hci_req_lock(hdev);
+	hci_req_sync_lock(hdev);
 	err = hdev->set_diag(hdev, enable);
-	hci_req_unlock(hdev);
+	hci_req_sync_unlock(hdev);
 
 	if (err < 0)
 		return err;
@@ -1252,7 +1252,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 
 	BT_DBG("%s %p", hdev->name, hdev);
 
-	hci_req_lock(hdev);
+	hci_req_sync_lock(hdev);
 
 	if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
 		ret = -ENODEV;
@@ -1405,7 +1405,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 	}
 
 done:
-	hci_req_unlock(hdev);
+	hci_req_sync_unlock(hdev);
 	return ret;
 }
 
@@ -1499,12 +1499,12 @@ int hci_dev_do_close(struct hci_dev *hdev)
 
 	cancel_delayed_work(&hdev->power_off);
 
-	hci_req_cancel(hdev, ENODEV);
-	hci_req_lock(hdev);
+	hci_req_sync_cancel(hdev, ENODEV);
+	hci_req_sync_lock(hdev);
 
 	if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
 		cancel_delayed_work_sync(&hdev->cmd_timer);
-		hci_req_unlock(hdev);
+		hci_req_sync_unlock(hdev);
 		return 0;
 	}
 
@@ -1602,7 +1602,7 @@ int hci_dev_do_close(struct hci_dev *hdev)
 	memset(hdev->dev_class, 0, sizeof(hdev->dev_class));
 	bacpy(&hdev->random_addr, BDADDR_ANY);
 
-	hci_req_unlock(hdev);
+	hci_req_sync_unlock(hdev);
 
 	hci_dev_put(hdev);
 	return 0;
@@ -1638,7 +1638,7 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
 
 	BT_DBG("%s %p", hdev->name, hdev);
 
-	hci_req_lock(hdev);
+	hci_req_sync_lock(hdev);
 
 	/* Drop queues */
 	skb_queue_purge(&hdev->rx_q);
@@ -1662,7 +1662,7 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
 
 	ret = __hci_req_sync(hdev, hci_reset_req, 0, HCI_INIT_TIMEOUT);
 
-	hci_req_unlock(hdev);
+	hci_req_sync_unlock(hdev);
 	return ret;
 }
 
@@ -3532,9 +3532,9 @@ struct sk_buff *hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 
 	bt_dev_dbg(hdev, "opcode 0x%4.4x plen %d", opcode, plen);
 
-	hci_req_lock(hdev);
+	hci_req_sync_lock(hdev);
 	skb = __hci_cmd_sync(hdev, opcode, plen, param, timeout);
-	hci_req_unlock(hdev);
+	hci_req_sync_unlock(hdev);
 
 	return skb;
 }
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index aa868f6f5a90..ae19bce89616 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -100,7 +100,7 @@ static void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 	}
 }
 
-void hci_req_cancel(struct hci_dev *hdev, int err)
+void hci_req_sync_cancel(struct hci_dev *hdev, int err)
 {
 	BT_DBG("%s err 0x%2.2x", hdev->name, err);
 
@@ -259,9 +259,9 @@ int hci_req_sync(struct hci_dev *hdev, void (*req)(struct hci_request *req,
 		return -ENETDOWN;
 
 	/* Serialize all requests */
-	hci_req_lock(hdev);
+	hci_req_sync_lock(hdev);
 	ret = __hci_req_sync(hdev, req, opt, timeout);
-	hci_req_unlock(hdev);
+	hci_req_sync_unlock(hdev);
 
 	return ret;
 }
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 6e6bad4ca4ab..5b3240cf9eb7 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -20,8 +20,8 @@
    SOFTWARE IS DISCLAIMED.
 */
 
-#define hci_req_lock(d)		mutex_lock(&d->req_lock)
-#define hci_req_unlock(d)	mutex_unlock(&d->req_lock)
+#define hci_req_sync_lock(hdev)   mutex_lock(&hdev->req_lock)
+#define hci_req_sync_unlock(hdev) mutex_unlock(&hdev->req_lock)
 
 struct hci_request {
 	struct hci_dev		*hdev;
@@ -50,7 +50,7 @@ int hci_req_sync(struct hci_dev *hdev, void (*req)(struct hci_request *req,
 int __hci_req_sync(struct hci_dev *hdev, void (*func)(struct hci_request *req,
 						      unsigned long opt),
 		   unsigned long opt, __u32 timeout);
-void hci_req_cancel(struct hci_dev *hdev, int err);
+void hci_req_sync_cancel(struct hci_dev *hdev, int err);
 
 struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 				const void *param);
-- 
2.5.0

