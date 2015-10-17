Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: Add new quirk for non-persistent diagnostic settings
Date: Sat, 17 Oct 2015 16:00:26 +0200
Message-Id: <1445090428-75287-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the diagnostic settings are not persistent over HCI Reset, then this
quirk can be used to tell the Bluetoth core about it. This will ensure
that the settings are programmed correctly when the controller is
powered up.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  9 +++++++++
 net/bluetooth/hci_core.c    | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index a26ff28ca878..b59971c5cb71 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -170,6 +170,15 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
+
+	/* When this quirk is set, the enabling of diagnostic mode is
+	 * not persistent over HCI Reset. Every time the controller
+	 * is brought up it needs to be reprogrammed.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_NON_PERSISTENT_DIAG,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b36a2e5693d2..f33268004195 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -162,6 +162,16 @@ static ssize_t vendor_diag_write(struct file *file, const char __user *user_buf,
 	if (strtobool(buf, &enable))
 		return -EINVAL;
 
+	/* When the diagnostic flags are not persistent and the transport
+	 * is not active, then there is no need for the vendor callback.
+	 *
+	 * Instead just store the desired value. If needed the setting
+	 * will be programmed when the controller gets powered on.
+	 */
+	if (test_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks) &&
+	    !test_bit(HCI_RUNNING, &hdev->flags))
+		goto done;
+
 	hci_req_lock(hdev);
 	err = hdev->set_diag(hdev, enable);
 	hci_req_unlock(hdev);
@@ -169,6 +179,7 @@ static ssize_t vendor_diag_write(struct file *file, const char __user *user_buf,
 	if (err < 0)
 		return err;
 
+done:
 	if (enable)
 		hci_dev_set_flag(hdev, HCI_VENDOR_DIAG);
 	else
@@ -1494,6 +1505,14 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 			ret = __hci_init(hdev);
 	}
 
+	/* If the HCI Reset command is clearing all diagnostic settings,
+	 * then they need to be reprogrammed after the init procedure
+	 * completed.
+	 */
+	if (test_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks) &&
+	    hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) && hdev->set_diag)
+		ret = hdev->set_diag(hdev, true);
+
 	clear_bit(HCI_INIT, &hdev->flags);
 
 	if (!ret) {
-- 
2.4.3

