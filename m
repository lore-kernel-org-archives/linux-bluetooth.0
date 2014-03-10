Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Enable duplicates filter in background scan
Date: Mon, 10 Mar 2014 18:26:24 -0300
Message-Id: <1394486784-5431-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To avoid flooding the host with useless advertising reports during
background scan, we enable the duplicates filter from controller.

However, enabling duplicates filter requires a small change in
background scan routine in order to fix the following scenario:
  1) Background scan is running.
  2) A device disconnects and starts advertising.
  3) Before host gets the disconnect event, the advertising is reported
     to host. Since there is no pending LE connection at that time,
     nothing happens.
  4) Host gets the disconnection event and adds a pending connection.
  5) No advertising is reported (since controller is filtering) and the
     connection is never established.

So, to address this scenario, we should always restart background scan
to unsure we don't miss any advertising report (due to duplicates
filter).

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8bbfdea..a27d0b8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5270,7 +5270,7 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 
 	memset(&enable_cp, 0, sizeof(enable_cp));
 	enable_cp.enable = LE_SCAN_ENABLE;
-	enable_cp.filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
+	enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
 	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
 		    &enable_cp);
 }
@@ -5313,10 +5313,6 @@ void hci_update_background_scan(struct hci_dev *hdev)
 		 * keep the background scan running.
 		 */
 
-		/* If controller is already scanning we are done. */
-		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
-			return;
-
 		/* If controller is connecting, we should not start scanning
 		 * since some controllers are not able to scan and connect at
 		 * the same time.
@@ -5325,6 +5321,12 @@ void hci_update_background_scan(struct hci_dev *hdev)
 		if (conn)
 			return;
 
+		/* If controller is currently scanning, we stop it to ensure we
+		 * don't miss any advertising (due to duplicates filter).
+		 */
+		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+			hci_req_add_le_scan_disable(&req);
+
 		hci_req_add_le_passive_scan(&req);
 
 		BT_DBG("%s starting background scanning", hdev->name);
-- 
1.8.5.4

