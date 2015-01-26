Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Enforce zero-valued hash/rand192 for LE OOB
Date: Mon, 26 Jan 2015 15:07:51 +0200
Message-Id: <1422277671-26069-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Until legacy SMP OOB pairing is implemented user space should be given a
clear error when trying to use it. This patch adds a corresponding check
to the Add Remote OOB Data handler function which returns "invalid
parameters" if non-zero Rand192 or Hash192 parameters were given for an
LE address.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 25e40e82b9a2..cf257cc0e09d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3673,6 +3673,20 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 		u8 status;
 
 		if (bdaddr_type_is_le(cp->addr.type)) {
+			static const u8 z16[16] = { 0 };
+
+			/* Enforce zero-valued 192-bit parameters as
+			 * long as legacy SMP OOB isn't implemented.
+			 */
+			if (memcmp(cp->rand192, z16, 16) ||
+			    memcmp(cp->hash192, z16, 16)) {
+				err = cmd_complete(sk, hdev->id,
+						   MGMT_OP_ADD_REMOTE_OOB_DATA,
+						   MGMT_STATUS_INVALID_PARAMS,
+						   addr, sizeof(*addr));
+				goto unlock;
+			}
+
 			rand192 = NULL;
 			hash192 = NULL;
 		} else {
-- 
2.1.0

