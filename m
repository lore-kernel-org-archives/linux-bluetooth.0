Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: Fix __hci_request synchronization for hci_open_dev
Date: Thu, 16 Dec 2010 19:16:44 +0200
Message-Id: <1292519804-23286-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

The initialization function used by hci_open_dev (hci_init_req) sends
many different HCI commands. The __hci_request function should only
return when all of these commands have completed (or a timeout occurs).
Several of these commands cause hci_req_complete to be called which
causes __hci_request to return prematurely.

This patch fixes the issue by adding a new hdev->req_last_cmd variable
which is set during the initialization procedure. The hci_req_complete
function will no longer mark the request as complete until the command
matching hdev->req_last_cmd completes.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
v3: This version makes the last command of the request completely
generic so that __hci_request can be used for other multi-HCI command
purposes besides the init sequence (something that will be needed in the
future). The need for the HCI_CLOSE flag also goes away with this patch
so the original patch for that can be ignored.

 include/net/bluetooth/hci_core.h |    3 ++-
 net/bluetooth/hci_core.c         |   10 +++++++---
 net/bluetooth/hci_event.c        |   33 +++++++++++++++++++++++----------
 3 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3786ee8..aad10e2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -129,6 +129,7 @@ struct hci_dev {
 	wait_queue_head_t	req_wait_q;
 	__u32			req_status;
 	__u32			req_result;
+	int			req_last_cmd;
 
 	struct inquiry_cache	inq_cache;
 	struct hci_conn_hash	conn_hash;
@@ -693,6 +694,6 @@ struct hci_sec_filter {
 #define hci_req_lock(d)		mutex_lock(&d->req_lock)
 #define hci_req_unlock(d)	mutex_unlock(&d->req_lock)
 
-void hci_req_complete(struct hci_dev *hdev, int result);
+void hci_req_complete(struct hci_dev *hdev, int cmd, int result);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1a4ec97..f60e68b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -91,9 +91,12 @@ static void hci_notify(struct hci_dev *hdev, int event)
 
 /* ---- HCI requests ---- */
 
-void hci_req_complete(struct hci_dev *hdev, int result)
+void hci_req_complete(struct hci_dev *hdev, int cmd, int result)
 {
-	BT_DBG("%s result 0x%2.2x", hdev->name, result);
+	BT_DBG("%s command %d result 0x%2.2x", hdev->name, cmd, result);
+
+	if (hdev->req_last_cmd && cmd != hdev->req_last_cmd)
+		return;
 
 	if (hdev->req_status == HCI_REQ_PEND) {
 		hdev->req_result = result;
@@ -149,7 +152,7 @@ static int __hci_request(struct hci_dev *hdev, void (*req)(struct hci_dev *hdev,
 		break;
 	}
 
-	hdev->req_status = hdev->req_result = 0;
+	hdev->req_last_cmd = hdev->req_status = hdev->req_result = 0;
 
 	BT_DBG("%s end: err %d", hdev->name, err);
 
@@ -252,6 +255,7 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 	/* Connection accept timeout ~20 secs */
 	param = cpu_to_le16(0x7d00);
 	hci_send_cmd(hdev, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
+	hdev->req_last_cmd = HCI_OP_WRITE_CA_TIMEOUT;
 }
 
 static void hci_scan_req(struct hci_dev *hdev, unsigned long opt)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8923b36..3810017 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -58,7 +58,7 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 
 	clear_bit(HCI_INQUIRY, &hdev->flags);
 
-	hci_req_complete(hdev, status);
+	hci_req_complete(hdev, HCI_OP_INQUIRY_CANCEL, status);
 
 	hci_conn_check_pending(hdev);
 }
@@ -174,7 +174,7 @@ static void hci_cc_write_def_link_policy(struct hci_dev *hdev, struct sk_buff *s
 	if (!status)
 		hdev->link_policy = get_unaligned_le16(sent);
 
-	hci_req_complete(hdev, status);
+	hci_req_complete(hdev, HCI_OP_WRITE_DEF_LINK_POLICY, status);
 }
 
 static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
@@ -183,7 +183,7 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
-	hci_req_complete(hdev, status);
+	hci_req_complete(hdev, HCI_OP_RESET, status);
 }
 
 static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
@@ -235,7 +235,7 @@ static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
 			clear_bit(HCI_AUTH, &hdev->flags);
 	}
 
-	hci_req_complete(hdev, status);
+	hci_req_complete(hdev, HCI_OP_WRITE_AUTH_ENABLE, status);
 }
 
 static void hci_cc_write_encrypt_mode(struct hci_dev *hdev, struct sk_buff *skb)
@@ -258,7 +258,7 @@ static void hci_cc_write_encrypt_mode(struct hci_dev *hdev, struct sk_buff *skb)
 			clear_bit(HCI_ENCRYPT, &hdev->flags);
 	}
 
-	hci_req_complete(hdev, status);
+	hci_req_complete(hdev, HCI_OP_WRITE_ENCRYPT_MODE, status);
 }
 
 static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
@@ -285,7 +285,7 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 			set_bit(HCI_PSCAN, &hdev->flags);
 	}
 
-	hci_req_complete(hdev, status);
+	hci_req_complete(hdev, HCI_OP_WRITE_SCAN_ENABLE, status);
 }
 
 static void hci_cc_read_class_of_dev(struct hci_dev *hdev, struct sk_buff *skb)
@@ -383,7 +383,7 @@ static void hci_cc_host_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
-	hci_req_complete(hdev, status);
+	hci_req_complete(hdev, HCI_OP_HOST_BUFFER_SIZE, status);
 }
 
 static void hci_cc_read_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
@@ -536,7 +536,16 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!rp->status)
 		bacpy(&hdev->bdaddr, &rp->bdaddr);
 
-	hci_req_complete(hdev, rp->status);
+	hci_req_complete(hdev, HCI_OP_READ_BD_ADDR, rp->status);
+}
+
+static void hci_cc_write_ca_timeout(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%x", hdev->name, status);
+
+	hci_req_complete(hdev, HCI_OP_WRITE_CA_TIMEOUT, status);
 }
 
 static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
@@ -544,7 +553,7 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
 	if (status) {
-		hci_req_complete(hdev, status);
+		hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 
 		hci_conn_check_pending(hdev);
 	} else
@@ -871,7 +880,7 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 
 	clear_bit(HCI_INQUIRY, &hdev->flags);
 
-	hci_req_complete(hdev, status);
+	hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 
 	hci_conn_check_pending(hdev);
 }
@@ -1379,6 +1388,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
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

