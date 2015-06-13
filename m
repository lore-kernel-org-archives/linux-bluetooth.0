Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 08/20] Bluetooth: mgmt: improve get_adv_instance_flags() readability
Date: Sat, 13 Jun 2015 05:41:01 +0200
Message-Id: <1434166873-21595-9-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
References: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432600463-7758-1-git-send-email-fgrandel@gmail.com>
References: <1432600463-7758-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Switch if and else conditions to replace a negative statement by a
positive one which makes the condition more readable.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 net/bluetooth/mgmt.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 05f14c5..47fa16b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -962,26 +962,28 @@ static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
 	u32 flags;
 	struct adv_info *adv_instance;
 
-	if (instance != 0x00) {
-		adv_instance = hci_find_adv_instance(hdev, instance);
+	if (instance == 0x00) {
+		/* Instance 0 always manages the "Tx Power" and "Flags"
+		 * fields
+		 */
+		flags = MGMT_ADV_FLAG_TX_POWER | MGMT_ADV_FLAG_MANAGED_FLAGS;
 
-		/* Return 0 when we got an invalid instance identifier. */
-		if (!adv_instance)
-			return 0;
+		/* For instance 0, the HCI_ADVERTISING_CONNECTABLE setting
+		 * corresponds to the "connectable" instance flag.
+		 */
+		if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
+			flags |= MGMT_ADV_FLAG_CONNECTABLE;
 
-		return adv_instance->flags;
+		return flags;
 	}
 
-	/* Instance 0 always manages the "Tx Power" and "Flags" fields */
-	flags = MGMT_ADV_FLAG_TX_POWER | MGMT_ADV_FLAG_MANAGED_FLAGS;
+	adv_instance = hci_find_adv_instance(hdev, instance);
 
-	/* For instance 0, the HCI_ADVERTISING_CONNECTABLE setting corresponds
-	 * to the "connectable" instance flag.
-	 */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
-		flags |= MGMT_ADV_FLAG_CONNECTABLE;
+	/* Return 0 when we got an invalid instance identifier. */
+	if (!adv_instance)
+		return 0;
 
-	return flags;
+	return adv_instance->flags;
 }
 
 static u8 get_adv_instance_scan_rsp_len(struct hci_dev *hdev, u8 instance)
-- 
1.9.1

