Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/2] Bluetooth: Allow to change type for virtual HCI
Date: Fri, 11 Nov 2011 16:14:26 +0200
Message-Id: <1321020867-8938-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Type can be changed during module loading.
---
 drivers/bluetooth/hci_vhci.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 2e302a1..4c4aec3 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -41,6 +41,8 @@
 
 #define VERSION "1.3"
 
+static ushort type;
+
 struct vhci_data {
 	struct hci_dev *hdev;
 
@@ -239,6 +241,11 @@ static int vhci_open(struct inode *inode, struct file *file)
 	hdev->bus = HCI_VIRTUAL;
 	hdev->driver_data = data;
 
+	if (type > HCI_AMP)
+		type = HCI_BREDR;
+
+	hdev->dev_type = type;
+
 	hdev->open     = vhci_open_dev;
 	hdev->close    = vhci_close_dev;
 	hdev->flush    = vhci_flush;
@@ -303,6 +310,9 @@ static void __exit vhci_exit(void)
 module_init(vhci_init);
 module_exit(vhci_exit);
 
+module_param(type, ushort, 0444);
+MODULE_PARM_DESC(type, "HCI device type");
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth virtual HCI driver ver " VERSION);
 MODULE_VERSION(VERSION);
-- 
1.7.4.1

