Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Change eir_has_data_type() to more generic eir_get_data()
Date: Tue,  5 Jan 2016 12:00:48 +0200
Message-Id: <1451988049-25893-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1451988049-25893-1-git-send-email-johan.hedberg@gmail.com>
References: <1451988049-25893-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To make the EIR parsing helper more general purpose, make it return
the found data and its length rather than just saying whether the data
was present or not.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 30 ++++++++++++++++++++----------
 net/bluetooth/hci_event.c        |  6 +++---
 net/bluetooth/mgmt.c             |  3 ++-
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c95e0326c41a..372e2a7c4ada 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1283,31 +1283,41 @@ static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
 	mutex_unlock(&hci_cb_list_lock);
 }
 
-static inline bool eir_has_data_type(u8 *data, size_t data_len, u8 type)
+static inline void *eir_get_data(u8 *eir, size_t eir_len, u8 type,
+				 size_t *data_len)
 {
 	size_t parsed = 0;
 
-	if (data_len < 2)
-		return false;
+	if (eir_len < 2)
+		return NULL;
 
-	while (parsed < data_len - 1) {
-		u8 field_len = data[0];
+	while (parsed < eir_len - 1) {
+		u8 field_len = eir[0];
 
 		if (field_len == 0)
 			break;
 
 		parsed += field_len + 1;
 
-		if (parsed > data_len)
+		if (parsed > eir_len)
 			break;
 
-		if (data[1] == type)
-			return true;
+		if (eir[1] != type) {
+			eir += field_len + 1;
+			continue;
+		}
+
+		/* Zero length data */
+		if (field_len == 1)
+			return NULL;
 
-		data += field_len + 1;
+		if (data_len)
+			*data_len = field_len - 1;
+
+		return &eir[2];
 	}
 
-	return false;
+	return NULL;
 }
 
 static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7554da5b7a8f..c162af5d16bf 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3833,9 +3833,9 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 		data.ssp_mode		= 0x01;
 
 		if (hci_dev_test_flag(hdev, HCI_MGMT))
-			name_known = eir_has_data_type(info->data,
-						       sizeof(info->data),
-						       EIR_NAME_COMPLETE);
+			name_known = eir_get_data(info->data,
+						  sizeof(info->data),
+						  EIR_NAME_COMPLETE, NULL);
 		else
 			name_known = true;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 621f6fdd0dd1..3297a4ecc05e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7266,7 +7266,8 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		/* Copy EIR or advertising data into event */
 		memcpy(ev->eir, eir, eir_len);
 
-	if (dev_class && !eir_has_data_type(ev->eir, eir_len, EIR_CLASS_OF_DEV))
+	if (dev_class && !eir_get_data(ev->eir, eir_len, EIR_CLASS_OF_DEV,
+				       NULL))
 		eir_len = eir_append_data(ev->eir, eir_len, EIR_CLASS_OF_DEV,
 					  dev_class, 3);
 
-- 
2.5.0

