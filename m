Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Introduce HCI_QUIRK_FIXUP_INQUIRY_MODE option
Date: Fri,  2 Jan 2015 23:35:19 -0800
Message-Id: <1420270520-32581-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HCI_QUIRK_FIXUP_INQUIRY_MODE option allows to force Inquiry Result
with RSSI setting on controllers that do not indicate support for it,
but where it is known to be fully functional.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 12 ++++++++++++
 net/bluetooth/hci_core.c    |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index aee16bf5d34f..d0bca316b43b 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -102,6 +102,18 @@ enum {
 	 */
 	HCI_QUIRK_FIXUP_BUFFER_SIZE,
 
+	/* When this quirk is set, then a controller that does not
+	 * indicate support for Inquiry Result with RSSI is assumed to
+	 * support it anyway. Some early Bluetooth 1.2 controllers had
+	 * wrongly configured local features that will require forcing
+	 * them to enable this mode. Getting RSSI information with the
+	 * inquiry responses is preferred since it allows for a better
+	 * user expierence.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_FIXUP_INQUIRY_MODE,
+
 	/* When this quirk is set, then the HCI Read Local Supported
 	 * Commands command is not supported. In general Bluetooth 1.2
 	 * and later controllers should support this command. However
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ebac859e1258..bc5486ea5411 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -621,7 +621,8 @@ static void hci_init2_req(struct hci_request *req, unsigned long opt)
 		}
 	}
 
-	if (lmp_inq_rssi_capable(hdev)) {
+	if (lmp_inq_rssi_capable(hdev) ||
+	    test_bit(HCI_QUIRK_FIXUP_INQUIRY_MODE, &hdev->quirks)) {
 		u8 mode;
 
 		/* If Extended Inquiry Result events are supported, then
-- 
2.1.0

