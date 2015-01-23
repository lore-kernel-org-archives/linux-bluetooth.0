Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Remove incorrect check for BDADDR_BREDR address type
Date: Fri, 23 Jan 2015 10:10:39 +0200
Message-Id: <1422000639-4918-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1422000639-4918-1-git-send-email-johan.hedberg@gmail.com>
References: <1422000639-4918-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The Add Remote OOB Data mgmt command should allow data to be passed for
LE as well. This patch removes a left-over check for BDADDR_BREDR that
should not be there anymore.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2c0de3e4e79a..862a005d9db2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3672,14 +3672,6 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 		u8 *rand192, *hash192;
 		u8 status;
 
-		if (cp->addr.type != BDADDR_BREDR) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_ADD_REMOTE_OOB_DATA,
-					   MGMT_STATUS_INVALID_PARAMS,
-					   &cp->addr, sizeof(cp->addr));
-			goto unlock;
-		}
-
 		if (bdaddr_type_is_le(cp->addr.type)) {
 			rand192 = NULL;
 			hash192 = NULL;
-- 
2.1.0

