Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 03/18] Bluetooth: bt3c-cs: Remove empty destruct cb
Date: Sat,  7 Jan 2012 15:47:09 +0100
Message-Id: <1325947644-11736-4-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The callback is optional and we provide an empty callback so remove it.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/bt3c_cs.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 0c97e5d..e74334d 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -456,11 +456,6 @@ static int bt3c_hci_send_frame(struct sk_buff *skb)
 }
 
 
-static void bt3c_hci_destruct(struct hci_dev *hdev)
-{
-}
-
-
 static int bt3c_hci_ioctl(struct hci_dev *hdev, unsigned int cmd, unsigned long arg)
 {
 	return -ENOIOCTLCMD;
@@ -587,7 +582,6 @@ static int bt3c_open(bt3c_info_t *info)
 	hdev->close    = bt3c_hci_close;
 	hdev->flush    = bt3c_hci_flush;
 	hdev->send     = bt3c_hci_send_frame;
-	hdev->destruct = bt3c_hci_destruct;
 	hdev->ioctl    = bt3c_hci_ioctl;
 
 	hdev->owner = THIS_MODULE;
-- 
1.7.8.1
