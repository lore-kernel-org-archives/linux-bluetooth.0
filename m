Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: Remove unused bluecard_hci_ioctl() callback
Date: Thu, 10 Oct 2013 10:50:01 -0700
Message-Id: <1381427406-26472-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The bluecard_hci_ioctl() function is not used and thus remove it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/bluecard_cs.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 6c3e3d4..aa872c9 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -693,12 +693,6 @@ static int bluecard_hci_send_frame(struct sk_buff *skb)
 }
 
 
-static int bluecard_hci_ioctl(struct hci_dev *hdev, unsigned int cmd, unsigned long arg)
-{
-	return -ENOIOCTLCMD;
-}
-
-
 
 /* ======================== Card services HCI interaction ======================== */
 
@@ -734,11 +728,10 @@ static int bluecard_open(bluecard_info_t *info)
 	hci_set_drvdata(hdev, info);
 	SET_HCIDEV_DEV(hdev, &info->p_dev->dev);
 
-	hdev->open     = bluecard_hci_open;
-	hdev->close    = bluecard_hci_close;
-	hdev->flush    = bluecard_hci_flush;
-	hdev->send     = bluecard_hci_send_frame;
-	hdev->ioctl    = bluecard_hci_ioctl;
+	hdev->open  = bluecard_hci_open;
+	hdev->close = bluecard_hci_close;
+	hdev->flush = bluecard_hci_flush;
+	hdev->send  = bluecard_hci_send_frame;
 
 	id = inb(iobase + 0x30);
 
-- 
1.8.3.1

