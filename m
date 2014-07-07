Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/3] Bluetooth: Remove unnecessary return value from check_pending_le_conn
Date: Mon,  7 Jul 2014 12:45:55 +0300
Message-Id: <1404726355-7037-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404726355-7037-1-git-send-email-johan.hedberg@gmail.com>
References: <1404726355-7037-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since only the caller of this function doesn't care about the return
value anymore let's just remove it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8a36abb3cb06..84f4659f136e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4228,18 +4228,18 @@ static void hci_le_conn_update_complete_evt(struct hci_dev *hdev,
 }
 
 /* This function requires the caller holds hdev->lock */
-static bool check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
+static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 				  u8 addr_type, u8 adv_type)
 {
 	struct hci_conn *conn;
 
 	/* If the event is not connectable don't proceed further */
 	if (adv_type != LE_ADV_IND && adv_type != LE_ADV_DIRECT_IND)
-		return false;
+		return;
 
 	/* Ignore if the device is blocked */
 	if (hci_blacklist_lookup(hdev, addr, addr_type))
-		return false;
+		return;
 
 	/* If we're connectable, always connect any ADV_DIRECT_IND event */
 	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags) &&
@@ -4250,13 +4250,13 @@ static bool check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 	 * our pend_le_conns list.
 	 */
 	if (!hci_pend_le_action_lookup(&hdev->pend_le_conns, addr, addr_type))
-		return false;
+		return;
 
 connect:
 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
 			      HCI_AT_NO_BONDING, HCI_LE_AUTOCONN_TIMEOUT);
 	if (!IS_ERR(conn))
-		return true;
+		return;
 
 	switch (PTR_ERR(conn)) {
 	case -EBUSY:
@@ -4269,8 +4269,6 @@ connect:
 	default:
 		BT_DBG("Failed to connect: err %ld", PTR_ERR(conn));
 	}
-
-	return true;
 }
 
 static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
-- 
1.9.3

