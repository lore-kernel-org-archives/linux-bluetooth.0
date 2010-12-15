Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix __hci_request synchronization for hci_open_dev
Date: Wed, 15 Dec 2010 19:33:28 +0200
Message-Id: <1292434408-20793-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

The initialization function used by hci_open_dev (hci_init_req) sends
many different HCI commands. The __hci_request function should only
return when all of these commands have completed (or a timeout occurs).
Several of these commands cause hci_req_complete to be called which
causes __hci_request to return prematurely.

This patch fixes the issue by adding a new hdev->last_init_cmd variable
and making use of the HCI_INIT flag which is set during the
initialization procedure. The hci_req_complete function will no longer
do anything when this flag is set and the completed command wasn't the
last_init_cmd one.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
v2: (based on feedback from Gustavo Padovan) hci_event.c and hci_core.c
are now less dependent on each other regarding this issue. Now the
hci_init_complete call doesn't need to be moved to a new location in
hci_event.c if the sequence of initialization HCI commands changes in
hci_core.c.

 include/net/bluetooth/hci_core.h |    4 +++-
 net/bluetooth/hci_core.c         |    8 ++++++--
 net/bluetooth/hci_event.c        |   33 +++++++++++++++++++++++----------
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3786ee8..23ca4b1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -134,6 +134,8 @@ struct hci_dev {
 	struct hci_conn_hash	conn_hash;
 	struct list_head	blacklist;
 
+	int			last_init_cmd;
+
 	struct hci_dev_stats	stat;
 
 	struct sk_buff_head	driver_init;
@@ -693,6 +695,6 @@ struct hci_sec_filter {
 #define hci_req_lock(d)		mutex_lock(&d->req_lock)
 #define hci_req_unlock(d)	mutex_unlock(&d->req_lock)
 
-void hci_req_complete(struct hci_dev *hdev, int result);
+void hci_req_complete(struct hci_dev *hdev, int cmd, int result);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6374054..e37b839 100644
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
+	if (test_bit(HCI_INIT, &hdev->flags) && cmd != hdev->last_init_cmd)
+		return;
 
 	if (hdev->req_status == HCI_REQ_PEND) {
 		hdev->req_result = result;
@@ -252,6 +255,7 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 	/* Connection accept timeout ~20 secs */
 	param = cpu_to_le16(0x7d00);
 	hci_send_cmd(hdev, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
+	hdev->last_init_cmd = HCI_OP_WRITE_CA_TIMEOUT;
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

