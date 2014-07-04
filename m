Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Document the existing device quirks
Date: Fri,  4 Jul 2014 16:08:02 +0200
Message-Id: <1404482882-46787-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The current existing device quirks are not documented. So instead of
spreading bits and pieces somewhere in the code, add proper comments
on where these quirks can be used and what behavior they change.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 606a9b1466a3..744713cd5335 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -81,9 +81,34 @@
 
 /* HCI device quirks */
 enum {
+	/* When this quirk is set, the HCI Reset command is send when
+	 * closing the transport instead of when opening it.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
 	HCI_QUIRK_RESET_ON_CLOSE,
+
+	/* When this quirk is set, the device is turned into a raw-only
+	 * device and it will stay in unconfigured state.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
 	HCI_QUIRK_RAW_DEVICE,
+
+	/* When this quirk is set, the buffer sizes reported by
+	 * HCI Read Buffer Size command are corrected if invalid.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
 	HCI_QUIRK_FIXUP_BUFFER_SIZE,
+
+	/* When this quirk is set, then no stored link key handling
+	 * is performed. This is mainly due to the fact that the
+	 * HCI Delete Stored Link Key command is advertised, but
+	 * not supported.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
 	HCI_QUIRK_BROKEN_STORED_LINK_KEY,
 };
 
-- 
1.9.3

