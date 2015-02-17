Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix AMP init for certain AMP controllers
Date: Tue, 17 Feb 2015 15:05:21 +0200
Message-Id: <1424178321-13480-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Some AMP controllers do not support the Read Local Features HCI commands
(even though according to the spec they should). Luckily they at least
correctly omit this from the supported commands bitmask, so we can work
around the issue by creating a second AMP init phase and issuing the HCI
command conditionally there.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4135a4406aed..980260846d25 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -390,7 +390,7 @@ static void bredr_init(struct hci_request *req)
 	hci_req_add(req, HCI_OP_READ_BD_ADDR, 0, NULL);
 }
 
-static void amp_init(struct hci_request *req)
+static void amp_init1(struct hci_request *req)
 {
 	req->hdev->flow_ctl_mode = HCI_FLOW_CTL_MODE_BLOCK_BASED;
 
@@ -400,9 +400,6 @@ static void amp_init(struct hci_request *req)
 	/* Read Local Supported Commands */
 	hci_req_add(req, HCI_OP_READ_LOCAL_COMMANDS, 0, NULL);
 
-	/* Read Local Supported Features */
-	hci_req_add(req, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
-
 	/* Read Local AMP Info */
 	hci_req_add(req, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);
 
@@ -416,6 +413,16 @@ static void amp_init(struct hci_request *req)
 	hci_req_add(req, HCI_OP_READ_LOCATION_DATA, 0, NULL);
 }
 
+static void amp_init2(struct hci_request *req)
+{
+	/* Read Local Supported Features. Not all AMP controllers
+	 * support this so it's placed conditionally in the second
+	 * stage init.
+	 */
+	if (req->hdev->commands[14] & 0x20)
+		hci_req_add(req, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
+}
+
 static void hci_init1_req(struct hci_request *req, unsigned long opt)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -432,7 +439,7 @@ static void hci_init1_req(struct hci_request *req, unsigned long opt)
 		break;
 
 	case HCI_AMP:
-		amp_init(req);
+		amp_init1(req);
 		break;
 
 	default:
@@ -578,6 +585,9 @@ static void hci_init2_req(struct hci_request *req, unsigned long opt)
 {
 	struct hci_dev *hdev = req->hdev;
 
+	if (hdev->dev_type == HCI_AMP)
+		return amp_init2(req);
+
 	if (lmp_bredr_capable(hdev))
 		bredr_setup(req);
 	else
@@ -896,17 +906,17 @@ static int __hci_init(struct hci_dev *hdev)
 				    &dut_mode_fops);
 	}
 
+	err = __hci_req_sync(hdev, hci_init2_req, 0, HCI_INIT_TIMEOUT);
+	if (err < 0)
+		return err;
+
 	/* HCI_BREDR covers both single-mode LE, BR/EDR and dual-mode
 	 * BR/EDR/LE type controllers. AMP controllers only need the
-	 * first stage init.
+	 * first two stages of init.
 	 */
 	if (hdev->dev_type != HCI_BREDR)
 		return 0;
 
-	err = __hci_req_sync(hdev, hci_init2_req, 0, HCI_INIT_TIMEOUT);
-	if (err < 0)
-		return err;
-
 	err = __hci_req_sync(hdev, hci_init3_req, 0, HCI_INIT_TIMEOUT);
 	if (err < 0)
 		return err;
-- 
2.1.0

