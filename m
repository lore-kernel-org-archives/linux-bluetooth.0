Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] Bluetooth: Remove hci_cs_le_create_conn event handler
Date: Tue,  1 Oct 2013 20:03:53 -0300
Message-Id: <1380668636-30654-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org>
References: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the hci_cs_le_create_conn event handler since this
handling is now done in create_le_connection_complete() callback in
hci_conn.c.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d171c04b..1d1ffa6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1465,33 +1465,6 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 	hci_dev_unlock(hdev);
 }
 
-static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
-{
-	struct hci_conn *conn;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	if (status) {
-		hci_dev_lock(hdev);
-
-		conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
-		if (!conn) {
-			hci_dev_unlock(hdev);
-			return;
-		}
-
-		BT_DBG("%s bdaddr %pMR conn %p", hdev->name, &conn->dst, conn);
-
-		conn->state = BT_CLOSED;
-		mgmt_connect_failed(hdev, &conn->dst, conn->type,
-				    conn->dst_type, status);
-		hci_proto_connect_cfm(conn, status);
-		hci_conn_del(conn);
-
-		hci_dev_unlock(hdev);
-	}
-}
-
 static void hci_cs_create_phylink(struct hci_dev *hdev, u8 status)
 {
 	struct hci_cp_create_phy_link *cp;
@@ -2342,10 +2315,6 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_disconnect(hdev, ev->status);
 		break;
 
-	case HCI_OP_LE_CREATE_CONN:
-		hci_cs_le_create_conn(hdev, ev->status);
-		break;
-
 	case HCI_OP_CREATE_PHY_LINK:
 		hci_cs_create_phylink(hdev, ev->status);
 		break;
-- 
1.8.4

