Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: Find hci_conn by BT_CONNECT state
Date: Fri, 27 Jul 2012 15:10:14 -0300
Message-Id: <1343412616-25641-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1343412616-25641-1-git-send-email-andre.guedes@openbossa.org>
References: <1343412616-25641-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes hci_cs_le_create_conn to perform hci_conn lookup
by state instead of bdaddr.

Since we can have only one LE connection in BT_CONNECT state, we can
perform LE hci_conn lookup by state. This way, we don't rely on
hci_sent_cmd_data helper to find the hci_conn object.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c0aa9f4..8dc1f0f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1614,29 +1614,24 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 
 static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
 {
-	struct hci_cp_le_create_conn *cp;
 	struct hci_conn *conn;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
-	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_CREATE_CONN);
-	if (!cp)
-		return;
-
 	if (status) {
 		hci_dev_lock(hdev);
 
-		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->peer_addr);
+		conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
 		if (!conn) {
 			hci_dev_unlock(hdev);
 			return;
 		}
 
-		BT_DBG("%s bdaddr %s conn %p", hdev->name, batostr(&cp->peer_addr),
+		BT_DBG("%s bdaddr %s conn %p", hdev->name, batostr(&conn->dst),
 		       conn);
 
 		conn->state = BT_CLOSED;
-		mgmt_connect_failed(hdev, &cp->peer_addr, conn->type,
+		mgmt_connect_failed(hdev, &conn->dst, conn->type,
 				    conn->dst_type, status);
 		hci_proto_connect_cfm(conn, status);
 		hci_conn_del(conn);
-- 
1.7.11.2

