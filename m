Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] Bluetooth: Move check for MGMT_CONNECTED flag into mgmt.c
Date: Mon, 24 Feb 2014 14:52:18 +0200
Message-Id: <1393246342-27980-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393246342-27980-1-git-send-email-johan.hedberg@gmail.com>
References: <1393246342-27980-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Once mgmt_set_powered(off) starts doing disconnections we'll need to
care about any disconnections in mgmt.c and not just those with the
MGMT_CONNECTED flag set. Therefore, move the check into mgmt.c from
hci_event.c.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 3 ++-
 net/bluetooth/hci_event.c        | 7 ++++---
 net/bluetooth/mgmt.c             | 6 +++++-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6ff882e727d4..269c8201a362 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1182,7 +1182,8 @@ void mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			   u8 addr_type, u32 flags, u8 *name, u8 name_len,
 			   u8 *dev_class);
 void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			      u8 link_type, u8 addr_type, u8 reason);
+			      u8 link_type, u8 addr_type, u8 reason,
+			      bool mgmt_connected);
 void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 link_type, u8 addr_type, u8 status);
 void mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dea465ba276b..877cee844b9e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1842,6 +1842,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	struct hci_ev_disconn_complete *ev = (void *) skb->data;
 	u8 reason = hci_to_mgmt_reason(ev->reason);
 	struct hci_conn *conn;
+	bool mgmt_connected;
 	u8 type;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
@@ -1860,9 +1861,9 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	conn->state = BT_CLOSED;
 
-	if (test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
-		mgmt_device_disconnected(hdev, &conn->dst, conn->type,
-					 conn->dst_type, reason);
+	mgmt_connected = test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags);
+	mgmt_device_disconnected(hdev, &conn->dst, conn->type, conn->dst_type,
+				reason, mgmt_connected);
 
 	if (conn->type == ACL_LINK && conn->flush_key)
 		hci_remove_link_key(hdev, &conn->dst);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d39e57e9fed6..bdc831b3bb97 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5012,11 +5012,15 @@ static void unpair_device_rsp(struct pending_cmd *cmd, void *data)
 }
 
 void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			      u8 link_type, u8 addr_type, u8 reason)
+			      u8 link_type, u8 addr_type, u8 reason,
+			      bool mgmt_connected)
 {
 	struct mgmt_ev_device_disconnected ev;
 	struct sock *sk = NULL;
 
+	if (!mgmt_connected)
+		return;
+
 	if (link_type != ACL_LINK && link_type != LE_LINK)
 		return;
 
-- 
1.8.5.3

