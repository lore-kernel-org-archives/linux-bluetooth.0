Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/9] Bluetooth: Return updated name state with hci_inquiry_cache_update
Date: Thu,  5 Jan 2012 17:16:18 +0200
Message-Id: <1325776582-10314-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
References: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If user-space has already confirmed the name for a remote device we
shouldn't request confirmation again. The simplest way to do this is to
return the name state from hci_inquiry_cache_update (if it is anything
else than unknown then we do not need confirmation from user-space).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_core.c         |    9 +++++++--
 net/bluetooth/hci_event.c        |   21 ++++++++++++++-------
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2999b6e..236f7f0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -384,7 +384,7 @@ struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev,
 							bdaddr_t *bdaddr);
 struct inquiry_entry *hci_inquiry_cache_lookup_unknown(struct hci_dev *hdev,
 							bdaddr_t *bdaddr);
-void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
+bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 							bool name_known);
 
 /* ----- HCI Connections ----- */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9e36fb1..67b0bd6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -400,7 +400,7 @@ struct inquiry_entry *hci_inquiry_cache_lookup_unknown(struct hci_dev *hdev,
 	return NULL;
 }
 
-void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
+bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 							bool name_known)
 {
 	struct inquiry_cache *cache = &hdev->inq_cache;
@@ -415,7 +415,7 @@ void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 	/* Entry not in the cache. Add new one. */
 	ie = kzalloc(sizeof(struct inquiry_entry), GFP_ATOMIC);
 	if (!ie)
-		return;
+		return false;
 
 	list_add(&ie->all, &cache->all);
 
@@ -436,6 +436,11 @@ update:
 	memcpy(&ie->data, data, sizeof(*data));
 	ie->timestamp = jiffies;
 	cache->timestamp = jiffies;
+
+	if (ie->name_state == NAME_NOT_KNOWN)
+		return false;
+
+	return true;
 }
 
 static int inquiry_cache_dump(struct hci_dev *hdev, int num, __u8 *buf)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index abcdadf..828ff14 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1525,6 +1525,8 @@ static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *
 	hci_dev_lock(hdev);
 
 	for (; num_rsp; num_rsp--, info++) {
+		bool name_known;
+
 		bacpy(&data.bdaddr, &info->bdaddr);
 		data.pscan_rep_mode	= info->pscan_rep_mode;
 		data.pscan_period_mode	= info->pscan_period_mode;
@@ -1533,9 +1535,10 @@ static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *
 		data.clock_offset	= info->clock_offset;
 		data.rssi		= 0x00;
 		data.ssp_mode		= 0x00;
-		hci_inquiry_cache_update(hdev, &data, false);
+
+		name_known = hci_inquiry_cache_update(hdev, &data, false);
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
-						info->dev_class, 0, 1, NULL);
+					info->dev_class, 0, !name_known, NULL);
 	}
 
 	hci_dev_unlock(hdev);
@@ -2551,6 +2554,7 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 {
 	struct inquiry_data data;
 	int num_rsp = *((__u8 *) skb->data);
+	bool name_known;
 
 	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
 
@@ -2572,10 +2576,12 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 			data.clock_offset	= info->clock_offset;
 			data.rssi		= info->rssi;
 			data.ssp_mode		= 0x00;
-			hci_inquiry_cache_update(hdev, &data, false);
+
+			name_known = hci_inquiry_cache_update(hdev, &data,
+								false);
 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 						info->dev_class, info->rssi,
-						1, NULL);
+						!name_known, NULL);
 		}
 	} else {
 		struct inquiry_info_with_rssi *info = (void *) (skb->data + 1);
@@ -2589,10 +2595,11 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 			data.clock_offset	= info->clock_offset;
 			data.rssi		= info->rssi;
 			data.ssp_mode		= 0x00;
-			hci_inquiry_cache_update(hdev, &data, false);
+			name_known = hci_inquiry_cache_update(hdev, &data,
+								false);
 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 						info->dev_class, info->rssi,
-						1, NULL);
+						!name_known, NULL);
 		}
 	}
 
@@ -2766,7 +2773,7 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 		else
 			name_known = true;
 
-		hci_inquiry_cache_update(hdev, &data, name_known);
+		name_known = hci_inquiry_cache_update(hdev, &data, name_known);
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 						info->dev_class, info->rssi,
 						!name_known, info->data);
-- 
1.7.7.3

