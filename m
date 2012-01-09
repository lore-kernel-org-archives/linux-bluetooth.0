Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Move mgmt related flags from hdev->flags to hdev->dev_flags
Date: Mon,  9 Jan 2012 13:46:03 +0200
Message-Id: <1326109565-32631-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1326109565-32631-1-git-send-email-johan.hedberg@gmail.com>
References: <1326109565-32631-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's no point in exposing these to user-space (which is what happens
to everything in hdev->flags) so move them to dev_flags instead.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |   16 +++++++-------
 net/bluetooth/hci_core.c    |   30 ++++++++++++++--------------
 net/bluetooth/hci_event.c   |   44 +++++++++++++++++++++---------------------
 net/bluetooth/mgmt.c        |   30 ++++++++++++++--------------
 net/bluetooth/smp.c         |    2 +-
 5 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 4202c9c..3ee39ed 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -77,14 +77,6 @@ enum {
 
 	HCI_RAW,
 
-	HCI_SETUP,
-	HCI_AUTO_OFF,
-	HCI_MGMT,
-	HCI_PAIRABLE,
-	HCI_SERVICE_CACHE,
-	HCI_LINK_KEYS,
-	HCI_DEBUG_KEYS,
-
 	HCI_RESET,
 };
 
@@ -93,6 +85,14 @@ enum {
  * states from the controller.
  */
 enum {
+	HCI_SETUP,
+	HCI_AUTO_OFF,
+	HCI_MGMT,
+	HCI_PAIRABLE,
+	HCI_SERVICE_CACHE,
+	HCI_LINK_KEYS,
+	HCI_DEBUG_KEYS,
+
 	HCI_LE_SCAN,
 };
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bd1a5c0..f86571d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -668,7 +668,7 @@ int hci_dev_open(__u16 dev)
 		hci_dev_hold(hdev);
 		set_bit(HCI_UP, &hdev->flags);
 		hci_notify(hdev, HCI_DEV_UP);
-		if (!test_bit(HCI_SETUP, &hdev->flags)) {
+		if (!test_bit(HCI_SETUP, &hdev->dev_flags)) {
 			hci_dev_lock(hdev);
 			mgmt_powered(hdev, 1);
 			hci_dev_unlock(hdev);
@@ -722,10 +722,10 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		hdev->discov_timeout = 0;
 	}
 
-	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->flags))
+	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
 		cancel_delayed_work(&hdev->power_off);
 
-	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->flags))
+	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
 		cancel_delayed_work(&hdev->service_cache);
 
 	hci_dev_lock(hdev);
@@ -947,11 +947,11 @@ int hci_get_dev_list(void __user *arg)
 
 	read_lock(&hci_dev_list_lock);
 	list_for_each_entry(hdev, &hci_dev_list, list) {
-		if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->flags))
+		if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
 			cancel_delayed_work(&hdev->power_off);
 
-		if (!test_bit(HCI_MGMT, &hdev->flags))
-			set_bit(HCI_PAIRABLE, &hdev->flags);
+		if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+			set_bit(HCI_PAIRABLE, &hdev->dev_flags);
 
 		(dr + n)->dev_id  = hdev->id;
 		(dr + n)->dev_opt = hdev->flags;
@@ -983,11 +983,11 @@ int hci_get_dev_info(void __user *arg)
 	if (!hdev)
 		return -ENODEV;
 
-	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->flags))
+	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
 		cancel_delayed_work_sync(&hdev->power_off);
 
-	if (!test_bit(HCI_MGMT, &hdev->flags))
-		set_bit(HCI_PAIRABLE, &hdev->flags);
+	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+		set_bit(HCI_PAIRABLE, &hdev->dev_flags);
 
 	strcpy(di.name, hdev->name);
 	di.bdaddr   = hdev->bdaddr;
@@ -1067,11 +1067,11 @@ static void hci_power_on(struct work_struct *work)
 	if (hci_dev_open(hdev->id) < 0)
 		return;
 
-	if (test_bit(HCI_AUTO_OFF, &hdev->flags))
+	if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
 		schedule_delayed_work(&hdev->power_off,
 					msecs_to_jiffies(AUTO_OFF_TIMEOUT));
 
-	if (test_and_clear_bit(HCI_SETUP, &hdev->flags))
+	if (test_and_clear_bit(HCI_SETUP, &hdev->dev_flags))
 		mgmt_index_added(hdev);
 }
 
@@ -1082,7 +1082,7 @@ static void hci_power_off(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
-	clear_bit(HCI_AUTO_OFF, &hdev->flags);
+	clear_bit(HCI_AUTO_OFF, &hdev->dev_flags);
 
 	hci_dev_close(hdev->id);
 }
@@ -1651,8 +1651,8 @@ int hci_register_dev(struct hci_dev *hdev)
 		}
 	}
 
-	set_bit(HCI_AUTO_OFF, &hdev->flags);
-	set_bit(HCI_SETUP, &hdev->flags);
+	set_bit(HCI_AUTO_OFF, &hdev->dev_flags);
+	set_bit(HCI_SETUP, &hdev->dev_flags);
 	schedule_work(&hdev->power_on);
 
 	hci_notify(hdev, HCI_DEV_REG);
@@ -1687,7 +1687,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 		kfree_skb(hdev->reassembly[i]);
 
 	if (!test_bit(HCI_INIT, &hdev->flags) &&
-					!test_bit(HCI_SETUP, &hdev->flags)) {
+				!test_bit(HCI_SETUP, &hdev->dev_flags)) {
 		hci_dev_lock(hdev);
 		mgmt_index_removed(hdev);
 		hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 99ea8b4..4693bbc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -211,7 +211,7 @@ static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->flags))
+	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		mgmt_set_local_name_complete(hdev, sent, status);
 
 	if (status == 0)
@@ -890,7 +890,7 @@ static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->flags))
+	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		mgmt_pin_code_reply_complete(hdev, &rp->bdaddr, rp->status);
 
 	if (rp->status != 0)
@@ -916,7 +916,7 @@ static void hci_cc_pin_code_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->flags))
+	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		mgmt_pin_code_neg_reply_complete(hdev, &rp->bdaddr,
 								rp->status);
 
@@ -951,7 +951,7 @@ static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->flags))
+	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		mgmt_user_confirm_reply_complete(hdev, &rp->bdaddr,
 								rp->status);
 
@@ -967,7 +967,7 @@ static void hci_cc_user_confirm_neg_reply(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->flags))
+	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		mgmt_user_confirm_neg_reply_complete(hdev, &rp->bdaddr,
 								rp->status);
 
@@ -982,7 +982,7 @@ static void hci_cc_user_passkey_reply(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->flags))
+	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		mgmt_user_passkey_reply_complete(hdev, &rp->bdaddr,
 								rp->status);
 
@@ -998,7 +998,7 @@ static void hci_cc_user_passkey_neg_reply(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->flags))
+	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		mgmt_user_passkey_neg_reply_complete(hdev, &rp->bdaddr,
 								rp->status);
 
@@ -1110,7 +1110,7 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 		hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 		hci_conn_check_pending(hdev);
 		hci_dev_lock(hdev);
-		if (test_bit(HCI_MGMT, &hdev->flags))
+		if (test_bit(HCI_MGMT, &hdev->dev_flags))
 			mgmt_start_discovery_failed(hdev, status);
 		hci_dev_unlock(hdev);
 		return;
@@ -1333,7 +1333,7 @@ static void hci_cs_remote_name_req(struct hci_dev *hdev, __u8 status)
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->flags))
+	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		hci_resolve_next_name(hdev, &cp->bdaddr);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
@@ -1555,7 +1555,7 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 	if (!test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
 		return;
 
-	if (!test_bit(HCI_MGMT, &hdev->flags))
+	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
 		return;
 
 	hci_dev_lock(hdev);
@@ -1876,7 +1876,7 @@ static inline void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->flags)) {
+	if (test_bit(HCI_MGMT, &hdev->dev_flags)) {
 		if (ev->status == 0)
 			mgmt_remote_name(hdev, &ev->bdaddr, ev->name);
 
@@ -2505,10 +2505,10 @@ static inline void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff
 		hci_conn_put(conn);
 	}
 
-	if (!test_bit(HCI_PAIRABLE, &hdev->flags))
+	if (!test_bit(HCI_PAIRABLE, &hdev->dev_flags))
 		hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY,
 					sizeof(ev->bdaddr), &ev->bdaddr);
-	else if (test_bit(HCI_MGMT, &hdev->flags)) {
+	else if (test_bit(HCI_MGMT, &hdev->dev_flags)) {
 		u8 secure;
 
 		if (conn->pending_sec_level == BT_SECURITY_HIGH)
@@ -2532,7 +2532,7 @@ static inline void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_bit(HCI_LINK_KEYS, &hdev->flags))
+	if (!test_bit(HCI_LINK_KEYS, &hdev->dev_flags))
 		return;
 
 	hci_dev_lock(hdev);
@@ -2547,7 +2547,7 @@ static inline void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff
 	BT_DBG("%s found key type %u for %s", hdev->name, key->type,
 							batostr(&ev->bdaddr));
 
-	if (!test_bit(HCI_DEBUG_KEYS, &hdev->flags) &&
+	if (!test_bit(HCI_DEBUG_KEYS, &hdev->dev_flags) &&
 				key->type == HCI_LK_DEBUG_COMBINATION) {
 		BT_DBG("%s ignoring debug key", hdev->name);
 		goto not_found;
@@ -2609,7 +2609,7 @@ static inline void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff
 		hci_conn_put(conn);
 	}
 
-	if (test_bit(HCI_LINK_KEYS, &hdev->flags))
+	if (test_bit(HCI_LINK_KEYS, &hdev->dev_flags))
 		hci_add_link_key(hdev, conn, 1, &ev->bdaddr, ev->link_key,
 							ev->key_type, pin_len);
 
@@ -2890,7 +2890,7 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 		data.rssi		= info->rssi;
 		data.ssp_mode		= 0x01;
 
-		if (test_bit(HCI_MGMT, &hdev->flags))
+		if (test_bit(HCI_MGMT, &hdev->dev_flags))
 			name_known = eir_has_complete_name(info->data,
 							sizeof(info->data));
 		else
@@ -2939,10 +2939,10 @@ static inline void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff
 
 	hci_conn_hold(conn);
 
-	if (!test_bit(HCI_MGMT, &hdev->flags))
+	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
 		goto unlock;
 
-	if (test_bit(HCI_PAIRABLE, &hdev->flags) ||
+	if (test_bit(HCI_PAIRABLE, &hdev->dev_flags) ||
 			(conn->remote_auth & ~0x01) == HCI_AT_NO_BONDING) {
 		struct hci_cp_io_capability_reply cp;
 
@@ -3005,7 +3005,7 @@ static inline void hci_user_confirm_request_evt(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_MGMT, &hdev->flags))
+	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
 		goto unlock;
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
@@ -3071,7 +3071,7 @@ static inline void hci_user_passkey_request_evt(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->flags))
+	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		mgmt_user_passkey_request(hdev, &ev->bdaddr);
 
 	hci_dev_unlock(hdev);
@@ -3130,7 +3130,7 @@ static inline void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_MGMT, &hdev->flags))
+	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
 		goto unlock;
 
 	data = hci_find_remote_oob_data(hdev, &ev->bdaddr);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 295cfc8..3de1e90 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -226,10 +226,10 @@ static int read_index_list(struct sock *sk)
 
 	i = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
-		if (test_and_clear_bit(HCI_AUTO_OFF, &d->flags))
+		if (test_and_clear_bit(HCI_AUTO_OFF, &d->dev_flags))
 			cancel_delayed_work(&d->power_off);
 
-		if (test_bit(HCI_SETUP, &d->flags))
+		if (test_bit(HCI_SETUP, &d->dev_flags))
 			continue;
 
 		put_unaligned_le16(d->id, &rp->index[i++]);
@@ -285,7 +285,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_ISCAN, &hdev->flags))
 		settings |= MGMT_SETTING_DISCOVERABLE;
 
-	if (test_bit(HCI_PAIRABLE, &hdev->flags))
+	if (test_bit(HCI_PAIRABLE, &hdev->dev_flags))
 		settings |= MGMT_SETTING_PAIRABLE;
 
 	if (!(hdev->features[4] & LMP_NO_BREDR))
@@ -419,7 +419,7 @@ static int update_eir(struct hci_dev *hdev)
 	if (hdev->ssp_mode == 0)
 		return 0;
 
-	if (test_bit(HCI_SERVICE_CACHE, &hdev->flags))
+	if (test_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
 		return 0;
 
 	memset(&cp, 0, sizeof(cp));
@@ -451,7 +451,7 @@ static int update_class(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	if (test_bit(HCI_SERVICE_CACHE, &hdev->flags))
+	if (test_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
 		return 0;
 
 	cod[0] = hdev->minor_class;
@@ -469,7 +469,7 @@ static void service_cache_off(struct work_struct *work)
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 							service_cache.work);
 
-	if (!test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->flags))
+	if (!test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
 		return;
 
 	hci_dev_lock(hdev);
@@ -482,10 +482,10 @@ static void service_cache_off(struct work_struct *work)
 
 static void mgmt_init_hdev(struct hci_dev *hdev)
 {
-	if (!test_and_set_bit(HCI_MGMT, &hdev->flags))
+	if (!test_and_set_bit(HCI_MGMT, &hdev->dev_flags))
 		INIT_DELAYED_WORK(&hdev->service_cache, service_cache_off);
 
-	if (!test_and_set_bit(HCI_SERVICE_CACHE, &hdev->flags))
+	if (!test_and_set_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
 		schedule_delayed_work(&hdev->service_cache,
 				msecs_to_jiffies(SERVICE_CACHE_TIMEOUT));
 }
@@ -502,7 +502,7 @@ static int read_controller_info(struct sock *sk, u16 index)
 		return cmd_status(sk, index, MGMT_OP_READ_INFO,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->flags))
+	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
 		cancel_delayed_work_sync(&hdev->power_off);
 
 	hci_dev_lock(hdev);
@@ -851,9 +851,9 @@ static int set_pairable(struct sock *sk, u16 index, unsigned char *data,
 	hci_dev_lock(hdev);
 
 	if (cp->val)
-		set_bit(HCI_PAIRABLE, &hdev->flags);
+		set_bit(HCI_PAIRABLE, &hdev->dev_flags);
 	else
-		clear_bit(HCI_PAIRABLE, &hdev->flags);
+		clear_bit(HCI_PAIRABLE, &hdev->dev_flags);
 
 	err = send_settings_rsp(sk, MGMT_OP_SET_PAIRABLE, hdev);
 	if (err < 0)
@@ -1008,7 +1008,7 @@ static int set_dev_class(struct sock *sk, u16 index, unsigned char *data,
 	hdev->major_class = cp->major;
 	hdev->minor_class = cp->minor;
 
-	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->flags)) {
+	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags)) {
 		hci_dev_unlock(hdev);
 		cancel_delayed_work_sync(&hdev->service_cache);
 		hci_dev_lock(hdev);
@@ -1063,12 +1063,12 @@ static int load_link_keys(struct sock *sk, u16 index, unsigned char *data,
 
 	hci_link_keys_clear(hdev);
 
-	set_bit(HCI_LINK_KEYS, &hdev->flags);
+	set_bit(HCI_LINK_KEYS, &hdev->dev_flags);
 
 	if (cp->debug_keys)
-		set_bit(HCI_DEBUG_KEYS, &hdev->flags);
+		set_bit(HCI_DEBUG_KEYS, &hdev->dev_flags);
 	else
-		clear_bit(HCI_DEBUG_KEYS, &hdev->flags);
+		clear_bit(HCI_DEBUG_KEYS, &hdev->dev_flags);
 
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_link_key_info *key = &cp->keys[i];
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 32c47de..65a9024 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -217,7 +217,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 {
 	u8 dist_keys = 0;
 
-	if (test_bit(HCI_PAIRABLE, &conn->hcon->hdev->flags)) {
+	if (test_bit(HCI_PAIRABLE, &conn->hcon->hdev->dev_flags)) {
 		dist_keys = SMP_DIST_ENC_KEY;
 		authreq |= SMP_AUTH_BONDING;
 	} else {
-- 
1.7.8.2

