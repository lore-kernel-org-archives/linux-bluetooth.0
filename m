Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Remove unnecessary LTK type check from hci_add_ltk
Date: Thu, 30 Jan 2014 19:39:59 -0800
Message-Id: <1391139600-15366-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1391139600-15366-1-git-send-email-johan.hedberg@gmail.com>
References: <1391139600-15366-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

All callers of hci_add_ltk pass a valid value to it. There are no places
where e.g. user space, the controller or the remote peer would be able
to cause invalid values to be passed. Therefore, just remove the
potentially confusing check from the beginning of the function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 754a59079de9..180473d965f6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2692,9 +2692,6 @@ int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
 {
 	struct smp_ltk *key, *old_key;
 
-	if (!(type & HCI_SMP_STK) && !(type & HCI_SMP_LTK))
-		return 0;
-
 	old_key = hci_find_ltk_by_addr(hdev, bdaddr, addr_type);
 	if (old_key)
 		key = old_key;
-- 
1.8.5.3

