Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 04/18] Bluetooth: btmrvl: Remove empty destruct cb
Date: Sat,  7 Jan 2012 15:47:10 +0100
Message-Id: <1325947644-11736-5-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The callback is optional and we provide an empty callback so remove it entirely.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/btmrvl_main.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index a88a78c..d62fc0d 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -387,10 +387,6 @@ static int btmrvl_ioctl(struct hci_dev *hdev,
 	return -ENOIOCTLCMD;
 }
 
-static void btmrvl_destruct(struct hci_dev *hdev)
-{
-}
-
 static int btmrvl_send_frame(struct sk_buff *skb)
 {
 	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
@@ -555,7 +551,6 @@ int btmrvl_register_hdev(struct btmrvl_private *priv)
 	hdev->close = btmrvl_close;
 	hdev->flush = btmrvl_flush;
 	hdev->send = btmrvl_send_frame;
-	hdev->destruct = btmrvl_destruct;
 	hdev->ioctl = btmrvl_ioctl;
 	hdev->owner = THIS_MODULE;
 
-- 
1.7.8.1
