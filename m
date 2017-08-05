Return-Path: <linux@rainbow-software.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 2/2] bluecard_cs: fix LED behavior
Date: Sat,  5 Aug 2017 21:34:45 +0200
Message-Id: <20170805193445.16411-2-linux@rainbow-software.org>
In-Reply-To: <20170805193445.16411-1-linux@rainbow-software.org>
References: <20170805193445.16411-1-linux@rainbow-software.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Keep power LED on during activity.

LED timer races with power LED disabling in hci_close(), resulting in
power LED left on after closing.
Stop LED timer before disabling power LED.

BTW. On cards without an activity LED, the behavior is a bit weird:
The LED is on after hci_open() but only until the first data transfer.
Then it's off in idle and on during activity.
It could be improved by keeping the LED on in idle and flashing during
activity.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/bluetooth/bluecard_cs.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 5cd1e164fde0..61ac48e1aa55 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -161,7 +161,7 @@ static void bluecard_activity_led_timeout(u_long arg)
 	unsigned int iobase = info->p_dev->resource[0]->start;
 
 	if (test_bit(CARD_HAS_ACTIVITY_LED, &(info->hw_state))) {
-		/* Disable activity LED */
+		/* Disable activity LED, keep power LED enabled */
 		outb(0x08 | 0x20, iobase + 0x30);
 	} else {
 		/* Disable power LED */
@@ -175,8 +175,8 @@ static void bluecard_enable_activity_led(struct bluecard_info *info)
 	unsigned int iobase = info->p_dev->resource[0]->start;
 
 	if (test_bit(CARD_HAS_ACTIVITY_LED, &(info->hw_state))) {
-		/* Enable activity LED */
-		outb(0x10 | 0x40, iobase + 0x30);
+		/* Enable activity LED, keep power LED enabled */
+		outb(0x18 | 0x60, iobase + 0x30);
 
 		/* Stop the LED after HZ/4 */
 		mod_timer(&(info->timer), jiffies + HZ / 4);
@@ -624,7 +624,7 @@ static int bluecard_hci_open(struct hci_dev *hdev)
 	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state)))
 		bluecard_hci_set_baud_rate(hdev, DEFAULT_BAUD_RATE);
 
-	/* Enable LED */
+	/* Enable power LED */
 	outb(0x08 | 0x20, iobase + 0x30);
 
 	return 0;
@@ -638,7 +638,10 @@ static int bluecard_hci_close(struct hci_dev *hdev)
 
 	bluecard_hci_flush(hdev);
 
-	/* Disable LED */
+	/* Stop LED timer */
+	del_timer_sync(&(info->timer));
+
+	/* Disable power LED */
 	outb(0x00, iobase + 0x30);
 
 	return 0;
-- 
Ondrej Zary
