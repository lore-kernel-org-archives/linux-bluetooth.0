Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Send H5 sync from timer events
Date: Mon, 23 Nov 2015 16:01:39 +0200
Message-Id: <1448287299-25109-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Current approach results in double sync messages sent after
h5_timed_event() wakes up transmit queue. This also makes code
cleaner.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 drivers/bluetooth/hci_h5.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index db039f2..02b073e 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -192,7 +192,6 @@ static void h5_peer_reset(struct hci_uart *hu)
 static int h5_open(struct hci_uart *hu)
 {
 	struct h5 *h5;
-	const unsigned char sync[] = { 0x01, 0x7e };
 
 	BT_DBG("hu %p", hu);
 
@@ -216,8 +215,6 @@ static int h5_open(struct hci_uart *hu)
 
 	set_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags);
 
-	/* Send initial sync request */
-	h5_link_control(hu, sync, sizeof(sync));
 	mod_timer(&h5->timer, jiffies + H5_SYNC_TIMEOUT);
 
 	return 0;
-- 
2.5.0

