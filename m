Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove Simultaneous LE & BR/EDR flags from AD
Date: Thu, 30 Jan 2014 11:16:50 -0800
Message-Id: <1391109410-8595-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Starting with the 4.1 Core Specification these flags are no longer used
and should always be cleared. From volume 3, part C, section 13.1.1:

"The 'Simultaneous LE and BR/EDR to Same Device Capable (Controller)'
and ‘Simultaneous LE and BR/EDR to Same Device Capable (Host)’ bits in
the Flags AD type shall be set to ‘0’."

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bde8e675c5ea..111b1296a2b8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -637,14 +637,8 @@ static u8 create_adv_data(struct hci_dev *hdev, u8 *ptr)
 
 	flags |= get_adv_discov_flags(hdev);
 
-	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
-		if (lmp_le_br_capable(hdev))
-			flags |= LE_AD_SIM_LE_BREDR_CTRL;
-		if (lmp_host_le_br_capable(hdev))
-			flags |= LE_AD_SIM_LE_BREDR_HOST;
-	} else {
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
 		flags |= LE_AD_NO_BREDR;
-	}
 
 	if (flags) {
 		BT_DBG("adv flags 0x%02x", flags);
-- 
1.8.5.3

