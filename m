Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/15] Bluetooth: Rename mgmt connected events to match user space
Date: Wed, 18 Jan 2012 20:51:44 +0200
Message-Id: <1326912717-6347-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

User space uses device_(dis)connected instead of just (dis)connected so
rename the defines and functions to match this.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    6 +++---
 include/net/bluetooth/mgmt.h     |    4 ++--
 net/bluetooth/hci_event.c        |    6 +++---
 net/bluetooth/mgmt.c             |   12 +++++++-----
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 393acd0..f3fbfd6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -896,10 +896,10 @@ int mgmt_connectable(struct hci_dev *hdev, u8 connectable);
 int mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status);
 int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 								u8 persistent);
-int mgmt_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-								u8 addr_type);
-int mgmt_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+int mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 								u8 addr_type);
+int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
+						u8 link_type, u8 addr_type);
 int mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 status);
 int mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 						u8 addr_type, u8 status);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index be65d34..d1d13dc 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -328,9 +328,9 @@ struct mgmt_ev_new_link_key {
 	struct mgmt_link_key_info key;
 } __packed;
 
-#define MGMT_EV_CONNECTED		0x000A
+#define MGMT_EV_DEVICE_CONNECTED	0x000A
 
-#define MGMT_EV_DISCONNECTED		0x000B
+#define MGMT_EV_DEVICE_DISCONNECTED	0x000B
 
 #define MGMT_EV_CONNECT_FAILED		0x000C
 struct mgmt_ev_connect_failed {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4eef43c..8d7505a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1643,7 +1643,7 @@ static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 			conn->state = BT_CONFIG;
 			hci_conn_hold(conn);
 			conn->disc_timeout = HCI_DISCONN_TIMEOUT;
-			mgmt_connected(hdev, &ev->bdaddr, conn->type,
+			mgmt_device_connected(hdev, &ev->bdaddr, conn->type,
 							conn->dst_type);
 		} else
 			conn->state = BT_CONNECTED;
@@ -1789,7 +1789,7 @@ static inline void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff
 		if (ev->status != 0)
 			mgmt_disconnect_failed(hdev, &conn->dst, ev->status);
 		else
-			mgmt_disconnected(hdev, &conn->dst, conn->type,
+			mgmt_device_disconnected(hdev, &conn->dst, conn->type,
 							conn->dst_type);
 	}
 
@@ -3188,7 +3188,7 @@ static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff
 		goto unlock;
 	}
 
-	mgmt_connected(hdev, &ev->bdaddr, conn->type, conn->dst_type);
+	mgmt_device_connected(hdev, &ev->bdaddr, conn->type, conn->dst_type);
 
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->handle = __le16_to_cpu(ev->handle);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e7bbad8..c8042c6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2464,7 +2464,7 @@ int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 	return mgmt_event(MGMT_EV_NEW_LINK_KEY, hdev, &ev, sizeof(ev), NULL);
 }
 
-int mgmt_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+int mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 								u8 addr_type)
 {
 	struct mgmt_addr_info ev;
@@ -2472,7 +2472,8 @@ int mgmt_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	bacpy(&ev.bdaddr, bdaddr);
 	ev.type = link_to_mgmt(link_type, addr_type);
 
-	return mgmt_event(MGMT_EV_CONNECTED, hdev, &ev, sizeof(ev), NULL);
+	return mgmt_event(MGMT_EV_DEVICE_CONNECTED, hdev, &ev, sizeof(ev),
+									NULL);
 }
 
 static void disconnect_rsp(struct pending_cmd *cmd, void *data)
@@ -2509,8 +2510,8 @@ static void remove_keys_rsp(struct pending_cmd *cmd, void *data)
 	mgmt_pending_remove(cmd);
 }
 
-int mgmt_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-								u8 addr_type)
+int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
+						u8 link_type, u8 addr_type)
 {
 	struct mgmt_addr_info ev;
 	struct sock *sk = NULL;
@@ -2521,7 +2522,8 @@ int mgmt_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	bacpy(&ev.bdaddr, bdaddr);
 	ev.type = link_to_mgmt(link_type, addr_type);
 
-	err = mgmt_event(MGMT_EV_DISCONNECTED, hdev, &ev, sizeof(ev), sk);
+	err = mgmt_event(MGMT_EV_DEVICE_DISCONNECTED, hdev, &ev, sizeof(ev),
+									sk);
 
 	if (sk)
 		sock_put(sk);
-- 
1.7.8.3

