Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 41/49] Bluetooth: Add support for adding remote OOB data for LE
Date: Wed,  3 Dec 2014 17:02:35 +0200
Message-Id: <1417618963-18010-42-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds proper support for passing LE OOB data to the
hci_add_remote_oob_data() function. For LE the 192-bit values are not
valid and should therefore be passed as NULL values.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 57de9f7222aa..1e73bead7dd9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3610,6 +3610,7 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 				   status, &cp->addr, sizeof(cp->addr));
 	} else if (len == MGMT_ADD_REMOTE_OOB_EXT_DATA_SIZE) {
 		struct mgmt_cp_add_remote_oob_ext_data *cp = data;
+		u8 *rand192, *hash192;
 		u8 status;
 
 		if (cp->addr.type != BDADDR_BREDR) {
@@ -3620,10 +3621,17 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 			goto unlock;
 		}
 
+		if (bdaddr_type_is_le(cp->addr.type)) {
+			rand192 = NULL;
+			hash192 = NULL;
+		} else {
+			rand192 = cp->rand192;
+			hash192 = cp->hash192;
+		}
+
 		err = hci_add_remote_oob_data(hdev, &cp->addr.bdaddr,
-					      cp->addr.type, cp->hash192,
-					      cp->rand192, cp->hash256,
-					      cp->rand256);
+					      cp->addr.type, hash192, rand192,
+					      cp->hash256, cp->rand256);
 		if (err < 0)
 			status = MGMT_STATUS_FAILED;
 		else
-- 
2.1.0

