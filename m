Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use devname:vhci module alias for virtual HCI driver
Date: Mon, 26 Aug 2013 22:02:38 -0700
Message-Id: <1377579758-10105-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To allow creating /dev/vhci device node, add the proper module alias for
this driver.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_vhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index d8b7aed..a1ea5b1 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -309,3 +309,4 @@ MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth virtual HCI driver ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("devname:vhci");
-- 
1.8.3.1

