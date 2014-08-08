Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: Fix HCI H5 corrupted ack value
Date: Fri,  8 Aug 2014 19:07:16 +0200
Message-Id: <1407517636-8484-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

In this expression: seq = (seq - 1) % 8
seq (u8) is implicitly converted to an int in the arithmetic operation.
So if seq value is 0, operation is ((0 - 1) % 8) => (-1 % 8) => -1.
The new seq value is 0xff which is an invalid ACK value, we expect 0x07.
It leads to frequent dropped ACK and retransmission.
Fix this by using '&' binary operator instead of '%'.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_h5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index fede8ca..5d9148f 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -237,7 +237,7 @@ static void h5_pkt_cull(struct h5 *h5)
 			break;
 
 		to_remove--;
-		seq = (seq - 1) % 8;
+		seq = (seq - 1) & 0x07;
 	}
 
 	if (seq != h5->rx_ack)
-- 
1.8.3.2
