Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use hci_copy_identity_addr() helper for SMP chan creation
Date: Fri, 20 Feb 2015 13:48:24 +0200
Message-Id: <1424432904-5217-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The only reason the SMP code is essentially duplicating the
hci_copy_identity_addr() function is that the helper returns the address
type in the HCI format rather than the three-value format expected by
l2cap_chan. This patch converts the SMP code to use the helper and then
do a simple conversion from one address type to another.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index c09a821f381d..b2803bd6e0d8 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2951,24 +2951,14 @@ create_chan:
 	l2cap_chan_set_defaults(chan);
 
 	if (cid == L2CAP_CID_SMP) {
-		/* If usage of static address is forced or if the devices
-		 * does not have a public address, then listen on the static
-		 * address.
-		 *
-		 * In case BR/EDR has been disabled on a dual-mode controller
-		 * and a static address has been configued, then listen on
-		 * the static address instead.
-		 */
-		if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ||
-		    !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
-		    (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) &&
-		     bacmp(&hdev->static_addr, BDADDR_ANY))) {
-			bacpy(&chan->src, &hdev->static_addr);
-			chan->src_type = BDADDR_LE_RANDOM;
-		} else {
-			bacpy(&chan->src, &hdev->bdaddr);
+		u8 bdaddr_type;
+
+		hci_copy_identity_address(hdev, &chan->src, &bdaddr_type);
+
+		if (bdaddr_type == ADDR_LE_DEV_PUBLIC)
 			chan->src_type = BDADDR_LE_PUBLIC;
-		}
+		else
+			chan->src_type = BDADDR_LE_RANDOM;
 	} else {
 		bacpy(&chan->src, &hdev->bdaddr);
 		chan->src_type = BDADDR_BREDR;
-- 
2.1.0

