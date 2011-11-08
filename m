Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Pass full hci_dev struct to mgmt callbacks
Date: Tue,  8 Nov 2011 20:40:14 +0200
Message-Id: <1320777616-15794-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The current global pending command list in mgmt.c is racy. Possibly the
simplest way to fix it is to have per-hci dev lists instead of a global
one (all commands that need a pending struct are hci_dev specific).
This way the list can be protected using the already existing per-hci
dev lock. To enable this refactoring the first thing that needs to be
done is to ensure that the mgmt functions have access to the hci_dev
struct (instead of just the dev id).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   61 ++++++-----
 net/bluetooth/hci_core.c         |   16 ++--
 net/bluetooth/hci_event.c        |   63 ++++++------
 net/bluetooth/mgmt.c             |  206 +++++++++++++++++++------------------
 4 files changed, 178 insertions(+), 168 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e6071d0..0f35a39 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -905,36 +905,41 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb,
 
 /* Management interface */
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
-int mgmt_index_added(u16 index);
-int mgmt_index_removed(u16 index);
-int mgmt_powered(u16 index, u8 powered);
-int mgmt_discoverable(u16 index, u8 discoverable);
-int mgmt_connectable(u16 index, u8 connectable);
-int mgmt_write_scan_failed(u16 index, u8 scan, u8 status);
-int mgmt_new_link_key(u16 index, struct link_key *key, u8 persistent);
-int mgmt_connected(u16 index, bdaddr_t *bdaddr, u8 type);
-int mgmt_disconnected(u16 index, bdaddr_t *bdaddr, u8 type);
-int mgmt_disconnect_failed(u16 index);
-int mgmt_connect_failed(u16 index, bdaddr_t *bdaddr, u8 type, u8 status);
-int mgmt_pin_code_request(u16 index, bdaddr_t *bdaddr, u8 secure);
-int mgmt_pin_code_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status);
-int mgmt_pin_code_neg_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status);
-int mgmt_user_confirm_request(u16 index, bdaddr_t *bdaddr, __le32 value,
-							u8 confirm_hint);
-int mgmt_user_confirm_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status);
-int mgmt_user_confirm_neg_reply_complete(u16 index, bdaddr_t *bdaddr,
+int mgmt_index_added(struct hci_dev *hdev);
+int mgmt_index_removed(struct hci_dev *hdev);
+int mgmt_powered(struct hci_dev *hdev, u8 powered);
+int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable);
+int mgmt_connectable(struct hci_dev *hdev, u8 connectable);
+int mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status);
+int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
+								u8 persistent);
+int mgmt_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
+int mgmt_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
+int mgmt_disconnect_failed(struct hci_dev *hdev);
+int mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type,
 								u8 status);
-int mgmt_auth_failed(u16 index, bdaddr_t *bdaddr, u8 status);
-int mgmt_set_local_name_complete(u16 index, u8 *name, u8 status);
-int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
+int mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure);
+int mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 								u8 status);
-int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 type, u8 *dev_class,
-							s8 rssi, u8 *eir);
-int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
-int mgmt_inquiry_failed(u16 index, u8 status);
-int mgmt_discovering(u16 index, u8 discovering);
-int mgmt_device_blocked(u16 index, bdaddr_t *bdaddr);
-int mgmt_device_unblocked(u16 index, bdaddr_t *bdaddr);
+int mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+								u8 status);
+int mgmt_user_confirm_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
+						__le32 value, u8 confirm_hint);
+int mgmt_user_confirm_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+								u8 status);
+int mgmt_user_confirm_neg_reply_complete(struct hci_dev *hdev,
+						bdaddr_t *bdaddr, u8 status);
+int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 status);
+int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
+int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
+						u8 *randomizer, u8 status);
+int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type,
+					u8 *dev_class, s8 rssi, u8 *eir);
+int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *name);
+int mgmt_inquiry_failed(struct hci_dev *hdev, u8 status);
+int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
+int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr);
+int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 693c0df..e4b5c63 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -550,7 +550,7 @@ int hci_dev_open(__u16 dev)
 		set_bit(HCI_UP, &hdev->flags);
 		hci_notify(hdev, HCI_DEV_UP);
 		if (!test_bit(HCI_SETUP, &hdev->flags))
-			mgmt_powered(hdev->id, 1);
+			mgmt_powered(hdev, 1);
 	} else {
 		/* Init failed, cleanup */
 		tasklet_kill(&hdev->rx_task);
@@ -642,7 +642,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	 * and no tasks are scheduled. */
 	hdev->close(hdev);
 
-	mgmt_powered(hdev->id, 0);
+	mgmt_powered(hdev, 0);
 
 	/* Clear flags */
 	hdev->flags = 0;
@@ -947,7 +947,7 @@ static void hci_power_on(struct work_struct *work)
 					msecs_to_jiffies(AUTO_OFF_TIMEOUT));
 
 	if (test_and_clear_bit(HCI_SETUP, &hdev->flags))
-		mgmt_index_added(hdev->id);
+		mgmt_index_added(hdev);
 }
 
 static void hci_power_off(struct work_struct *work)
@@ -1140,7 +1140,7 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 
 	persistent = hci_persistent_key(hdev, conn, type, old_key_type);
 
-	mgmt_new_link_key(hdev->id, key, persistent);
+	mgmt_new_link_key(hdev, key, persistent);
 
 	if (!persistent) {
 		list_del(&key->list);
@@ -1183,7 +1183,7 @@ int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
 	memcpy(id->rand, rand, sizeof(id->rand));
 
 	if (new_key)
-		mgmt_new_link_key(hdev->id, key, old_key_type);
+		mgmt_new_link_key(hdev, key, old_key_type);
 
 	return 0;
 }
@@ -1324,7 +1324,7 @@ int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr)
 
 	list_add(&entry->list, &hdev->blacklist);
 
-	return mgmt_device_blocked(hdev->id, bdaddr);
+	return mgmt_device_blocked(hdev, bdaddr);
 }
 
 int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr)
@@ -1343,7 +1343,7 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	list_del(&entry->list);
 	kfree(entry);
 
-	return mgmt_device_unblocked(hdev->id, bdaddr);
+	return mgmt_device_unblocked(hdev, bdaddr);
 }
 
 static void hci_clear_adv_cache(unsigned long arg)
@@ -1560,7 +1560,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	if (!test_bit(HCI_INIT, &hdev->flags) &&
 					!test_bit(HCI_SETUP, &hdev->flags))
-		mgmt_index_removed(hdev->id);
+		mgmt_index_removed(hdev);
 
 	hci_notify(hdev, HCI_DEV_UNREG);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2fced8c..8303f8f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -60,7 +60,7 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 
 	clear_bit(HCI_INQUIRY, &hdev->flags);
 
-	mgmt_discovering(hdev->id, 0);
+	mgmt_discovering(hdev, 0);
 
 	hci_req_complete(hdev, HCI_OP_INQUIRY_CANCEL, status);
 
@@ -202,7 +202,7 @@ static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 
 	if (test_bit(HCI_MGMT, &hdev->flags))
-		mgmt_set_local_name_complete(hdev->id, sent, status);
+		mgmt_set_local_name_complete(hdev, sent, status);
 
 	if (status)
 		return;
@@ -283,7 +283,7 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 	param = *((__u8 *) sent);
 
 	if (status != 0) {
-		mgmt_write_scan_failed(hdev->id, param, status);
+		mgmt_write_scan_failed(hdev, param, status);
 		hdev->discov_timeout = 0;
 		goto done;
 	}
@@ -294,21 +294,21 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 	if (param & SCAN_INQUIRY) {
 		set_bit(HCI_ISCAN, &hdev->flags);
 		if (!old_iscan)
-			mgmt_discoverable(hdev->id, 1);
+			mgmt_discoverable(hdev, 1);
 		if (hdev->discov_timeout > 0) {
 			int to = msecs_to_jiffies(hdev->discov_timeout * 1000);
 			queue_delayed_work(hdev->workqueue, &hdev->discov_off,
 									to);
 		}
 	} else if (old_iscan)
-		mgmt_discoverable(hdev->id, 0);
+		mgmt_discoverable(hdev, 0);
 
 	if (param & SCAN_PAGE) {
 		set_bit(HCI_PSCAN, &hdev->flags);
 		if (!old_pscan)
-			mgmt_connectable(hdev->id, 1);
+			mgmt_connectable(hdev, 1);
 	} else if (old_pscan)
-		mgmt_connectable(hdev->id, 0);
+		mgmt_connectable(hdev, 0);
 
 done:
 	hci_req_complete(hdev, HCI_OP_WRITE_SCAN_ENABLE, status);
@@ -835,7 +835,7 @@ static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s status 0x%x", hdev->name, rp->status);
 
 	if (test_bit(HCI_MGMT, &hdev->flags))
-		mgmt_pin_code_reply_complete(hdev->id, &rp->bdaddr, rp->status);
+		mgmt_pin_code_reply_complete(hdev, &rp->bdaddr, rp->status);
 
 	if (rp->status != 0)
 		return;
@@ -856,7 +856,7 @@ static void hci_cc_pin_code_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s status 0x%x", hdev->name, rp->status);
 
 	if (test_bit(HCI_MGMT, &hdev->flags))
-		mgmt_pin_code_neg_reply_complete(hdev->id, &rp->bdaddr,
+		mgmt_pin_code_neg_reply_complete(hdev, &rp->bdaddr,
 								rp->status);
 }
 static void hci_cc_le_read_buffer_size(struct hci_dev *hdev,
@@ -886,7 +886,7 @@ static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s status 0x%x", hdev->name, rp->status);
 
 	if (test_bit(HCI_MGMT, &hdev->flags))
-		mgmt_user_confirm_reply_complete(hdev->id, &rp->bdaddr,
+		mgmt_user_confirm_reply_complete(hdev, &rp->bdaddr,
 								rp->status);
 }
 
@@ -898,7 +898,7 @@ static void hci_cc_user_confirm_neg_reply(struct hci_dev *hdev,
 	BT_DBG("%s status 0x%x", hdev->name, rp->status);
 
 	if (test_bit(HCI_MGMT, &hdev->flags))
-		mgmt_user_confirm_neg_reply_complete(hdev->id, &rp->bdaddr,
+		mgmt_user_confirm_neg_reply_complete(hdev, &rp->bdaddr,
 								rp->status);
 }
 
@@ -909,7 +909,7 @@ static void hci_cc_read_local_oob_data_reply(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%x", hdev->name, rp->status);
 
-	mgmt_read_local_oob_data_reply_complete(hdev->id, rp->hash,
+	mgmt_read_local_oob_data_reply_complete(hdev, rp->hash,
 						rp->randomizer, rp->status);
 }
 
@@ -986,13 +986,13 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 		hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 		hci_conn_check_pending(hdev);
 		if (test_bit(HCI_MGMT, &hdev->flags))
-			mgmt_inquiry_failed(hdev->id, status);
+			mgmt_inquiry_failed(hdev, status);
 		return;
 	}
 
 	set_bit(HCI_INQUIRY, &hdev->flags);
 
-	mgmt_discovering(hdev->id, 1);
+	mgmt_discovering(hdev, 1);
 }
 
 static inline void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
@@ -1378,7 +1378,7 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 	if (!test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
 		return;
 
-	mgmt_discovering(hdev->id, 0);
+	mgmt_discovering(hdev, 0);
 }
 
 static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
@@ -1404,7 +1404,7 @@ static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *
 		data.rssi		= 0x00;
 		data.ssp_mode		= 0x00;
 		hci_inquiry_cache_update(hdev, &data);
-		mgmt_device_found(hdev->id, &info->bdaddr, ACL_LINK,
+		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK,
 						info->dev_class, 0, NULL);
 	}
 
@@ -1439,7 +1439,7 @@ static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 			conn->state = BT_CONFIG;
 			hci_conn_hold(conn);
 			conn->disc_timeout = HCI_DISCONN_TIMEOUT;
-			mgmt_connected(hdev->id, &ev->bdaddr, conn->type);
+			mgmt_connected(hdev, &ev->bdaddr, conn->type);
 		} else
 			conn->state = BT_CONNECTED;
 
@@ -1471,7 +1471,7 @@ static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 	} else {
 		conn->state = BT_CLOSED;
 		if (conn->type == ACL_LINK)
-			mgmt_connect_failed(hdev->id, &ev->bdaddr, conn->type,
+			mgmt_connect_failed(hdev, &ev->bdaddr, conn->type,
 								ev->status);
 	}
 
@@ -1572,7 +1572,7 @@ static inline void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff
 	BT_DBG("%s status %d", hdev->name, ev->status);
 
 	if (ev->status) {
-		mgmt_disconnect_failed(hdev->id);
+		mgmt_disconnect_failed(hdev);
 		return;
 	}
 
@@ -1585,7 +1585,7 @@ static inline void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff
 	conn->state = BT_CLOSED;
 
 	if (conn->type == ACL_LINK || conn->type == LE_LINK)
-		mgmt_disconnected(hdev->id, &conn->dst, conn->type);
+		mgmt_disconnected(hdev, &conn->dst, conn->type);
 
 	hci_proto_disconn_cfm(conn, ev->reason);
 	hci_conn_del(conn);
@@ -1616,7 +1616,7 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 			conn->sec_level = conn->pending_sec_level;
 		}
 	} else {
-		mgmt_auth_failed(hdev->id, &conn->dst, ev->status);
+		mgmt_auth_failed(hdev, &conn->dst, ev->status);
 	}
 
 	clear_bit(HCI_CONN_AUTH_PEND, &conn->pend);
@@ -1671,7 +1671,7 @@ static inline void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb
 	hci_dev_lock(hdev);
 
 	if (ev->status == 0 && test_bit(HCI_MGMT, &hdev->flags))
-		mgmt_remote_name(hdev->id, &ev->bdaddr, ev->name);
+		mgmt_remote_name(hdev, &ev->bdaddr, ev->name);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 	if (!conn)
@@ -2061,7 +2061,7 @@ static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	case HCI_OP_DISCONNECT:
 		if (ev->status != 0)
-			mgmt_disconnect_failed(hdev->id);
+			mgmt_disconnect_failed(hdev);
 		break;
 
 	case HCI_OP_LE_CREATE_CONN:
@@ -2226,7 +2226,7 @@ static inline void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff
 		else
 			secure = 0;
 
-		mgmt_pin_code_request(hdev->id, &ev->bdaddr, secure);
+		mgmt_pin_code_request(hdev, &ev->bdaddr, secure);
 	}
 
 unlock:
@@ -2409,7 +2409,7 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 			data.rssi		= info->rssi;
 			data.ssp_mode		= 0x00;
 			hci_inquiry_cache_update(hdev, &data);
-			mgmt_device_found(hdev->id, &info->bdaddr, ACL_LINK,
+			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK,
 						info->dev_class, info->rssi,
 						NULL);
 		}
@@ -2426,7 +2426,7 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 			data.rssi		= info->rssi;
 			data.ssp_mode		= 0x00;
 			hci_inquiry_cache_update(hdev, &data);
-			mgmt_device_found(hdev->id, &info->bdaddr, ACL_LINK,
+			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK,
 						info->dev_class, info->rssi,
 						NULL);
 		}
@@ -2569,7 +2569,7 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 		data.rssi		= info->rssi;
 		data.ssp_mode		= 0x01;
 		hci_inquiry_cache_update(hdev, &data);
-		mgmt_device_found(hdev->id, &info->bdaddr, ACL_LINK,
+		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK,
 				info->dev_class, info->rssi, info->data);
 	}
 
@@ -2726,7 +2726,7 @@ static inline void hci_user_confirm_request_evt(struct hci_dev *hdev,
 	}
 
 confirm:
-	mgmt_user_confirm_request(hdev->id, &ev->bdaddr, ev->passkey,
+	mgmt_user_confirm_request(hdev, &ev->bdaddr, ev->passkey,
 								confirm_hint);
 
 unlock:
@@ -2752,7 +2752,7 @@ static inline void hci_simple_pair_complete_evt(struct hci_dev *hdev, struct sk_
 	 * event gets always produced as initiator and is also mapped to
 	 * the mgmt_auth_failed event */
 	if (!test_bit(HCI_CONN_AUTH_PEND, &conn->pend) && ev->status != 0)
-		mgmt_auth_failed(hdev->id, &conn->dst, ev->status);
+		mgmt_auth_failed(hdev, &conn->dst, ev->status);
 
 	hci_conn_put(conn);
 
@@ -2833,15 +2833,14 @@ static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff
 	}
 
 	if (ev->status) {
-		mgmt_connect_failed(hdev->id, &ev->bdaddr, conn->type,
-								ev->status);
+		mgmt_connect_failed(hdev, &ev->bdaddr, conn->type, ev->status);
 		hci_proto_connect_cfm(conn, ev->status);
 		conn->state = BT_CLOSED;
 		hci_conn_del(conn);
 		goto unlock;
 	}
 
-	mgmt_connected(hdev->id, &ev->bdaddr, conn->type);
+	mgmt_connected(hdev, &ev->bdaddr, conn->type);
 
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->handle = __le16_to_cpu(ev->handle);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4cb2f95..2ca7b44 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -255,7 +255,7 @@ static struct pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
 	return cmd;
 }
 
-static void mgmt_pending_foreach(u16 opcode, int index,
+static void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
 				void (*cb)(struct pending_cmd *cmd, void *data),
 				void *data)
 {
@@ -269,7 +269,7 @@ static void mgmt_pending_foreach(u16 opcode, int index,
 		if (opcode > 0 && cmd->opcode != opcode)
 			continue;
 
-		if (index >= 0 && cmd->index != index)
+		if (hdev && cmd->index != hdev->id)
 			continue;
 
 		cb(cmd, data);
@@ -475,8 +475,8 @@ failed:
 	return err;
 }
 
-static int mgmt_event(u16 event, u16 index, void *data, u16 data_len,
-							struct sock *skip_sk)
+static int mgmt_event(u16 event, struct hci_dev *hdev, void *data,
+					u16 data_len, struct sock *skip_sk)
 {
 	struct sk_buff *skb;
 	struct mgmt_hdr *hdr;
@@ -489,7 +489,10 @@ static int mgmt_event(u16 event, u16 index, void *data, u16 data_len,
 
 	hdr = (void *) skb_put(skb, sizeof(*hdr));
 	hdr->opcode = cpu_to_le16(event);
-	hdr->index = cpu_to_le16(index);
+	if (hdev)
+		hdr->index = cpu_to_le16(hdev->id);
+	else
+		hdr->index = cpu_to_le16(MGMT_INDEX_NONE);
 	hdr->len = cpu_to_le16(data_len);
 
 	if (data)
@@ -541,7 +544,7 @@ static int set_pairable(struct sock *sk, u16 index, unsigned char *data,
 
 	ev.val = cp->val;
 
-	err = mgmt_event(MGMT_EV_PAIRABLE, index, &ev, sizeof(ev), sk);
+	err = mgmt_event(MGMT_EV_PAIRABLE, hdev, &ev, sizeof(ev), sk);
 
 failed:
 	hci_dev_unlock_bh(hdev);
@@ -1966,18 +1969,18 @@ static void cmd_status_rsp(struct pending_cmd *cmd, void *data)
 	mgmt_pending_remove(cmd);
 }
 
-int mgmt_index_added(u16 index)
+int mgmt_index_added(struct hci_dev *hdev)
 {
-	return mgmt_event(MGMT_EV_INDEX_ADDED, index, NULL, 0, NULL);
+	return mgmt_event(MGMT_EV_INDEX_ADDED, hdev, NULL, 0, NULL);
 }
 
-int mgmt_index_removed(u16 index)
+int mgmt_index_removed(struct hci_dev *hdev)
 {
 	u8 status = ENODEV;
 
-	mgmt_pending_foreach(0, index, cmd_status_rsp, &status);
+	mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
 
-	return mgmt_event(MGMT_EV_INDEX_REMOVED, index, NULL, 0, NULL);
+	return mgmt_event(MGMT_EV_INDEX_REMOVED, hdev, NULL, 0, NULL);
 }
 
 struct cmd_lookup {
@@ -2005,22 +2008,22 @@ static void mode_rsp(struct pending_cmd *cmd, void *data)
 	mgmt_pending_free(cmd);
 }
 
-int mgmt_powered(u16 index, u8 powered)
+int mgmt_powered(struct hci_dev *hdev, u8 powered)
 {
 	struct mgmt_mode ev;
 	struct cmd_lookup match = { powered, NULL };
 	int ret;
 
-	mgmt_pending_foreach(MGMT_OP_SET_POWERED, index, mode_rsp, &match);
+	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, mode_rsp, &match);
 
 	if (!powered) {
 		u8 status = ENETDOWN;
-		mgmt_pending_foreach(0, index, cmd_status_rsp, &status);
+		mgmt_pending_foreach(0, hdev, cmd_status_rsp, &status);
 	}
 
 	ev.val = powered;
 
-	ret = mgmt_event(MGMT_EV_POWERED, index, &ev, sizeof(ev), match.sk);
+	ret = mgmt_event(MGMT_EV_POWERED, hdev, &ev, sizeof(ev), match.sk);
 
 	if (match.sk)
 		sock_put(match.sk);
@@ -2028,17 +2031,17 @@ int mgmt_powered(u16 index, u8 powered)
 	return ret;
 }
 
-int mgmt_discoverable(u16 index, u8 discoverable)
+int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
 {
 	struct mgmt_mode ev;
 	struct cmd_lookup match = { discoverable, NULL };
 	int ret;
 
-	mgmt_pending_foreach(MGMT_OP_SET_DISCOVERABLE, index, mode_rsp, &match);
+	mgmt_pending_foreach(MGMT_OP_SET_DISCOVERABLE, hdev, mode_rsp, &match);
 
 	ev.val = discoverable;
 
-	ret = mgmt_event(MGMT_EV_DISCOVERABLE, index, &ev, sizeof(ev),
+	ret = mgmt_event(MGMT_EV_DISCOVERABLE, hdev, &ev, sizeof(ev),
 								match.sk);
 
 	if (match.sk)
@@ -2047,17 +2050,17 @@ int mgmt_discoverable(u16 index, u8 discoverable)
 	return ret;
 }
 
-int mgmt_connectable(u16 index, u8 connectable)
+int mgmt_connectable(struct hci_dev *hdev, u8 connectable)
 {
 	struct mgmt_mode ev;
 	struct cmd_lookup match = { connectable, NULL };
 	int ret;
 
-	mgmt_pending_foreach(MGMT_OP_SET_CONNECTABLE, index, mode_rsp, &match);
+	mgmt_pending_foreach(MGMT_OP_SET_CONNECTABLE, hdev, mode_rsp, &match);
 
 	ev.val = connectable;
 
-	ret = mgmt_event(MGMT_EV_CONNECTABLE, index, &ev, sizeof(ev), match.sk);
+	ret = mgmt_event(MGMT_EV_CONNECTABLE, hdev, &ev, sizeof(ev), match.sk);
 
 	if (match.sk)
 		sock_put(match.sk);
@@ -2065,20 +2068,21 @@ int mgmt_connectable(u16 index, u8 connectable)
 	return ret;
 }
 
-int mgmt_write_scan_failed(u16 index, u8 scan, u8 status)
+int mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status)
 {
 	if (scan & SCAN_PAGE)
-		mgmt_pending_foreach(MGMT_OP_SET_CONNECTABLE, index,
+		mgmt_pending_foreach(MGMT_OP_SET_CONNECTABLE, hdev,
 						cmd_status_rsp, &status);
 
 	if (scan & SCAN_INQUIRY)
-		mgmt_pending_foreach(MGMT_OP_SET_DISCOVERABLE, index,
+		mgmt_pending_foreach(MGMT_OP_SET_DISCOVERABLE, hdev,
 						cmd_status_rsp, &status);
 
 	return 0;
 }
 
-int mgmt_new_link_key(u16 index, struct link_key *key, u8 persistent)
+int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
+								u8 persistent)
 {
 	struct mgmt_ev_new_link_key ev;
 
@@ -2090,17 +2094,17 @@ int mgmt_new_link_key(u16 index, struct link_key *key, u8 persistent)
 	memcpy(ev.key.val, key->val, 16);
 	ev.key.pin_len = key->pin_len;
 
-	return mgmt_event(MGMT_EV_NEW_LINK_KEY, index, &ev, sizeof(ev), NULL);
+	return mgmt_event(MGMT_EV_NEW_LINK_KEY, hdev, &ev, sizeof(ev), NULL);
 }
 
-int mgmt_connected(u16 index, bdaddr_t *bdaddr, u8 link_type)
+int mgmt_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type)
 {
 	struct mgmt_addr_info ev;
 
 	bacpy(&ev.bdaddr, bdaddr);
 	ev.type = link_to_mgmt(link_type);
 
-	return mgmt_event(MGMT_EV_CONNECTED, index, &ev, sizeof(ev), NULL);
+	return mgmt_event(MGMT_EV_CONNECTED, hdev, &ev, sizeof(ev), NULL);
 }
 
 static void disconnect_rsp(struct pending_cmd *cmd, void *data)
@@ -2119,18 +2123,18 @@ static void disconnect_rsp(struct pending_cmd *cmd, void *data)
 	mgmt_pending_remove(cmd);
 }
 
-int mgmt_disconnected(u16 index, bdaddr_t *bdaddr, u8 type)
+int mgmt_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 {
 	struct mgmt_addr_info ev;
 	struct sock *sk = NULL;
 	int err;
 
-	mgmt_pending_foreach(MGMT_OP_DISCONNECT, index, disconnect_rsp, &sk);
+	mgmt_pending_foreach(MGMT_OP_DISCONNECT, hdev, disconnect_rsp, &sk);
 
 	bacpy(&ev.bdaddr, bdaddr);
 	ev.type = link_to_mgmt(type);
 
-	err = mgmt_event(MGMT_EV_DISCONNECTED, index, &ev, sizeof(ev), sk);
+	err = mgmt_event(MGMT_EV_DISCONNECTED, hdev, &ev, sizeof(ev), sk);
 
 	if (sk)
 		sock_put(sk);
@@ -2138,23 +2142,24 @@ int mgmt_disconnected(u16 index, bdaddr_t *bdaddr, u8 type)
 	return err;
 }
 
-int mgmt_disconnect_failed(u16 index)
+int mgmt_disconnect_failed(struct hci_dev *hdev)
 {
 	struct pending_cmd *cmd;
 	int err;
 
-	cmd = mgmt_pending_find(MGMT_OP_DISCONNECT, index);
+	cmd = mgmt_pending_find(MGMT_OP_DISCONNECT, hdev->id);
 	if (!cmd)
 		return -ENOENT;
 
-	err = cmd_status(cmd->sk, index, MGMT_OP_DISCONNECT, EIO);
+	err = cmd_status(cmd->sk, hdev->id, MGMT_OP_DISCONNECT, EIO);
 
 	mgmt_pending_remove(cmd);
 
 	return err;
 }
 
-int mgmt_connect_failed(u16 index, bdaddr_t *bdaddr, u8 type, u8 status)
+int mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type,
+								u8 status)
 {
 	struct mgmt_ev_connect_failed ev;
 
@@ -2162,34 +2167,35 @@ int mgmt_connect_failed(u16 index, bdaddr_t *bdaddr, u8 type, u8 status)
 	ev.addr.type = link_to_mgmt(type);
 	ev.status = status;
 
-	return mgmt_event(MGMT_EV_CONNECT_FAILED, index, &ev, sizeof(ev), NULL);
+	return mgmt_event(MGMT_EV_CONNECT_FAILED, hdev, &ev, sizeof(ev), NULL);
 }
 
-int mgmt_pin_code_request(u16 index, bdaddr_t *bdaddr, u8 secure)
+int mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure)
 {
 	struct mgmt_ev_pin_code_request ev;
 
 	bacpy(&ev.bdaddr, bdaddr);
 	ev.secure = secure;
 
-	return mgmt_event(MGMT_EV_PIN_CODE_REQUEST, index, &ev, sizeof(ev),
+	return mgmt_event(MGMT_EV_PIN_CODE_REQUEST, hdev, &ev, sizeof(ev),
 									NULL);
 }
 
-int mgmt_pin_code_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
+int mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+								u8 status)
 {
 	struct pending_cmd *cmd;
 	struct mgmt_rp_pin_code_reply rp;
 	int err;
 
-	cmd = mgmt_pending_find(MGMT_OP_PIN_CODE_REPLY, index);
+	cmd = mgmt_pending_find(MGMT_OP_PIN_CODE_REPLY, hdev->id);
 	if (!cmd)
 		return -ENOENT;
 
 	bacpy(&rp.bdaddr, bdaddr);
 	rp.status = status;
 
-	err = cmd_complete(cmd->sk, index, MGMT_OP_PIN_CODE_REPLY, &rp,
+	err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_PIN_CODE_REPLY, &rp,
 								sizeof(rp));
 
 	mgmt_pending_remove(cmd);
@@ -2197,20 +2203,21 @@ int mgmt_pin_code_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
 	return err;
 }
 
-int mgmt_pin_code_neg_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
+int mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+								u8 status)
 {
 	struct pending_cmd *cmd;
 	struct mgmt_rp_pin_code_reply rp;
 	int err;
 
-	cmd = mgmt_pending_find(MGMT_OP_PIN_CODE_NEG_REPLY, index);
+	cmd = mgmt_pending_find(MGMT_OP_PIN_CODE_NEG_REPLY, hdev->id);
 	if (!cmd)
 		return -ENOENT;
 
 	bacpy(&rp.bdaddr, bdaddr);
 	rp.status = status;
 
-	err = cmd_complete(cmd->sk, index, MGMT_OP_PIN_CODE_NEG_REPLY, &rp,
+	err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_PIN_CODE_NEG_REPLY, &rp,
 								sizeof(rp));
 
 	mgmt_pending_remove(cmd);
@@ -2218,97 +2225,95 @@ int mgmt_pin_code_neg_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
 	return err;
 }
 
-int mgmt_user_confirm_request(u16 index, bdaddr_t *bdaddr, __le32 value,
-							u8 confirm_hint)
+int mgmt_user_confirm_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
+						__le32 value, u8 confirm_hint)
 {
 	struct mgmt_ev_user_confirm_request ev;
 
-	BT_DBG("hci%u", index);
+	BT_DBG("%s", hdev->name);
 
 	bacpy(&ev.bdaddr, bdaddr);
 	ev.confirm_hint = confirm_hint;
 	put_unaligned_le32(value, &ev.value);
 
-	return mgmt_event(MGMT_EV_USER_CONFIRM_REQUEST, index, &ev, sizeof(ev),
+	return mgmt_event(MGMT_EV_USER_CONFIRM_REQUEST, hdev, &ev, sizeof(ev),
 									NULL);
 }
 
-static int confirm_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status,
-								u8 opcode)
+static int confirm_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+							u8 status, u8 opcode)
 {
 	struct pending_cmd *cmd;
 	struct mgmt_rp_user_confirm_reply rp;
 	int err;
 
-	cmd = mgmt_pending_find(opcode, index);
+	cmd = mgmt_pending_find(opcode, hdev->id);
 	if (!cmd)
 		return -ENOENT;
 
 	bacpy(&rp.bdaddr, bdaddr);
 	rp.status = status;
-	err = cmd_complete(cmd->sk, index, opcode, &rp, sizeof(rp));
+	err = cmd_complete(cmd->sk, hdev->id, opcode, &rp, sizeof(rp));
 
 	mgmt_pending_remove(cmd);
 
 	return err;
 }
 
-int mgmt_user_confirm_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
+int mgmt_user_confirm_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+								u8 status)
 {
-	return confirm_reply_complete(index, bdaddr, status,
+	return confirm_reply_complete(hdev, bdaddr, status,
 						MGMT_OP_USER_CONFIRM_REPLY);
 }
 
-int mgmt_user_confirm_neg_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
+int mgmt_user_confirm_neg_reply_complete(struct hci_dev *hdev,
+						bdaddr_t *bdaddr, u8 status)
 {
-	return confirm_reply_complete(index, bdaddr, status,
+	return confirm_reply_complete(hdev, bdaddr, status,
 					MGMT_OP_USER_CONFIRM_NEG_REPLY);
 }
 
-int mgmt_auth_failed(u16 index, bdaddr_t *bdaddr, u8 status)
+int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 status)
 {
 	struct mgmt_ev_auth_failed ev;
 
 	bacpy(&ev.bdaddr, bdaddr);
 	ev.status = status;
 
-	return mgmt_event(MGMT_EV_AUTH_FAILED, index, &ev, sizeof(ev), NULL);
+	return mgmt_event(MGMT_EV_AUTH_FAILED, hdev, &ev, sizeof(ev), NULL);
 }
 
-int mgmt_set_local_name_complete(u16 index, u8 *name, u8 status)
+int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 {
 	struct pending_cmd *cmd;
-	struct hci_dev *hdev;
 	struct mgmt_cp_set_local_name ev;
 	int err;
 
 	memset(&ev, 0, sizeof(ev));
 	memcpy(ev.name, name, HCI_MAX_NAME_LENGTH);
 
-	cmd = mgmt_pending_find(MGMT_OP_SET_LOCAL_NAME, index);
+	cmd = mgmt_pending_find(MGMT_OP_SET_LOCAL_NAME, hdev->id);
 	if (!cmd)
 		goto send_event;
 
 	if (status) {
-		err = cmd_status(cmd->sk, index, MGMT_OP_SET_LOCAL_NAME, EIO);
+		err = cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
+									EIO);
 		goto failed;
 	}
 
-	hdev = hci_dev_get(index);
-	if (hdev) {
-		hci_dev_lock_bh(hdev);
-		update_eir(hdev);
-		hci_dev_unlock_bh(hdev);
-		hci_dev_put(hdev);
-	}
+	hci_dev_lock_bh(hdev);
+	update_eir(hdev);
+	hci_dev_unlock_bh(hdev);
 
-	err = cmd_complete(cmd->sk, index, MGMT_OP_SET_LOCAL_NAME, &ev,
+	err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, &ev,
 								sizeof(ev));
 	if (err < 0)
 		goto failed;
 
 send_event:
-	err = mgmt_event(MGMT_EV_LOCAL_NAME_CHANGED, index, &ev, sizeof(ev),
+	err = mgmt_event(MGMT_EV_LOCAL_NAME_CHANGED, hdev, &ev, sizeof(ev),
 							cmd ? cmd->sk : NULL);
 
 failed:
@@ -2317,29 +2322,30 @@ failed:
 	return err;
 }
 
-int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
-								u8 status)
+int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
+						u8 *randomizer, u8 status)
 {
 	struct pending_cmd *cmd;
 	int err;
 
-	BT_DBG("hci%u status %u", index, status);
+	BT_DBG("%s status %u", hdev->name, status);
 
-	cmd = mgmt_pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, index);
+	cmd = mgmt_pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, hdev->id);
 	if (!cmd)
 		return -ENOENT;
 
 	if (status) {
-		err = cmd_status(cmd->sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
-									EIO);
+		err = cmd_status(cmd->sk, hdev->id,
+					MGMT_OP_READ_LOCAL_OOB_DATA, EIO);
 	} else {
 		struct mgmt_rp_read_local_oob_data rp;
 
 		memcpy(rp.hash, hash, sizeof(rp.hash));
 		memcpy(rp.randomizer, randomizer, sizeof(rp.randomizer));
 
-		err = cmd_complete(cmd->sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
-							&rp, sizeof(rp));
+		err = cmd_complete(cmd->sk, hdev->id,
+						MGMT_OP_READ_LOCAL_OOB_DATA,
+						&rp, sizeof(rp));
 	}
 
 	mgmt_pending_remove(cmd);
@@ -2347,8 +2353,8 @@ int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
 	return err;
 }
 
-int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 type, u8 *dev_class,
-							s8 rssi, u8 *eir)
+int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type,
+					u8 *dev_class, s8 rssi, u8 *eir)
 {
 	struct mgmt_ev_device_found ev;
 
@@ -2364,10 +2370,10 @@ int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 type, u8 *dev_class,
 	if (dev_class)
 		memcpy(ev.dev_class, dev_class, sizeof(ev.dev_class));
 
-	return mgmt_event(MGMT_EV_DEVICE_FOUND, index, &ev, sizeof(ev), NULL);
+	return mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, &ev, sizeof(ev), NULL);
 }
 
-int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name)
+int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *name)
 {
 	struct mgmt_ev_remote_name ev;
 
@@ -2376,64 +2382,64 @@ int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name)
 	bacpy(&ev.bdaddr, bdaddr);
 	memcpy(ev.name, name, HCI_MAX_NAME_LENGTH);
 
-	return mgmt_event(MGMT_EV_REMOTE_NAME, index, &ev, sizeof(ev), NULL);
+	return mgmt_event(MGMT_EV_REMOTE_NAME, hdev, &ev, sizeof(ev), NULL);
 }
 
-int mgmt_inquiry_failed(u16 index, u8 status)
+int mgmt_inquiry_failed(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
 	int err;
 
-	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, index);
+	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev->id);
 	if (!cmd)
 		return -ENOENT;
 
-	err = cmd_status(cmd->sk, index, cmd->opcode, status);
+	err = cmd_status(cmd->sk, hdev->id, cmd->opcode, status);
 	mgmt_pending_remove(cmd);
 
 	return err;
 }
 
-int mgmt_discovering(u16 index, u8 discovering)
+int mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 {
 	struct pending_cmd *cmd;
 
 	if (discovering)
-		cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, index);
+		cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev->id);
 	else
-		cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, index);
+		cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev->id);
 
 	if (cmd != NULL) {
-		cmd_complete(cmd->sk, index, cmd->opcode, NULL, 0);
+		cmd_complete(cmd->sk, hdev->id, cmd->opcode, NULL, 0);
 		mgmt_pending_remove(cmd);
 	}
 
-	return mgmt_event(MGMT_EV_DISCOVERING, index, &discovering,
+	return mgmt_event(MGMT_EV_DISCOVERING, hdev, &discovering,
 						sizeof(discovering), NULL);
 }
 
-int mgmt_device_blocked(u16 index, bdaddr_t *bdaddr)
+int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct pending_cmd *cmd;
 	struct mgmt_ev_device_blocked ev;
 
-	cmd = mgmt_pending_find(MGMT_OP_BLOCK_DEVICE, index);
+	cmd = mgmt_pending_find(MGMT_OP_BLOCK_DEVICE, hdev->id);
 
 	bacpy(&ev.bdaddr, bdaddr);
 
-	return mgmt_event(MGMT_EV_DEVICE_BLOCKED, index, &ev, sizeof(ev),
-						cmd ? cmd->sk : NULL);
+	return mgmt_event(MGMT_EV_DEVICE_BLOCKED, hdev, &ev, sizeof(ev),
+							cmd ? cmd->sk : NULL);
 }
 
-int mgmt_device_unblocked(u16 index, bdaddr_t *bdaddr)
+int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct pending_cmd *cmd;
 	struct mgmt_ev_device_unblocked ev;
 
-	cmd = mgmt_pending_find(MGMT_OP_UNBLOCK_DEVICE, index);
+	cmd = mgmt_pending_find(MGMT_OP_UNBLOCK_DEVICE, hdev->id);
 
 	bacpy(&ev.bdaddr, bdaddr);
 
-	return mgmt_event(MGMT_EV_DEVICE_UNBLOCKED, index, &ev, sizeof(ev),
-						cmd ? cmd->sk : NULL);
+	return mgmt_event(MGMT_EV_DEVICE_UNBLOCKED, hdev, &ev, sizeof(ev),
+							cmd ? cmd->sk : NULL);
 }
-- 
1.7.7.1

