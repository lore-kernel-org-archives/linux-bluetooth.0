Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Use hexadecimal notation for mask
Date: Thu, 26 Nov 2015 16:49:33 +0200
Message-Id: <1448549374-15530-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Using hexadecimal notation for mask makes code easier to read

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 drivers/bluetooth/hci_h5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index db039f2..fc1a499 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -317,7 +317,7 @@ static void h5_handle_internal_rx(struct hci_uart *hu)
 		h5_link_control(hu, conf_req, 3);
 	} else if (memcmp(data, conf_rsp, 2) == 0) {
 		if (H5_HDR_LEN(hdr) > 2)
-			h5->tx_win = (data[2] & 7);
+			h5->tx_win = (data[2] & 0x07);
 		BT_DBG("Three-wire init complete. tx_win %u", h5->tx_win);
 		h5->state = H5_ACTIVE;
 		hci_uart_init_ready(hu);
-- 
2.5.0

