Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/3] Bluetooth: Move set_bredr_scan() to a more convenient location
Date: Tue,  1 Oct 2013 18:22:01 +0300
Message-Id: <1380640922-18647-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1380640922-18647-1-git-send-email-johan.hedberg@gmail.com>
References: <1380640922-18647-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The static set_bredr_scan function will soon be reused by a new
set_bredr method. This trivial patch moves the function to a new
location within the mgmt.c file where it can be reused without requiring
forward declarations.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e1c41b0..eea0b97 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3147,6 +3147,26 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static void set_bredr_scan(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	u8 scan = 0;
+
+	/* Ensure that fast connectable is disabled. This function will
+	 * not do anything if the page scan parameters are already what
+	 * they should be.
+	 */
+	write_fast_connectable(req, false);
+
+	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
+		scan |= SCAN_PAGE;
+	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
+		scan |= SCAN_INQUIRY;
+
+	if (scan)
+		hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+}
+
 static void set_advertising_complete(struct hci_dev *hdev, u8 status)
 {
 	struct cmd_lookup match = { NULL, hdev };
@@ -3567,26 +3587,6 @@ int mgmt_index_removed(struct hci_dev *hdev)
 	return mgmt_event(MGMT_EV_INDEX_REMOVED, hdev, NULL, 0, NULL);
 }
 
-static void set_bredr_scan(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	u8 scan = 0;
-
-	/* Ensure that fast connectable is disabled. This function will
-	 * not do anything if the page scan parameters are already what
-	 * they should be.
-	 */
-	write_fast_connectable(req, false);
-
-	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
-		scan |= SCAN_PAGE;
-	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
-		scan |= SCAN_INQUIRY;
-
-	if (scan)
-		hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
-}
-
 static void powered_complete(struct hci_dev *hdev, u8 status)
 {
 	struct cmd_lookup match = { NULL, hdev };
-- 
1.8.3.1

