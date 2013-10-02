Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix advertising data flags with disabled BR/EDR
Date: Wed,  2 Oct 2013 16:02:24 +0300
Message-Id: <1380718944-28164-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We shouldn't include the simultaneous LE & BR/EDR flags in the LE
advertising data if BR/EDR is disabled on a dual-mode controller. This
patch fixes this issue and ensures that the create_ad function generates
the correct flags when BR/EDR is disabled.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 14df032..82dbdc6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1108,14 +1108,14 @@ static u8 create_ad(struct hci_dev *hdev, u8 *ptr)
 	if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
 		flags |= LE_AD_GENERAL;
 
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
+		if (lmp_le_br_capable(hdev))
+			flags |= LE_AD_SIM_LE_BREDR_CTRL;
+		if (lmp_host_le_br_capable(hdev))
+			flags |= LE_AD_SIM_LE_BREDR_HOST;
+	} else {
 		flags |= LE_AD_NO_BREDR;
-
-	if (lmp_le_br_capable(hdev))
-		flags |= LE_AD_SIM_LE_BREDR_CTRL;
-
-	if (lmp_host_le_br_capable(hdev))
-		flags |= LE_AD_SIM_LE_BREDR_HOST;
+	}
 
 	if (flags) {
 		BT_DBG("adv flags 0x%02x", flags);
-- 
1.8.3.1

