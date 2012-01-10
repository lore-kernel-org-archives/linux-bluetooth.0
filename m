Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/7] Bluetooth: Add 'eir_len' param to mgmt_device_found()
Date: Tue, 10 Jan 2012 18:20:49 -0300
Message-Id: <1326230455-9117-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1326230455-9117-1-git-send-email-andre.guedes@openbossa.org>
References: <1326230455-9117-1-git-send-email-andre.guedes@openbossa.org>
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
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_event.c        |   10 ++++++----
 net/bluetooth/mgmt.c             |    7 +++++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 59e3541..393acd0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -925,7 +925,7 @@ int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 						u8 *randomizer, u8 status);
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 					u8 addr_type, u8 *dev_class, s8 rssi,
-					u8 cfm_name, u8 *eir);
+					u8 cfm_name, u8 *eir, u8 eir_len);
 int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *name);
 int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 94a9ca2..5e40d4e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1608,7 +1608,8 @@ static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *
 
 		name_known = hci_inquiry_cache_update(hdev, &data, false);
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
-					info->dev_class, 0, !name_known, NULL);
+					info->dev_class, 0, !name_known,
+					NULL, 0);
 	}
 
 	hci_dev_unlock(hdev);
@@ -2705,7 +2706,7 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 								false);
 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 						info->dev_class, info->rssi,
-						!name_known, NULL);
+						!name_known, NULL, 0);
 		}
 	} else {
 		struct inquiry_info_with_rssi *info = (void *) (skb->data + 1);
@@ -2723,7 +2724,7 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 								false);
 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 						info->dev_class, info->rssi,
-						!name_known, NULL);
+						!name_known, NULL, 0);
 		}
 	}
 
@@ -2900,7 +2901,8 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 		name_known = hci_inquiry_cache_update(hdev, &data, name_known);
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 						info->dev_class, info->rssi,
-						!name_known, info->data);
+						!name_known, info->data,
+						sizeof(info->data));
 	}
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2dae2e8..e7bbad8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2780,10 +2780,13 @@ int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 				u8 addr_type, u8 *dev_class, s8 rssi,
-				u8 cfm_name, u8 *eir)
+				u8 cfm_name, u8 *eir, u8 eir_len)
 {
 	struct mgmt_ev_device_found ev;
 
+	if (eir_len > sizeof(ev.eir))
+		return -EINVAL;
+
 	memset(&ev, 0, sizeof(ev));
 
 	bacpy(&ev.addr.bdaddr, bdaddr);
@@ -2792,7 +2795,7 @@ int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	ev.confirm_name = cfm_name;
 
 	if (eir)
-		memcpy(ev.eir, eir, sizeof(ev.eir));
+		memcpy(ev.eir, eir, eir_len);
 
 	if (dev_class)
 		memcpy(ev.dev_class, dev_class, sizeof(ev.dev_class));
-- 
1.7.8.1

