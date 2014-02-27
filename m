Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Track LE initiator and responder address information
Date: Thu, 27 Feb 2014 14:05:42 +0200
Message-Id: <1393502743-9995-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393502743-9995-1-git-send-email-johan.hedberg@gmail.com>
References: <1393502743-9995-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For SMP we need the local and remote addresses (and their types) that
were used to establish the connection. These may be different from the
Identity Addresses or even the current RPA. To guarantee that we have
this information available and it is correct track these values
separately from the very beginning of the connection.

For outgoing connections we set the values as soon as we get a
successful command status for HCI_LE_Create_Connection (for which the
patch adds a command status handler function) and for incoming
connections as soon as we get a LE Connection Complete HCI event.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  4 +++
 net/bluetooth/hci_event.c        | 74 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 093d05eeb3fa..f18f342bb120 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -331,6 +331,10 @@ struct hci_conn {
 	__u8		dst_type;
 	bdaddr_t	src;
 	__u8		src_type;
+	bdaddr_t	init_addr;
+	__u8		init_addr_type;
+	bdaddr_t	resp_addr;
+	__u8		resp_addr_type;
 	__u16		handle;
 	__u16		state;
 	__u8		mode;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 162235633bf5..203a4f1c32b1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1598,6 +1598,47 @@ static void hci_cs_accept_phylink(struct hci_dev *hdev, u8 status)
 	amp_write_remote_assoc(hdev, cp->phy_handle);
 }
 
+static void hci_cs_le_create_conn(struct hci_dev *hdev, u8 status)
+{
+	struct hci_cp_le_create_conn *cp;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	/* All connection failure handling is taken care of by the
+	 * hci_le_conn_failed function which is triggered by the HCI
+	 * request completion callbacks used for connecting.
+	 */
+	if (status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_CREATE_CONN);
+	if (!cp)
+		return;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->peer_addr);
+	if (!conn)
+		goto unlock;
+
+	/* Store the initiator and responder address information which
+	 * is needed for SMP. These values will not change during the
+	 * lifetime of the connection.
+	 */
+	conn->init_addr_type = cp->own_address_type;
+	if (cp->own_address_type == ADDR_LE_DEV_RANDOM)
+		bacpy(&conn->init_addr, &hdev->random_addr);
+	else
+		bacpy(&conn->init_addr, &hdev->bdaddr);
+
+	conn->resp_addr_type = cp->peer_addr_type;
+	bacpy(&conn->resp_addr, &cp->peer_addr);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -2477,6 +2518,10 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cs_accept_phylink(hdev, ev->status);
 		break;
 
+	case HCI_OP_LE_CREATE_CONN:
+		hci_cs_le_create_conn(hdev, ev->status);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
 		break;
@@ -3661,6 +3706,35 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			conn->out = true;
 			conn->link_mode |= HCI_LM_MASTER;
 		}
+
+		/* If we didn't have a hci_conn object previously
+		 * but we're in master role this must be something
+		 * initiated using a white list.
+		 */
+		if (conn->out) {
+			conn->resp_addr_type = ev->bdaddr_type;
+			bacpy(&conn->resp_addr, &ev->bdaddr);
+			if (test_bit(HCI_PRIVACY, &hdev->dev_flags)) {
+				conn->init_addr_type = ADDR_LE_DEV_RANDOM;
+				bacpy(&conn->init_addr, &hdev->rpa);
+			} else {
+				hci_copy_identity_address(hdev,
+							  &conn->init_addr,
+							  &conn->init_addr_type);
+			}
+		} else {
+			/* Set the responder (our side) address type based on
+			 * the advertising address type.
+			 */
+			conn->resp_addr_type = hdev->adv_addr_type;
+			if (hdev->adv_addr_type == ADDR_LE_DEV_RANDOM)
+				bacpy(&conn->resp_addr, &hdev->random_addr);
+			else
+				bacpy(&conn->resp_addr, &hdev->bdaddr);
+
+			conn->init_addr_type = ev->bdaddr_type;
+			bacpy(&conn->init_addr, &ev->bdaddr);
+		}
 	}
 
 	/* Ensure that the hci_conn contains the identity address type
-- 
1.8.5.3

