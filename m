Return-Path: <paulmcquad@gmail.com>
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: trailing whitespace
Date: Mon, 19 Mar 2018 11:32:19 +0000
Message-Id: <20180319113222.6725-1-paulmcquad@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Removed whitespace

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 drivers/bluetooth/bfusb.c     | 2 +-
 drivers/bluetooth/btuart_cs.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index ab090a313a5f..0d5b403fe431 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -148,7 +148,7 @@ static int bfusb_send_bulk(struct bfusb_data *data, struct sk_buff *skb)
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err) {
-		BT_ERR("%s bulk tx submit failed urb %p err %d", 
+		BT_ERR("%s bulk tx submit failed urb %p err %d",
 					data->hdev->name, urb, err);
 		skb_unlink(skb, &data->pending_q);
 		usb_free_urb(urb);
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index 310e9c2e09b6..8dce5bfad947 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -365,10 +365,10 @@ static void btuart_change_speed(struct btuart_info *info,
 
 	fcr = UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT;
 
-	/* 
+	/*
 	 * Use trigger level 1 to avoid 3 ms. timeout delay at 9600 bps, and
 	 * almost 1,7 ms at 19200 bps. At speeds above that we can just forget
-	 * about this timeout since it will always be fast enough. 
+	 * about this timeout since it will always be fast enough.
 	 */
 
 	if (speed < 38400)
-- 
2.16.2
