Return-Path: <cyrus@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Refactor arguments of mgmt_device_connected
Date: Fri,  3 Oct 2014 12:10:25 +0000
Message-Id: <1412338226-7351-2-git-send-email-fons@spotify.com>
In-Reply-To: <1412338226-7351-1-git-send-email-fons@spotify.com>
References: <1412338226-7351-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pass hci_conn to mgmt_device_connected to reduce its argument number.

Signed-off-by: Alfonso Acosta <fons@spotify.com>
---
 include/net/bluetooth/hci_core.h |  5 ++---
 net/bluetooth/hci_event.c        | 14 ++++----------
 net/bluetooth/l2cap_core.c       |  4 +---
 net/bluetooth/mgmt.c             | 13 ++++++-------
 4 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 37ff1ae..f1407fe 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1310,9 +1310,8 @@ int mgmt_update_adv_data(struct hci_dev *hdev);
 void mgmt_discoverable_timeout(struct hci_dev *hdev);
 void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 		       bool persistent);
-void mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-			   u8 addr_type, u32 flags, u8 *name, u8 name_len,
-			   u8 *dev_class);
+void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
+			   u32 flags, u8 *name, u8 name_len);
 void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			      u8 link_type, u8 addr_type, u8 reason,
 			      bool mgmt_connected);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8b0a2a6..6ee7de2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1577,8 +1577,7 @@ static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *conn,
 	struct inquiry_entry *e;
 
 	if (conn && !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
-		mgmt_device_connected(hdev, bdaddr, ACL_LINK, 0x00, 0, name,
-				      name_len, conn->dev_class);
+		mgmt_device_connected(hdev, conn, 0, name, name_len);
 
 	if (discov->state == DISCOVERY_STOPPED)
 		return;
@@ -2536,9 +2535,7 @@ static void hci_remote_features_evt(struct hci_dev *hdev,
 		cp.pscan_rep_mode = 0x02;
 		hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
 	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
-		mgmt_device_connected(hdev, &conn->dst, conn->type,
-				      conn->dst_type, 0, NULL, 0,
-				      conn->dev_class);
+		mgmt_device_connected(hdev, conn, 0, NULL, 0);
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
@@ -3434,9 +3431,7 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev,
 		cp.pscan_rep_mode = 0x02;
 		hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
 	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
-		mgmt_device_connected(hdev, &conn->dst, conn->type,
-				      conn->dst_type, 0, NULL, 0,
-				      conn->dev_class);
+		mgmt_device_connected(hdev, conn, 0, NULL, 0);
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
@@ -4214,8 +4209,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
-		mgmt_device_connected(hdev, &conn->dst, conn->type,
-				      conn->dst_type, 0, NULL, 0, NULL);
+		mgmt_device_connected(hdev, conn, 0, NULL, 0);
 
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->handle = __le16_to_cpu(ev->handle);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b6f9777..2ff5591 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3873,9 +3873,7 @@ static int l2cap_connect_req(struct l2cap_conn *conn,
 	hci_dev_lock(hdev);
 	if (test_bit(HCI_MGMT, &hdev->dev_flags) &&
 	    !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &hcon->flags))
-		mgmt_device_connected(hdev, &hcon->dst, hcon->type,
-				      hcon->dst_type, 0, NULL, 0,
-				      hcon->dev_class);
+		mgmt_device_connected(hdev, hcon, 0, NULL, 0);
 	hci_dev_unlock(hdev);
 
 	l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP, 0);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index efb71b0..fc275dc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6171,16 +6171,15 @@ static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
 	return eir_len;
 }
 
-void mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-			   u8 addr_type, u32 flags, u8 *name, u8 name_len,
-			   u8 *dev_class)
+void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
+			   u32 flags, u8 *name, u8 name_len)
 {
 	char buf[512];
 	struct mgmt_ev_device_connected *ev = (void *) buf;
 	u16 eir_len = 0;
 
-	bacpy(&ev->addr.bdaddr, bdaddr);
-	ev->addr.type = link_to_bdaddr(link_type, addr_type);
+	bacpy(&ev->addr.bdaddr, &conn->dst);
+	ev->addr.type = link_to_bdaddr(conn->type, conn->dst_type);
 
 	ev->flags = __cpu_to_le32(flags);
 
@@ -6188,9 +6187,9 @@ void mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		eir_len = eir_append_data(ev->eir, 0, EIR_NAME_COMPLETE,
 					  name, name_len);
 
-	if (dev_class && memcmp(dev_class, "\0\0\0", 3) != 0)
+	if (conn->dev_class && memcmp(conn->dev_class, "\0\0\0", 3) != 0)
 		eir_len = eir_append_data(ev->eir, eir_len,
-					  EIR_CLASS_OF_DEV, dev_class, 3);
+					  EIR_CLASS_OF_DEV, conn->dev_class, 3);
 
 	ev->eir_len = cpu_to_le16(eir_len);
 
-- 
1.9.1

