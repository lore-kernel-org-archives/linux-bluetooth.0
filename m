Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Enforce zero-valued hash/rand192 for LE OOB
Date: Tue, 27 Jan 2015 12:55:52 +0200
Message-Id: <1422356152-13920-1-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1422277671-26069-1-git-send-email-johan.hedberg@gmail.com>
References: <1422277671-26069-1-git-send-email-johan.hedberg@gmail.com>
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
v2: Use a define instead of a variable for the zero-valued key

 net/bluetooth/mgmt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 25e40e82b9a2..8417ab387d1a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -131,6 +131,9 @@ static const u16 mgmt_events[] = {
 
 #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
 
+#define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
+		 "\x00\x00\x00\x00\x00\x00\x00\x00"
+
 struct pending_cmd {
 	struct list_head list;
 	u16 opcode;
@@ -3673,6 +3676,18 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 		u8 status;
 
 		if (bdaddr_type_is_le(cp->addr.type)) {
+			/* Enforce zero-valued 192-bit parameters as
+			 * long as legacy SMP OOB isn't implemented.
+			 */
+			if (memcmp(cp->rand192, ZERO_KEY, 16) ||
+			    memcmp(cp->hash192, ZERO_KEY, 16)) {
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

