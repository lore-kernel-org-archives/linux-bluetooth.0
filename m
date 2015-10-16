Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v5] Bluetooth: Fix initializing conn_params in scan phase
Date: Thu, 15 Oct 2015 22:51:12 -0700
Message-Id: <1444974672-2840-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes sure that conn_params that were created just for
explicit_connect, will get properly deleted during cleanup.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/hci_conn.c | 22 +++++++++++++++-------
 net/bluetooth/mgmt.c     |  6 +++++-
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index dbe32db..2be2233 100644
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
+			return -ENOMEM;
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
index 9216393..f13e1a7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3565,6 +3565,7 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 				       auth_type);
 	} else {
 		u8 addr_type;
+		struct hci_conn_params *p;
 
 		/* Convert from L2CAP channel address type to HCI address type
 		 */
@@ -3582,7 +3583,10 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		 * If connection parameters already exist, then they
 		 * will be kept and this function does nothing.
 		 */
-		hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type);
+		p = hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type);
+
+		if (p->auto_connect == HCI_AUTO_CONN_EXPLICIT)
+			p->auto_connect = HCI_AUTO_CONN_DISABLED;
 
 		conn = hci_connect_le_scan(hdev, &cp->addr.bdaddr,
 					   addr_type, sec_level,
-- 
2.5.0

