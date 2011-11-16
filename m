Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 2/3] Bluetooth: Allow to set AMP type for virtual HCI
Date: Wed, 16 Nov 2011 17:27:38 +0200
Message-Id: <1321457259-31485-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1321457259-31485-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1321457259-31485-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Type can be changed during re-opening device /dev/vhci.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_vhci.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 2e302a1..2ed6ab1 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -41,6 +41,8 @@
 
 #define VERSION "1.3"
 
+static bool amp;
+
 struct vhci_data {
 	struct hci_dev *hdev;
 
@@ -239,6 +241,9 @@ static int vhci_open(struct inode *inode, struct file *file)
 	hdev->bus = HCI_VIRTUAL;
 	hdev->driver_data = data;
 
+	if (amp)
+		hdev->dev_type = HCI_AMP;
+
 	hdev->open     = vhci_open_dev;
 	hdev->close    = vhci_close_dev;
 	hdev->flush    = vhci_flush;
@@ -303,6 +308,9 @@ static void __exit vhci_exit(void)
 module_init(vhci_init);
 module_exit(vhci_exit);
 
+module_param(amp, bool, 0644);
+MODULE_PARM_DESC(amp, "Create AMP controller device");
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth virtual HCI driver ver " VERSION);
 MODULE_VERSION(VERSION);
-- 
1.7.4.1

