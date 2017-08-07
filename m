Return-Path: <linux@rainbow-software.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] bluecard_cs: blink LED during continuous activity
Date: Mon,  7 Aug 2017 19:35:49 +0200
Message-Id: <20170807173549.527-1-linux@rainbow-software.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Currently the activity LED is solid on during continuous activity.
Blink the LED during continuous activity to match Windows driver
behavior.

Cards with activity LED:
power LED = solid on when up, off when down
activity LED = blinking during activity, off when idle

Cards without activity LED:
power LED = solid on when up, off when down, blinking during activity
(don't have such a card so I don't know if Windows driver does the same
thing)

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/bluetooth/bluecard_cs.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 61ac48e1aa55..b07ca9565291 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -93,6 +93,7 @@ static void bluecard_detach(struct pcmcia_device *p_dev);
 
 /* Hardware states */
 #define CARD_READY             1
+#define CARD_ACTIVITY	       2
 #define CARD_HAS_PCCARD_ID     4
 #define CARD_HAS_POWER_LED     5
 #define CARD_HAS_ACTIVITY_LED  6
@@ -160,13 +161,14 @@ static void bluecard_activity_led_timeout(u_long arg)
 	struct bluecard_info *info = (struct bluecard_info *)arg;
 	unsigned int iobase = info->p_dev->resource[0]->start;
 
-	if (test_bit(CARD_HAS_ACTIVITY_LED, &(info->hw_state))) {
-		/* Disable activity LED, keep power LED enabled */
-		outb(0x08 | 0x20, iobase + 0x30);
-	} else {
-		/* Disable power LED */
-		outb(0x00, iobase + 0x30);
+	if (test_bit(CARD_ACTIVITY, &(info->hw_state))) {
+		/* leave LED in inactive state for HZ/10 for blink effect */
+		clear_bit(CARD_ACTIVITY, &(info->hw_state));
+		mod_timer(&(info->timer), jiffies + HZ / 10);
 	}
+
+	/* Disable activity LED, enable power LED */
+	outb(0x08 | 0x20, iobase + 0x30);
 }
 
 
@@ -174,19 +176,22 @@ static void bluecard_enable_activity_led(struct bluecard_info *info)
 {
 	unsigned int iobase = info->p_dev->resource[0]->start;
 
+	/* don't disturb running blink timer */
+	if (timer_pending(&(info->timer)))
+		return;
+
+	set_bit(CARD_ACTIVITY, &(info->hw_state));
+
 	if (test_bit(CARD_HAS_ACTIVITY_LED, &(info->hw_state))) {
 		/* Enable activity LED, keep power LED enabled */
 		outb(0x18 | 0x60, iobase + 0x30);
-
-		/* Stop the LED after HZ/4 */
-		mod_timer(&(info->timer), jiffies + HZ / 4);
 	} else {
-		/* Enable power LED */
-		outb(0x08 | 0x20, iobase + 0x30);
-
-		/* Stop the LED after HZ/2 */
-		mod_timer(&(info->timer), jiffies + HZ / 2);
+		/* Disable power LED */
+		outb(0x00, iobase + 0x30);
 	}
+
+	/* Stop the LED after HZ/10 */
+	mod_timer(&(info->timer), jiffies + HZ / 10);
 }
 
 
-- 
Ondrej Zary
