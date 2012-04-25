Return-Path: <cyrus@holtmann.org>
From: Vishal Agarwal <vishal.agarwal@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <vishal.agarwal@stericsson.com>
Subject: [PATCH] Bluetooth: Padding should be removed from EIR data
Date: Wed, 25 Apr 2012 18:57:14 +0530
Message-ID: <1335360434-28774-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

EIR data received from controller might contain padding zeros.
This padding should be removed before any further processing and
sending it over mgmt interface.

Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
---
 include/net/bluetooth/hci_core.h |   17 +++++++++++++++++
 net/bluetooth/hci_event.c        |    4 +++-
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ef6e654..eec721c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -935,6 +935,23 @@ static inline bool eir_has_data_type(u8 *data, size_t data_len, u8 type)
 	return false;
 }
 
+static inline size_t eir_get_padding_offset(u8 *eir, size_t eir_len)
+{
+	u8 field_len;
+	size_t parsed = 0;
+
+	while (parsed < eir_len) {
+		field_len = eir[0];
+
+		if (field_len == 0)
+			return parsed;
+
+		parsed += field_len + 1;
+		eir += field_len + 1;
+	}
+	return eir_len;
+}
+
 static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
 				  u8 data_len)
 {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fb23c47..067464f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3000,6 +3000,7 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 	struct inquiry_data data;
 	struct extended_inquiry_info *info = (void *) (skb->data + 1);
 	int num_rsp = *((__u8 *) skb->data);
+	size_t eir_len;
 
 	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
 
@@ -3032,9 +3033,10 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 
 		name_known = hci_inquiry_cache_update(hdev, &data, name_known,
 						      &ssp);
+		eir_len = eir_get_padding_offset(info->data, sizeof(info->data));
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 				  info->dev_class, info->rssi, !name_known,
-				  ssp, info->data, sizeof(info->data));
+				  ssp, info->data, eir_len);
 	}
 
 	hci_dev_unlock(hdev);
-- 
1.7.0.4

