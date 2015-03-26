Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 5/8] Bluetooth: Support the "managed-flags" adv flag
Date: Wed, 25 Mar 2015 18:53:43 -0700
Message-Id: <1427334826-14858-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1427334826-14858-1-git-send-email-armansito@chromium.org>
References: <1427334826-14858-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for the "managed-flags" flag of the Add
Advertising command.

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 net/bluetooth/mgmt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4cb02f3..0ce4bd6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -986,7 +986,13 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 *ptr)
 	if (hdev->adv_instance.flags & MGMT_ADV_FLAG_LIMITED_DISCOV)
 		flags |= LE_AD_LIMITED;
 
-	if (flags) {
+	if (flags || (hdev->adv_instance.flags & MGMT_ADV_FLAG_MANAGED_FLAGS)) {
+		/* If a discovery flag wasn't provided, simply use the global
+		 * settings.
+		 */
+		if (!flags)
+			flags |= get_adv_discov_flags(hdev);
+
 		if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
 			flags |= LE_AD_NO_BREDR;
 
@@ -6582,7 +6588,8 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
 	u8 max_len = HCI_MAX_AD_LENGTH;
 	int i, cur_len;
 	bool flags_managed = false;
-	u32 flags_params = MGMT_ADV_FLAG_DISCOV | MGMT_ADV_FLAG_LIMITED_DISCOV;
+	u32 flags_params = MGMT_ADV_FLAG_DISCOV | MGMT_ADV_FLAG_LIMITED_DISCOV |
+			   MGMT_ADV_FLAG_MANAGED_FLAGS;
 
 	if (is_adv_data && (adv_flags & flags_params)) {
 		flags_managed = true;
-- 
2.2.0.rc0.207.ga3a616c

