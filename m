Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Add address type fields to mgmt messages that need them
Date: Mon,  7 Nov 2011 23:13:39 +0200
Message-Id: <1320700419-4665-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1320700419-4665-1-git-send-email-johan.hedberg@gmail.com>
References: <1320700419-4665-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds address type info (typically BR/EDR vs LE) to management
messages that need this. This also ensures conformance to the latest
management API specification.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   10 ++++----
 include/net/bluetooth/mgmt.h     |   23 ++++++++++--------
 net/bluetooth/hci_event.c        |   20 +++++++++-------
 net/bluetooth/mgmt.c             |   47 ++++++++++++++++++++++++++++---------
 4 files changed, 64 insertions(+), 36 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4ebc882..e6071d0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -912,10 +912,10 @@ int mgmt_discoverable(u16 index, u8 discoverable);
 int mgmt_connectable(u16 index, u8 connectable);
 int mgmt_write_scan_failed(u16 index, u8 scan, u8 status);
 int mgmt_new_link_key(u16 index, struct link_key *key, u8 persistent);
-int mgmt_connected(u16 index, bdaddr_t *bdaddr, u8 link_type);
-int mgmt_disconnected(u16 index, bdaddr_t *bdaddr);
+int mgmt_connected(u16 index, bdaddr_t *bdaddr, u8 type);
+int mgmt_disconnected(u16 index, bdaddr_t *bdaddr, u8 type);
 int mgmt_disconnect_failed(u16 index);
-int mgmt_connect_failed(u16 index, bdaddr_t *bdaddr, u8 status);
+int mgmt_connect_failed(u16 index, bdaddr_t *bdaddr, u8 type, u8 status);
 int mgmt_pin_code_request(u16 index, bdaddr_t *bdaddr, u8 secure);
 int mgmt_pin_code_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status);
 int mgmt_pin_code_neg_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status);
@@ -928,8 +928,8 @@ int mgmt_auth_failed(u16 index, bdaddr_t *bdaddr, u8 status);
 int mgmt_set_local_name_complete(u16 index, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
 								u8 status);
-int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
-								u8 *eir);
+int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 type, u8 *dev_class,
+							s8 rssi, u8 *eir);
 int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
 int mgmt_inquiry_failed(u16 index, u8 status);
 int mgmt_discovering(u16 index, u8 discovering);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index fa33bc6..3e320c9 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -128,10 +128,20 @@ struct mgmt_rp_disconnect {
 	bdaddr_t bdaddr;
 } __packed;
 
+#define MGMT_ADDR_BREDR			0x00
+#define MGMT_ADDR_LE			0x01
+#define MGMT_ADDR_BREDR_LE		0x02
+#define MGMT_ADDR_INVALID		0xff
+
+struct mgmt_addr_info {
+	bdaddr_t bdaddr;
+	__u8 type;
+} __packed;
+
 #define MGMT_OP_GET_CONNECTIONS		0x0010
 struct mgmt_rp_get_connections {
 	__le16 conn_count;
-	bdaddr_t conn[0];
+	struct mgmt_addr_info addr[0];
 } __packed;
 
 #define MGMT_OP_PIN_CODE_REPLY		0x0011
@@ -254,19 +264,12 @@ struct mgmt_ev_new_link_key {
 } __packed;
 
 #define MGMT_EV_CONNECTED		0x000B
-struct mgmt_ev_connected {
-	bdaddr_t bdaddr;
-	__u8 link_type;
-} __packed;
 
 #define MGMT_EV_DISCONNECTED		0x000C
-struct mgmt_ev_disconnected {
-	bdaddr_t bdaddr;
-} __packed;
 
 #define MGMT_EV_CONNECT_FAILED		0x000D
 struct mgmt_ev_connect_failed {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 	__u8 status;
 } __packed;
 
@@ -296,7 +299,7 @@ struct mgmt_ev_local_name_changed {
 
 #define MGMT_EV_DEVICE_FOUND		0x0012
 struct mgmt_ev_device_found {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 	__u8 dev_class[3];
 	__s8 rssi;
 	__u8 eir[HCI_MAX_EIR_LENGTH];
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 176ceca..2fced8c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1404,8 +1404,8 @@ static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *
 		data.rssi		= 0x00;
 		data.ssp_mode		= 0x00;
 		hci_inquiry_cache_update(hdev, &data);
-		mgmt_device_found(hdev->id, &info->bdaddr, info->dev_class, 0,
-									NULL);
+		mgmt_device_found(hdev->id, &info->bdaddr, ACL_LINK,
+						info->dev_class, 0, NULL);
 	}
 
 	hci_dev_unlock(hdev);
@@ -1471,7 +1471,8 @@ static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 	} else {
 		conn->state = BT_CLOSED;
 		if (conn->type == ACL_LINK)
-			mgmt_connect_failed(hdev->id, &ev->bdaddr, ev->status);
+			mgmt_connect_failed(hdev->id, &ev->bdaddr, conn->type,
+								ev->status);
 	}
 
 	if (conn->type == ACL_LINK)
@@ -1584,7 +1585,7 @@ static inline void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff
 	conn->state = BT_CLOSED;
 
 	if (conn->type == ACL_LINK || conn->type == LE_LINK)
-		mgmt_disconnected(hdev->id, &conn->dst);
+		mgmt_disconnected(hdev->id, &conn->dst, conn->type);
 
 	hci_proto_disconn_cfm(conn, ev->reason);
 	hci_conn_del(conn);
@@ -2408,7 +2409,7 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 			data.rssi		= info->rssi;
 			data.ssp_mode		= 0x00;
 			hci_inquiry_cache_update(hdev, &data);
-			mgmt_device_found(hdev->id, &info->bdaddr,
+			mgmt_device_found(hdev->id, &info->bdaddr, ACL_LINK,
 						info->dev_class, info->rssi,
 						NULL);
 		}
@@ -2425,7 +2426,7 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 			data.rssi		= info->rssi;
 			data.ssp_mode		= 0x00;
 			hci_inquiry_cache_update(hdev, &data);
-			mgmt_device_found(hdev->id, &info->bdaddr,
+			mgmt_device_found(hdev->id, &info->bdaddr, ACL_LINK,
 						info->dev_class, info->rssi,
 						NULL);
 		}
@@ -2568,8 +2569,8 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 		data.rssi		= info->rssi;
 		data.ssp_mode		= 0x01;
 		hci_inquiry_cache_update(hdev, &data);
-		mgmt_device_found(hdev->id, &info->bdaddr, info->dev_class,
-						info->rssi, info->data);
+		mgmt_device_found(hdev->id, &info->bdaddr, ACL_LINK,
+				info->dev_class, info->rssi, info->data);
 	}
 
 	hci_dev_unlock(hdev);
@@ -2832,7 +2833,8 @@ static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff
 	}
 
 	if (ev->status) {
-		mgmt_connect_failed(hdev->id, &ev->bdaddr, ev->status);
+		mgmt_connect_failed(hdev->id, &ev->bdaddr, conn->type,
+								ev->status);
 		hci_proto_connect_cfm(conn, ev->status);
 		conn->state = BT_CLOSED;
 		hci_conn_del(conn);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7d32981..950242e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1069,6 +1069,18 @@ failed:
 	return err;
 }
 
+static u8 link_to_mgmt(u8 link_type)
+{
+	switch (link_type) {
+	case LE_LINK:
+		return MGMT_ADDR_LE;
+	case ACL_LINK:
+		return MGMT_ADDR_BREDR;
+	default:
+		return MGMT_ADDR_INVALID;
+	}
+}
+
 static int get_connections(struct sock *sk, u16 index)
 {
 	struct mgmt_rp_get_connections *rp;
@@ -1092,7 +1104,7 @@ static int get_connections(struct sock *sk, u16 index)
 		count++;
 	}
 
-	rp_len = sizeof(*rp) + (count * sizeof(bdaddr_t));
+	rp_len = sizeof(*rp) + (count * sizeof(struct mgmt_addr_info));
 	rp = kmalloc(rp_len, GFP_ATOMIC);
 	if (!rp) {
 		err = -ENOMEM;
@@ -1102,8 +1114,16 @@ static int get_connections(struct sock *sk, u16 index)
 	put_unaligned_le16(count, &rp->conn_count);
 
 	i = 0;
-	list_for_each_entry(c, &hdev->conn_hash.list, list)
-		bacpy(&rp->conn[i++], &c->dst);
+	list_for_each_entry(c, &hdev->conn_hash.list, list) {
+		bacpy(&rp->addr[i].bdaddr, &c->dst);
+		rp->addr[i].type = link_to_mgmt(c->type);
+		if (rp->addr[i].type == MGMT_ADDR_INVALID)
+			continue;
+		i++;
+	}
+
+	/* Recalculate length in case of filtered SCO connections, etc */
+	rp_len = sizeof(*rp) + (i * sizeof(struct mgmt_addr_info));
 
 	err = cmd_complete(sk, index, MGMT_OP_GET_CONNECTIONS, rp, rp_len);
 
@@ -2096,10 +2116,10 @@ int mgmt_new_link_key(u16 index, struct link_key *key, u8 persistent)
 
 int mgmt_connected(u16 index, bdaddr_t *bdaddr, u8 link_type)
 {
-	struct mgmt_ev_connected ev;
+	struct mgmt_addr_info ev;
 
 	bacpy(&ev.bdaddr, bdaddr);
-	ev.link_type = link_type;
+	ev.type = link_to_mgmt(link_type);
 
 	return mgmt_event(MGMT_EV_CONNECTED, index, &ev, sizeof(ev), NULL);
 }
@@ -2120,15 +2140,16 @@ static void disconnect_rsp(struct pending_cmd *cmd, void *data)
 	mgmt_pending_remove(cmd);
 }
 
-int mgmt_disconnected(u16 index, bdaddr_t *bdaddr)
+int mgmt_disconnected(u16 index, bdaddr_t *bdaddr, u8 type)
 {
-	struct mgmt_ev_disconnected ev;
+	struct mgmt_addr_info ev;
 	struct sock *sk = NULL;
 	int err;
 
 	mgmt_pending_foreach(MGMT_OP_DISCONNECT, index, disconnect_rsp, &sk);
 
 	bacpy(&ev.bdaddr, bdaddr);
+	ev.type = link_to_mgmt(type);
 
 	err = mgmt_event(MGMT_EV_DISCONNECTED, index, &ev, sizeof(ev), sk);
 
@@ -2154,11 +2175,12 @@ int mgmt_disconnect_failed(u16 index)
 	return err;
 }
 
-int mgmt_connect_failed(u16 index, bdaddr_t *bdaddr, u8 status)
+int mgmt_connect_failed(u16 index, bdaddr_t *bdaddr, u8 type, u8 status)
 {
 	struct mgmt_ev_connect_failed ev;
 
-	bacpy(&ev.bdaddr, bdaddr);
+	bacpy(&ev.addr.bdaddr, bdaddr);
+	ev.addr.type = link_to_mgmt(type);
 	ev.status = status;
 
 	return mgmt_event(MGMT_EV_CONNECT_FAILED, index, &ev, sizeof(ev), NULL);
@@ -2346,14 +2368,15 @@ int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
 	return err;
 }
 
-int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
-								u8 *eir)
+int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 type, u8 *dev_class,
+							s8 rssi, u8 *eir)
 {
 	struct mgmt_ev_device_found ev;
 
 	memset(&ev, 0, sizeof(ev));
 
-	bacpy(&ev.bdaddr, bdaddr);
+	bacpy(&ev.addr.bdaddr, bdaddr);
+	ev.addr.type = link_to_mgmt(type);
 	ev.rssi = rssi;
 
 	if (eir)
-- 
1.7.7.1

