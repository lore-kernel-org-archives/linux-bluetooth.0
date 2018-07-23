Return-Path: <baijiaju1990@gmail.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] bluetooth: bluecard_cs: Replace GFP_ATOMIC with GFP_KERNEL in bluecard_hci_set_baud_rate()
Date: Mon, 23 Jul 2018 11:17:35 +0800
Message-Id: <20180723031735.7518-1-baijiaju1990@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

bluecard_hci_set_baud_rate() is never called in atomic context.

bluecard_hci_set_baud_rate() is only by bluecard_hci_open(), which is 
set to hdev->open, and hdev->open() is never called in atomic context.

bluecard_hci_set_baud_rate() calls bt_skb_alloc() with GFP_ATOMIC, 
which is not necessary. GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/bluetooth/bluecard_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 82437a69f99c..cc6e56223656 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -565,7 +565,7 @@ static int bluecard_hci_set_baud_rate(struct hci_dev *hdev, int baud)
 	/* Ericsson baud rate command */
 	unsigned char cmd[] = { HCI_COMMAND_PKT, 0x09, 0xfc, 0x01, 0x03 };
 
-	skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC);
+	skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_KERNEL);
 	if (!skb) {
 		BT_ERR("Can't allocate mem for new packet");
 		return -1;
-- 
2.17.0
