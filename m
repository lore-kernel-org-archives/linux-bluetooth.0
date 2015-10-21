Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/13] Bluetooth: Add hdev helper variable to hci_le_create_connection_cancel
Date: Wed, 21 Oct 2015 18:03:09 +0300
Message-Id: <1445439791-2151-12-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1445439791-2151-1-git-send-email-johan.hedberg@gmail.com>
References: <1445439791-2151-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hci_le_create_connection_cancel() function needs to use the hdev
pointer in many places so add a variable for it to avoid the need to
dereference the hci_conn every time.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c562d5d5b14e..77b2bf9e808e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -63,6 +63,7 @@ static const struct sco_param esco_param_msbc[] = {
 static void hci_connect_le_scan_cleanup(struct hci_conn *conn)
 {
 	struct hci_conn_params *params;
+	struct hci_dev *hdev = conn->hdev;
 	struct smp_irk *irk;
 	bdaddr_t *bdaddr;
 	u8 bdaddr_type;
@@ -71,13 +72,13 @@ static void hci_connect_le_scan_cleanup(struct hci_conn *conn)
 	bdaddr_type = conn->dst_type;
 
 	/* Check if we need to convert to identity address */
-	irk = hci_get_irk(conn->hdev, bdaddr, bdaddr_type);
+	irk = hci_get_irk(hdev, bdaddr, bdaddr_type);
 	if (irk) {
 		bdaddr = &irk->bdaddr;
 		bdaddr_type = irk->addr_type;
 	}
 
-	params = hci_explicit_connect_lookup(conn->hdev, bdaddr, bdaddr_type);
+	params = hci_explicit_connect_lookup(hdev, bdaddr, bdaddr_type);
 	if (!params)
 		return;
 
@@ -92,21 +93,21 @@ static void hci_connect_le_scan_cleanup(struct hci_conn *conn)
 
 	switch (params->auto_connect) {
 	case HCI_AUTO_CONN_EXPLICIT:
-		hci_conn_params_del(conn->hdev, bdaddr, bdaddr_type);
+		hci_conn_params_del(hdev, bdaddr, bdaddr_type);
 		/* return instead of break to avoid duplicate scan update */
 		return;
 	case HCI_AUTO_CONN_DIRECT:
 	case HCI_AUTO_CONN_ALWAYS:
-		list_add(&params->action, &conn->hdev->pend_le_conns);
+		list_add(&params->action, &hdev->pend_le_conns);
 		break;
 	case HCI_AUTO_CONN_REPORT:
-		list_add(&params->action, &conn->hdev->pend_le_reports);
+		list_add(&params->action, &hdev->pend_le_reports);
 		break;
 	default:
 		break;
 	}
 
-	hci_update_background_scan(conn->hdev);
+	hci_update_background_scan(hdev);
 }
 
 static void hci_conn_cleanup(struct hci_conn *conn)
-- 
2.5.0

