Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Allow changing device class when BR/EDR is disabled
Date: Wed,  2 Oct 2013 23:37:29 -0700
Message-Id: <1380782249-29597-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changing the device class when BR/EDR is disabled has no visible
effect for remote devices. However to simplify the logic allow it
as long as the controller supports BR/EDR operations.

If it is not allowed, then the overall logic becomes rather
complicated since the class of device values would need clearing
or restoring when BR/EDR setting changes.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4ce0f11..16125ff9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1757,7 +1757,7 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+	if (!lmp_bredr_capable(hdev))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
-- 
1.8.3.1

