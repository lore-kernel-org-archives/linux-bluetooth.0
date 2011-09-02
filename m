Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 3/3] Bluetooth: Use the MEDIUM security level for pairings
Date: Fri,  2 Sep 2011 14:51:22 -0300
Message-Id: <1314985882-24059-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1314985882-24059-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1314985882-24059-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This lifts the requirement of 16 digits pin codes when pairing
with devices that do not support SSP when using the mgmt interface.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/mgmt.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4f91a00..4796930 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1365,13 +1365,11 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 
 	hci_dev_lock_bh(hdev);
 
-	if (cp->io_cap == 0x03) {
-		sec_level = BT_SECURITY_MEDIUM;
+	sec_level = BT_SECURITY_MEDIUM;
+	if (cp->io_cap == 0x03)
 		auth_type = HCI_AT_DEDICATED_BONDING;
-	} else {
-		sec_level = BT_SECURITY_HIGH;
+	else
 		auth_type = HCI_AT_DEDICATED_BONDING_MITM;
-	}
 
 	entry = hci_find_adv_entry(hdev, &cp->bdaddr);
 	if (entry)
-- 
1.7.6.1

