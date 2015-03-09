Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/7] Bluetooth: Convert hci_req_sync family of function to new request API
Date: Mon,  9 Mar 2015 13:03:37 +0200
Message-Id: <1425899021-16414-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1425899021-16414-1-git-send-email-johan.hedberg@gmail.com>
References: <1425899021-16414-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that there's an API in place that allows passing the resulting skb
to the request callback we can conveniently convert the hci_req_sync and
related functions to use it. Since we still need to get the skb from the
async callback into the sleeping _sync() function the patch adds another
req_skb variable to hci_dev where the sync request state is tracked.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index afc641c5e55c..65215245c913 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -323,6 +323,7 @@ struct hci_dev {
 	wait_queue_head_t	req_wait_q;
 	__u32			req_status;
 	__u32			req_result;
+	struct sk_buff		*req_skb;
 
 	void			*smp_data;
 	void			*smp_bredr_data;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 335014e85bf5..2619bff1bdfb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -141,13 +141,16 @@ static const struct file_operations dut_mode_fops = {
 
 /* ---- HCI requests ---- */
 
-static void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode)
+static void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
+				  struct sk_buff *skb)
 {
 	BT_DBG("%s result 0x%2.2x", hdev->name, result);
 
 	if (hdev->req_status == HCI_REQ_PEND) {
 		hdev->req_result = result;
 		hdev->req_status = HCI_REQ_DONE;
+		if (skb)
+			hdev->req_skb = skb_get(skb);
 		wake_up_interruptible(&hdev->req_wait_q);
 	}
 }
@@ -164,18 +167,10 @@ static void hci_req_cancel(struct hci_dev *hdev, int err)
 }
 
 static struct sk_buff *hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
-					    u8 event)
+					    u8 event, struct sk_buff *skb)
 {
 	struct hci_ev_cmd_complete *ev;
 	struct hci_event_hdr *hdr;
-	struct sk_buff *skb;
-
-	hci_dev_lock(hdev);
-
-	skb = hdev->recv_evt;
-	hdev->recv_evt = NULL;
-
-	hci_dev_unlock(hdev);
 
 	if (!skb)
 		return ERR_PTR(-ENODATA);
@@ -223,6 +218,7 @@ struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
 {
 	DECLARE_WAITQUEUE(wait, current);
 	struct hci_request req;
+	struct sk_buff *skb;
 	int err = 0;
 
 	BT_DBG("%s", hdev->name);
@@ -236,7 +232,7 @@ struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
 	add_wait_queue(&hdev->req_wait_q, &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
 
-	err = hci_req_run(&req, hci_req_sync_complete);
+	err = hci_req_run_skb(&req, hci_req_sync_complete);
 	if (err < 0) {
 		remove_wait_queue(&hdev->req_wait_q, &wait);
 		set_current_state(TASK_RUNNING);
@@ -265,13 +261,17 @@ struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
 	}
 
 	hdev->req_status = hdev->req_result = 0;
+	skb = hdev->req_skb;
+	hdev->req_skb = NULL;
 
 	BT_DBG("%s end: err %d", hdev->name, err);
 
-	if (err < 0)
+	if (err < 0) {
+		kfree_skb(skb);
 		return ERR_PTR(err);
+	}
 
-	return hci_get_cmd_complete(hdev, opcode, event);
+	return hci_get_cmd_complete(hdev, opcode, event, skb);
 }
 EXPORT_SYMBOL(__hci_cmd_sync_ev);
 
@@ -303,7 +303,7 @@ static int __hci_req_sync(struct hci_dev *hdev,
 	add_wait_queue(&hdev->req_wait_q, &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
 
-	err = hci_req_run(&req, hci_req_sync_complete);
+	err = hci_req_run_skb(&req, hci_req_sync_complete);
 	if (err < 0) {
 		hdev->req_status = 0;
 
-- 
2.1.0

