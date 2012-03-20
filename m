Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <aguedespe@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.guedes@openbossa.org
Subject: [PATCH] Bluetooth: Replace EPERM by EALREADY in hci_cancel_inquiry
Date: Tue, 20 Mar 2012 00:13:38 -0300
Message-Id: <1332213218-21420-1-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should return -EALREADY in hci_cancel_inquiry since it is more
suitable than -EPERM error code.

Signed-off-by: Andre Guedes <aguedespe@gmail.com>
---
 net/bluetooth/hci_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 68b58af..286f3fc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2958,7 +2958,7 @@ int hci_cancel_inquiry(struct hci_dev *hdev)
 	BT_DBG("%s", hdev->name);
 
 	if (!test_bit(HCI_INQUIRY, &hdev->flags))
-		return -EPERM;
+		return -EALREADY;
 
 	return hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
 }
-- 
1.7.9.4

