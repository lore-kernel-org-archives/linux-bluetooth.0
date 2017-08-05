Return-Path: <linux@rainbow-software.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 1/2] bluecard_cs: Always enable LEDs (fix for Anycom CF-300)
Date: Sat,  5 Aug 2017 21:34:44 +0200
Message-Id: <20170805193445.16411-1-linux@rainbow-software.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Anycom CF-300 (HP C8249A) has both power and activity LEDs.
However the id read in bluecard_open() is 0x73 so the driver does not
enable the LEDs.
Remove the CARD_HAS_PCCARD_ID check to enable LEDs.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/bluetooth/bluecard_cs.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index d4b0b655dde6..5cd1e164fde0 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -160,9 +160,6 @@ static void bluecard_activity_led_timeout(u_long arg)
 	struct bluecard_info *info = (struct bluecard_info *)arg;
 	unsigned int iobase = info->p_dev->resource[0]->start;
 
-	if (!test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state)))
-		return;
-
 	if (test_bit(CARD_HAS_ACTIVITY_LED, &(info->hw_state))) {
 		/* Disable activity LED */
 		outb(0x08 | 0x20, iobase + 0x30);
@@ -177,9 +174,6 @@ static void bluecard_enable_activity_led(struct bluecard_info *info)
 {
 	unsigned int iobase = info->p_dev->resource[0]->start;
 
-	if (!test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state)))
-		return;
-
 	if (test_bit(CARD_HAS_ACTIVITY_LED, &(info->hw_state))) {
 		/* Enable activity LED */
 		outb(0x10 | 0x40, iobase + 0x30);
@@ -625,16 +619,13 @@ static int bluecard_hci_flush(struct hci_dev *hdev)
 static int bluecard_hci_open(struct hci_dev *hdev)
 {
 	struct bluecard_info *info = hci_get_drvdata(hdev);
+	unsigned int iobase = info->p_dev->resource[0]->start;
 
 	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state)))
 		bluecard_hci_set_baud_rate(hdev, DEFAULT_BAUD_RATE);
 
-	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state))) {
-		unsigned int iobase = info->p_dev->resource[0]->start;
-
-		/* Enable LED */
-		outb(0x08 | 0x20, iobase + 0x30);
-	}
+	/* Enable LED */
+	outb(0x08 | 0x20, iobase + 0x30);
 
 	return 0;
 }
@@ -643,15 +634,12 @@ static int bluecard_hci_open(struct hci_dev *hdev)
 static int bluecard_hci_close(struct hci_dev *hdev)
 {
 	struct bluecard_info *info = hci_get_drvdata(hdev);
+	unsigned int iobase = info->p_dev->resource[0]->start;
 
 	bluecard_hci_flush(hdev);
 
-	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state))) {
-		unsigned int iobase = info->p_dev->resource[0]->start;
-
-		/* Disable LED */
-		outb(0x00, iobase + 0x30);
-	}
+	/* Disable LED */
+	outb(0x00, iobase + 0x30);
 
 	return 0;
 }
-- 
Ondrej Zary
