Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] Bluetooth: Remove unused bt3c_hci_ioctl() callback
Date: Thu, 10 Oct 2013 10:50:02 -0700
Message-Id: <1381427406-26472-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The bt3c_hci_ioctl() function is not used and thus remove it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/bt3c_cs.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index a1aaa3b..673455c 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -455,12 +455,6 @@ static int bt3c_hci_send_frame(struct sk_buff *skb)
 }
 
 
-static int bt3c_hci_ioctl(struct hci_dev *hdev, unsigned int cmd, unsigned long arg)
-{
-	return -ENOIOCTLCMD;
-}
-
-
 
 /* ======================== Card services HCI interaction ======================== */
 
@@ -577,11 +571,10 @@ static int bt3c_open(bt3c_info_t *info)
 	hci_set_drvdata(hdev, info);
 	SET_HCIDEV_DEV(hdev, &info->p_dev->dev);
 
-	hdev->open     = bt3c_hci_open;
-	hdev->close    = bt3c_hci_close;
-	hdev->flush    = bt3c_hci_flush;
-	hdev->send     = bt3c_hci_send_frame;
-	hdev->ioctl    = bt3c_hci_ioctl;
+	hdev->open  = bt3c_hci_open;
+	hdev->close = bt3c_hci_close;
+	hdev->flush = bt3c_hci_flush;
+	hdev->send  = bt3c_hci_send_frame;
 
 	/* Load firmware */
 	err = request_firmware(&firmware, "BT3CPCC.bin", &info->p_dev->dev);
-- 
1.8.3.1

