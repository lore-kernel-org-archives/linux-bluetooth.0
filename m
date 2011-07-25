Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH v2 11/16] Bluetooth: Add 'eir_len' param to mgmt_device_found()
Date: Mon, 25 Jul 2011 16:50:00 -0300
Message-Id: <1311623405-31108-12-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org>
References: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a new parameter to mgmt_device_found() to inform
the length of 'eir' pointer.

EIR data from LE advertising report event doesn't have a fixed length
as EIR data from extended inquiry result event does. We needed to
change mgmt_device_found() so it copies 'eir_len' bytes instead of
HCI_MAX_EIR_LENGTH.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_event.c        |    9 +++++----
 net/bluetooth/mgmt.c             |    7 +++++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0d2e703..1ca4e60 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -855,7 +855,7 @@ int mgmt_set_local_name_complete(u16 index, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
 								u8 status);
 int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
-								u8 *eir);
+							u8 *eir, u8 eir_len);
 int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
 int mgmt_discovering(u16 index, u8 discovering);
 int mgmt_start_discovery_complete(u16 index);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c75211c..4f85669 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1393,7 +1393,7 @@ static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *
 		data.ssp_mode		= 0x00;
 		hci_inquiry_cache_update(hdev, &data);
 		mgmt_device_found(hdev->id, &info->bdaddr, info->dev_class, 0,
-									NULL);
+								NULL, 0);
 	}
 
 	hci_dev_unlock(hdev);
@@ -2390,7 +2390,7 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 			hci_inquiry_cache_update(hdev, &data);
 			mgmt_device_found(hdev->id, &info->bdaddr,
 						info->dev_class, info->rssi,
-						NULL);
+						NULL, 0);
 		}
 	} else {
 		struct inquiry_info_with_rssi *info = (void *) (skb->data + 1);
@@ -2407,7 +2407,7 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 			hci_inquiry_cache_update(hdev, &data);
 			mgmt_device_found(hdev->id, &info->bdaddr,
 						info->dev_class, info->rssi,
-						NULL);
+						NULL, 0);
 		}
 	}
 
@@ -2549,7 +2549,8 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 		data.ssp_mode		= 0x01;
 		hci_inquiry_cache_update(hdev, &data);
 		mgmt_device_found(hdev->id, &info->bdaddr, info->dev_class,
-						info->rssi, info->data);
+						info->rssi, info->data,
+						sizeof(info->data));
 	}
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 796edd7..c0d3321 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2330,17 +2330,20 @@ int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
 }
 
 int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
-								u8 *eir)
+							u8 *eir, u8 eir_len)
 {
 	struct mgmt_ev_device_found ev;
 
+	if (eir_len > sizeof(ev.eir))
+		return -EINVAL;
+
 	memset(&ev, 0, sizeof(ev));
 
 	bacpy(&ev.bdaddr, bdaddr);
 	ev.rssi = rssi;
 
 	if (eir)
-		memcpy(ev.eir, eir, sizeof(ev.eir));
+		memcpy(ev.eir, eir, eir_len);
 
 	if (dev_class)
 		memcpy(ev.dev_class, dev_class, sizeof(ev.dev_class));
-- 
1.7.4.1

