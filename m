Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Set HCI_PAIRABLE during power on for legacy ioctl
Date: Thu, 10 Jul 2014 15:25:22 +0200
Message-Id: <1404998722-60828-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the controller is brought up using legacy ioctl, the setting of
the HCI_PAIRABLE flag should happen then. Previously it was set during
enumeration and when retrieving device information.

This change also will not set the HCI_PAIRABLE flag when the controller
is used with the HCI User Channel operation.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 96e0acc3fc92..52e8c91ea3e9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2435,6 +2435,16 @@ int hci_dev_open(__u16 dev)
 	 */
 	flush_workqueue(hdev->req_workqueue);
 
+	/* For controllers not using the management interface and that
+	 * are brought up using legacy ioctl, set the HCI_PAIRABLE bit
+	 * so that pairing works for them. Once the management interface
+	 * is in use this bit will be cleared again and userspace has
+	 * to explicitly enable it.
+	 */
+	if (!test_bit(HCI_USER_CHANNEL, &hdev->dev_flags) &&
+	    !test_bit(HCI_MGMT, &hdev->dev_flags))
+		set_bit(HCI_PAIRABLE, &hdev->dev_flags);
+
 	err = hci_dev_do_open(hdev);
 
 done:
@@ -2826,9 +2836,6 @@ int hci_get_dev_list(void __user *arg)
 		if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
 			flags &= ~BIT(HCI_UP);
 
-		if (!test_bit(HCI_MGMT, &hdev->dev_flags))
-			set_bit(HCI_PAIRABLE, &hdev->dev_flags);
-
 		(dr + n)->dev_id  = hdev->id;
 		(dr + n)->dev_opt = flags;
 
@@ -2869,9 +2876,6 @@ int hci_get_dev_info(void __user *arg)
 	else
 		flags = hdev->flags;
 
-	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
-		set_bit(HCI_PAIRABLE, &hdev->dev_flags);
-
 	strcpy(di.name, hdev->name);
 	di.bdaddr   = hdev->bdaddr;
 	di.type     = (hdev->bus & 0x0f) | ((hdev->dev_type & 0x03) << 4);
-- 
1.9.3

