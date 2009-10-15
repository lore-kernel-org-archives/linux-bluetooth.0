Return-Path: <cyrus@holtmann.org>
Message-Id: <20091015202758.591296185@linutronix.de>
Date: Thu, 15 Oct 2009 20:28:53 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: ALan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: [patch 5/5] bluetooth: Remove stub ioctl in hci_vhci
References: <20091015202722.372890083@linutronix.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Remove the empty ioctl which just returns -EINVAL. vfs_ioctl() will
return -ENOTTY instead, but I doubt that any application will notice
the difference :)

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org

---
 drivers/bluetooth/hci_vhci.c |    7 -------
 1 file changed, 7 deletions(-)

Index: linux-2.6-tip/drivers/bluetooth/hci_vhci.c
===================================================================
--- linux-2.6-tip.orig/drivers/bluetooth/hci_vhci.c
+++ linux-2.6-tip/drivers/bluetooth/hci_vhci.c
@@ -218,12 +218,6 @@ static unsigned int vhci_poll(struct fil
 	return POLLOUT | POLLWRNORM;
 }
 
-static int vhci_ioctl(struct inode *inode, struct file *file,
-					unsigned int cmd, unsigned long arg)
-{
-	return -EINVAL;
-}
-
 static int vhci_open(struct inode *inode, struct file *file)
 {
 	struct vhci_data *data;
@@ -287,7 +281,6 @@ static const struct file_operations vhci
 	.read		= vhci_read,
 	.write		= vhci_write,
 	.poll		= vhci_poll,
-	.ioctl		= vhci_ioctl,
 	.open		= vhci_open,
 	.release	= vhci_release,
 };
