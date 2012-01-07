Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 05/18] Bluetooth: btuart-cs: Remove empty destruct cb
Date: Sat,  7 Jan 2012 15:47:11 +0100
Message-Id: <1325947644-11736-6-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The destruct callback is optional and we provide an empty callback so remove it.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/btuart_cs.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index 200b3a2..84e02f1 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -459,11 +459,6 @@ static int btuart_hci_send_frame(struct sk_buff *skb)
 }
 
 
-static void btuart_hci_destruct(struct hci_dev *hdev)
-{
-}
-
-
 static int btuart_hci_ioctl(struct hci_dev *hdev, unsigned int cmd, unsigned long arg)
 {
 	return -ENOIOCTLCMD;
@@ -505,7 +500,6 @@ static int btuart_open(btuart_info_t *info)
 	hdev->close    = btuart_hci_close;
 	hdev->flush    = btuart_hci_flush;
 	hdev->send     = btuart_hci_send_frame;
-	hdev->destruct = btuart_hci_destruct;
 	hdev->ioctl    = btuart_hci_ioctl;
 
 	hdev->owner = THIS_MODULE;
-- 
1.7.8.1
