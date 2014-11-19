Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix setting conn->pending_sec_level value from link key
Date: Wed, 19 Nov 2014 14:53:04 +0200
Message-Id: <1416401584-26705-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When a connection is requested the conn->pending_sec_level value gets
set to whatever level the user requested the connection to be. During
the pairing process there are various sanity checks to try to ensure
that the right length PIN or right IO Capability is used to satisfy the
target security level. However, when we finally get hold of the link key
that is to be used we should still set the actual final security level
from the key type.

This way when we eventually get an Encrypt Change event the correct
value gets copied to conn->sec_level.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 844f7d1ff1cd..54680fd39608 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3191,6 +3191,38 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static void conn_set_key(struct hci_conn *conn, u8 key_type, u8 pin_len)
+{
+	if (key_type == HCI_LK_CHANGED_COMBINATION)
+		return;
+
+	conn->pin_length = pin_len;
+	conn->key_type = key_type;
+
+	switch (key_type) {
+	case HCI_LK_LOCAL_UNIT:
+	case HCI_LK_REMOTE_UNIT:
+	case HCI_LK_DEBUG_COMBINATION:
+		return;
+	case HCI_LK_COMBINATION:
+		if (pin_len == 16)
+			conn->pending_sec_level = BT_SECURITY_HIGH;
+		else
+			conn->pending_sec_level = BT_SECURITY_MEDIUM;
+		break;
+	case HCI_LK_UNAUTH_COMBINATION_P192:
+	case HCI_LK_UNAUTH_COMBINATION_P256:
+		conn->pending_sec_level = BT_SECURITY_MEDIUM;
+		break;
+	case HCI_LK_AUTH_COMBINATION_P192:
+		conn->pending_sec_level = BT_SECURITY_HIGH;
+		break;
+	case HCI_LK_AUTH_COMBINATION_P256:
+		conn->pending_sec_level = BT_SECURITY_FIPS;
+		break;
+	}
+}
+
 static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_link_key_req *ev = (void *) skb->data;
@@ -3232,8 +3264,7 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			goto not_found;
 		}
 
-		conn->key_type = key->type;
-		conn->pin_length = key->pin_len;
+		conn_set_key(conn, key->type, key->pin_len);
 	}
 
 	bacpy(&cp.bdaddr, &ev->bdaddr);
@@ -3266,12 +3297,8 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (conn) {
 		hci_conn_hold(conn);
 		conn->disc_timeout = HCI_DISCONN_TIMEOUT;
-		pin_len = conn->pin_length;
-
-		if (ev->key_type != HCI_LK_CHANGED_COMBINATION)
-			conn->key_type = ev->key_type;
-
 		hci_conn_drop(conn);
+		conn_set_key(conn, ev->key_type, conn->pin_length);
 	}
 
 	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
@@ -3282,6 +3309,12 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!key)
 		goto unlock;
 
+	/* Update connection information since adding the key will have
+	 * fixed up the type in the case of changed combination keys.
+	 */
+	if (ev->key_type == HCI_LK_CHANGED_COMBINATION)
+		conn_set_key(conn, key->type, key->pin_len);
+
 	mgmt_new_link_key(hdev, key, persistent);
 
 	/* Keep debug keys around only if the HCI_KEEP_DEBUG_KEYS flag
-- 
2.1.0

