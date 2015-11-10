Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/12] Bluetooth: Add HCI status return parameter to hci_req_sync()
Date: Tue, 10 Nov 2015 20:14:26 +0200
Message-Id: <1447179274-12276-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1447179274-12276-1-git-send-email-johan.hedberg@gmail.com>
References: <1447179274-12276-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In some cases it may be important to get the exact HCI status rather
than the converted HCI-to-errno value. Add an optional return
parameter to the hci_req_sync() API to allow for this. Since there are
no good HCI translation candidates for cancelation and timeout, use
the "unknown" status code for those cases.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |  3 ++-
 net/bluetooth/hci_core.c    | 26 +++++++++++++-------------
 net/bluetooth/hci_request.c | 12 +++++++++---
 net/bluetooth/hci_request.h |  4 ++--
 4 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0205b80cc90b..cc2216727655 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -452,7 +452,8 @@ enum {
 #define HCI_ERROR_REMOTE_POWER_OFF	0x15
 #define HCI_ERROR_LOCAL_HOST_TERM	0x16
 #define HCI_ERROR_PAIRING_NOT_ALLOWED	0x18
-#define HCI_ERROR_INVALID_LL_PARAMS	0x1E
+#define HCI_ERROR_INVALID_LL_PARAMS	0x1e
+#define HCI_ERROR_UNSPECIFIED		0x1f
 #define HCI_ERROR_ADVERTISING_TIMEOUT	0x3c
 
 /* Flow control modes */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 955b907f7ed8..9c7e4b8e56ae 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -763,14 +763,14 @@ static int __hci_init(struct hci_dev *hdev)
 {
 	int err;
 
-	err = __hci_req_sync(hdev, hci_init1_req, 0, HCI_INIT_TIMEOUT);
+	err = __hci_req_sync(hdev, hci_init1_req, 0, HCI_INIT_TIMEOUT, NULL);
 	if (err < 0)
 		return err;
 
 	if (hci_dev_test_flag(hdev, HCI_SETUP))
 		hci_debugfs_create_basic(hdev);
 
-	err = __hci_req_sync(hdev, hci_init2_req, 0, HCI_INIT_TIMEOUT);
+	err = __hci_req_sync(hdev, hci_init2_req, 0, HCI_INIT_TIMEOUT, NULL);
 	if (err < 0)
 		return err;
 
@@ -781,11 +781,11 @@ static int __hci_init(struct hci_dev *hdev)
 	if (hdev->dev_type != HCI_BREDR)
 		return 0;
 
-	err = __hci_req_sync(hdev, hci_init3_req, 0, HCI_INIT_TIMEOUT);
+	err = __hci_req_sync(hdev, hci_init3_req, 0, HCI_INIT_TIMEOUT, NULL);
 	if (err < 0)
 		return err;
 
-	err = __hci_req_sync(hdev, hci_init4_req, 0, HCI_INIT_TIMEOUT);
+	err = __hci_req_sync(hdev, hci_init4_req, 0, HCI_INIT_TIMEOUT, NULL);
 	if (err < 0)
 		return err;
 
@@ -841,7 +841,7 @@ static int __hci_unconf_init(struct hci_dev *hdev)
 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
 		return 0;
 
-	err = __hci_req_sync(hdev, hci_init0_req, 0, HCI_INIT_TIMEOUT);
+	err = __hci_req_sync(hdev, hci_init0_req, 0, HCI_INIT_TIMEOUT, NULL);
 	if (err < 0)
 		return err;
 
@@ -1199,7 +1199,7 @@ int hci_inquiry(void __user *arg)
 
 	if (do_inquiry) {
 		err = hci_req_sync(hdev, hci_inq_req, (unsigned long) &ir,
-				   timeo);
+				   timeo, NULL);
 		if (err < 0)
 			goto done;
 
@@ -1565,7 +1565,7 @@ int hci_dev_do_close(struct hci_dev *hdev)
 	if (test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks) &&
 	    !auto_off && !hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
 		set_bit(HCI_INIT, &hdev->flags);
-		__hci_req_sync(hdev, hci_reset_req, 0, HCI_CMD_TIMEOUT);
+		__hci_req_sync(hdev, hci_reset_req, 0, HCI_CMD_TIMEOUT, NULL);
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
 
@@ -1662,7 +1662,7 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
 	atomic_set(&hdev->cmd_cnt, 1);
 	hdev->acl_cnt = 0; hdev->sco_cnt = 0; hdev->le_cnt = 0;
 
-	ret = __hci_req_sync(hdev, hci_reset_req, 0, HCI_INIT_TIMEOUT);
+	ret = __hci_req_sync(hdev, hci_reset_req, 0, HCI_INIT_TIMEOUT, NULL);
 
 	hci_req_sync_unlock(hdev);
 	return ret;
@@ -1797,7 +1797,7 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 	switch (cmd) {
 	case HCISETAUTH:
 		err = hci_req_sync(hdev, hci_auth_req, dr.dev_opt,
-				   HCI_INIT_TIMEOUT);
+				   HCI_INIT_TIMEOUT, NULL);
 		break;
 
 	case HCISETENCRYPT:
@@ -1809,18 +1809,18 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 		if (!test_bit(HCI_AUTH, &hdev->flags)) {
 			/* Auth must be enabled first */
 			err = hci_req_sync(hdev, hci_auth_req, dr.dev_opt,
-					   HCI_INIT_TIMEOUT);
+					   HCI_INIT_TIMEOUT, NULL);
 			if (err)
 				break;
 		}
 
 		err = hci_req_sync(hdev, hci_encrypt_req, dr.dev_opt,
-				   HCI_INIT_TIMEOUT);
+				   HCI_INIT_TIMEOUT, NULL);
 		break;
 
 	case HCISETSCAN:
 		err = hci_req_sync(hdev, hci_scan_req, dr.dev_opt,
-				   HCI_INIT_TIMEOUT);
+				   HCI_INIT_TIMEOUT, NULL);
 
 		/* Ensure that the connectable and discoverable states
 		 * get correctly modified as this was a non-mgmt change.
@@ -1831,7 +1831,7 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 
 	case HCISETLINKPOL:
 		err = hci_req_sync(hdev, hci_linkpol_req, dr.dev_opt,
-				   HCI_INIT_TIMEOUT);
+				   HCI_INIT_TIMEOUT, NULL);
 		break;
 
 	case HCISETLINKMODE:
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 842f64cd8800..3439b791c583 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -186,7 +186,7 @@ EXPORT_SYMBOL(__hci_cmd_sync);
 /* Execute request and wait for completion. */
 int __hci_req_sync(struct hci_dev *hdev, void (*func)(struct hci_request *req,
 						      unsigned long opt),
-		   unsigned long opt, __u32 timeout)
+		   unsigned long opt, u32 timeout, u8 *hci_status)
 {
 	struct hci_request req;
 	DECLARE_WAITQUEUE(wait, current);
@@ -231,14 +231,20 @@ int __hci_req_sync(struct hci_dev *hdev, void (*func)(struct hci_request *req,
 	switch (hdev->req_status) {
 	case HCI_REQ_DONE:
 		err = -bt_to_errno(hdev->req_result);
+		if (hci_status)
+			*hci_status = hdev->req_result;
 		break;
 
 	case HCI_REQ_CANCELED:
 		err = -hdev->req_result;
+		if (hci_status)
+			*hci_status = HCI_ERROR_UNSPECIFIED;
 		break;
 
 	default:
 		err = -ETIMEDOUT;
+		if (hci_status)
+			*hci_status = HCI_ERROR_UNSPECIFIED;
 		break;
 	}
 
@@ -251,7 +257,7 @@ int __hci_req_sync(struct hci_dev *hdev, void (*func)(struct hci_request *req,
 
 int hci_req_sync(struct hci_dev *hdev, void (*req)(struct hci_request *req,
 						   unsigned long opt),
-		 unsigned long opt, __u32 timeout)
+		 unsigned long opt, u32 timeout, u8 *hci_status)
 {
 	int ret;
 
@@ -260,7 +266,7 @@ int hci_req_sync(struct hci_dev *hdev, void (*req)(struct hci_request *req,
 
 	/* Serialize all requests */
 	hci_req_sync_lock(hdev);
-	ret = __hci_req_sync(hdev, req, opt, timeout);
+	ret = __hci_req_sync(hdev, req, opt, timeout, hci_status);
 	hci_req_sync_unlock(hdev);
 
 	return ret;
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 6adf91e793de..8833617f68ba 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -46,10 +46,10 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status,
 
 int hci_req_sync(struct hci_dev *hdev, void (*req)(struct hci_request *req,
 						   unsigned long opt),
-		 unsigned long opt, __u32 timeout);
+		 unsigned long opt, u32 timeout, u8 *hci_status);
 int __hci_req_sync(struct hci_dev *hdev, void (*func)(struct hci_request *req,
 						      unsigned long opt),
-		   unsigned long opt, __u32 timeout);
+		   unsigned long opt, u32 timeout, u8 *hci_status);
 void hci_req_sync_cancel(struct hci_dev *hdev, int err);
 
 struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
-- 
2.5.0

