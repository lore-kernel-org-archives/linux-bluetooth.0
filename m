Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] Bluetooth: Remove unnecessary hci_dev_unlock for smp_user_confirm_reply
Date: Fri, 27 Jun 2014 14:23:05 +0300
Message-Id: <1403868187-19396-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1403868187-19396-1-git-send-email-johan.hedberg@gmail.com>
References: <1403868187-19396-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that the SMP context has it's own crypto handle it doesn't need to
lock the hci_dev anymore for most operations. This means that it is safe
to call smp_user_confirm_reply with the lock already held.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f75a090cd7e4..d542f8af6a5d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3052,14 +3052,7 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 	}
 
 	if (addr->type == BDADDR_LE_PUBLIC || addr->type == BDADDR_LE_RANDOM) {
-		/* Continue with pairing via SMP. The hdev lock must be
-		 * released as SMP may try to recquire it for crypto
-		 * purposes.
-		 */
-		hci_dev_unlock(hdev);
 		err = smp_user_confirm_reply(conn, mgmt_op, passkey);
-		hci_dev_lock(hdev);
-
 		if (!err)
 			err = cmd_complete(sk, hdev->id, mgmt_op,
 					   MGMT_STATUS_SUCCESS, addr,
-- 
1.9.3

