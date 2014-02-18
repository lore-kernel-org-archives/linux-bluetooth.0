Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v10 04/10] Bluetooth: Remove unused function
Date: Tue, 18 Feb 2014 17:15:28 -0300
Message-Id: <1392754534-12747-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1392754534-12747-1-git-send-email-andre.guedes@openbossa.org>
References: <1392754534-12747-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes hci_create_le_conn() since it is not used anymore.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e147fd3..0ae7692 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -551,38 +551,6 @@ done:
 	hci_dev_unlock(hdev);
 }
 
-static int hci_create_le_conn(struct hci_conn *conn)
-{
-	struct hci_dev *hdev = conn->hdev;
-	struct hci_cp_le_create_conn cp;
-	struct hci_request req;
-	int err;
-
-	hci_req_init(&req, hdev);
-
-	memset(&cp, 0, sizeof(cp));
-	cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
-	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
-	bacpy(&cp.peer_addr, &conn->dst);
-	cp.peer_addr_type = conn->dst_type;
-	cp.own_address_type = conn->src_type;
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

