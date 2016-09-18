Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v2 4/6] Bluetooth: Unify advertising instance flags check
Date: Sun, 18 Sep 2016 12:50:05 +0200
Message-Id: <1474195807-12310-4-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1474195807-12310-1-git-send-email-szymon.janc@codecoup.pl>
References: <1474195807-12310-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This unifies max length and TLV validity checks.

Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
---
 net/bluetooth/mgmt.c | 85 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 37 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0751195..cdc88f4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6007,34 +6007,59 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static bool tlv_data_is_valid(u32 adv_flags, u8 *data, u8 len, bool is_adv_data)
+static u8 tlv_data_max_len(u32 adv_flags, bool is_adv_data)
 {
 	u8 max_len = HCI_MAX_AD_LENGTH;
-	int i, cur_len;
-	bool flags_managed = false;
-	bool tx_power_managed = false;
 
 	if (is_adv_data) {
 		if (adv_flags & (MGMT_ADV_FLAG_DISCOV |
 				 MGMT_ADV_FLAG_LIMITED_DISCOV |
-				 MGMT_ADV_FLAG_MANAGED_FLAGS)) {
-			flags_managed = true;
+				 MGMT_ADV_FLAG_MANAGED_FLAGS))
 			max_len -= 3;
-		}
 
-		if (adv_flags & MGMT_ADV_FLAG_TX_POWER) {
-			tx_power_managed = true;
+		if (adv_flags & MGMT_ADV_FLAG_TX_POWER)
 			max_len -= 3;
-		}
 	} else {
 		/* at least 1 byte of name should fit in */
 		if (adv_flags & MGMT_ADV_FLAG_LOCAL_NAME)
 			max_len -= 3;
 
-		if (adv_flags & MGMT_ADV_FLAG_APPEARANCE)
+		if (adv_flags & (MGMT_ADV_FLAG_APPEARANCE))
 			max_len -= 4;
 	}
 
+	return max_len;
+}
+
+static bool flags_managed(u32 adv_flags)
+{
+	return adv_flags & (MGMT_ADV_FLAG_DISCOV |
+			    MGMT_ADV_FLAG_LIMITED_DISCOV |
+			    MGMT_ADV_FLAG_MANAGED_FLAGS);
+}
+
+static bool tx_power_managed(u32 adv_flags)
+{
+	return adv_flags & MGMT_ADV_FLAG_TX_POWER;
+}
+
+static bool name_managed(u32 adv_flags)
+{
+	return adv_flags & MGMT_ADV_FLAG_LOCAL_NAME;
+}
+
+static bool appearance_managed(u32 adv_flags)
+{
+	return adv_flags & MGMT_ADV_FLAG_APPEARANCE;
+}
+
+static bool tlv_data_is_valid(u32 adv_flags, u8 *data, u8 len, bool is_adv_data)
+{
+	int i, cur_len;
+	u8 max_len;
+
+	max_len = tlv_data_max_len(adv_flags, is_adv_data);
+
 	if (len > max_len)
 		return false;
 
@@ -6042,10 +6067,20 @@ static bool tlv_data_is_valid(u32 adv_flags, u8 *data, u8 len, bool is_adv_data)
 	for (i = 0, cur_len = 0; i < len; i += (cur_len + 1)) {
 		cur_len = data[i];
 
-		if (flags_managed && data[i + 1] == EIR_FLAGS)
+		if (data[i + 1] == EIR_FLAGS && flags_managed(adv_flags))
+			return false;
+
+		if (data[i + 1] == EIR_TX_POWER && tx_power_managed(adv_flags))
+			return false;
+
+		if (data[i + 1] == EIR_NAME_COMPLETE && name_managed(adv_flags))
+			return false;
+
+		if (data[i + 1] == EIR_NAME_SHORT && name_managed(adv_flags))
 			return false;
 
-		if (tx_power_managed && data[i + 1] == EIR_TX_POWER)
+		if (data[i + 1] == EIR_APPEARANCE &&
+		    appearance_managed(adv_flags))
 			return false;
 
 		/* If the current field length would exceed the total data
@@ -6353,30 +6388,6 @@ unlock:
 	return err;
 }
 
-static u8 tlv_data_max_len(u32 adv_flags, bool is_adv_data)
-{
-	u8 max_len = HCI_MAX_AD_LENGTH;
-
-	if (is_adv_data) {
-		if (adv_flags & (MGMT_ADV_FLAG_DISCOV |
-				 MGMT_ADV_FLAG_LIMITED_DISCOV |
-				 MGMT_ADV_FLAG_MANAGED_FLAGS))
-			max_len -= 3;
-
-		if (adv_flags & MGMT_ADV_FLAG_TX_POWER)
-			max_len -= 3;
-	} else {
-		/* at least 1 byte of name should fit in */
-		if (adv_flags & MGMT_ADV_FLAG_LOCAL_NAME)
-			max_len -= 3;
-
-		if (adv_flags & (MGMT_ADV_FLAG_APPEARANCE))
-			max_len -= 4;
-	}
-
-	return max_len;
-}
-
 static int get_adv_size_info(struct sock *sk, struct hci_dev *hdev,
 			     void *data, u16 data_len)
 {
-- 
2.7.4

