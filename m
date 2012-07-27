Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] Bluetooth: Refactor hci_cs_le_create_conn
Date: Fri, 27 Jul 2012 15:10:13 -0300
Message-Id: <1343412616-25641-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1343412616-25641-1-git-send-email-andre.guedes@openbossa.org>
References: <1343412616-25641-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch does some code refactoring in hci_cs_le_create_conn
function. The hci_conn object is only needed in case of failure,
therefore hdev locking and hci_conn lookup were moved to
if-statement scope.

Also, the conn->state check was removed since we should always
close the connection if it fails.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 27064be..c0aa9f4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1623,24 +1623,26 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
 	if (!cp)
 		return;
 
-	hci_dev_lock(hdev);
+	if (status) {
+		hci_dev_lock(hdev);
 
-	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->peer_addr);
+		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->peer_addr);
+		if (!conn) {
+			hci_dev_unlock(hdev);
+			return;
+		}
 
-	BT_DBG("%s bdaddr %s conn %p", hdev->name, batostr(&cp->peer_addr),
-	       conn);
+		BT_DBG("%s bdaddr %s conn %p", hdev->name, batostr(&cp->peer_addr),
+		       conn);
 
-	if (status) {
-		if (conn && conn->state == BT_CONNECT) {
-			conn->state = BT_CLOSED;
-			mgmt_connect_failed(hdev, &cp->peer_addr, conn->type,
-					    conn->dst_type, status);
-			hci_proto_connect_cfm(conn, status);
-			hci_conn_del(conn);
-		}
-	}
+		conn->state = BT_CLOSED;
+		mgmt_connect_failed(hdev, &cp->peer_addr, conn->type,
+				    conn->dst_type, status);
+		hci_proto_connect_cfm(conn, status);
+		hci_conn_del(conn);
 
-	hci_dev_unlock(hdev);
+		hci_dev_unlock(hdev);
+	}
 }
 
 static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
-- 
1.7.11.2

