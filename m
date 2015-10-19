Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix removing connection parameters when unpairing
Date: Mon, 19 Oct 2015 10:51:47 +0300
Message-Id: <1445241107-5303-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The commit 89cbb0638e9b7 introduced support for deferred connection
parameter removal when unpairing by removing them only once an
existing connection gets disconnected. However, it failed to address
the scenario when we're *not* connected and do an unpair operation.

What makes things worse is that most user space BlueZ versions will
first issue a disconnect request and only then unpair, meaning the
buggy code will be triggered every time. This effectively causes the
kernel to resume scanning and reconnect to a device for which we've
removed all keys and GATT database information.

This patch fixes the issue by adding the missing call to the
hci_conn_params_del() function to a branch which handles the case of
no existing connection.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Cc: stable@vger.kernel.org # 3.19+
---
 net/bluetooth/mgmt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9f9a70f0c981..39dda3e273ed 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3090,6 +3090,11 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	} else {
 		u8 addr_type;
 
+		if (cp->addr.type == BDADDR_LE_PUBLIC)
+			addr_type = ADDR_LE_DEV_PUBLIC;
+		else
+			addr_type = ADDR_LE_DEV_RANDOM;
+
 		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
 					       &cp->addr.bdaddr);
 		if (conn) {
@@ -3105,13 +3110,10 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 			 */
 			if (!cp->disconnect)
 				conn = NULL;
+		} else {
+			hci_conn_params_del(hdev, &cp->addr.bdaddr, addr_type);
 		}
 
-		if (cp->addr.type == BDADDR_LE_PUBLIC)
-			addr_type = ADDR_LE_DEV_PUBLIC;
-		else
-			addr_type = ADDR_LE_DEV_RANDOM;
-
 		hci_remove_irk(hdev, &cp->addr.bdaddr, addr_type);
 
 		err = hci_remove_ltk(hdev, &cp->addr.bdaddr, addr_type);
-- 
2.4.3

