Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Add scan_rsp parameter to mgmt_device_found()
Date: Tue, 25 Mar 2014 10:30:47 +0200
Message-Id: <1395736249-11450-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1395736249-11450-1-git-send-email-johan.hedberg@gmail.com>
References: <1395736249-11450-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In preparation for being able to merge ADV_IND/ADV_SCAN_IND and SCAN_RSP
together into a single device found event add a second parameter to the
mgmt_device_found function. For now all callers pass NULL as this
parameters since we don't yet have storing of the last received
advertising report.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  5 +++--
 net/bluetooth/hci_event.c        | 10 +++++-----
 net/bluetooth/mgmt.c             | 16 +++++++++++-----
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5f8bc05694ac..a1b8eab8a47d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1264,8 +1264,9 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
 				       u8 *randomizer192, u8 *hash256,
 				       u8 *randomizer256, u8 status);
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-		       u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name,
-		       u8 ssp, u8 *eir, u16 eir_len);
+		       u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name, u8
+		       ssp, u8 *eir, u16 eir_len, u8 *scan_rsp,
+		       u8 scan_rsp_len);
 void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, s8 rssi, u8 *name, u8 name_len);
 void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2388f2c09887..4a2c919d5908 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1827,7 +1827,7 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		name_known = hci_inquiry_cache_update(hdev, &data, false, &ssp);
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 				  info->dev_class, 0, !name_known, ssp, NULL,
-				  0);
+				  0, NULL, 0);
 	}
 
 	hci_dev_unlock(hdev);
@@ -3102,7 +3102,7 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 							      false, &ssp);
 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 					  info->dev_class, info->rssi,
-					  !name_known, ssp, NULL, 0);
+					  !name_known, ssp, NULL, 0, NULL, 0);
 		}
 	} else {
 		struct inquiry_info_with_rssi *info = (void *) (skb->data + 1);
@@ -3120,7 +3120,7 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 							      false, &ssp);
 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 					  info->dev_class, info->rssi,
-					  !name_known, ssp, NULL, 0);
+					  !name_known, ssp, NULL, 0, NULL, 0);
 		}
 	}
 
@@ -3309,7 +3309,7 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 		eir_len = eir_get_length(info->data, sizeof(info->data));
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 				  info->dev_class, info->rssi, !name_known,
-				  ssp, info->data, eir_len);
+				  ssp, info->data, eir_len, NULL, 0);
 	}
 
 	hci_dev_unlock(hdev);
@@ -3972,7 +3972,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	}
 
 	mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL, rssi, 0, 1,
-			  data, len);
+			  data, len, NULL, 0);
 }
 
 static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d2d4e0d5aed0..a0ef5c076880 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5669,7 +5669,8 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
 
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name, u8
-		       ssp, u8 *eir, u16 eir_len)
+		       ssp, u8 *eir, u16 eir_len, u8 *scan_rsp,
+		       u8 scan_rsp_len)
 {
 	char buf[512];
 	struct mgmt_ev_device_found *ev = (void *) buf;
@@ -5679,8 +5680,10 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	if (!hci_discovery_active(hdev))
 		return;
 
-	/* Leave 5 bytes for a potential CoD field */
-	if (sizeof(*ev) + eir_len + 5 > sizeof(buf))
+	/* Make sure that the buffer is big enough. The 5 extra bytes
+	 * are for the potential CoD field.
+	 */
+	if (sizeof(*ev) + eir_len + scan_rsp_len + 5 > sizeof(buf))
 		return;
 
 	memset(buf, 0, sizeof(buf));
@@ -5707,8 +5710,11 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		eir_len = eir_append_data(ev->eir, eir_len, EIR_CLASS_OF_DEV,
 					  dev_class, 3);
 
-	ev->eir_len = cpu_to_le16(eir_len);
-	ev_size = sizeof(*ev) + eir_len;
+	if (scan_rsp_len > 0)
+		memcpy(ev->eir + eir_len, scan_rsp, scan_rsp_len);
+
+	ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
+	ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
 
 	mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
 }
-- 
1.8.5.3

