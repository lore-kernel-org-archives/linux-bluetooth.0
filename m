Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Fix LE SMP channel source address and source address type
Date: Wed, 14 Jan 2015 15:43:09 -0800
Message-Id: <1421278991-4169-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The source address and source address type of the LE SMP channel can
either be the public address of the controller or the static random
address configured by the host.

Right now the public address is used for the LE SMP channel and
obviously that is not correct if the controller operates with the
configured static random address.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 04e49f8f0982..3e4de935f667 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2950,11 +2950,30 @@ create_chan:
 
 	l2cap_chan_set_defaults(chan);
 
-	bacpy(&chan->src, &hdev->bdaddr);
-	if (cid == L2CAP_CID_SMP)
-		chan->src_type = BDADDR_LE_PUBLIC;
-	else
+	if (cid == L2CAP_CID_SMP) {
+		/* If usage of static address is forced or if the devices
+		 * does not have a public address, then listen on the static
+		 * address.
+		 *
+		 * In case BR/EDR has been disabled on a dual-mode controller
+		 * and a static address has been configued, then listen on
+		 * the static address instead.
+		 */
+		if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dbg_flags) ||
+		    !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
+		    (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) &&
+		     bacmp(&hdev->static_addr, BDADDR_ANY))) {
+			bacpy(&chan->src, &hdev->static_addr);
+			chan->src_type = BDADDR_LE_RANDOM;
+		} else {
+			bacpy(&chan->src, &hdev->bdaddr);
+			chan->src_type = BDADDR_LE_PUBLIC;
+		}
+	} else {
+		bacpy(&chan->src, &hdev->bdaddr);
 		chan->src_type = BDADDR_BREDR;
+	}
+
 	chan->state = BT_LISTEN;
 	chan->mode = L2CAP_MODE_BASIC;
 	chan->imtu = L2CAP_DEFAULT_MTU;
-- 
2.1.0

