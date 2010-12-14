Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix __hci_request synchronization for hci_open_dev
Date: Tue, 14 Dec 2010 14:04:04 +0200
Message-Id: <1292328244-5335-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1292328244-5335-1-git-send-email-johan.hedberg@gmail.com>
References: <1292328244-5335-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

The initialization function used by hci_open_dev (hci_init_req) sends
many different HCI commands. The __hci_request function should only
return when all of these commands have completed (or a timeout occurs).
Several of these commands cause hci_req_complete to be called which
causes __hci_request to return prematurely.

This patch fixes the issue by making use of the HCI_INIT flag which is
set during the initialization procedure. The hci_req_comple function
will no longer do anything when this flag is set and a new
hci_init_complete function is added which ignores the flag and gets
called when the last hci_init_req HCI command completes.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   14 ++++++++++++++
 net/bluetooth/hci_event.c        |   14 ++++++++++++++
 3 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3786ee8..1f421df 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -694,5 +694,6 @@ struct hci_sec_filter {
 #define hci_req_unlock(d)	mutex_unlock(&d->req_lock)
 
 void hci_req_complete(struct hci_dev *hdev, int result);
+void hci_init_complete(struct hci_dev *hdev, int result);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6374054..8d08538 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -91,10 +91,24 @@ static void hci_notify(struct hci_dev *hdev, int event)
 
 /* ---- HCI requests ---- */
 
+void hci_init_complete(struct hci_dev *hdev, int result)
+{
+	BT_DBG("%s result 0x%2.2x", hdev->name, result);
+
+	if (hdev->req_status == HCI_REQ_PEND) {
+		hdev->req_result = result;
+		hdev->req_status = HCI_REQ_DONE;
+		wake_up_interruptible(&hdev->req_wait_q);
+	}
+}
+
 void hci_req_complete(struct hci_dev *hdev, int result)
 {
 	BT_DBG("%s result 0x%2.2x", hdev->name, result);
 
+	if (test_bit(HCI_INIT, &hdev->flags))
+		return;
+
 	if (hdev->req_status == HCI_REQ_PEND) {
 		hdev->req_result = result;
 		hdev->req_status = HCI_REQ_DONE;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8923b36..939ba9f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -539,6 +539,16 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete(hdev, rp->status);
 }
 
+static void hci_cc_write_ca_timeout(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%x", hdev->name, status);
+
+	if (test_bit(HCI_INIT, &hdev->flags))
+		hci_init_complete(hdev, status);
+}
+
 static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%x", hdev->name, status);
@@ -1379,6 +1389,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_read_bd_addr(hdev, skb);
 		break;
 
+	case HCI_OP_WRITE_CA_TIMEOUT:
+		hci_cc_write_ca_timeout(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		break;
-- 
1.7.2.3

