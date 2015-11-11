Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 10/12] Bluetooth: Add error return value to hci_req_sync callback
Date: Wed, 11 Nov 2015 08:11:25 +0200
Message-Id: <1447222287-4288-11-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1447222287-4288-1-git-send-email-johan.hedberg@gmail.com>
References: <1447222287-4288-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In some circumstances it may be useful to abort the request through
checks done in the request callback. To make the feature possible this
patch changes the return value of the request callback from void to
int and aborts the request if a non-zero value is returned.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c    | 45 ++++++++++++++++++++++++++++++++-------------
 net/bluetooth/hci_request.c | 27 ++++++++++++++++++---------
 net/bluetooth/hci_request.h |  8 ++++----
 3 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 37c1714f9062..bca09e86481f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -189,13 +189,14 @@ static void hci_debugfs_create_basic(struct hci_dev *hdev)
 				    &vendor_diag_fops);
 }
 
-static void hci_reset_req(struct hci_request *req, unsigned long opt)
+static int hci_reset_req(struct hci_request *req, unsigned long opt)
 {
 	BT_DBG("%s %ld", req->hdev->name, opt);
 
 	/* Reset device */
 	set_bit(HCI_RESET, &req->hdev->flags);
 	hci_req_add(req, HCI_OP_RESET, 0, NULL);
+	return 0;
 }
 
 static void bredr_init(struct hci_request *req)
@@ -235,7 +236,7 @@ static void amp_init1(struct hci_request *req)
 	hci_req_add(req, HCI_OP_READ_LOCATION_DATA, 0, NULL);
 }
 
-static void amp_init2(struct hci_request *req)
+static int amp_init2(struct hci_request *req)
 {
 	/* Read Local Supported Features. Not all AMP controllers
 	 * support this so it's placed conditionally in the second
@@ -243,9 +244,11 @@ static void amp_init2(struct hci_request *req)
 	 */
 	if (req->hdev->commands[14] & 0x20)
 		hci_req_add(req, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
+
+	return 0;
 }
 
-static void hci_init1_req(struct hci_request *req, unsigned long opt)
+static int hci_init1_req(struct hci_request *req, unsigned long opt)
 {
 	struct hci_dev *hdev = req->hdev;
 
@@ -268,6 +271,8 @@ static void hci_init1_req(struct hci_request *req, unsigned long opt)
 		BT_ERR("Unknown device type %d", hdev->dev_type);
 		break;
 	}
+
+	return 0;
 }
 
 static void bredr_setup(struct hci_request *req)
@@ -422,7 +427,7 @@ static void hci_setup_event_mask(struct hci_request *req)
 	hci_req_add(req, HCI_OP_SET_EVENT_MASK, sizeof(events), events);
 }
 
-static void hci_init2_req(struct hci_request *req, unsigned long opt)
+static int hci_init2_req(struct hci_request *req, unsigned long opt)
 {
 	struct hci_dev *hdev = req->hdev;
 
@@ -502,6 +507,8 @@ static void hci_init2_req(struct hci_request *req, unsigned long opt)
 		hci_req_add(req, HCI_OP_WRITE_AUTH_ENABLE, sizeof(enable),
 			    &enable);
 	}
+
+	return 0;
 }
 
 static void hci_setup_link_policy(struct hci_request *req)
@@ -576,7 +583,7 @@ static void hci_set_event_mask_page_2(struct hci_request *req)
 	hci_req_add(req, HCI_OP_SET_EVENT_MASK_PAGE_2, sizeof(events), events);
 }
 
-static void hci_init3_req(struct hci_request *req, unsigned long opt)
+static int hci_init3_req(struct hci_request *req, unsigned long opt)
 {
 	struct hci_dev *hdev = req->hdev;
 	u8 p;
@@ -704,9 +711,11 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 		hci_req_add(req, HCI_OP_READ_LOCAL_EXT_FEATURES,
 			    sizeof(cp), &cp);
 	}
+
+	return 0;
 }
 
-static void hci_init4_req(struct hci_request *req, unsigned long opt)
+static int hci_init4_req(struct hci_request *req, unsigned long opt)
 {
 	struct hci_dev *hdev = req->hdev;
 
@@ -757,6 +766,8 @@ static void hci_init4_req(struct hci_request *req, unsigned long opt)
 		hci_req_add(req, HCI_OP_WRITE_SC_SUPPORT,
 			    sizeof(support), &support);
 	}
+
+	return 0;
 }
 
 static int __hci_init(struct hci_dev *hdev)
@@ -816,7 +827,7 @@ static int __hci_init(struct hci_dev *hdev)
 	return 0;
 }
 
-static void hci_init0_req(struct hci_request *req, unsigned long opt)
+static int hci_init0_req(struct hci_request *req, unsigned long opt)
 {
 	struct hci_dev *hdev = req->hdev;
 
@@ -832,6 +843,8 @@ static void hci_init0_req(struct hci_request *req, unsigned long opt)
 	/* Read BD Address */
 	if (hdev->set_bdaddr)
 		hci_req_add(req, HCI_OP_READ_BD_ADDR, 0, NULL);
+
+	return 0;
 }
 
 static int __hci_unconf_init(struct hci_dev *hdev)
@@ -851,7 +864,7 @@ static int __hci_unconf_init(struct hci_dev *hdev)
 	return 0;
 }
 
-static void hci_scan_req(struct hci_request *req, unsigned long opt)
+static int hci_scan_req(struct hci_request *req, unsigned long opt)
 {
 	__u8 scan = opt;
 
@@ -859,9 +872,10 @@ static void hci_scan_req(struct hci_request *req, unsigned long opt)
 
 	/* Inquiry and Page scans */
 	hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+	return 0;
 }
 
-static void hci_auth_req(struct hci_request *req, unsigned long opt)
+static int hci_auth_req(struct hci_request *req, unsigned long opt)
 {
 	__u8 auth = opt;
 
@@ -869,9 +883,10 @@ static void hci_auth_req(struct hci_request *req, unsigned long opt)
 
 	/* Authentication */
 	hci_req_add(req, HCI_OP_WRITE_AUTH_ENABLE, 1, &auth);
+	return 0;
 }
 
-static void hci_encrypt_req(struct hci_request *req, unsigned long opt)
+static int hci_encrypt_req(struct hci_request *req, unsigned long opt)
 {
 	__u8 encrypt = opt;
 
@@ -879,9 +894,10 @@ static void hci_encrypt_req(struct hci_request *req, unsigned long opt)
 
 	/* Encryption */
 	hci_req_add(req, HCI_OP_WRITE_ENCRYPT_MODE, 1, &encrypt);
+	return 0;
 }
 
-static void hci_linkpol_req(struct hci_request *req, unsigned long opt)
+static int hci_linkpol_req(struct hci_request *req, unsigned long opt)
 {
 	__le16 policy = cpu_to_le16(opt);
 
@@ -889,6 +905,7 @@ static void hci_linkpol_req(struct hci_request *req, unsigned long opt)
 
 	/* Default link policy */
 	hci_req_add(req, HCI_OP_WRITE_DEF_LINK_POLICY, 2, &policy);
+	return 0;
 }
 
 /* Get HCI device by index.
@@ -1133,7 +1150,7 @@ static int inquiry_cache_dump(struct hci_dev *hdev, int num, __u8 *buf)
 	return copied;
 }
 
-static void hci_inq_req(struct hci_request *req, unsigned long opt)
+static int hci_inq_req(struct hci_request *req, unsigned long opt)
 {
 	struct hci_inquiry_req *ir = (struct hci_inquiry_req *) opt;
 	struct hci_dev *hdev = req->hdev;
@@ -1142,13 +1159,15 @@ static void hci_inq_req(struct hci_request *req, unsigned long opt)
 	BT_DBG("%s", hdev->name);
 
 	if (test_bit(HCI_INQUIRY, &hdev->flags))
-		return;
+		return 0;
 
 	/* Start Inquiry */
 	memcpy(&cp.lap, &ir->lap, 3);
 	cp.length  = ir->length;
 	cp.num_rsp = ir->num_rsp;
 	hci_req_add(req, HCI_OP_INQUIRY, sizeof(cp), &cp);
+
+	return 0;
 }
 
 int hci_inquiry(void __user *arg)
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 4588fe2bfc0e..ecfa4105e00d 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -184,8 +184,8 @@ struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 EXPORT_SYMBOL(__hci_cmd_sync);
 
 /* Execute request and wait for completion. */
-int __hci_req_sync(struct hci_dev *hdev, void (*func)(struct hci_request *req,
-						      unsigned long opt),
+int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
+						     unsigned long opt),
 		   unsigned long opt, u32 timeout, u8 *hci_status)
 {
 	struct hci_request req;
@@ -198,7 +198,12 @@ int __hci_req_sync(struct hci_dev *hdev, void (*func)(struct hci_request *req,
 
 	hdev->req_status = HCI_REQ_PEND;
 
-	func(&req, opt);
+	err = func(&req, opt);
+	if (err) {
+		if (hci_status)
+			*hci_status = HCI_ERROR_UNSPECIFIED;
+		return err;
+	}
 
 	add_wait_queue(&hdev->req_wait_q, &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -255,8 +260,8 @@ int __hci_req_sync(struct hci_dev *hdev, void (*func)(struct hci_request *req,
 	return err;
 }
 
-int hci_req_sync(struct hci_dev *hdev, void (*req)(struct hci_request *req,
-						   unsigned long opt),
+int hci_req_sync(struct hci_dev *hdev, int (*req)(struct hci_request *req,
+						  unsigned long opt),
 		 unsigned long opt, u32 timeout, u8 *hci_status)
 {
 	int ret;
@@ -830,11 +835,12 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	return 0;
 }
 
-static void update_bg_scan(struct hci_request *req, unsigned long opt)
+static int update_bg_scan(struct hci_request *req, unsigned long opt)
 {
 	hci_dev_lock(req->hdev);
 	__hci_update_background_scan(req);
 	hci_dev_unlock(req->hdev);
+	return 0;
 }
 
 static void bg_scan_update(struct work_struct *work)
@@ -932,9 +938,10 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status)
 	}
 }
 
-static void le_scan_disable(struct hci_request *req, unsigned long opt)
+static int le_scan_disable(struct hci_request *req, unsigned long opt)
 {
 	hci_req_add_le_scan_disable(req);
+	return 0;
 }
 
 static void le_scan_disable_work(struct work_struct *work)
@@ -1000,14 +1007,14 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static void le_scan_restart(struct hci_request *req, unsigned long opt)
+static int le_scan_restart(struct hci_request *req, unsigned long opt)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_le_set_scan_enable cp;
 
 	/* If controller is not scanning we are done. */
 	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
-		return;
+		return 0;
 
 	hci_req_add_le_scan_disable(req);
 
@@ -1015,6 +1022,8 @@ static void le_scan_restart(struct hci_request *req, unsigned long opt)
 	cp.enable = LE_SCAN_ENABLE;
 	cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
 	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+
+	return 0;
 }
 
 static void le_scan_restart_work(struct work_struct *work)
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 1f1194628652..1927013f5e67 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -44,11 +44,11 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status,
 			  hci_req_complete_t *req_complete,
 			  hci_req_complete_skb_t *req_complete_skb);
 
-int hci_req_sync(struct hci_dev *hdev, void (*req)(struct hci_request *req,
-						   unsigned long opt),
+int hci_req_sync(struct hci_dev *hdev, int (*req)(struct hci_request *req,
+						  unsigned long opt),
 		 unsigned long opt, u32 timeout, u8 *hci_status);
-int __hci_req_sync(struct hci_dev *hdev, void (*func)(struct hci_request *req,
-						      unsigned long opt),
+int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
+						     unsigned long opt),
 		   unsigned long opt, u32 timeout, u8 *hci_status);
 void hci_req_sync_cancel(struct hci_dev *hdev, int err);
 
-- 
2.5.0

