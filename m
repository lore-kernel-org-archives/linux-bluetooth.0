Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Remove bogus check for pending mgmt Set HS command
Date: Thu, 19 Feb 2015 17:38:06 +0200
Message-Id: <1424360287-2379-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The command handler for Set HS doesn't use mgmt_pending_add() so we can
never have a pending Set HS command that mgmt_pending_find() would
return. This patch removes an unnecessary lookup for it in the set_ssp()
handler function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1b528dea9844..cc67d19a7cb8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2116,8 +2116,7 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto failed;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_SET_SSP, hdev) ||
-	    mgmt_pending_find(MGMT_OP_SET_HS, hdev)) {
+	if (mgmt_pending_find(MGMT_OP_SET_SSP, hdev)) {
 		err = cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
 				 MGMT_STATUS_BUSY);
 		goto failed;
-- 
2.1.0

