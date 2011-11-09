Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Add public/random LE address information to mgmt messages
Date: Wed,  9 Nov 2011 13:58:58 +0200
Message-Id: <1320839938-24873-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1320839938-24873-1-git-send-email-johan.hedberg@gmail.com>
References: <1320839938-24873-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

It's necessary to know the distinction between public and random LE
addresses so the mgmt interface also needs to distinguish between them.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   14 ++++++++------
 include/net/bluetooth/mgmt.h     |    4 ++--
 net/bluetooth/hci_event.c        |   21 ++++++++++++---------
 net/bluetooth/mgmt.c             |   35 ++++++++++++++++++++++-------------
 4 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0a5a05d..5f401e7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -915,11 +915,13 @@ int mgmt_connectable(struct hci_dev *hdev, u8 connectable);
 int mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status);
 int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 								u8 persistent);
-int mgmt_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
-int mgmt_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
+int mgmt_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+								u8 addr_type);
+int mgmt_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+								u8 addr_type);
 int mgmt_disconnect_failed(struct hci_dev *hdev);
-int mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type,
-								u8 status);
+int mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+						u8 addr_type, u8 status);
 int mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure);
 int mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 								u8 status);
@@ -935,8 +937,8 @@ int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 status);
 int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 						u8 *randomizer, u8 status);
-int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type,
-					u8 *dev_class, s8 rssi, u8 *eir);
+int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+				u8 addr_type, u8 *dev_class, s8 rssi, u8 *eir);
 int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *name);
 int mgmt_inquiry_failed(struct hci_dev *hdev, u8 status);
 int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 3e320c9..76a3f16 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -129,8 +129,8 @@ struct mgmt_rp_disconnect {
 } __packed;
 
 #define MGMT_ADDR_BREDR			0x00
-#define MGMT_ADDR_LE			0x01
-#define MGMT_ADDR_BREDR_LE		0x02
+#define MGMT_ADDR_LE_PUBLIC		0x01
+#define MGMT_ADDR_LE_RANDOM		0x02
 #define MGMT_ADDR_INVALID		0xff
 
 struct mgmt_addr_info {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a89cf1f..bbfaaa8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1437,7 +1437,7 @@ static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *
 		data.rssi		= 0x00;
 		data.ssp_mode		= 0x00;
 		hci_inquiry_cache_update(hdev, &data);
-		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK,
+		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 						info->dev_class, 0, NULL);
 	}
 
@@ -1472,7 +1472,8 @@ static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 			conn->state = BT_CONFIG;
 			hci_conn_hold(conn);
 			conn->disc_timeout = HCI_DISCONN_TIMEOUT;
-			mgmt_connected(hdev, &ev->bdaddr, conn->type);
+			mgmt_connected(hdev, &ev->bdaddr, conn->type,
+							conn->dst_type);
 		} else
 			conn->state = BT_CONNECTED;
 
@@ -1505,7 +1506,7 @@ static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 		conn->state = BT_CLOSED;
 		if (conn->type == ACL_LINK)
 			mgmt_connect_failed(hdev, &ev->bdaddr, conn->type,
-								ev->status);
+						conn->dst_type, ev->status);
 	}
 
 	if (conn->type == ACL_LINK)
@@ -1620,7 +1621,8 @@ static inline void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff
 	conn->state = BT_CLOSED;
 
 	if (conn->type == ACL_LINK || conn->type == LE_LINK)
-		mgmt_disconnected(hdev, &conn->dst, conn->type);
+		mgmt_disconnected(hdev, &conn->dst, conn->type,
+							conn->dst_type);
 
 	hci_proto_disconn_cfm(conn, ev->reason);
 	hci_conn_del(conn);
@@ -2444,7 +2446,7 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 			data.rssi		= info->rssi;
 			data.ssp_mode		= 0x00;
 			hci_inquiry_cache_update(hdev, &data);
-			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK,
+			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 						info->dev_class, info->rssi,
 						NULL);
 		}
@@ -2461,7 +2463,7 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 			data.rssi		= info->rssi;
 			data.ssp_mode		= 0x00;
 			hci_inquiry_cache_update(hdev, &data);
-			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK,
+			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 						info->dev_class, info->rssi,
 						NULL);
 		}
@@ -2604,7 +2606,7 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 		data.rssi		= info->rssi;
 		data.ssp_mode		= 0x01;
 		hci_inquiry_cache_update(hdev, &data);
-		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK,
+		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 				info->dev_class, info->rssi, info->data);
 	}
 
@@ -2868,14 +2870,15 @@ static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff
 	}
 
 	if (ev->status) {
-		mgmt_connect_failed(hdev, &ev->bdaddr, conn->type, ev->status);
+		mgmt_connect_failed(hdev, &ev->bdaddr, conn->type,
+						conn->dst_type, ev->status);
 		hci_proto_connect_cfm(conn, ev->status);
 		conn->state = BT_CLOSED;
 		hci_conn_del(conn);
 		goto unlock;
 	}
 
-	mgmt_connected(hdev, &ev->bdaddr, conn->type);
+	mgmt_connected(hdev, &ev->bdaddr, conn->type, conn->dst_type);
 
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->handle = __le16_to_cpu(ev->handle);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a6720c6..d23a803 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1063,11 +1063,18 @@ failed:
 	return err;
 }
 
-static u8 link_to_mgmt(u8 link_type)
+static u8 link_to_mgmt(u8 link_type, u8 addr_type)
 {
 	switch (link_type) {
 	case LE_LINK:
-		return MGMT_ADDR_LE;
+		switch (addr_type) {
+		case ADDR_LE_DEV_PUBLIC:
+			return MGMT_ADDR_LE_PUBLIC;
+		case ADDR_LE_DEV_RANDOM:
+			return MGMT_ADDR_LE_RANDOM;
+		default:
+			return MGMT_ADDR_INVALID;
+		}
 	case ACL_LINK:
 		return MGMT_ADDR_BREDR;
 	default:
@@ -1110,7 +1117,7 @@ static int get_connections(struct sock *sk, u16 index)
 	i = 0;
 	list_for_each_entry(c, &hdev->conn_hash.list, list) {
 		bacpy(&rp->addr[i].bdaddr, &c->dst);
-		rp->addr[i].type = link_to_mgmt(c->type);
+		rp->addr[i].type = link_to_mgmt(c->type, c->dst_type);
 		if (rp->addr[i].type == MGMT_ADDR_INVALID)
 			continue;
 		i++;
@@ -2088,12 +2095,13 @@ int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 	return mgmt_event(MGMT_EV_NEW_LINK_KEY, hdev, &ev, sizeof(ev), NULL);
 }
 
-int mgmt_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type)
+int mgmt_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+								u8 addr_type)
 {
 	struct mgmt_addr_info ev;
 
 	bacpy(&ev.bdaddr, bdaddr);
-	ev.type = link_to_mgmt(link_type);
+	ev.type = link_to_mgmt(link_type, addr_type);
 
 	return mgmt_event(MGMT_EV_CONNECTED, hdev, &ev, sizeof(ev), NULL);
 }
@@ -2114,7 +2122,8 @@ static void disconnect_rsp(struct pending_cmd *cmd, void *data)
 	mgmt_pending_remove(cmd);
 }
 
-int mgmt_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
+int mgmt_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+								u8 addr_type)
 {
 	struct mgmt_addr_info ev;
 	struct sock *sk = NULL;
@@ -2123,7 +2132,7 @@ int mgmt_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 	mgmt_pending_foreach(MGMT_OP_DISCONNECT, hdev, disconnect_rsp, &sk);
 
 	bacpy(&ev.bdaddr, bdaddr);
-	ev.type = link_to_mgmt(type);
+	ev.type = link_to_mgmt(link_type, addr_type);
 
 	err = mgmt_event(MGMT_EV_DISCONNECTED, hdev, &ev, sizeof(ev), sk);
 
@@ -2149,13 +2158,13 @@ int mgmt_disconnect_failed(struct hci_dev *hdev)
 	return err;
 }
 
-int mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type,
-								u8 status)
+int mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+						u8 addr_type, u8 status)
 {
 	struct mgmt_ev_connect_failed ev;
 
 	bacpy(&ev.addr.bdaddr, bdaddr);
-	ev.addr.type = link_to_mgmt(type);
+	ev.addr.type = link_to_mgmt(link_type, addr_type);
 	ev.status = status;
 
 	return mgmt_event(MGMT_EV_CONNECT_FAILED, hdev, &ev, sizeof(ev), NULL);
@@ -2342,15 +2351,15 @@ int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 	return err;
 }
 
-int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type,
-					u8 *dev_class, s8 rssi, u8 *eir)
+int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+				u8 addr_type, u8 *dev_class, s8 rssi, u8 *eir)
 {
 	struct mgmt_ev_device_found ev;
 
 	memset(&ev, 0, sizeof(ev));
 
 	bacpy(&ev.addr.bdaddr, bdaddr);
-	ev.addr.type = link_to_mgmt(type);
+	ev.addr.type = link_to_mgmt(link_type, addr_type);
 	ev.rssi = rssi;
 
 	if (eir)
-- 
1.7.7.1

