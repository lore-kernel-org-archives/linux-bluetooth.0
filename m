Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/17] Bluetooth: Remove unused function
Date: Tue, 25 Feb 2014 18:01:31 -0300
Message-Id: <1393362104-12175-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org>
References: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes hci_create_le_conn() since it is not used anymore.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 43 -------------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ae2c3e1..a823d30 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -551,49 +551,6 @@ done:
 	hci_dev_unlock(hdev);
 }
 
-static int hci_create_le_conn(struct hci_conn *conn)
-{
-	struct hci_dev *hdev = conn->hdev;
-	struct hci_cp_le_create_conn cp;
-	struct hci_request req;
-	u8 own_addr_type;
-	int err;
-
-	hci_req_init(&req, hdev);
-
-	memset(&cp, 0, sizeof(cp));
-
-	/* Update random address, but set require_privacy to false so
-	 * that we never connect with an unresolvable address.
-	 */
-	err = hci_update_random_address(&req, false, &own_addr_type);
-	if (err < 0)
-		return err;
-
-	conn->src_type = own_addr_type;
-
-	cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
-	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
-	bacpy(&cp.peer_addr, &conn->dst);
-	cp.peer_addr_type = conn->dst_type;
-	cp.own_address_type = own_addr_type;
-	cp.conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
-	cp.conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
-	cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
-	cp.min_ce_len = __constant_cpu_to_le16(0x0000);
-	cp.max_ce_len = __constant_cpu_to_le16(0x0000);
-
-	hci_req_add(&req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
-
-	err = hci_req_run(&req, create_le_conn_complete);
-	if (err) {
-		hci_conn_del(conn);
-		return err;
-	}
-
-	return 0;
-}
-
 static void hci_req_add_le_create_conn(struct hci_request *req,
 				       struct hci_conn *conn)
 {
-- 
1.8.5.4

