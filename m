Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Remove unused btmrvl_ioctl() callback
Date: Thu, 10 Oct 2013 10:50:05 -0700
Message-Id: <1381427406-26472-6-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The btmrvl_ioctl() function is not used and thus remove it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btmrvl_main.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 6e7bd4e..8ac4d93 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -356,12 +356,6 @@ static void btmrvl_free_adapter(struct btmrvl_private *priv)
 	priv->adapter = NULL;
 }
 
-static int btmrvl_ioctl(struct hci_dev *hdev,
-				unsigned int cmd, unsigned long arg)
-{
-	return -ENOIOCTLCMD;
-}
-
 static int btmrvl_send_frame(struct sk_buff *skb)
 {
 	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
@@ -650,12 +644,11 @@ int btmrvl_register_hdev(struct btmrvl_private *priv)
 	priv->btmrvl_dev.hcidev = hdev;
 	hci_set_drvdata(hdev, priv);
 
-	hdev->bus = HCI_SDIO;
-	hdev->open = btmrvl_open;
+	hdev->bus   = HCI_SDIO;
+	hdev->open  = btmrvl_open;
 	hdev->close = btmrvl_close;
 	hdev->flush = btmrvl_flush;
-	hdev->send = btmrvl_send_frame;
-	hdev->ioctl = btmrvl_ioctl;
+	hdev->send  = btmrvl_send_frame;
 	hdev->setup = btmrvl_setup;
 
 	hdev->dev_type = priv->btmrvl_dev.dev_type;
-- 
1.8.3.1

