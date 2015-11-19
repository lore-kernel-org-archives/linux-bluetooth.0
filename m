Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use hex notation for mask
Date: Thu, 19 Nov 2015 16:47:38 +0200
Message-Id: <1447944458-1700-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This makes it easier to read and makes code consistent.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 drivers/bluetooth/hci_h5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 012248e..db039f2 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -119,7 +119,7 @@ static u8 h5_cfg_field(struct h5 *h5)
 	u8 field = 0;
 
 	/* Sliding window size (first 3 bits) */
-	field |= (h5->tx_win & 7);
+	field |= (h5->tx_win & 0x07);
 
 	return field;
 }
-- 
2.5.0

