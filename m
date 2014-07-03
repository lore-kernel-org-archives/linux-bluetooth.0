Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/5] Bluetooth: Remove unnecessary checks for auto-connected devices
Date: Thu,  3 Jul 2014 19:33:50 +0300
Message-Id: <1404405231-16390-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404405231-16390-1-git-send-email-johan.hedberg@gmail.com>
References: <1404405231-16390-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If a device is in the pend_le_conns list it cannot at the same time also
have the need to be notified through mgmt_device_found. By making
check_pending_le_conn return whether it found an entry or not we can
avoid unnecessary checks in process_adv_report().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4ebfcedd9ae7..e0b439d4f958 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4185,18 +4185,18 @@ static void hci_le_conn_update_complete_evt(struct hci_dev *hdev,
 }
 
 /* This function requires the caller holds hdev->lock */
-static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
+static bool check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 				  u8 addr_type)
 {
 	struct hci_conn *conn;
 
 	if (!hci_pend_le_conn_lookup(hdev, addr, addr_type))
-		return;
+		return false;
 
 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
 			      HCI_AT_NO_BONDING);
 	if (!IS_ERR(conn))
-		return;
+		return true;
 
 	switch (PTR_ERR(conn)) {
 	case -EBUSY:
@@ -4209,6 +4209,8 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 	default:
 		BT_DBG("Failed to connect: err %ld", PTR_ERR(conn));
 	}
+
+	return true;
 }
 
 static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
@@ -4233,8 +4235,10 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 			bdaddr_type = irk->addr_type;
 		}
 
-		if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND)
-			check_pending_le_conn(hdev, bdaddr, bdaddr_type);
+		if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND) {
+			if (check_pending_le_conn(hdev, bdaddr, bdaddr_type))
+				return;
+		}
 
 		if (!hdev->pend_le_reports)
 			return;
-- 
1.9.3

