Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: Move synchronous request handling into hci_request.c
Date: Tue, 10 Nov 2015 09:44:54 +0200
Message-Id: <1447141495-31126-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1447141495-31126-1-git-send-email-johan.hedberg@gmail.com>
References: <1447141495-31126-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

hci_request.c is a more natural place for the synchronous request
handling. Furthermore, we will soon need access to some of the
previously private-to-hci_core.c functions from hci_request.c.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c    | 193 --------------------------------------------
 net/bluetooth/hci_request.c | 184 +++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_request.h |  11 +++
 3 files changed, 195 insertions(+), 193 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9421b079de55..0b8b4f551645 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -56,15 +56,6 @@ DEFINE_MUTEX(hci_cb_list_lock);
 /* HCI ID Numbering */
 static DEFINE_IDA(hci_index_ida);
 
-/* ----- HCI requests ----- */
-
-#define HCI_REQ_DONE	  0
-#define HCI_REQ_PEND	  1
-#define HCI_REQ_CANCELED  2
-
-#define hci_req_lock(d)		mutex_lock(&d->req_lock)
-#define hci_req_unlock(d)	mutex_unlock(&d->req_lock)
-
 /* ---- HCI debugfs entries ---- */
 
 static ssize_t dut_mode_read(struct file *file, char __user *user_buf,
@@ -198,190 +189,6 @@ static void hci_debugfs_create_basic(struct hci_dev *hdev)
 				    &vendor_diag_fops);
 }
 
-/* ---- HCI requests ---- */
-
-static void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
-				  struct sk_buff *skb)
-{
-	BT_DBG("%s result 0x%2.2x", hdev->name, result);
-
-	if (hdev->req_status == HCI_REQ_PEND) {
-		hdev->req_result = result;
-		hdev->req_status = HCI_REQ_DONE;
-		if (skb)
-			hdev->req_skb = skb_get(skb);
-		wake_up_interruptible(&hdev->req_wait_q);
-	}
-}
-
-static void hci_req_cancel(struct hci_dev *hdev, int err)
-{
-	BT_DBG("%s err 0x%2.2x", hdev->name, err);
-
-	if (hdev->req_status == HCI_REQ_PEND) {
-		hdev->req_result = err;
-		hdev->req_status = HCI_REQ_CANCELED;
-		wake_up_interruptible(&hdev->req_wait_q);
-	}
-}
-
-struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
-				  const void *param, u8 event, u32 timeout)
-{
-	DECLARE_WAITQUEUE(wait, current);
-	struct hci_request req;
-	struct sk_buff *skb;
-	int err = 0;
-
-	BT_DBG("%s", hdev->name);
-
-	hci_req_init(&req, hdev);
-
-	hci_req_add_ev(&req, opcode, plen, param, event);
-
-	hdev->req_status = HCI_REQ_PEND;
-
-	add_wait_queue(&hdev->req_wait_q, &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
-
-	err = hci_req_run_skb(&req, hci_req_sync_complete);
-	if (err < 0) {
-		remove_wait_queue(&hdev->req_wait_q, &wait);
-		set_current_state(TASK_RUNNING);
-		return ERR_PTR(err);
-	}
-
-	schedule_timeout(timeout);
-
-	remove_wait_queue(&hdev->req_wait_q, &wait);
-
-	if (signal_pending(current))
-		return ERR_PTR(-EINTR);
-
-	switch (hdev->req_status) {
-	case HCI_REQ_DONE:
-		err = -bt_to_errno(hdev->req_result);
-		break;
-
-	case HCI_REQ_CANCELED:
-		err = -hdev->req_result;
-		break;
-
-	default:
-		err = -ETIMEDOUT;
-		break;
-	}
-
-	hdev->req_status = hdev->req_result = 0;
-	skb = hdev->req_skb;
-	hdev->req_skb = NULL;
-
-	BT_DBG("%s end: err %d", hdev->name, err);
-
-	if (err < 0) {
-		kfree_skb(skb);
-		return ERR_PTR(err);
-	}
-
-	if (!skb)
-		return ERR_PTR(-ENODATA);
-
-	return skb;
-}
-EXPORT_SYMBOL(__hci_cmd_sync_ev);
-
-struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
-			       const void *param, u32 timeout)
-{
-	return __hci_cmd_sync_ev(hdev, opcode, plen, param, 0, timeout);
-}
-EXPORT_SYMBOL(__hci_cmd_sync);
-
-/* Execute request and wait for completion. */
-static int __hci_req_sync(struct hci_dev *hdev,
-			  void (*func)(struct hci_request *req,
-				      unsigned long opt),
-			  unsigned long opt, __u32 timeout)
-{
-	struct hci_request req;
-	DECLARE_WAITQUEUE(wait, current);
-	int err = 0;
-
-	BT_DBG("%s start", hdev->name);
-
-	hci_req_init(&req, hdev);
-
-	hdev->req_status = HCI_REQ_PEND;
-
-	func(&req, opt);
-
-	add_wait_queue(&hdev->req_wait_q, &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
-
-	err = hci_req_run_skb(&req, hci_req_sync_complete);
-	if (err < 0) {
-		hdev->req_status = 0;
-
-		remove_wait_queue(&hdev->req_wait_q, &wait);
-		set_current_state(TASK_RUNNING);
-
-		/* ENODATA means the HCI request command queue is empty.
-		 * This can happen when a request with conditionals doesn't
-		 * trigger any commands to be sent. This is normal behavior
-		 * and should not trigger an error return.
-		 */
-		if (err == -ENODATA)
-			return 0;
-
-		return err;
-	}
-
-	schedule_timeout(timeout);
-
-	remove_wait_queue(&hdev->req_wait_q, &wait);
-
-	if (signal_pending(current))
-		return -EINTR;
-
-	switch (hdev->req_status) {
-	case HCI_REQ_DONE:
-		err = -bt_to_errno(hdev->req_result);
-		break;
-
-	case HCI_REQ_CANCELED:
-		err = -hdev->req_result;
-		break;
-
-	default:
-		err = -ETIMEDOUT;
-		break;
-	}
-
-	hdev->req_status = hdev->req_result = 0;
-
-	BT_DBG("%s end: err %d", hdev->name, err);
-
-	return err;
-}
-
-static int hci_req_sync(struct hci_dev *hdev,
-			void (*req)(struct hci_request *req,
-				    unsigned long opt),
-			unsigned long opt, __u32 timeout)
-{
-	int ret;
-
-	if (!test_bit(HCI_UP, &hdev->flags))
-		return -ENETDOWN;
-
-	/* Serialize all requests */
-	hci_req_lock(hdev);
-	ret = __hci_req_sync(hdev, req, opt, timeout);
-	hci_req_unlock(hdev);
-
-	return ret;
-}
-
 static void hci_reset_req(struct hci_request *req, unsigned long opt)
 {
 	BT_DBG("%s %ld", req->hdev->name, opt);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 5ba27c30e8f2..aa868f6f5a90 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -27,6 +27,10 @@
 #include "smp.h"
 #include "hci_request.h"
 
+#define HCI_REQ_DONE	  0
+#define HCI_REQ_PEND	  1
+#define HCI_REQ_CANCELED  2
+
 void hci_req_init(struct hci_request *req, struct hci_dev *hdev)
 {
 	skb_queue_head_init(&req->cmd_q);
@@ -82,6 +86,186 @@ int hci_req_run_skb(struct hci_request *req, hci_req_complete_skb_t complete)
 	return req_run(req, NULL, complete);
 }
 
+static void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
+				  struct sk_buff *skb)
+{
+	BT_DBG("%s result 0x%2.2x", hdev->name, result);
+
+	if (hdev->req_status == HCI_REQ_PEND) {
+		hdev->req_result = result;
+		hdev->req_status = HCI_REQ_DONE;
+		if (skb)
+			hdev->req_skb = skb_get(skb);
+		wake_up_interruptible(&hdev->req_wait_q);
+	}
+}
+
+void hci_req_cancel(struct hci_dev *hdev, int err)
+{
+	BT_DBG("%s err 0x%2.2x", hdev->name, err);
+
+	if (hdev->req_status == HCI_REQ_PEND) {
+		hdev->req_result = err;
+		hdev->req_status = HCI_REQ_CANCELED;
+		wake_up_interruptible(&hdev->req_wait_q);
+	}
+}
+
+struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
+				  const void *param, u8 event, u32 timeout)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	struct hci_request req;
+	struct sk_buff *skb;
+	int err = 0;
+
+	BT_DBG("%s", hdev->name);
+
+	hci_req_init(&req, hdev);
+
+	hci_req_add_ev(&req, opcode, plen, param, event);
+
+	hdev->req_status = HCI_REQ_PEND;
+
+	add_wait_queue(&hdev->req_wait_q, &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	err = hci_req_run_skb(&req, hci_req_sync_complete);
+	if (err < 0) {
+		remove_wait_queue(&hdev->req_wait_q, &wait);
+		set_current_state(TASK_RUNNING);
+		return ERR_PTR(err);
+	}
+
+	schedule_timeout(timeout);
+
+	remove_wait_queue(&hdev->req_wait_q, &wait);
+
+	if (signal_pending(current))
+		return ERR_PTR(-EINTR);
+
+	switch (hdev->req_status) {
+	case HCI_REQ_DONE:
+		err = -bt_to_errno(hdev->req_result);
+		break;
+
+	case HCI_REQ_CANCELED:
+		err = -hdev->req_result;
+		break;
+
+	default:
+		err = -ETIMEDOUT;
+		break;
+	}
+
+	hdev->req_status = hdev->req_result = 0;
+	skb = hdev->req_skb;
+	hdev->req_skb = NULL;
+
+	BT_DBG("%s end: err %d", hdev->name, err);
+
+	if (err < 0) {
+		kfree_skb(skb);
+		return ERR_PTR(err);
+	}
+
+	if (!skb)
+		return ERR_PTR(-ENODATA);
+
+	return skb;
+}
+EXPORT_SYMBOL(__hci_cmd_sync_ev);
+
+struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
+			       const void *param, u32 timeout)
+{
+	return __hci_cmd_sync_ev(hdev, opcode, plen, param, 0, timeout);
+}
+EXPORT_SYMBOL(__hci_cmd_sync);
+
+/* Execute request and wait for completion. */
+int __hci_req_sync(struct hci_dev *hdev, void (*func)(struct hci_request *req,
+						      unsigned long opt),
+		   unsigned long opt, __u32 timeout)
+{
+	struct hci_request req;
+	DECLARE_WAITQUEUE(wait, current);
+	int err = 0;
+
+	BT_DBG("%s start", hdev->name);
+
+	hci_req_init(&req, hdev);
+
+	hdev->req_status = HCI_REQ_PEND;
+
+	func(&req, opt);
+
+	add_wait_queue(&hdev->req_wait_q, &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	err = hci_req_run_skb(&req, hci_req_sync_complete);
+	if (err < 0) {
+		hdev->req_status = 0;
+
+		remove_wait_queue(&hdev->req_wait_q, &wait);
+		set_current_state(TASK_RUNNING);
+
+		/* ENODATA means the HCI request command queue is empty.
+		 * This can happen when a request with conditionals doesn't
+		 * trigger any commands to be sent. This is normal behavior
+		 * and should not trigger an error return.
+		 */
+		if (err == -ENODATA)
+			return 0;
+
+		return err;
+	}
+
+	schedule_timeout(timeout);
+
+	remove_wait_queue(&hdev->req_wait_q, &wait);
+
+	if (signal_pending(current))
+		return -EINTR;
+
+	switch (hdev->req_status) {
+	case HCI_REQ_DONE:
+		err = -bt_to_errno(hdev->req_result);
+		break;
+
+	case HCI_REQ_CANCELED:
+		err = -hdev->req_result;
+		break;
+
+	default:
+		err = -ETIMEDOUT;
+		break;
+	}
+
+	hdev->req_status = hdev->req_result = 0;
+
+	BT_DBG("%s end: err %d", hdev->name, err);
+
+	return err;
+}
+
+int hci_req_sync(struct hci_dev *hdev, void (*req)(struct hci_request *req,
+						   unsigned long opt),
+		 unsigned long opt, __u32 timeout)
+{
+	int ret;
+
+	if (!test_bit(HCI_UP, &hdev->flags))
+		return -ENETDOWN;
+
+	/* Serialize all requests */
+	hci_req_lock(hdev);
+	ret = __hci_req_sync(hdev, req, opt, timeout);
+	hci_req_unlock(hdev);
+
+	return ret;
+}
+
 struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 				const void *param)
 {
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 25c7f1305dcb..6e6bad4ca4ab 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -20,6 +20,9 @@
    SOFTWARE IS DISCLAIMED.
 */
 
+#define hci_req_lock(d)		mutex_lock(&d->req_lock)
+#define hci_req_unlock(d)	mutex_unlock(&d->req_lock)
+
 struct hci_request {
 	struct hci_dev		*hdev;
 	struct sk_buff_head	cmd_q;
@@ -41,6 +44,14 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status,
 			  hci_req_complete_t *req_complete,
 			  hci_req_complete_skb_t *req_complete_skb);
 
+int hci_req_sync(struct hci_dev *hdev, void (*req)(struct hci_request *req,
+						   unsigned long opt),
+		 unsigned long opt, __u32 timeout);
+int __hci_req_sync(struct hci_dev *hdev, void (*func)(struct hci_request *req,
+						      unsigned long opt),
+		   unsigned long opt, __u32 timeout);
+void hci_req_cancel(struct hci_dev *hdev, int err);
+
 struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 				const void *param);
 
-- 
2.5.0

