Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Enforce providing hdev->send driver callback
Date: Sun,  6 Jul 2014 15:50:27 +0200
Message-Id: <1404654627-7257-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hdev->send driver callback is mandatory to be provided by a driver
before calling hci_register_dev. So enforce it and return EINVAL in
case it is not available.

All existing drivers are providing this callback anyway, so this is
just an extra sanity check.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b02454ab07ee..623ffe0da4a6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3932,7 +3932,7 @@ int hci_register_dev(struct hci_dev *hdev)
 {
 	int id, error;
 
-	if (!hdev->open || !hdev->close)
+	if (!hdev->open || !hdev->close || !hdev->send)
 		return -EINVAL;
 
 	/* Do not allow HCI_AMP devices to register at index 0,
-- 
1.9.3

