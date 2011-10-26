Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 1/2] Bluetooth: Ignore hci_unregister_dev return value
Date: Wed, 26 Oct 2011 10:43:18 +0200
Message-Id: <1319618599-10938-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Make all bluetooth drivers ignore the return value of hci_unregister_dev as it
always returns 0. In the next step, hci_unregister_dev can be modified to return
void.
Some of the drivers already ignore the return value (including btusb), hence,
this will increase consitency in the bluetooth drivers.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/bfusb.c       |    4 +---
 drivers/bluetooth/bluecard_cs.c |    4 +---
 drivers/bluetooth/bt3c_cs.c     |    4 +---
 drivers/bluetooth/btuart_cs.c   |    4 +---
 drivers/bluetooth/dtl1_cs.c     |    4 +---
 drivers/bluetooth/hci_vhci.c    |    5 +----
 6 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 005919a..6580d50 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -750,9 +750,7 @@ static void bfusb_disconnect(struct usb_interface *intf)
 
 	bfusb_close(hdev);
 
-	if (hci_unregister_dev(hdev) < 0)
-		BT_ERR("Can't unregister HCI device %s", hdev->name);
-
+	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 }
 
diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index aed1904..c6a0c61 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -844,9 +844,7 @@ static int bluecard_close(bluecard_info_t *info)
 	/* Turn FPGA off */
 	outb(0x80, iobase + 0x30);
 
-	if (hci_unregister_dev(hdev) < 0)
-		BT_ERR("Can't unregister HCI device %s", hdev->name);
-
+	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 
 	return 0;
diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 4fc0194..0c97e5d 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -636,9 +636,7 @@ static int bt3c_close(bt3c_info_t *info)
 
 	bt3c_hci_close(hdev);
 
-	if (hci_unregister_dev(hdev) < 0)
-		BT_ERR("Can't unregister HCI device %s", hdev->name);
-
+	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 
 	return 0;
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index 526b618..200b3a2 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -565,9 +565,7 @@ static int btuart_close(btuart_info_t *info)
 
 	spin_unlock_irqrestore(&(info->lock), flags);
 
-	if (hci_unregister_dev(hdev) < 0)
-		BT_ERR("Can't unregister HCI device %s", hdev->name);
-
+	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 
 	return 0;
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 5e4c2de..969bb22 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -551,9 +551,7 @@ static int dtl1_close(dtl1_info_t *info)
 
 	spin_unlock_irqrestore(&(info->lock), flags);
 
-	if (hci_unregister_dev(hdev) < 0)
-		BT_ERR("Can't unregister HCI device %s", hdev->name);
-
+	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 
 	return 0;
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 67c180c..2e302a1 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -264,10 +264,7 @@ static int vhci_release(struct inode *inode, struct file *file)
 	struct vhci_data *data = file->private_data;
 	struct hci_dev *hdev = data->hdev;
 
-	if (hci_unregister_dev(hdev) < 0) {
-		BT_ERR("Can't unregister HCI device %s", hdev->name);
-	}
-
+	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 
 	file->private_data = NULL;
-- 
1.7.7.1
