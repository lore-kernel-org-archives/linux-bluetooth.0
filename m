Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: Ignore H5 non-link packets in non-active state
Date: Mon, 23 Jun 2014 15:09:43 +0200
Message-Id: <1403528983-9314-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Fix missing return in the non-link packet detection.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_h5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index e521730..5e3fc8d 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -404,6 +404,7 @@ static int h5_rx_3wire_hdr(struct hci_uart *hu, unsigned char c)
 	    H5_HDR_PKT_TYPE(hdr) != HCI_3WIRE_LINK_PKT) {
 		BT_ERR("Non-link packet received in non-active state");
 		h5_reset_rx(h5);
+		return 0;
 	}
 
 	h5->rx_func = h5_rx_payload;
-- 
1.8.3.2
