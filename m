Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: Remove unused dtl1_hci_ioctl() callback
Date: Thu, 10 Oct 2013 10:50:04 -0700
Message-Id: <1381427406-26472-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The dtl1_hci_ioctl() function is not used and thus remove it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/dtl1_cs.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 33f3a69..c43aff8 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -438,12 +438,6 @@ static int dtl1_hci_send_frame(struct sk_buff *skb)
 }
 
 
-static int dtl1_hci_ioctl(struct hci_dev *hdev, unsigned int cmd,  unsigned long arg)
-{
-	return -ENOIOCTLCMD;
-}
-
-
 
 /* ======================== Card services HCI interaction ======================== */
 
@@ -477,11 +471,10 @@ static int dtl1_open(dtl1_info_t *info)
 	hci_set_drvdata(hdev, info);
 	SET_HCIDEV_DEV(hdev, &info->p_dev->dev);
 
-	hdev->open     = dtl1_hci_open;
-	hdev->close    = dtl1_hci_close;
-	hdev->flush    = dtl1_hci_flush;
-	hdev->send     = dtl1_hci_send_frame;
-	hdev->ioctl    = dtl1_hci_ioctl;
+	hdev->open  = dtl1_hci_open;
+	hdev->close = dtl1_hci_close;
+	hdev->flush = dtl1_hci_flush;
+	hdev->send  = dtl1_hci_send_frame;
 
 	spin_lock_irqsave(&(info->lock), flags);
 
-- 
1.8.3.1

