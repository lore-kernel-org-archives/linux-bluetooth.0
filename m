Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 02/18] Bluetooth: bluecard-cs: Remove empty destruct cb
Date: Sat,  7 Jan 2012 15:47:08 +0100
Message-Id: <1325947644-11736-3-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The destruct callback is optional and we provide an empty callback so remove it
entirely to avoid unnecessary code.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/bluecard_cs.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index c6a0c61..5cb325a 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -691,11 +691,6 @@ static int bluecard_hci_send_frame(struct sk_buff *skb)
 }
 
 
-static void bluecard_hci_destruct(struct hci_dev *hdev)
-{
-}
-
-
 static int bluecard_hci_ioctl(struct hci_dev *hdev, unsigned int cmd, unsigned long arg)
 {
 	return -ENOIOCTLCMD;
@@ -741,7 +736,6 @@ static int bluecard_open(bluecard_info_t *info)
 	hdev->close    = bluecard_hci_close;
 	hdev->flush    = bluecard_hci_flush;
 	hdev->send     = bluecard_hci_send_frame;
-	hdev->destruct = bluecard_hci_destruct;
 	hdev->ioctl    = bluecard_hci_ioctl;
 
 	hdev->owner = THIS_MODULE;
-- 
1.7.8.1
