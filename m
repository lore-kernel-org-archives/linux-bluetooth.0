Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix checking for master LTKs
Date: Wed, 18 Jun 2014 14:09:40 +0300
Message-Id: <1403089780-21734-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When the rename of STK_SLAVE to simply STK happened we missed this place
in the ltk_type_master function. Now, checking for master is as simple
as checking whether the type is SMP_LTK. The helper function is kept
around for better readability in the (right now three) callers and for
simpler extension with new key types in the future.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6001b9293905..c3d184fd24de 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2974,10 +2974,7 @@ static bool hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
 
 static bool ltk_type_master(u8 type)
 {
-	if (type == SMP_STK || type == SMP_LTK)
-		return true;
-
-	return false;
+	return (type == SMP_LTK);
 }
 
 struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, __le64 rand,
-- 
1.9.3

