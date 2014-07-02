Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Add support for background LE scanning
Date: Wed,  2 Jul 2014 22:42:02 +0300
Message-Id: <1404330122-18770-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404330122-18770-1-git-send-email-johan.hedberg@gmail.com>
References: <1404330122-18770-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we have one or more devices with HCI_AUTO_CONN_REPORT we should do
background scanning and emit mgmt_device_found events. This patch
modifies the hci_update_background_scan() function to extend the
conditions needed to trigger scanning, and adds the necessary code to
process_adv_report() to emit mgmt_device_found events.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c  |  7 ++++---
 net/bluetooth/hci_event.c | 25 +++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8e0061f72dd1..41cc64429ea1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5380,9 +5380,10 @@ void hci_update_background_scan(struct hci_dev *hdev)
 
 	hci_req_init(&req, hdev);
 
-	if (list_empty(&hdev->pend_le_conns)) {
-		/* If there is no pending LE connections, we should stop
-		 * the background scanning.
+	if (list_empty(&hdev->pend_le_conns) && !hdev->pend_le_reports) {
+		/* If there is no pending LE connections or devices
+		 * to be scanned for, we should stop the background
+		 * scanning.
 		 */
 
 		/* If controller is not scanning we are done. */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 846f6a6af881..87a704bd7eb7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4225,11 +4225,32 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	bool match;
 	u32 flags;
 
-	/* Passive scanning shouldn't trigger any device found events */
+	/* Passive scanning shouldn't trigger any device found events,
+	 * except for devices marked as CONN_REPORT for which we do send
+	 * device found events.
+	 */
 	if (hdev->le_scan_type == LE_SCAN_PASSIVE) {
+		struct hci_conn_params *param;
+
 		if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND)
 			check_pending_le_conn(hdev, bdaddr, bdaddr_type);
-		return;
+
+		if (!hdev->pend_le_reports)
+			return;
+
+		if (type == LE_ADV_DIRECT_IND)
+			return;
+
+		param = hci_conn_params_lookup(hdev, bdaddr, bdaddr_type);
+		if (!param || param->auto_connect != HCI_AUTO_CONN_REPORT)
+			return;
+
+		if (type == LE_ADV_NONCONN_IND || type == LE_ADV_SCAN_IND)
+			flags = MGMT_DEV_FOUND_NOT_CONNECTABLE;
+		else
+			flags = 0;
+		mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL,
+				  rssi, flags, data, len, NULL, 0);
 	}
 
 	/* When receiving non-connectable or scannable undirected
-- 
1.9.3

