Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Remove dead code for manufacturer inquiry mode quirks
Date: Fri,  2 Jan 2015 23:35:18 -0800
Message-Id: <1420270520-32581-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There are some old Bluetooth modules from Silicon Wave and Broadcom
which support Inquiry Result with RSSI, but do not advertise it. The
core has quirks in the code to enable that inquiry mode. However as
it stands right now, that code is not even executed since entering
the function to determine which inquiry mode requires that the device
has the feature bit for Inquiry Result with RSSI set in the first
place. So this makes this dead code that hasn't work for a long
time.

In conclusion, just remove these extra quirks and simplify the setup
of the inquiry mode to be inline and with that a lot easier to read
and understand.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 50 +++++++++++-------------------------------------
 1 file changed, 11 insertions(+), 39 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6c12110b75a7..ebac859e1258 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -497,43 +497,6 @@ static void le_setup(struct hci_request *req)
 		set_bit(HCI_LE_ENABLED, &hdev->dev_flags);
 }
 
-static u8 hci_get_inquiry_mode(struct hci_dev *hdev)
-{
-	if (lmp_ext_inq_capable(hdev))
-		return 0x02;
-
-	if (lmp_inq_rssi_capable(hdev))
-		return 0x01;
-
-	if (hdev->manufacturer == 11 && hdev->hci_rev == 0x00 &&
-	    hdev->lmp_subver == 0x0757)
-		return 0x01;
-
-	if (hdev->manufacturer == 15) {
-		if (hdev->hci_rev == 0x03 && hdev->lmp_subver == 0x6963)
-			return 0x01;
-		if (hdev->hci_rev == 0x09 && hdev->lmp_subver == 0x6963)
-			return 0x01;
-		if (hdev->hci_rev == 0x00 && hdev->lmp_subver == 0x6965)
-			return 0x01;
-	}
-
-	if (hdev->manufacturer == 31 && hdev->hci_rev == 0x2005 &&
-	    hdev->lmp_subver == 0x1805)
-		return 0x01;
-
-	return 0x00;
-}
-
-static void hci_setup_inquiry_mode(struct hci_request *req)
-{
-	u8 mode;
-
-	mode = hci_get_inquiry_mode(req->hdev);
-
-	hci_req_add(req, HCI_OP_WRITE_INQUIRY_MODE, 1, &mode);
-}
-
 static void hci_setup_event_mask(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -658,8 +621,17 @@ static void hci_init2_req(struct hci_request *req, unsigned long opt)
 		}
 	}
 
-	if (lmp_inq_rssi_capable(hdev))
-		hci_setup_inquiry_mode(req);
+	if (lmp_inq_rssi_capable(hdev)) {
+		u8 mode;
+
+		/* If Extended Inquiry Result events are supported, then
+		 * they are clearly preferred over Inquiry Result with RSSI
+		 * events.
+		 */
+		mode = lmp_ext_inq_capable(hdev) ? 0x02 : 0x01;
+
+		hci_req_add(req, HCI_OP_WRITE_INQUIRY_MODE, 1, &mode);
+	}
 
 	if (lmp_inq_tx_pwr_capable(hdev))
 		hci_req_add(req, HCI_OP_READ_INQ_RSP_TX_POWER, 0, NULL);
-- 
2.1.0

