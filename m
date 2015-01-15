Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3 v2] Bluetooth: Fix LE SMP channel source address and source address type
Date: Thu, 15 Jan 2015 02:41:34 -0800
Message-Id: <1421318494-13821-1-git-send-email-marcel@holtmann.org>
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
 net/bluetooth/smp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 04e49f8f0982..c201cd1005e4 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2950,11 +2950,13 @@ create_chan:
 
 	l2cap_chan_set_defaults(chan);
 
-	bacpy(&chan->src, &hdev->bdaddr);
-	if (cid == L2CAP_CID_SMP)
-		chan->src_type = BDADDR_LE_PUBLIC;
-	else
+	if (cid == L2CAP_CID_SMP) {
+		hci_copy_identity_address(hdev, &chan->src, &chan->src_type);
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

