Return-Path: <cyrus@holtmann.org>
From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
To: marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: [PATCH] bluetooth: remove useless variable in virtual hci driver
Date: Mon, 26 Oct 2009 13:59:19 -0200
Message-Id: <1256572759-3042-1-git-send-email-cascardo@holoscopio.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Commit ac28494c has removed the option to give a minor number as
parameter for VHCI driver. Remove the variable used for that parameter.
Printing the requested minor number, which would always be
MISC_DYNAMIC_MINOR, is not needed. And return the error code returned by
misc_register, instead of -EIO in init function.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
---
 drivers/bluetooth/hci_vhci.c |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index d5cde6d..8fed210 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -41,8 +41,6 @@
 
 #define VERSION "1.3"
 
-static int minor = MISC_DYNAMIC_MINOR;
-
 struct vhci_data {
 	struct hci_dev *hdev;
 
@@ -292,7 +290,7 @@ static const struct file_operations vhci_fops = {
 	.release	= vhci_release,
 };
 
-static struct miscdevice vhci_miscdev= {
+static struct miscdevice vhci_miscdev = {
 	.name	= "vhci",
 	.fops	= &vhci_fops,
 	.minor	= MISC_DYNAMIC_MINOR,
@@ -301,19 +299,12 @@ static struct miscdevice vhci_miscdev= {
 static int __init vhci_init(void)
 {
 	BT_INFO("Virtual HCI driver ver %s", VERSION);
-
-	if (misc_register(&vhci_miscdev) < 0) {
-		BT_ERR("Can't register misc device with minor %d", minor);
-		return -EIO;
-	}
-
-	return 0;
+	return misc_register(&vhci_miscdev);
 }
 
 static void __exit vhci_exit(void)
 {
-	if (misc_deregister(&vhci_miscdev) < 0)
-		BT_ERR("Can't unregister misc device with minor %d", minor);
+	misc_deregister(&vhci_miscdev);
 }
 
 module_init(vhci_init);
-- 
1.6.3.3
