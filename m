Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix valid Identity Address check
Date: Wed, 14 Jan 2015 20:51:37 +0200
Message-Id: <1421261497-11211-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

According to the Bluetooth core specification valid identity addresses
are either Public Device Addresses or Static Random Addresses. IRKs
received with any other type of address should be discarded since we
cannot assume to know the permanent identity of the peer device.

This patch fixes a missing check for the Identity Address when receiving
the Identity Address Information SMP PDU.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Cc: stable@vger.kernel.org # 3.16+
---
 net/bluetooth/smp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 379654e70e6f..04e49f8f0982 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2305,8 +2305,12 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	 * implementations are not known of and in order to not over
 	 * complicate our implementation, simply pretend that we never
 	 * received an IRK for such a device.
+	 *
+	 * The Identity Address must also be a Static Random or Public
+	 * Address, which hci_is_identity_address() checks for.
 	 */
-	if (!bacmp(&info->bdaddr, BDADDR_ANY)) {
+	if (!bacmp(&info->bdaddr, BDADDR_ANY) ||
+	    !hci_is_identity_address(&info->bdaddr, info->addr_type)) {
 		BT_ERR("Ignoring IRK with no identity address");
 		goto distribute;
 	}
-- 
2.1.0

