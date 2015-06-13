Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 07/20] Bluetooth: mgmt: multi adv for get_adv_instance_flags()
Date: Sat, 13 Jun 2015 05:41:00 +0200
Message-Id: <1434166873-21595-8-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
References: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432600463-7758-1-git-send-email-fgrandel@gmail.com>
References: <1432600463-7758-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The get_adv_instance_flags() would not work with instance identifiers
other than 0x01. This is being fixed so that arbitrary instance
identifiers can be dealt with while still correctly dealing with the
special case of the 0x00 identifier.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 net/bluetooth/mgmt.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 55b9153..05f14c5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -960,12 +960,17 @@ static bool get_connectable(struct hci_dev *hdev)
 static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
 {
 	u32 flags;
+	struct adv_info *adv_instance;
 
-	if (instance > 0x01)
-		return 0;
+	if (instance != 0x00) {
+		adv_instance = hci_find_adv_instance(hdev, instance);
 
-	if (instance == 0x01)
-		return hdev->adv_instance.flags;
+		/* Return 0 when we got an invalid instance identifier. */
+		if (!adv_instance)
+			return 0;
+
+		return adv_instance->flags;
+	}
 
 	/* Instance 0 always manages the "Tx Power" and "Flags" fields */
 	flags = MGMT_ADV_FLAG_TX_POWER | MGMT_ADV_FLAG_MANAGED_FLAGS;
-- 
1.9.1

