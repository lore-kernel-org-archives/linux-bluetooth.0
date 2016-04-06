Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix setting NO_BREDR advertising flag
Date: Wed,  6 Apr 2016 13:09:05 +0300
Message-Id: <1459937345-30236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we're dealing with a single-mode controller or BR/EDR is disable
for a dual-mode one, the NO_BREDR flag needs to be unconditionally
present in the advertising data. This patch moves it out from behind
an extra condition to be always set in the create_instance_adv_data()
function if BR/EDR is disabled.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_request.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 6e125d76df0d..c045b3c54768 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1065,6 +1065,9 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 	if (instance_flags & MGMT_ADV_FLAG_LIMITED_DISCOV)
 		flags |= LE_AD_LIMITED;
 
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
+		flags |= LE_AD_NO_BREDR;
+
 	if (flags || (instance_flags & MGMT_ADV_FLAG_MANAGED_FLAGS)) {
 		/* If a discovery flag wasn't provided, simply use the global
 		 * settings.
@@ -1072,9 +1075,6 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 		if (!flags)
 			flags |= mgmt_get_adv_discov_flags(hdev);
 
-		if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
-			flags |= LE_AD_NO_BREDR;
-
 		/* If flags would still be empty, then there is no need to
 		 * include the "Flags" AD field".
 		 */
-- 
2.5.5

