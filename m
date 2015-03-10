Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Update Fast Connectable Behavior to match latest mgmt spec
Date: Tue, 10 Mar 2015 12:57:57 +0200
Message-Id: <1425985077-6239-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1425985077-6239-1-git-send-email-johan.hedberg@gmail.com>
References: <1425985077-6239-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that the page scan state can change based on the BR/EDR whitelist we
shouldn't require the connectable setting as a pre-requisite. This patch
removes the HCI_CONNECTABLE check from set_fast_connectable() and
removes any changes to the page scan parameters from set_connectable()
(since the parameters are now independent from any connectable setting
changes).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 840c245a5cf4..f032818bc185 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1968,15 +1968,6 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 no_scan_update:
-	/* If we're going from non-connectable to connectable or
-	 * vice-versa when fast connectable is enabled ensure that fast
-	 * connectable gets disabled. write_fast_connectable won't do
-	 * anything if the page scan parameters are already what they
-	 * should be.
-	 */
-	if (cp->val || test_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags))
-		write_fast_connectable(&req, false);
-
 	/* Update the advertising parameters if necessary */
 	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
 		enable_advertising(&req);
@@ -4664,10 +4655,6 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
 				       MGMT_STATUS_NOT_POWERED);
 
-	if (!test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
-		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
-				       MGMT_STATUS_REJECTED);
-
 	hci_dev_lock(hdev);
 
 	if (mgmt_pending_find(MGMT_OP_SET_FAST_CONNECTABLE, hdev)) {
-- 
2.1.0

