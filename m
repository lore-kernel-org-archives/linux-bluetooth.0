Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCHv2] Bluetooth: Remove redundant calls to h5_reset_rx
Date: Mon, 23 Jun 2014 15:49:46 +0200
Message-Id: <1403531386-10331-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

h5_reset_rx is unconditionally called at the end of
h5_complete_rx_pkt, no need to call it anymore after
that.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 v2: remove unused h5

 drivers/bluetooth/hci_h5.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 04680ea..1fe9dba 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -355,10 +355,7 @@ static void h5_complete_rx_pkt(struct hci_uart *hu)
 
 static int h5_rx_crc(struct hci_uart *hu, unsigned char c)
 {
-	struct h5 *h5 = hu->priv;
-
 	h5_complete_rx_pkt(hu);
-	h5_reset_rx(h5);
 
 	return 0;
 }
@@ -373,7 +370,6 @@ static int h5_rx_payload(struct hci_uart *hu, unsigned char c)
 		h5->rx_pending = 2;
 	} else {
 		h5_complete_rx_pkt(hu);
-		h5_reset_rx(h5);
 	}
 
 	return 0;
-- 
1.8.3.2
