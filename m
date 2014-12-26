Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Introduce HCI_QUIRK_BROKEN_LOCAL_COMMANDS constant
Date: Fri, 26 Dec 2014 04:42:31 +0100
Message-Id: <1419565354-49553-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some controllers advertise support for Bluetooth 1.2 specification,
but they do not support the HCI Read Local Supported Commands command.

If that is the case, then the driver can quirk the behavior and force
the core to skip this command. This will allow removing vendor specific
checks out of the core.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index f39926ee06f7..1849a437f6e1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -102,6 +102,16 @@ enum {
 	 */
 	HCI_QUIRK_FIXUP_BUFFER_SIZE,
 
+	/* When this quirk is set, then the HCI Read Local Supported
+	 * Commands command is not supported. In general Bluetooth 1.2
+	 * and later controllers should support this command. However
+	 * some controllers indicate Bluetooth 1.2 support, but do
+	 * not support this command.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_BROKEN_LOCAL_COMMANDS,
+
 	/* When this quirk is set, then no stored link key handling
 	 * is performed. This is mainly due to the fact that the
 	 * HCI Delete Stored Link Key command is advertised, but
-- 
2.1.0

