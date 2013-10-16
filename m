Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 10/15] Bluetooth: Create start_background_scan helper
Date: Wed, 16 Oct 2013 20:18:00 -0300
Message-Id: <1381965485-9159-11-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch creates the start_background_scan() function so it can
be reused in the next patch.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f232965..68f3c0a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3888,20 +3888,11 @@ static void start_background_scan_complete(struct hci_dev *hdev, u8 status)
 		       "status 0x%2.2x", status);
 }
 
-int hci_trigger_background_scan(struct hci_dev *hdev)
+static int start_background_scan(struct hci_dev *hdev)
 {
 	struct hci_cp_le_set_scan_param param_cp;
 	struct hci_cp_le_set_scan_enable enable_cp;
 	struct hci_request req;
-	int err;
-
-	BT_DBG("%s", hdev->name);
-
-	/* If we already have triggers, there is no need to send HCI command
-	 * to start the background scanning.
-	 */
-	if (atomic_read(&hdev->background_scan_cnt) > 0)
-		goto done;
 
 	hci_req_init(&req, hdev);
 
@@ -3918,7 +3909,22 @@ int hci_trigger_background_scan(struct hci_dev *hdev)
 	hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
 		    &enable_cp);
 
-	err = hci_req_run(&req, start_background_scan_complete);
+	return hci_req_run(&req, start_background_scan_complete);
+}
+
+int hci_trigger_background_scan(struct hci_dev *hdev)
+{
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	/* If we already have triggers, there is no need to send HCI command
+	 * to start the background scanning.
+	 */
+	if (atomic_read(&hdev->background_scan_cnt) > 0)
+		goto done;
+
+	err = start_background_scan(hdev);
 	if (err)
 		return err;
 
-- 
1.8.4

