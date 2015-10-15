Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH] Bluetooth: properly initialize conn_params in scan phase
Date: Thu, 15 Oct 2015 13:45:50 -0700
Message-Id: <1444941950-5362-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes sure that conn_params that were created just for
explicit_connect, will get properly deleted during cleanup.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/hci_conn.c | 22 +++++++++++++++-------
 net/bluetooth/mgmt.c     |  3 +++
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index dbe32db..42b083e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1015,15 +1015,23 @@ static int hci_explicit_conn_params_set(struct hci_request *req,
 	if (is_connected(hdev, addr, addr_type))
 		return -EISCONN;
 
-	params = hci_conn_params_add(hdev, addr, addr_type);
-	if (!params)
-		return -EIO;
+	params = hci_conn_params_lookup(hdev, addr, addr_type);
+	if (!params) {
+		params = hci_conn_params_add(hdev, addr, addr_type);
+		if (!params)
+			return -EIO;
+
+		/* If we created new params, mark them to be deleted in
+		 * hci_connect_le_scan_cleanup. It's different case than
+		 * existing disabled params, those will stay after cleanup.
+		 */
+		params->auto_connect = HCI_AUTO_CONN_EXPLICIT;
+	}
 
-	/* If we created new params, or existing params were marked as disabled,
-	 * mark them to be used just once to connect.
-	 */
+	/* We're trying to connect, so make sure params are at pend_le_conns */
 	if (params->auto_connect == HCI_AUTO_CONN_DISABLED ||
-	    params->auto_connect == HCI_AUTO_CONN_REPORT) {
+	    params->auto_connect == HCI_AUTO_CONN_REPORT ||
+	    params->auto_connect == HCI_AUTO_CONN_EXPLICIT) {
 		list_del_init(&params->action);
 		list_add(&params->action, &hdev->pend_le_conns);
 	}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9216393..61df34f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3584,6 +3584,9 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		 */
 		hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type);
 
+		if (hci_param->auto_connect == HCI_AUTO_CONN_EXPLICIT)
+			hci_param->auto_connect = HCI_AUTO_CONN_DISABLED;
+
 		conn = hci_connect_le_scan(hdev, &cp->addr.bdaddr,
 					   addr_type, sec_level,
 					   HCI_LE_CONN_TIMEOUT,
-- 
2.5.0

