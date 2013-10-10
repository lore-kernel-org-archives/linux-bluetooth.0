Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] Bluetooth: Remove unused btuart_hci_ioctl() callback
Date: Thu, 10 Oct 2013 10:50:03 -0700
Message-Id: <1381427406-26472-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The btuart_hci_ioctl() function is not used and thus remove it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btuart_cs.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index beb262f..970e2d3 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -458,12 +458,6 @@ static int btuart_hci_send_frame(struct sk_buff *skb)
 }
 
 
-static int btuart_hci_ioctl(struct hci_dev *hdev, unsigned int cmd, unsigned long arg)
-{
-	return -ENOIOCTLCMD;
-}
-
-
 
 /* ======================== Card services HCI interaction ======================== */
 
@@ -495,11 +489,10 @@ static int btuart_open(btuart_info_t *info)
 	hci_set_drvdata(hdev, info);
 	SET_HCIDEV_DEV(hdev, &info->p_dev->dev);
 
-	hdev->open     = btuart_hci_open;
-	hdev->close    = btuart_hci_close;
-	hdev->flush    = btuart_hci_flush;
-	hdev->send     = btuart_hci_send_frame;
-	hdev->ioctl    = btuart_hci_ioctl;
+	hdev->open  = btuart_hci_open;
+	hdev->close = btuart_hci_close;
+	hdev->flush = btuart_hci_flush;
+	hdev->send  = btuart_hci_send_frame;
 
 	spin_lock_irqsave(&(info->lock), flags);
 
-- 
1.8.3.1

