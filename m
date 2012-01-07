Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 07/18] Bluetooth: dtl1-cs: Remove empty destruct cb
Date: Sat,  7 Jan 2012 15:47:13 +0100
Message-Id: <1325947644-11736-8-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325947644-11736-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The destruct cb is optional so we can safely remove our dummy cb.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/dtl1_cs.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index b2db5e9..aae40ca 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -439,11 +439,6 @@ static int dtl1_hci_send_frame(struct sk_buff *skb)
 }
 
 
-static void dtl1_hci_destruct(struct hci_dev *hdev)
-{
-}
-
-
 static int dtl1_hci_ioctl(struct hci_dev *hdev, unsigned int cmd,  unsigned long arg)
 {
 	return -ENOIOCTLCMD;
@@ -487,7 +482,6 @@ static int dtl1_open(dtl1_info_t *info)
 	hdev->close    = dtl1_hci_close;
 	hdev->flush    = dtl1_hci_flush;
 	hdev->send     = dtl1_hci_send_frame;
-	hdev->destruct = dtl1_hci_destruct;
 	hdev->ioctl    = dtl1_hci_ioctl;
 
 	hdev->owner = THIS_MODULE;
-- 
1.7.8.1
