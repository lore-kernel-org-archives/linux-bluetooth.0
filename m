Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Provide flags parameter direct to mgmt_device_found
Date: Tue,  1 Jul 2014 13:24:13 +0200
Message-Id: <1404213853-25362-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Providing the flags parameter directly to mgmt_device_found function
makes the core simpler and more readable. With this it becomes a lot
easier to add new flags in the future.

This also changes hci_inquiry_cache_update to just return that flags
needed for mgmt_device_found since that is its only use for the two
return parameters anyway.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  9 ++++----
 include/net/bluetooth/mgmt.h     |  1 +
 net/bluetooth/hci_core.c         | 24 ++++++++++++--------
 net/bluetooth/hci_event.c        | 48 ++++++++++++++++++++++------------------
 net/bluetooth/mgmt.c             | 10 +++------
 5 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 61d4d265f42d..ab3d4dda071c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -510,8 +510,8 @@ struct inquiry_entry *hci_inquiry_cache_lookup_resolve(struct hci_dev *hdev,
 						       int state);
 void hci_inquiry_cache_update_resolve(struct hci_dev *hdev,
 				      struct inquiry_entry *ie);
-bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
-			      bool name_known, bool *ssp);
+u32 hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
+			     bool name_known);
 void hci_inquiry_cache_flush(struct hci_dev *hdev);
 
 /* ----- HCI Connections ----- */
@@ -1318,9 +1318,8 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
 				       u8 *randomizer192, u8 *hash256,
 				       u8 *randomizer256, u8 status);
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-		       u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name,
-		       u8 ssp, u8 *eir, u16 eir_len, u8 *scan_rsp,
-		       u8 scan_rsp_len);
+		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
+		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len);
 void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, s8 rssi, u8 *name, u8 name_len);
 void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 1f95ad4fce02..2d88f361a016 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -547,6 +547,7 @@ struct mgmt_ev_auth_failed {
 
 #define MGMT_DEV_FOUND_CONFIRM_NAME    0x01
 #define MGMT_DEV_FOUND_LEGACY_PAIRING  0x02
+#define MGMT_DEV_FOUND_NOT_CONNECTABLE 0x04
 
 #define MGMT_EV_DEVICE_FOUND		0x0012
 struct mgmt_ev_device_found {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 237963d5473c..0aa392406629 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -35,6 +35,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/mgmt.h>
 
 #include "smp.h"
 
@@ -1970,22 +1971,24 @@ void hci_inquiry_cache_update_resolve(struct hci_dev *hdev,
 	list_add(&ie->list, pos);
 }
 
-bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
-			      bool name_known, bool *ssp)
+u32 hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
+			     bool name_known)
 {
 	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *ie;
+	u32 flags = 0;
 
 	BT_DBG("cache %p, %pMR", cache, &data->bdaddr);
 
 	hci_remove_remote_oob_data(hdev, &data->bdaddr);
 
-	*ssp = data->ssp_mode;
+	if (!data->ssp_mode)
+		flags |= MGMT_DEV_FOUND_LEGACY_PAIRING;
 
 	ie = hci_inquiry_cache_lookup(hdev, &data->bdaddr);
 	if (ie) {
-		if (ie->data.ssp_mode)
-			*ssp = true;
+		if (!ie->data.ssp_mode)
+			flags |= MGMT_DEV_FOUND_LEGACY_PAIRING;
 
 		if (ie->name_state == NAME_NEEDED &&
 		    data->rssi != ie->data.rssi) {
@@ -1998,8 +2001,10 @@ bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 
 	/* Entry not in the cache. Add new one. */
 	ie = kzalloc(sizeof(struct inquiry_entry), GFP_ATOMIC);
-	if (!ie)
-		return false;
+	if (!ie) {
+		flags |= MGMT_DEV_FOUND_CONFIRM_NAME;
+		goto done;
+	}
 
 	list_add(&ie->all, &cache->all);
 
@@ -2022,9 +2027,10 @@ update:
 	cache->timestamp = jiffies;
 
 	if (ie->name_state == NAME_NOT_KNOWN)
-		return false;
+		flags |= MGMT_DEV_FOUND_CONFIRM_NAME;
 
-	return true;
+done:
+	return flags;
 }
 
 static int inquiry_cache_dump(struct hci_dev *hdev, int num, __u8 *buf)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fe7a54b65e55..9fbcd1eade3d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1132,7 +1132,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 			mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
 					  d->last_adv_addr_type, NULL,
-					  d->last_adv_rssi, 0, 1,
+					  d->last_adv_rssi, 0,
 					  d->last_adv_data,
 					  d->last_adv_data_len, NULL, 0);
 		}
@@ -1965,7 +1965,7 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_lock(hdev);
 
 	for (; num_rsp; num_rsp--, info++) {
-		bool name_known, ssp;
+		u32 flags;
 
 		bacpy(&data.bdaddr, &info->bdaddr);
 		data.pscan_rep_mode	= info->pscan_rep_mode;
@@ -1976,10 +1976,10 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		data.rssi		= 0x00;
 		data.ssp_mode		= 0x00;
 
-		name_known = hci_inquiry_cache_update(hdev, &data, false, &ssp);
+		flags = hci_inquiry_cache_update(hdev, &data, false);
+
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
-				  info->dev_class, 0, !name_known, ssp, NULL,
-				  0, NULL, 0);
+				  info->dev_class, 0, flags, NULL, 0, NULL, 0);
 	}
 
 	hci_dev_unlock(hdev);
@@ -3257,7 +3257,6 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 {
 	struct inquiry_data data;
 	int num_rsp = *((__u8 *) skb->data);
-	bool name_known, ssp;
 
 	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
 
@@ -3274,6 +3273,8 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 		info = (void *) (skb->data + 1);
 
 		for (; num_rsp; num_rsp--, info++) {
+			u32 flags;
+
 			bacpy(&data.bdaddr, &info->bdaddr);
 			data.pscan_rep_mode	= info->pscan_rep_mode;
 			data.pscan_period_mode	= info->pscan_period_mode;
@@ -3283,16 +3284,18 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 			data.rssi		= info->rssi;
 			data.ssp_mode		= 0x00;
 
-			name_known = hci_inquiry_cache_update(hdev, &data,
-							      false, &ssp);
+			flags = hci_inquiry_cache_update(hdev, &data, false);
+
 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 					  info->dev_class, info->rssi,
-					  !name_known, ssp, NULL, 0, NULL, 0);
+					  flags, NULL, 0, NULL, 0);
 		}
 	} else {
 		struct inquiry_info_with_rssi *info = (void *) (skb->data + 1);
 
 		for (; num_rsp; num_rsp--, info++) {
+			u32 flags;
+
 			bacpy(&data.bdaddr, &info->bdaddr);
 			data.pscan_rep_mode	= info->pscan_rep_mode;
 			data.pscan_period_mode	= info->pscan_period_mode;
@@ -3301,11 +3304,12 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 			data.clock_offset	= info->clock_offset;
 			data.rssi		= info->rssi;
 			data.ssp_mode		= 0x00;
-			name_known = hci_inquiry_cache_update(hdev, &data,
-							      false, &ssp);
+
+			flags = hci_inquiry_cache_update(hdev, &data, false);
+
 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 					  info->dev_class, info->rssi,
-					  !name_known, ssp, NULL, 0, NULL, 0);
+					  flags, NULL, 0, NULL, 0);
 		}
 	}
 
@@ -3472,7 +3476,8 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	for (; num_rsp; num_rsp--, info++) {
-		bool name_known, ssp;
+		u32 flags;
+		bool name_known;
 
 		bacpy(&data.bdaddr, &info->bdaddr);
 		data.pscan_rep_mode	= info->pscan_rep_mode;
@@ -3490,12 +3495,13 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 		else
 			name_known = true;
 
-		name_known = hci_inquiry_cache_update(hdev, &data, name_known,
-						      &ssp);
+		flags = hci_inquiry_cache_update(hdev, &data, name_known);
+
 		eir_len = eir_get_length(info->data, sizeof(info->data));
+
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
-				  info->dev_class, info->rssi, !name_known,
-				  ssp, info->data, eir_len, NULL, 0);
+				  info->dev_class, info->rssi,
+				  flags, info->data, eir_len, NULL, 0);
 	}
 
 	hci_dev_unlock(hdev);
@@ -4226,7 +4232,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		}
 
 		mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL,
-				  rssi, 0, 1, data, len, NULL, 0);
+				  rssi, 0, data, len, NULL, 0);
 		return;
 	}
 
@@ -4243,7 +4249,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		if (!match)
 			mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
 					  d->last_adv_addr_type, NULL,
-					  d->last_adv_rssi, 0, 1,
+					  d->last_adv_rssi, 0,
 					  d->last_adv_data,
 					  d->last_adv_data_len, NULL, 0);
 
@@ -4261,7 +4267,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		 */
 		clear_pending_adv_report(hdev);
 		mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL,
-				  rssi, 0, 1, data, len, NULL, 0);
+				  rssi, 0, data, len, NULL, 0);
 		return;
 	}
 
@@ -4270,7 +4276,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 * sending a merged device found event.
 	 */
 	mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
-			  d->last_adv_addr_type, NULL, rssi, 0, 1, data, len,
+			  d->last_adv_addr_type, NULL, rssi, 0, data, len,
 			  d->last_adv_data, d->last_adv_data_len);
 	clear_pending_adv_report(hdev);
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c6e9b551242b..336a2311bdca 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6233,9 +6233,8 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
 }
 
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-		       u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name,
-		       u8 ssp, u8 *eir, u16 eir_len, u8 *scan_rsp,
-		       u8 scan_rsp_len)
+		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
+		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
 {
 	char buf[512];
 	struct mgmt_ev_device_found *ev = (void *) buf;
@@ -6263,10 +6262,7 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	}
 
 	ev->rssi = rssi;
-	if (cfm_name)
-		ev->flags |= cpu_to_le32(MGMT_DEV_FOUND_CONFIRM_NAME);
-	if (!ssp)
-		ev->flags |= cpu_to_le32(MGMT_DEV_FOUND_LEGACY_PAIRING);
+	ev->flags = cpu_to_le32(flags);
 
 	if (eir_len > 0)
 		memcpy(ev->eir, eir, eir_len);
-- 
1.9.3

