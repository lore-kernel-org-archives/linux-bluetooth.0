Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Skip vendor diagnostic configuration for HCI User Channel
Date: Tue,  2 May 2017 12:43:31 -0700
Message-Id: <20170502194331.9874-1-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the HCI User Channel access is requested, then do not try to
undermine it with vendor diagnostic configuration. The exclusive user
is required to configure its own vendor diagnostic in that case and
can not rely on the host stack support.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 43fecd59dfef..7655b4005dfb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -148,13 +148,13 @@ static ssize_t vendor_diag_write(struct file *file, const char __user *user_buf,
 		return -EINVAL;
 
 	/* When the diagnostic flags are not persistent and the transport
-	 * is not active, then there is no need for the vendor callback.
-	 *
-	 * Instead just store the desired value. If needed the setting
-	 * will be programmed when the controller gets powered on.
+	 * is not active or in user channel operation, then there is no need
+	 * for the vendor callback. Instead just store the desired value and
+	 * the setting will be programmed when the controller gets powered on.
 	 */
 	if (test_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks) &&
-	    !test_bit(HCI_RUNNING, &hdev->flags))
+	    (!test_bit(HCI_RUNNING, &hdev->flags) ||
+	     hci_dev_test_flag(hdev, HCI_USER_CHANNEL)))
 		goto done;
 
 	hci_req_sync_lock(hdev);
@@ -1419,6 +1419,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 	 * completed.
 	 */
 	if (test_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks) &&
+	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
 	    hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) && hdev->set_diag)
 		ret = hdev->set_diag(hdev, true);
 
-- 
2.9.3

