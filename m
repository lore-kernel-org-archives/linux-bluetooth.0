Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Ignore ADV_DIRECT_IND attempts from unknown devices
Date: Wed, 23 Jul 2014 21:55:22 +0200
Message-Id: <1406145323-42940-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Unconditionally connecting to devices sending ADV_DIRECT_IND when
the controller is in CONNECTABLE mode is a feature that is not
fully working. The background scanning trigger for this has been
removed, but the statement allowing it to happen in case some
other part triggers is still present. So remove that code part
as well to avoid unwanted connections.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4c41774aa556..293dd98ae98f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4266,18 +4266,12 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 	if (hdev->conn_hash.le_num_slave > 0)
 		return;
 
-	/* If we're connectable, always connect any ADV_DIRECT_IND event */
-	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags) &&
-	    adv_type == LE_ADV_DIRECT_IND)
-		goto connect;
-
 	/* If we're not connectable only connect devices that we have in
 	 * our pend_le_conns list.
 	 */
 	if (!hci_pend_le_action_lookup(&hdev->pend_le_conns, addr, addr_type))
 		return;
 
-connect:
 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
 			      HCI_LE_AUTOCONN_TIMEOUT, HCI_ROLE_MASTER);
 	if (!IS_ERR(conn))
-- 
1.9.3

