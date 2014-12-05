Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Clear discovery filter before starting background scan
Date: Fri,  5 Dec 2014 11:45:23 +0100
Message-Id: <1417776323-131063-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently the discovery filter information are only cleared when the
actual discovery procedure has been stopped. To make sure that none
of the filters interfere with the background scanning and its device
found event reporting, clear the filter before starting background
scanning.

This means that the discovery filter is now cleared before either
Start Discovery, Start Service Discovery or background scanning.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8b3f839ba826..523700eefdd1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2052,17 +2052,6 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 	case DISCOVERY_STOPPED:
 		hci_update_background_scan(hdev);
 
-		/* Reset RSSI and UUID filters to ensure Start Discovery
-		 * and Start Service Discovery operate properly no matter
-		 * which one started the previous discovery.
-		 *
-		 * While the Start Discovery and Start Service Discovery
-		 * operations will set proper values for RSSI and UUID
-		 * count, it is important to actually free the allocated
-		 * list of UUIDs here.
-		 */
-		hci_discovery_filter_clear(hdev);
-
 		if (old_state != DISCOVERY_STARTING)
 			mgmt_discovering(hdev, 0);
 		break;
@@ -5679,6 +5668,15 @@ void hci_update_background_scan(struct hci_dev *hdev)
 	if (hdev->discovery.state != DISCOVERY_STOPPED)
 		return;
 
+	/* Reset RSSI and UUID filters when starting background scanning
+	 * since these filters are meant for service discovery only.
+	 *
+	 * The Start Discovery and Start Service Discovery operations
+	 * ensure to set proper values for RSSI threshold and UUID
+	 * filter list. So it is safe to just reset them here.
+	 */
+	hci_discovery_filter_clear(hdev);
+
 	hci_req_init(&req, hdev);
 
 	if (list_empty(&hdev->pend_le_conns) &&
-- 
1.9.3

