Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Simplify setting Configuration Field
Date: Thu, 26 Nov 2015 16:49:34 +0200
Message-Id: <1448549374-15530-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1448549374-15530-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1448549374-15530-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Only Sliding Window Size is used at the moment for H5 Bluetooth
Configuration messages.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 drivers/bluetooth/hci_h5.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index fc1a499..2d1c9f6 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -116,12 +116,8 @@ static void h5_link_control(struct hci_uart *hu, const void *data, size_t len)
 
 static u8 h5_cfg_field(struct h5 *h5)
 {
-	u8 field = 0;
-
 	/* Sliding window size (first 3 bits) */
-	field |= (h5->tx_win & 0x07);
-
-	return field;
+	return h5->tx_win & 0x07;
 }
 
 static void h5_timed_event(unsigned long arg)
-- 
2.5.0

