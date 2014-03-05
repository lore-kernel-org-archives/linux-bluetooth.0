Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Thomas=20B=C3=A4chler?= <thomas@archlinux.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thomas=20B=C3=A4chler?= <thomas@archlinux.org>
Subject: [PATCH] Revert "Bluetooth: Use devname:vhci module alias for virtual HCI driver"
Date: Wed,  5 Mar 2014 12:59:12 +0100
Message-Id: <1394020752-6186-1-git-send-email-thomas@archlinux.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Adding the devname:vhci alias and thus adding a static /dev/vhci device node
only works when assigning a fixed major/minor number. However, the code
currently uses a dynamically assigned minor number. It is therefore impossible
to create a static device and to autoload the module when accessing it.

Reverting this fixes the kmod error message
 depmod: ERROR: Module 'hci_vhci' has devname (vhci) but lacks major and minor information. Ignoring.

This reverts commit bfacbb9aec029b3200053d84c8cd5d7575f2d4a5.
---
 drivers/bluetooth/hci_vhci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 1ef6990..cf05d70 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -384,4 +384,3 @@ MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth virtual HCI driver ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("devname:vhci");
-- 
1.9.0
