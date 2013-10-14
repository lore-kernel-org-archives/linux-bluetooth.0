Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Move set_bredr_scan() to avoid forward declaration
Date: Mon, 14 Oct 2013 21:15:25 +0300
Message-Id: <1381774527-13746-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1381774527-13746-1-git-send-email-johan.hedberg@gmail.com>
References: <1381774527-13746-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The set_bredr_scan() function will soon be needed by the set_bredr()
function, so move it to a new location to avoid having to add a forward
declaration.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a07b081..48aa239 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3558,6 +3558,26 @@ unlock:
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
 static void set_bredr_complete(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
@@ -3917,26 +3937,6 @@ void mgmt_index_removed(struct hci_dev *hdev)
 	mgmt_event(MGMT_EV_INDEX_REMOVED, hdev, NULL, 0, NULL);
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

