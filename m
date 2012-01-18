Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 15/15] Bluetooth: Rename hdev->dev_flags to hdev-flags
Date: Wed, 18 Jan 2012 20:51:57 +0200
Message-Id: <1326912717-6347-16-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch renames hdev->dev_flags to simply hdev->flags as these are
now the "default" set of flags and the place where new flags should be
added. To be consistent with struct hci_conn flags naming each flag also
receives a HCI_DEV_* prefix instead of just HCI_*.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h      |   22 +++++++-------
 include/net/bluetooth/hci_core.h |    4 +-
 net/bluetooth/hci_core.c         |   32 ++++++++++----------
 net/bluetooth/hci_event.c        |   59 +++++++++++++++++++------------------
 net/bluetooth/mgmt.c             |   34 +++++++++++-----------
 net/bluetooth/smp.c              |    2 +-
 6 files changed, 77 insertions(+), 76 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 8797c3f..28a0087 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -80,18 +80,18 @@ enum {
 	HCI_RESET,
 };
 
-/* hdev->dev_flags */
+/* hdev->flags */
 enum {
-	HCI_SETUP,
-	HCI_AUTO_OFF,
-	HCI_MGMT,
-	HCI_PAIRABLE,
-	HCI_SERVICE_CACHE,
-	HCI_LINK_KEYS,
-	HCI_DEBUG_KEYS,
-
-	HCI_LE_SCAN,
-	HCI_SSP_ENABLED,
+	HCI_DEV_SETUP,
+	HCI_DEV_AUTO_OFF,
+	HCI_DEV_MGMT,
+	HCI_DEV_PAIRABLE,
+	HCI_DEV_SERVICE_CACHE,
+	HCI_DEV_LINK_KEYS,
+	HCI_DEV_DEBUG_KEYS,
+
+	HCI_DEV_LE_SCAN,
+	HCI_DEV_SSP_ENABLED,
 };
 
 /* HCI ioctl defines */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c972406..071d359 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -260,7 +260,7 @@ struct hci_dev {
 
 	struct rfkill		*rfkill;
 
-	unsigned long		dev_flags;
+	unsigned long		flags;
 
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
@@ -414,7 +414,7 @@ enum {
 static inline bool hci_conn_ssp_support(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
-	return (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
+	return (test_bit(HCI_DEV_SSP_ENABLED, &hdev->flags) &&
 				test_bit(HCI_CONN_SSP_SUPPORT, &conn->flags));
 }
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ff01f0a..2de4c72 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -695,7 +695,7 @@ int hci_dev_open(__u16 dev)
 		hci_dev_hold(hdev);
 		set_bit(HCI_UP, &hdev->compat_flags);
 		hci_notify(hdev, HCI_DEV_UP);
-		if (!test_bit(HCI_SETUP, &hdev->dev_flags)) {
+		if (!test_bit(HCI_DEV_SETUP, &hdev->flags)) {
 			hci_dev_lock(hdev);
 			mgmt_powered(hdev, 1);
 			hci_dev_unlock(hdev);
@@ -749,10 +749,10 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		hdev->discov_timeout = 0;
 	}
 
-	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+	if (test_and_clear_bit(HCI_DEV_AUTO_OFF, &hdev->flags))
 		cancel_delayed_work(&hdev->power_off);
 
-	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
+	if (test_and_clear_bit(HCI_DEV_SERVICE_CACHE, &hdev->flags))
 		cancel_delayed_work(&hdev->service_cache);
 
 	hci_dev_lock(hdev);
@@ -974,11 +974,11 @@ int hci_get_dev_list(void __user *arg)
 
 	read_lock(&hci_dev_list_lock);
 	list_for_each_entry(hdev, &hci_dev_list, list) {
-		if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+		if (test_and_clear_bit(HCI_DEV_AUTO_OFF, &hdev->flags))
 			cancel_delayed_work(&hdev->power_off);
 
-		if (!test_bit(HCI_MGMT, &hdev->dev_flags))
-			set_bit(HCI_PAIRABLE, &hdev->dev_flags);
+		if (!test_bit(HCI_DEV_MGMT, &hdev->flags))
+			set_bit(HCI_DEV_PAIRABLE, &hdev->flags);
 
 		(dr + n)->dev_id  = hdev->id;
 		(dr + n)->dev_opt = hdev->compat_flags;
@@ -1010,11 +1010,11 @@ int hci_get_dev_info(void __user *arg)
 	if (!hdev)
 		return -ENODEV;
 
-	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+	if (test_and_clear_bit(HCI_DEV_AUTO_OFF, &hdev->flags))
 		cancel_delayed_work_sync(&hdev->power_off);
 
-	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
-		set_bit(HCI_PAIRABLE, &hdev->dev_flags);
+	if (!test_bit(HCI_DEV_MGMT, &hdev->flags))
+		set_bit(HCI_DEV_PAIRABLE, &hdev->flags);
 
 	strcpy(di.name, hdev->name);
 	di.bdaddr   = hdev->bdaddr;
@@ -1094,11 +1094,11 @@ static void hci_power_on(struct work_struct *work)
 	if (hci_dev_open(hdev->id) < 0)
 		return;
 
-	if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+	if (test_bit(HCI_DEV_AUTO_OFF, &hdev->flags))
 		schedule_delayed_work(&hdev->power_off,
 					msecs_to_jiffies(AUTO_OFF_TIMEOUT));
 
-	if (test_and_clear_bit(HCI_SETUP, &hdev->dev_flags))
+	if (test_and_clear_bit(HCI_DEV_SETUP, &hdev->flags))
 		mgmt_index_added(hdev);
 }
 
@@ -1109,7 +1109,7 @@ static void hci_power_off(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
-	clear_bit(HCI_AUTO_OFF, &hdev->dev_flags);
+	clear_bit(HCI_DEV_AUTO_OFF, &hdev->flags);
 
 	hci_dev_close(hdev->id);
 }
@@ -1601,7 +1601,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	mutex_init(&hdev->lock);
 
 	hdev->compat_flags = 0;
-	hdev->dev_flags = 0;
+	hdev->flags = 0;
 	hdev->pkt_type  = (HCI_DM1 | HCI_DH1 | HCI_HV1);
 	hdev->esco_type = (ESCO_HV1);
 	hdev->link_mode = (HCI_LM_ACCEPT);
@@ -1676,8 +1676,8 @@ int hci_register_dev(struct hci_dev *hdev)
 		}
 	}
 
-	set_bit(HCI_AUTO_OFF, &hdev->dev_flags);
-	set_bit(HCI_SETUP, &hdev->dev_flags);
+	set_bit(HCI_DEV_AUTO_OFF, &hdev->flags);
+	set_bit(HCI_DEV_SETUP, &hdev->flags);
 	schedule_work(&hdev->power_on);
 
 	hci_notify(hdev, HCI_DEV_REG);
@@ -1713,7 +1713,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 		kfree_skb(hdev->reassembly[i]);
 
 	if (!test_bit(HCI_INIT, &hdev->compat_flags) &&
-				!test_bit(HCI_SETUP, &hdev->dev_flags)) {
+				!test_bit(HCI_DEV_SETUP, &hdev->flags)) {
 		hci_dev_lock(hdev);
 		mgmt_index_removed(hdev);
 		hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6817c52..987cedf 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -196,7 +196,8 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete(hdev, HCI_OP_RESET, status);
 
 	/* Reset all flags, except persistent ones */
-	hdev->dev_flags &= BIT(HCI_MGMT) | BIT(HCI_SETUP) | BIT(HCI_AUTO_OFF);
+	hdev->flags &= BIT(HCI_DEV_MGMT) | BIT(HCI_DEV_SETUP) |
+							BIT(HCI_DEV_AUTO_OFF);
 }
 
 static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
@@ -212,7 +213,7 @@ static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (test_bit(HCI_DEV_MGMT, &hdev->flags))
 		mgmt_set_local_name_complete(hdev, sent, status);
 
 	if (status == 0)
@@ -430,9 +431,9 @@ static void hci_cc_read_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 
 	if (rp->mode)
-		set_bit(HCI_SSP_ENABLED, &hdev->compat_flags);
+		set_bit(HCI_DEV_SSP_ENABLED, &hdev->compat_flags);
 	else
-		clear_bit(HCI_SSP_ENABLED, &hdev->compat_flags);
+		clear_bit(HCI_DEV_SSP_ENABLED, &hdev->compat_flags);
 }
 
 static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
@@ -450,9 +451,9 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 
 	if (*(u8 *) sent)
-		set_bit(HCI_SSP_ENABLED, &hdev->compat_flags);
+		set_bit(HCI_DEV_SSP_ENABLED, &hdev->compat_flags);
 	else
-		clear_bit(HCI_SSP_ENABLED, &hdev->compat_flags);
+		clear_bit(HCI_DEV_SSP_ENABLED, &hdev->compat_flags);
 }
 
 static u8 hci_get_inquiry_mode(struct hci_dev *hdev)
@@ -898,7 +899,7 @@ static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (test_bit(HCI_DEV_MGMT, &hdev->flags))
 		mgmt_pin_code_reply_complete(hdev, &rp->bdaddr, rp->status);
 
 	if (rp->status != 0)
@@ -924,7 +925,7 @@ static void hci_cc_pin_code_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (test_bit(HCI_DEV_MGMT, &hdev->flags))
 		mgmt_pin_code_neg_reply_complete(hdev, &rp->bdaddr,
 								rp->status);
 
@@ -959,7 +960,7 @@ static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (test_bit(HCI_DEV_MGMT, &hdev->flags))
 		mgmt_user_confirm_reply_complete(hdev, &rp->bdaddr,
 								rp->status);
 
@@ -975,7 +976,7 @@ static void hci_cc_user_confirm_neg_reply(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (test_bit(HCI_DEV_MGMT, &hdev->flags))
 		mgmt_user_confirm_neg_reply_complete(hdev, &rp->bdaddr,
 								rp->status);
 
@@ -990,7 +991,7 @@ static void hci_cc_user_passkey_reply(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (test_bit(HCI_DEV_MGMT, &hdev->flags))
 		mgmt_user_passkey_reply_complete(hdev, &rp->bdaddr,
 								rp->status);
 
@@ -1006,7 +1007,7 @@ static void hci_cc_user_passkey_neg_reply(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (test_bit(HCI_DEV_MGMT, &hdev->flags))
 		mgmt_user_passkey_neg_reply_complete(hdev, &rp->bdaddr,
 								rp->status);
 
@@ -1050,7 +1051,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 	switch (cp->enable) {
 	case LE_SCANNING_ENABLED:
-		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
+		set_bit(HCI_DEV_LE_SCAN, &hdev->flags);
 
 		cancel_delayed_work_sync(&hdev->adv_work);
 
@@ -1060,7 +1061,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		break;
 
 	case LE_SCANNING_DISABLED:
-		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
+		clear_bit(HCI_DEV_LE_SCAN, &hdev->flags);
 
 		schedule_delayed_work(&hdev->adv_work, ADV_CLEAR_TIMEOUT);
 		break;
@@ -1118,7 +1119,7 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 		hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 		hci_conn_check_pending(hdev);
 		hci_dev_lock(hdev);
-		if (test_bit(HCI_MGMT, &hdev->dev_flags))
+		if (test_bit(HCI_DEV_MGMT, &hdev->flags))
 			mgmt_start_discovery_failed(hdev, status);
 		hci_dev_unlock(hdev);
 		return;
@@ -1365,7 +1366,7 @@ static void hci_cs_remote_name_req(struct hci_dev *hdev, __u8 status)
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (test_bit(HCI_DEV_MGMT, &hdev->flags))
 		hci_check_pending_name(hdev, conn, &cp->bdaddr, NULL, 0);
 
 	if (!conn)
@@ -1586,7 +1587,7 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 	if (!test_and_clear_bit(HCI_INQUIRY, &hdev->compat_flags))
 		return;
 
-	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (!test_bit(HCI_DEV_MGMT, &hdev->flags))
 		return;
 
 	hci_dev_lock(hdev);
@@ -1909,7 +1910,7 @@ static inline void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 
-	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (!test_bit(HCI_DEV_MGMT, &hdev->flags))
 		goto check_auth;
 
 	if (ev->status == 0)
@@ -2543,10 +2544,10 @@ static inline void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff
 		hci_conn_put(conn);
 	}
 
-	if (!test_bit(HCI_PAIRABLE, &hdev->dev_flags))
+	if (!test_bit(HCI_DEV_PAIRABLE, &hdev->flags))
 		hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY,
 					sizeof(ev->bdaddr), &ev->bdaddr);
-	else if (test_bit(HCI_MGMT, &hdev->dev_flags)) {
+	else if (test_bit(HCI_DEV_MGMT, &hdev->flags)) {
 		u8 secure;
 
 		if (conn->pending_sec_level == BT_SECURITY_HIGH)
@@ -2570,7 +2571,7 @@ static inline void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_bit(HCI_LINK_KEYS, &hdev->dev_flags))
+	if (!test_bit(HCI_DEV_LINK_KEYS, &hdev->flags))
 		return;
 
 	hci_dev_lock(hdev);
@@ -2585,7 +2586,7 @@ static inline void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff
 	BT_DBG("%s found key type %u for %s", hdev->name, key->type,
 							batostr(&ev->bdaddr));
 
-	if (!test_bit(HCI_DEBUG_KEYS, &hdev->dev_flags) &&
+	if (!test_bit(HCI_DEV_DEBUG_KEYS, &hdev->flags) &&
 				key->type == HCI_LK_DEBUG_COMBINATION) {
 		BT_DBG("%s ignoring debug key", hdev->name);
 		goto not_found;
@@ -2647,7 +2648,7 @@ static inline void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff
 		hci_conn_put(conn);
 	}
 
-	if (test_bit(HCI_LINK_KEYS, &hdev->dev_flags))
+	if (test_bit(HCI_DEV_LINK_KEYS, &hdev->flags))
 		hci_add_link_key(hdev, conn, 1, &ev->bdaddr, ev->link_key,
 							ev->key_type, pin_len);
 
@@ -2907,7 +2908,7 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 		data.rssi		= info->rssi;
 		data.ssp_mode		= 0x01;
 
-		if (test_bit(HCI_MGMT, &hdev->dev_flags))
+		if (test_bit(HCI_DEV_MGMT, &hdev->flags))
 			name_known = eir_has_data_type(info->data,
 							sizeof(info->data),
 							EIR_NAME_COMPLETE);
@@ -2958,10 +2959,10 @@ static inline void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff
 
 	hci_conn_hold(conn);
 
-	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (!test_bit(HCI_DEV_MGMT, &hdev->flags))
 		goto unlock;
 
-	if (test_bit(HCI_PAIRABLE, &hdev->dev_flags) ||
+	if (test_bit(HCI_DEV_PAIRABLE, &hdev->flags) ||
 			(conn->remote_auth & ~0x01) == HCI_AT_NO_BONDING) {
 		struct hci_cp_io_capability_reply cp;
 
@@ -3025,7 +3026,7 @@ static inline void hci_user_confirm_request_evt(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (!test_bit(HCI_DEV_MGMT, &hdev->flags))
 		goto unlock;
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
@@ -3091,7 +3092,7 @@ static inline void hci_user_passkey_request_evt(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (test_bit(HCI_DEV_MGMT, &hdev->flags))
 		mgmt_user_passkey_request(hdev, &ev->bdaddr);
 
 	hci_dev_unlock(hdev);
@@ -3150,7 +3151,7 @@ static inline void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+	if (!test_bit(HCI_DEV_MGMT, &hdev->flags))
 		goto unlock;
 
 	data = hci_find_remote_oob_data(hdev, &ev->bdaddr);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index de07f7c..2016c1c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -226,10 +226,10 @@ static int read_index_list(struct sock *sk)
 
 	i = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
-		if (test_and_clear_bit(HCI_AUTO_OFF, &d->dev_flags))
+		if (test_and_clear_bit(HCI_DEV_AUTO_OFF, &d->flags))
 			cancel_delayed_work(&d->power_off);
 
-		if (test_bit(HCI_SETUP, &d->dev_flags))
+		if (test_bit(HCI_DEV_SETUP, &d->flags))
 			continue;
 
 		put_unaligned_le16(d->id, &rp->index[i++]);
@@ -285,7 +285,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_ISCAN, &hdev->compat_flags))
 		settings |= MGMT_SETTING_DISCOVERABLE;
 
-	if (test_bit(HCI_PAIRABLE, &hdev->dev_flags))
+	if (test_bit(HCI_DEV_PAIRABLE, &hdev->flags))
 		settings |= MGMT_SETTING_PAIRABLE;
 
 	if (!(hdev->features[4] & LMP_NO_BREDR))
@@ -297,7 +297,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_AUTH, &hdev->compat_flags))
 		settings |= MGMT_SETTING_LINK_SECURITY;
 
-	if (test_bit(HCI_SSP_ENABLED, &hdev->compat_flags))
+	if (test_bit(HCI_DEV_SSP_ENABLED, &hdev->compat_flags))
 		settings |= MGMT_SETTING_SSP;
 
 	return settings;
@@ -416,10 +416,10 @@ static int update_eir(struct hci_dev *hdev)
 	if (!(hdev->features[6] & LMP_EXT_INQ))
 		return 0;
 
-	if (!test_bit(HCI_SSP_ENABLED, &hdev->compat_flags))
+	if (!test_bit(HCI_DEV_SSP_ENABLED, &hdev->compat_flags))
 		return 0;
 
-	if (test_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
+	if (test_bit(HCI_DEV_SERVICE_CACHE, &hdev->flags))
 		return 0;
 
 	memset(&cp, 0, sizeof(cp));
@@ -451,7 +451,7 @@ static int update_class(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	if (test_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
+	if (test_bit(HCI_DEV_SERVICE_CACHE, &hdev->flags))
 		return 0;
 
 	cod[0] = hdev->minor_class;
@@ -469,7 +469,7 @@ static void service_cache_off(struct work_struct *work)
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 							service_cache.work);
 
-	if (!test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
+	if (!test_and_clear_bit(HCI_DEV_SERVICE_CACHE, &hdev->flags))
 		return;
 
 	hci_dev_lock(hdev);
@@ -482,10 +482,10 @@ static void service_cache_off(struct work_struct *work)
 
 static void mgmt_init_hdev(struct hci_dev *hdev)
 {
-	if (!test_and_set_bit(HCI_MGMT, &hdev->dev_flags))
+	if (!test_and_set_bit(HCI_DEV_MGMT, &hdev->flags))
 		INIT_DELAYED_WORK(&hdev->service_cache, service_cache_off);
 
-	if (!test_and_set_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
+	if (!test_and_set_bit(HCI_DEV_SERVICE_CACHE, &hdev->flags))
 		schedule_delayed_work(&hdev->service_cache,
 				msecs_to_jiffies(SERVICE_CACHE_TIMEOUT));
 }
@@ -502,7 +502,7 @@ static int read_controller_info(struct sock *sk, u16 index)
 		return cmd_status(sk, index, MGMT_OP_READ_INFO,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+	if (test_and_clear_bit(HCI_DEV_AUTO_OFF, &hdev->flags))
 		cancel_delayed_work_sync(&hdev->power_off);
 
 	hci_dev_lock(hdev);
@@ -851,9 +851,9 @@ static int set_pairable(struct sock *sk, u16 index, unsigned char *data,
 	hci_dev_lock(hdev);
 
 	if (cp->val)
-		set_bit(HCI_PAIRABLE, &hdev->dev_flags);
+		set_bit(HCI_DEV_PAIRABLE, &hdev->flags);
 	else
-		clear_bit(HCI_PAIRABLE, &hdev->dev_flags);
+		clear_bit(HCI_DEV_PAIRABLE, &hdev->flags);
 
 	err = send_settings_rsp(sk, MGMT_OP_SET_PAIRABLE, hdev);
 	if (err < 0)
@@ -1008,7 +1008,7 @@ static int set_dev_class(struct sock *sk, u16 index, unsigned char *data,
 	hdev->major_class = cp->major;
 	hdev->minor_class = cp->minor;
 
-	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags)) {
+	if (test_and_clear_bit(HCI_DEV_SERVICE_CACHE, &hdev->flags)) {
 		hci_dev_unlock(hdev);
 		cancel_delayed_work_sync(&hdev->service_cache);
 		hci_dev_lock(hdev);
@@ -1063,12 +1063,12 @@ static int load_link_keys(struct sock *sk, u16 index, unsigned char *data,
 
 	hci_link_keys_clear(hdev);
 
-	set_bit(HCI_LINK_KEYS, &hdev->dev_flags);
+	set_bit(HCI_DEV_LINK_KEYS, &hdev->flags);
 
 	if (cp->debug_keys)
-		set_bit(HCI_DEBUG_KEYS, &hdev->dev_flags);
+		set_bit(HCI_DEV_DEBUG_KEYS, &hdev->flags);
 	else
-		clear_bit(HCI_DEBUG_KEYS, &hdev->dev_flags);
+		clear_bit(HCI_DEV_DEBUG_KEYS, &hdev->flags);
 
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_link_key_info *key = &cp->keys[i];
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index e08fe6c..1c5e103 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -217,7 +217,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 {
 	u8 dist_keys = 0;
 
-	if (test_bit(HCI_PAIRABLE, &conn->hcon->hdev->dev_flags)) {
+	if (test_bit(HCI_DEV_PAIRABLE, &conn->hcon->hdev->flags)) {
 		dist_keys = SMP_DIST_ENC_KEY;
 		authreq |= SMP_AUTH_BONDING;
 	} else {
-- 
1.7.8.3

