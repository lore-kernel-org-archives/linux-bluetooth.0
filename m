Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Add mgmt_device_found event
Date: Wed, 30 Mar 2011 13:18:11 +0300
Message-Id: <1301480292-25370-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds a device_found event to the Management interface. For
now the event only maps to BR/EDR inquiry result HCI events, but in the
future the plan is to also use it for the LE device discovery process.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci_core.h |    2 ++
 include/net/bluetooth/mgmt.h     |    8 ++++++++
 net/bluetooth/hci_event.c        |   22 ++++++++++++++--------
 net/bluetooth/mgmt.c             |   17 +++++++++++++++++
 4 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3b2f09d..2a88fc8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -787,6 +787,8 @@ int mgmt_auth_failed(u16 index, bdaddr_t *bdaddr, u8 status);
 int mgmt_set_local_name_complete(u16 index, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
 								u8 status);
+int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
+								u8 *eir);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 1a6283f..864d0cb 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -267,3 +267,11 @@ struct mgmt_ev_auth_failed {
 struct mgmt_ev_local_name_changed {
 	__u8 name[MGMT_MAX_NAME_LENGTH];
 } __packed;
+
+#define MGMT_EV_DEVICE_FOUND		0x0012
+struct mgmt_ev_device_found {
+	bdaddr_t bdaddr;
+	__u8 dev_class[3];
+	__s8 rssi;
+	__u8 eir[HCI_MAX_EIR_LENGTH];
+} __packed;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index da4c662..fb78c27 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1226,7 +1226,7 @@ static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *
 
 	hci_dev_lock(hdev);
 
-	for (; num_rsp; num_rsp--) {
+	for (; num_rsp; num_rsp--, info++) {
 		bacpy(&data.bdaddr, &info->bdaddr);
 		data.pscan_rep_mode	= info->pscan_rep_mode;
 		data.pscan_period_mode	= info->pscan_period_mode;
@@ -1235,8 +1235,9 @@ static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *
 		data.clock_offset	= info->clock_offset;
 		data.rssi		= 0x00;
 		data.ssp_mode		= 0x00;
-		info++;
 		hci_inquiry_cache_update(hdev, &data);
+		mgmt_device_found(hdev->id, &info->bdaddr, info->dev_class, 0,
+									NULL);
 	}
 
 	hci_dev_unlock(hdev);
@@ -2156,7 +2157,7 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 		struct inquiry_info_with_rssi_and_pscan_mode *info;
 		info = (void *) (skb->data + 1);
 
-		for (; num_rsp; num_rsp--) {
+		for (; num_rsp; num_rsp--, info++) {
 			bacpy(&data.bdaddr, &info->bdaddr);
 			data.pscan_rep_mode	= info->pscan_rep_mode;
 			data.pscan_period_mode	= info->pscan_period_mode;
@@ -2165,13 +2166,15 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 			data.clock_offset	= info->clock_offset;
 			data.rssi		= info->rssi;
 			data.ssp_mode		= 0x00;
-			info++;
 			hci_inquiry_cache_update(hdev, &data);
+			mgmt_device_found(hdev->id, &info->bdaddr,
+						info->dev_class, info->rssi,
+						NULL);
 		}
 	} else {
 		struct inquiry_info_with_rssi *info = (void *) (skb->data + 1);
 
-		for (; num_rsp; num_rsp--) {
+		for (; num_rsp; num_rsp--, info++) {
 			bacpy(&data.bdaddr, &info->bdaddr);
 			data.pscan_rep_mode	= info->pscan_rep_mode;
 			data.pscan_period_mode	= info->pscan_period_mode;
@@ -2180,8 +2183,10 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 			data.clock_offset	= info->clock_offset;
 			data.rssi		= info->rssi;
 			data.ssp_mode		= 0x00;
-			info++;
 			hci_inquiry_cache_update(hdev, &data);
+			mgmt_device_found(hdev->id, &info->bdaddr,
+						info->dev_class, info->rssi,
+						NULL);
 		}
 	}
 
@@ -2312,7 +2317,7 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 
 	hci_dev_lock(hdev);
 
-	for (; num_rsp; num_rsp--) {
+	for (; num_rsp; num_rsp--, info++) {
 		bacpy(&data.bdaddr, &info->bdaddr);
 		data.pscan_rep_mode	= info->pscan_rep_mode;
 		data.pscan_period_mode	= info->pscan_period_mode;
@@ -2321,8 +2326,9 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 		data.clock_offset	= info->clock_offset;
 		data.rssi		= info->rssi;
 		data.ssp_mode		= 0x01;
-		info++;
 		hci_inquiry_cache_update(hdev, &data);
+		mgmt_device_found(hdev->id, &info->bdaddr, info->dev_class,
+						info->rssi, info->data);
 	}
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 62055c9..066a7f1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2044,3 +2044,20 @@ int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
 
 	return err;
 }
+
+int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
+								u8 *eir)
+{
+	struct mgmt_ev_device_found ev;
+
+	memset(&ev, 0, sizeof(ev));
+
+	bacpy(&ev.bdaddr, bdaddr);
+	memcpy(ev.dev_class, dev_class, 3);
+	ev.rssi = rssi;
+
+	if (eir)
+		memcpy(ev.eir, eir, HCI_MAX_EIR_LENGTH);
+
+	return mgmt_event(MGMT_EV_DEVICE_FOUND, index, &ev, sizeof(ev), NULL);
+}
-- 
1.7.4.1

