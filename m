Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Introduce HCI_QUIRK_STRICT_DUPLICATE_FILTER
Date: Sun,  2 Nov 2014 20:52:23 +0100
Message-Id: <1414957944-22818-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some vendors decide to use a struct duplicate filter policy that only
filters on Bluetooth device addresses. This means that when the RSSI
changes, these devices are not reported again. During discovery it is
useful to actually get the RSSI updates.

Since this is specific to each controller, add a new quirk setting
that allows drivers to tell the core what kind of filtering policy
the controller uses.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ecfa306e1375..2e08f5a89463 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -129,6 +129,15 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_INVALID_BDADDR,
+
+	/* When this quirk is set, the duplicate filtering during
+	 * scanning is based on Bluetooth devices addresses. To allow
+	 * RSSI based updates, restart scanning if needed.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_STRICT_DUPLICATE_FILTER,
 };
 
 /* HCI device flags */
-- 
1.9.3

