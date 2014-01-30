Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v6 05/14] Bluetooth: Introduce le_conn_failed() helper
Date: Thu, 30 Jan 2014 18:22:08 -0300
Message-Id: <1391116937-28217-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1391116937-28217-1-git-send-email-andre.guedes@openbossa.org>
References: <1391116937-28217-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves connection attempt failure code to its own function
so it can be reused in the next patch.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4d1ce74..914d7f5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -514,6 +514,21 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 }
 EXPORT_SYMBOL(hci_get_route);
 
+/* This function requires the caller holds hdev->lock */
+static void le_conn_failed(struct hci_conn *conn, u8 status)
+{
+	struct hci_dev *hdev = conn->hdev;
+
+	conn->state = BT_CLOSED;
+
+	mgmt_connect_failed(hdev, &conn->dst, conn->type, conn->dst_type,
+			    status);
+
+	hci_proto_connect_cfm(conn, status);
+
+	hci_conn_del(conn);
+}
+
 static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
 {
 	struct hci_conn *conn;
@@ -530,14 +545,7 @@ static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
 	if (!conn)
 		goto done;
 
-	conn->state = BT_CLOSED;
-
-	mgmt_connect_failed(hdev, &conn->dst, conn->type, conn->dst_type,
-			    status);
-
-	hci_proto_connect_cfm(conn, status);
-
-	hci_conn_del(conn);
+	le_conn_failed(conn, status);
 
 done:
 	hci_dev_unlock(hdev);
-- 
1.8.5.3

