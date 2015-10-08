Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix basic debugfs entries for unconfigured controllers
Date: Thu,  8 Oct 2015 12:35:42 +0200
Message-Id: <1444300542-96764-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the controller is unconfigured (for example it does not have a
valid Bluetooth address), then the basic debugfs entries for dut_mode
and vendor_diag are not creates. Ensure they are created in __hci_init
and also __hci_unconf_init functions. One of them is called during setup
stage of a new controller.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b2095ca8472e..d2b3dd32d6cf 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -184,6 +184,16 @@ static const struct file_operations vendor_diag_fops = {
 	.llseek		= default_llseek,
 };
 
+static void hci_debugfs_create_basic(struct hci_dev *hdev)
+{
+	debugfs_create_file("dut_mode", 0644, hdev->debugfs, hdev,
+			    &dut_mode_fops);
+
+	if (hdev->set_diag)
+		debugfs_create_file("vendor_diag", 0644, hdev->debugfs, hdev,
+				    &vendor_diag_fops);
+}
+
 /* ---- HCI requests ---- */
 
 static void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
@@ -900,20 +910,8 @@ static int __hci_init(struct hci_dev *hdev)
 	if (err < 0)
 		return err;
 
-	if (hci_dev_test_flag(hdev, HCI_SETUP)) {
-		/* The Device Under Test (DUT) mode is special and available
-		 * for all controller types. So just create it early on.
-		 */
-		debugfs_create_file("dut_mode", 0644, hdev->debugfs, hdev,
-				    &dut_mode_fops);
-
-		/* When the driver supports the set_diag callback, then
-		 * expose an entry to modify the vendor diagnostic setting.
-		 */
-		if (hdev->set_diag)
-			debugfs_create_file("vendor_diag", 0644, hdev->debugfs,
-					    hdev, &vendor_diag_fops);
-	}
+	if (hci_dev_test_flag(hdev, HCI_SETUP))
+		hci_debugfs_create_basic(hdev);
 
 	err = __hci_req_sync(hdev, hci_init2_req, 0, HCI_INIT_TIMEOUT);
 	if (err < 0)
@@ -990,6 +988,9 @@ static int __hci_unconf_init(struct hci_dev *hdev)
 	if (err < 0)
 		return err;
 
+	if (hci_dev_test_flag(hdev, HCI_SETUP))
+		hci_debugfs_create_basic(hdev);
+
 	return 0;
 }
 
-- 
2.4.3

