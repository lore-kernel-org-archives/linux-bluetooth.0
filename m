Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH trivial 1/2] Bluetooth: bluecard_cs: Shorten scope for iobase
Date: Fri, 29 Jun 2012 14:58:07 +0300
Message-Id: <1340971088-16059-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340971088-16059-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340971088-16059-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Shortening scope shall silence some warnings reported by Geert
Uytterhoeven:

...
drivers/bluetooth/bluecard_cs.c: warning: unused variable 'iobase'
	[-Wunused-variable]
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 drivers/bluetooth/bluecard_cs.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 585c88e..66c3a67 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -621,7 +621,6 @@ static int bluecard_hci_flush(struct hci_dev *hdev)
 static int bluecard_hci_open(struct hci_dev *hdev)
 {
 	bluecard_info_t *info = hci_get_drvdata(hdev);
-	unsigned int iobase = info->p_dev->resource[0]->start;
 
 	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state)))
 		bluecard_hci_set_baud_rate(hdev, DEFAULT_BAUD_RATE);
@@ -630,6 +629,8 @@ static int bluecard_hci_open(struct hci_dev *hdev)
 		return 0;
 
 	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state))) {
+		unsigned int iobase = info->p_dev->resource[0]->start;
+
 		/* Enable LED */
 		outb(0x08 | 0x20, iobase + 0x30);
 	}
@@ -641,7 +642,6 @@ static int bluecard_hci_open(struct hci_dev *hdev)
 static int bluecard_hci_close(struct hci_dev *hdev)
 {
 	bluecard_info_t *info = hci_get_drvdata(hdev);
-	unsigned int iobase = info->p_dev->resource[0]->start;
 
 	if (!test_and_clear_bit(HCI_RUNNING, &(hdev->flags)))
 		return 0;
@@ -649,6 +649,8 @@ static int bluecard_hci_close(struct hci_dev *hdev)
 	bluecard_hci_flush(hdev);
 
 	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state))) {
+		unsigned int iobase = info->p_dev->resource[0]->start;
+
 		/* Disable LED */
 		outb(0x00, iobase + 0x30);
 	}
-- 
1.7.9.5

