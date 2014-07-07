Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/3] Bluetooth: Fix connecting devices during LE device discovery
Date: Mon,  7 Jul 2014 12:45:53 +0300
Message-Id: <1404726355-7037-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we have devices set as to be connected we should connect to them even
during normal discovery if we get a connectable advertising event. If we
also have HCI_CONNECTABLE set we should connect ADV_DIRECT_IND events
even to devices that we don't have in our pend_le_conns list. This patch
implements such behavior by passing the advertising report type to
check_pending_le_conn() and calls that function regardless of what type
of scanning we are doing.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 57837cad9919..8a36abb3cb06 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4229,13 +4229,30 @@ static void hci_le_conn_update_complete_evt(struct hci_dev *hdev,
 
 /* This function requires the caller holds hdev->lock */
 static bool check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
-				  u8 addr_type)
+				  u8 addr_type, u8 adv_type)
 {
 	struct hci_conn *conn;
 
+	/* If the event is not connectable don't proceed further */
+	if (adv_type != LE_ADV_IND && adv_type != LE_ADV_DIRECT_IND)
+		return false;
+
+	/* Ignore if the device is blocked */
+	if (hci_blacklist_lookup(hdev, addr, addr_type))
+		return false;
+
+	/* If we're connectable, always connect any ADV_DIRECT_IND event */
+	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags) &&
+	    adv_type == LE_ADV_DIRECT_IND)
+		goto connect;
+
+	/* If we're not connectable only connect devices that we have in
+	 * our pend_le_conns list.
+	 */
 	if (!hci_pend_le_action_lookup(&hdev->pend_le_conns, addr, addr_type))
 		return false;
 
+connect:
 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
 			      HCI_AT_NO_BONDING, HCI_LE_AUTOCONN_TIMEOUT);
 	if (!IS_ERR(conn))
@@ -4260,32 +4277,26 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 			       u8 bdaddr_type, s8 rssi, u8 *data, u8 len)
 {
 	struct discovery_state *d = &hdev->discovery;
+	struct smp_irk *irk;
 	bool match;
 	u32 flags;
 
+	/* Check if we need to convert to identity address */
+	irk = hci_get_irk(hdev, bdaddr, bdaddr_type);
+	if (irk) {
+		bdaddr = &irk->bdaddr;
+		bdaddr_type = irk->addr_type;
+	}
+
+	/* Check if we have been requested to connect to this device */
+	check_pending_le_conn(hdev, bdaddr, bdaddr_type, type);
+
 	/* Passive scanning shouldn't trigger any device found events,
 	 * except for devices marked as CONN_REPORT for which we do send
 	 * device found events.
 	 */
 	if (hdev->le_scan_type == LE_SCAN_PASSIVE) {
 		struct hci_conn_params *param;
-		struct smp_irk *irk;
-
-		/* Check if we need to convert to identity address */
-		irk = hci_get_irk(hdev, bdaddr, bdaddr_type);
-		if (irk) {
-			bdaddr = &irk->bdaddr;
-			bdaddr_type = irk->addr_type;
-		}
-
-		/* Ignore if the device is blocked */
-		if (hci_blacklist_lookup(hdev, bdaddr, bdaddr_type))
-			return;
-
-		if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND) {
-			if (check_pending_le_conn(hdev, bdaddr, bdaddr_type))
-				return;
-		}
 
 		if (type == LE_ADV_DIRECT_IND)
 			return;
-- 
1.9.3

