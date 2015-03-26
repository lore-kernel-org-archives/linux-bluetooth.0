Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 4/8] Bluetooth: Support the "limited-discoverable" adv flag
Date: Wed, 25 Mar 2015 18:53:42 -0700
Message-Id: <1427334826-14858-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1427334826-14858-1-git-send-email-armansito@chromium.org>
References: <1427334826-14858-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for the "limited-discoverable" flag of the
Add Advertising command.

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 net/bluetooth/mgmt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 03ddcfe..4cb02f3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -977,9 +977,15 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 *ptr)
 {
 	u8 ad_len = 0, flags = 0;
 
+	/* The Add Advertising command allows userspace to set both the general
+	 * and limited discoverable flags.
+	 */
 	if (hdev->adv_instance.flags & MGMT_ADV_FLAG_DISCOV)
 		flags |= LE_AD_GENERAL;
 
+	if (hdev->adv_instance.flags & MGMT_ADV_FLAG_LIMITED_DISCOV)
+		flags |= LE_AD_LIMITED;
+
 	if (flags) {
 		if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
 			flags |= LE_AD_NO_BREDR;
@@ -6576,8 +6582,9 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
 	u8 max_len = HCI_MAX_AD_LENGTH;
 	int i, cur_len;
 	bool flags_managed = false;
+	u32 flags_params = MGMT_ADV_FLAG_DISCOV | MGMT_ADV_FLAG_LIMITED_DISCOV;
 
-	if (is_adv_data && (adv_flags & MGMT_ADV_FLAG_DISCOV)) {
+	if (is_adv_data && (adv_flags & flags_params)) {
 		flags_managed = true;
 		max_len -= 3;
 	}
-- 
2.2.0.rc0.207.ga3a616c

