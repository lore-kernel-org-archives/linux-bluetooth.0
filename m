Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/4] Bluetooth: Move local identity address setting to a central place
Date: Fri, 14 Mar 2014 14:45:37 +0200
Message-Id: <1394801137-19268-1-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1394790195-4109-2-git-send-email-johan.hedberg@gmail.com>
References: <1394790195-4109-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Any time hci_conn_add is used for an LE connection we need to ensure
that the local identity address is correctly described in the src and
src_type variables. This patch moves setting these values directly into
hci_conn_add so that callers don't have to duplicate the effort
themselves.

The patch also takes advantage of the hci_copy_identity_address helper
function in order not to duplicate the logic needlessly.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
v2: Use hci_copy_identity_address

 net/bluetooth/hci_conn.c  |  4 ++++
 net/bluetooth/hci_event.c | 11 -----------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b4809e473a19..1a025b953f19 100644
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
index e97f1905aa5c..89dbcc5575a7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3769,17 +3769,6 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
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
-- 
1.8.5.3

