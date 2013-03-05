Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 01/11] Bluetooth: Rename hci_request to hci_req_sync
Date: Tue,  5 Mar 2013 20:37:41 +0200
Message-Id: <1362508671-6460-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1362508671-6460-1-git-send-email-johan.hedberg@gmail.com>
References: <1362508671-6460-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We'll be introducing an async version of hci_request. To make things
clear it makes sense to rename the existing API to have a _sync suffix.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |   49 +++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index aeb2b26..cdece72 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -107,9 +107,9 @@ static void hci_req_cancel(struct hci_dev *hdev, int err)
 }
 
 /* Execute request and wait for completion. */
-static int __hci_request(struct hci_dev *hdev,
-			 void (*req)(struct hci_dev *hdev, unsigned long opt),
-			 unsigned long opt, __u32 timeout)
+static int __hci_req_sync(struct hci_dev *hdev,
+			  void (*req)(struct hci_dev *hdev, unsigned long opt),
+			  unsigned long opt, __u32 timeout)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int err = 0;
@@ -150,9 +150,9 @@ static int __hci_request(struct hci_dev *hdev,
 	return err;
 }
 
-static int hci_request(struct hci_dev *hdev,
-		       void (*req)(struct hci_dev *hdev, unsigned long opt),
-		       unsigned long opt, __u32 timeout)
+static int hci_req_sync(struct hci_dev *hdev,
+			void (*req)(struct hci_dev *hdev, unsigned long opt),
+			unsigned long opt, __u32 timeout)
 {
 	int ret;
 
@@ -161,7 +161,7 @@ static int hci_request(struct hci_dev *hdev,
 
 	/* Serialize all requests */
 	hci_req_lock(hdev);
-	ret = __hci_request(hdev, req, opt, timeout);
+	ret = __hci_req_sync(hdev, req, opt, timeout);
 	hci_req_unlock(hdev);
 
 	return ret;
@@ -556,7 +556,8 @@ int hci_inquiry(void __user *arg)
 	timeo = ir.length * msecs_to_jiffies(2000);
 
 	if (do_inquiry) {
-		err = hci_request(hdev, hci_inq_req, (unsigned long)&ir, timeo);
+		err = hci_req_sync(hdev, hci_inq_req, (unsigned long) &ir,
+				   timeo);
 		if (err < 0)
 			goto done;
 	}
@@ -737,7 +738,7 @@ int hci_dev_open(__u16 dev)
 		set_bit(HCI_INIT, &hdev->flags);
 		hdev->init_last_cmd = 0;
 
-		ret = __hci_request(hdev, hci_init_req, 0, HCI_INIT_TIMEOUT);
+		ret = __hci_req_sync(hdev, hci_init_req, 0, HCI_INIT_TIMEOUT);
 
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
@@ -828,7 +829,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	if (!test_bit(HCI_RAW, &hdev->flags) &&
 	    test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks)) {
 		set_bit(HCI_INIT, &hdev->flags);
-		__hci_request(hdev, hci_reset_req, 0, HCI_CMD_TIMEOUT);
+		__hci_req_sync(hdev, hci_reset_req, 0, HCI_CMD_TIMEOUT);
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
 
@@ -921,7 +922,7 @@ int hci_dev_reset(__u16 dev)
 	hdev->acl_cnt = 0; hdev->sco_cnt = 0; hdev->le_cnt = 0;
 
 	if (!test_bit(HCI_RAW, &hdev->flags))
-		ret = __hci_request(hdev, hci_reset_req, 0, HCI_INIT_TIMEOUT);
+		ret = __hci_req_sync(hdev, hci_reset_req, 0, HCI_INIT_TIMEOUT);
 
 done:
 	hci_req_unlock(hdev);
@@ -960,8 +961,8 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 
 	switch (cmd) {
 	case HCISETAUTH:
-		err = hci_request(hdev, hci_auth_req, dr.dev_opt,
-				  HCI_INIT_TIMEOUT);
+		err = hci_req_sync(hdev, hci_auth_req, dr.dev_opt,
+				   HCI_INIT_TIMEOUT);
 		break;
 
 	case HCISETENCRYPT:
@@ -972,24 +973,24 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 
 		if (!test_bit(HCI_AUTH, &hdev->flags)) {
 			/* Auth must be enabled first */
-			err = hci_request(hdev, hci_auth_req, dr.dev_opt,
-					  HCI_INIT_TIMEOUT);
+			err = hci_req_sync(hdev, hci_auth_req, dr.dev_opt,
+					   HCI_INIT_TIMEOUT);
 			if (err)
 				break;
 		}
 
-		err = hci_request(hdev, hci_encrypt_req, dr.dev_opt,
-				  HCI_INIT_TIMEOUT);
+		err = hci_req_sync(hdev, hci_encrypt_req, dr.dev_opt,
+				   HCI_INIT_TIMEOUT);
 		break;
 
 	case HCISETSCAN:
-		err = hci_request(hdev, hci_scan_req, dr.dev_opt,
-				  HCI_INIT_TIMEOUT);
+		err = hci_req_sync(hdev, hci_scan_req, dr.dev_opt,
+				   HCI_INIT_TIMEOUT);
 		break;
 
 	case HCISETLINKPOL:
-		err = hci_request(hdev, hci_linkpol_req, dr.dev_opt,
-				  HCI_INIT_TIMEOUT);
+		err = hci_req_sync(hdev, hci_linkpol_req, dr.dev_opt,
+				   HCI_INIT_TIMEOUT);
 		break;
 
 	case HCISETLINKMODE:
@@ -1608,10 +1609,10 @@ static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
 
 	hci_req_lock(hdev);
 
-	err = __hci_request(hdev, le_scan_param_req, (unsigned long) &param,
-			    timeo);
+	err = __hci_req_sync(hdev, le_scan_param_req, (unsigned long) &param,
+			     timeo);
 	if (!err)
-		err = __hci_request(hdev, le_scan_enable_req, 0, timeo);
+		err = __hci_req_sync(hdev, le_scan_enable_req, 0, timeo);
 
 	hci_req_unlock(hdev);
 
-- 
1.7.10.4

