Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Don't send device found events for duplicate reports
Date: Tue, 25 Mar 2014 14:34:59 +0200
Message-Id: <1395750900-10755-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1395750900-10755-1-git-send-email-johan.hedberg@gmail.com>
References: <1395750900-10755-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Occasionally, during active scanning we will receive duplicate ADV_IND
reports from the same device before receiving the SCAN_RSP from them. In
order to not wake up user space unnecessarily it's better not to send
these extra events as they do not contain any new information.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5816a13c5342..1b2221d62007 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4021,6 +4021,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 			       u8 bdaddr_type, s8 rssi, u8 *data, u8 len)
 {
 	struct discovery_state *d = &hdev->discovery;
+	bool match;
 
 	/* Passive scanning shouldn't trigger any device found events */
 	if (hdev->le_scan_type == LE_SCAN_PASSIVE) {
@@ -4048,17 +4049,21 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		return;
 	}
 
+	/* Check if the pending report is for the same device as the new one */
+	match = (!bacmp(bdaddr, &d->last_adv_addr) &&
+		 bdaddr_type == d->last_adv_addr_type);
+
 	/* If the pending data doesn't match this report or this isn't a
 	 * scan response (e.g. we got a duplicate ADV_IND) then force
 	 * sending of the pending data.
 	 */
-	if (type != LE_ADV_SCAN_RSP || bacmp(bdaddr, &d->last_adv_addr) ||
-	    bdaddr_type != d->last_adv_addr_type) {
-		/* Send out whatever is in the cache */
-		mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
-				  d->last_adv_addr_type, NULL, 0, 0, 1,
-				  d->last_adv_data, d->last_adv_data_len,
-				  NULL, 0);
+	if (type != LE_ADV_SCAN_RSP || !match) {
+		/* Send out whatever is in the cache, but skip duplicates */
+		if (!match)
+			mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
+					  d->last_adv_addr_type, NULL, 0,
+					  0, 1, d->last_adv_data,
+					  d->last_adv_data_len, NULL, 0);
 
 		/* If the new report will trigger a SCAN_REQ store it for
 		 * later merging.
-- 
1.8.5.3

