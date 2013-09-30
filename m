Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Use only 2 bits for controller type information
Date: Sun, 29 Sep 2013 21:10:59 -0700
Message-Id: <1380514261-21742-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The controller type is limited to BR/EDR/LE and AMP controllers. This
can be easily encoded with just 2 bits and still leave enough room
for future controller types.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4549b5c..dd2528c5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1610,7 +1610,7 @@ int hci_get_dev_info(void __user *arg)
 
 	strcpy(di.name, hdev->name);
 	di.bdaddr   = hdev->bdaddr;
-	di.type     = (hdev->bus & 0x0f) | (hdev->dev_type << 4);
+	di.type     = (hdev->bus & 0x0f) | ((hdev->dev_type & 0x03) << 4);
 	di.flags    = hdev->flags;
 	di.pkt_type = hdev->pkt_type;
 	if (lmp_bredr_capable(hdev)) {
-- 
1.8.3.1

