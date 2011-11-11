Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] Bluetooth: Add 'eir_len' param to mgmt_device_found()
Date: Fri, 11 Nov 2011 19:50:22 -0300
Message-Id: <1321051824-5216-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org>
References: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a new parameter to mgmt_device_found() to inform
the length of 'eir' pointer.

EIR data from LE advertising report event doesn't have a fixed length
as EIR data from extended inquiry result event does. We needed to
change mgmt_device_found() so it copies 'eir_len' bytes instead of
HCI_MAX_EIR_LENGTH.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |    3 ++-
 net/bluetooth/hci_event.c        |    9 +++++----
 net/bluetooth/mgmt.c             |    8 ++++++--
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 69dda9b..9da5b69 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -942,7 +942,8 @@ int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 						u8 *randomizer, u8 status);
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-				u8 addr_type, u8 *dev_class, s8 rssi, u8 *eir);
+					u8 addr_type, u8 *dev_class, s8 rssi,
+					u8 *eir,  u8 eir_len);
 int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *name);
 int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0beb633..6d60fec 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1448,7 +1448,7 @@ static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *
 		data.ssp_mode		= 0x00;
 		hci_inquiry_cache_update(hdev, &data);
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
-						info->dev_class, 0, NULL);
+						info->dev_class, 0, NULL, 0);
 	}
 
 	hci_dev_unlock(hdev);
@@ -2458,7 +2458,7 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 			hci_inquiry_cache_update(hdev, &data);
 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 						info->dev_class, info->rssi,
-						NULL);
+						NULL, 0);
 		}
 	} else {
 		struct inquiry_info_with_rssi *info = (void *) (skb->data + 1);
@@ -2475,7 +2475,7 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 			hci_inquiry_cache_update(hdev, &data);
 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 						info->dev_class, info->rssi,
-						NULL);
+						NULL, 0);
 		}
 	}
 
@@ -2617,7 +2617,8 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 		data.ssp_mode		= 0x01;
 		hci_inquiry_cache_update(hdev, &data);
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
-				info->dev_class, info->rssi, info->data);
+					info->dev_class, info->rssi,
+					info->data, sizeof(info->data));
 	}
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bd77f54..b63a7d0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2397,10 +2397,14 @@ int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 }
 
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-				u8 addr_type, u8 *dev_class, s8 rssi, u8 *eir)
+					u8 addr_type, u8 *dev_class, s8 rssi,
+					u8 *eir, u8 eir_len)
 {
 	struct mgmt_ev_device_found ev;
 
+	if (eir_len > sizeof(ev.eir))
+		return -EINVAL;
+
 	memset(&ev, 0, sizeof(ev));
 
 	bacpy(&ev.addr.bdaddr, bdaddr);
@@ -2408,7 +2412,7 @@ int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	ev.rssi = rssi;
 
 	if (eir)
-		memcpy(ev.eir, eir, sizeof(ev.eir));
+		memcpy(ev.eir, eir, eir_len);
 
 	if (dev_class)
 		memcpy(ev.dev_class, dev_class, sizeof(ev.dev_class));
-- 
1.7.7.1

