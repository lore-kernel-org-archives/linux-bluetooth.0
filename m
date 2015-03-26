Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v1 6/8] Bluetooth: Support the "tx-power" adv flag
Date: Wed, 25 Mar 2015 18:14:14 -0700
Message-Id: <1427332456-7148-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1427332456-7148-1-git-send-email-armansito@chromium.org>
References: <1427332456-7148-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for the "tx-power" flag of the Add
Advertising command.

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 net/bluetooth/mgmt.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2ee94f5..4a5d2fb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1004,6 +1004,16 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 *ptr)
 		ptr += 3;
 	}
 
+	if (hdev->adv_tx_power != HCI_TX_POWER_INVALID &&
+	    (hdev->adv_instance.flags & MGMT_ADV_FLAG_TX_POWER)) {
+		ptr[0] = 0x02;
+		ptr[1] = EIR_TX_POWER;
+		ptr[2] = (u8)hdev->adv_tx_power;
+
+		ad_len += 3;
+		ptr += 3;
+	}
+
 	memcpy(ptr, hdev->adv_instance.adv_data,
 	       hdev->adv_instance.adv_data_len);
 	ad_len += hdev->adv_instance.adv_data_len;
@@ -6590,6 +6600,7 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
 	u8 max_len = HCI_MAX_AD_LENGTH;
 	int i, cur_len;
 	bool flags_managed = false;
+	bool tx_power_managed = false;
 	u32 flags_params = MGMT_ADV_FLAG_DISCOV | MGMT_ADV_FLAG_LIMITED_DISCOV |
 			   MGMT_ADV_FLAG_MANAGED_FLAGS;
 
@@ -6598,6 +6609,11 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
 		max_len -= 3;
 	}
 
+	if (is_adv_data && (adv_flags & MGMT_ADV_FLAG_TX_POWER)) {
+		tx_power_managed = true;
+		max_len -= 3;
+	}
+
 	if (len > max_len)
 		return false;
 
@@ -6608,6 +6624,9 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
 		if (flags_managed && data[i + 1] == EIR_FLAGS)
 			return false;
 
+		if (tx_power_managed && data[i + 1] == EIR_TX_POWER)
+			return false;
+
 		/* If the current field length would exceed the total data
 		 * length, then it's invalid.
 		 */
-- 
2.2.0.rc0.207.ga3a616c

