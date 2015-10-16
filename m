Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] Bluetooth: Fix initializing conn_params in scan phase
Date: Fri, 16 Oct 2015 10:07:54 +0300
Message-Id: <1444979274-21622-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1444979274-21622-1-git-send-email-johan.hedberg@gmail.com>
References: <1444979274-21622-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Pawlowski <jpawlowski@google.com>

This patch makes sure that conn_params that were created just for
explicit_connect, will get properly deleted during cleanup.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
Acked-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 22 +++++++++++++++-------
 net/bluetooth/mgmt.c     |  6 +++++-
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index fe99025fb649..2dda439c8cb8 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1008,15 +1008,23 @@ static int hci_explicit_conn_params_set(struct hci_request *req,
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
index 0ed94e6f4de9..c4fe2fee753f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3545,6 +3545,7 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 				       auth_type);
 	} else {
 		u8 addr_type;
+		struct hci_conn_params *p;
 
 		/* Convert from L2CAP channel address type to HCI address type
 		 */
@@ -3562,7 +3563,10 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
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
2.4.3

