Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Make LTK key type check more readable
Date: Thu, 30 Jan 2014 19:39:58 -0800
Message-Id: <1391139600-15366-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1391139600-15366-1-git-send-email-johan.hedberg@gmail.com>
References: <1391139600-15366-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Instead of magic bitwise operations simply compare with the two possible
type values that we are interested in.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8094a41c9a26..754a59079de9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2717,7 +2717,7 @@ int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
 	if (!new_key)
 		return 0;
 
-	if (type & HCI_SMP_LTK)
+	if (type == HCI_SMP_LTK || type == HCI_SMP_LTK_SLAVE)
 		mgmt_new_ltk(hdev, key, 1);
 
 	return 0;
-- 
1.8.5.3

