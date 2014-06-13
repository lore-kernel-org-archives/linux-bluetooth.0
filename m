Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix locking of hdev when calling into SMP code
Date: Fri, 13 Jun 2014 10:22:28 +0300
Message-Id: <1402644148-24141-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The SMP code expects hdev to be unlocked since e.g. crypto functions
will try to (re)lock it. Therefore, we need to release the lock before
calling into smp.c from mgmt.c. Without this we risk a deadlock whenever
the smp_user_confirm_reply() function is called.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6107e037cd8e..af8e0a6243b7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3031,8 +3031,13 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 	}
 
 	if (addr->type == BDADDR_LE_PUBLIC || addr->type == BDADDR_LE_RANDOM) {
-		/* Continue with pairing via SMP */
+		/* Continue with pairing via SMP. The hdev lock must be
+		 * released as SMP may try to recquire it for crypto
+		 * purposes.
+		 */
+		hci_dev_unlock(hdev);
 		err = smp_user_confirm_reply(conn, mgmt_op, passkey);
+		hci_dev_lock(hdev);
 
 		if (!err)
 			err = cmd_complete(sk, hdev->id, mgmt_op,
-- 
1.9.3

