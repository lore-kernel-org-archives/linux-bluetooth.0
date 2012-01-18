Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/15] Bluetooth: Rename eir_has_complete_name to eir_has_data_type
Date: Wed, 18 Jan 2012 20:51:46 +0200
Message-Id: <1326912717-6347-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This allows for other uses such as checking for an embedded class of
device value in order to decide whether to append the class or not.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8d7505a..ea2ec61 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2842,7 +2842,7 @@ static inline void hci_sniff_subrate_evt(struct hci_dev *hdev, struct sk_buff *s
 	BT_DBG("%s status %d", hdev->name, ev->status);
 }
 
-static inline bool eir_has_complete_name(u8 *data, size_t data_len)
+static inline bool eir_has_data_type(u8 *data, size_t data_len, u8 type)
 {
 	u8 field_len;
 	size_t parsed;
@@ -2858,7 +2858,7 @@ static inline bool eir_has_complete_name(u8 *data, size_t data_len)
 		if (parsed > data_len)
 			break;
 
-		if (data[1] == EIR_NAME_COMPLETE)
+		if (data[1] == type)
 			return true;
 
 		data += field_len + 1;
@@ -2893,8 +2893,9 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 		data.ssp_mode		= 0x01;
 
 		if (test_bit(HCI_MGMT, &hdev->dev_flags))
-			name_known = eir_has_complete_name(info->data,
-							sizeof(info->data));
+			name_known = eir_has_data_type(info->data,
+							sizeof(info->data),
+							EIR_NAME_COMPLETE);
 		else
 			name_known = true;
 
-- 
1.7.8.3

