Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 1/4] Bluetooth: Move local identity address setting to a central place
Date: Mon, 24 Mar 2014 20:21:50 +0200
Message-Id: <1395685313-26085-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Any time hci_conn_add is used for an LE connection we need to ensure
that the local identity address is correctly described in the src and
src_type variables. This patch moves setting these values directly into
hci_conn_add so that callers don't have to duplicate the effort
themselves.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c  |  4 ++++
 net/bluetooth/hci_event.c | 16 ----------------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d958e2dca52f..129c22a85ccf 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -401,6 +401,10 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	case ACL_LINK:
 		conn->pkt_type = hdev->pkt_type & ACL_PTYPE_MASK;
 		break;
+	case LE_LINK:
+		/* conn->src should reflect the local identity address */
+		hci_copy_identity_address(hdev, &conn->src, &conn->src_type);
+		break;
 	case SCO_LINK:
 		if (lmp_esco_capable(hdev))
 			conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4ac8ee07bec3..15cc11965148 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3858,17 +3858,6 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 		conn->dst_type = ev->bdaddr_type;
 
-		/* The advertising parameters for own address type
-		 * define which source address and source address
-		 * type this connections has.
-		 */
-		if (bacmp(&conn->src, BDADDR_ANY)) {
-			conn->src_type = ADDR_LE_DEV_PUBLIC;
-		} else {
-			bacpy(&conn->src, &hdev->static_addr);
-			conn->src_type = ADDR_LE_DEV_RANDOM;
-		}
-
 		if (ev->role == LE_CONN_ROLE_MASTER) {
 			conn->out = true;
 			conn->link_mode |= HCI_LM_MASTER;
@@ -3910,11 +3899,6 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		cancel_delayed_work(&conn->le_conn_timeout);
 	}
 
-	/* Ensure that the hci_conn contains the identity address type
-	 * regardless of which address the connection was made with.
-	 */
-	hci_copy_identity_address(hdev, &conn->src, &conn->src_type);
-
 	/* Lookup the identity address from the stored connection
 	 * address and address type.
 	 *
-- 
1.8.5.3

