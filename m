Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Mark controller is down when HCI_AUTO_OFF is set
Date: Thu, 10 Jul 2014 12:08:09 +0200
Message-Id: <1404986889-52589-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

During the initial setup phase, the controller is powered on and will
be powered off again if it is not used within the auto-off timeout.

Userspace using ioctl does not know about the difference between the
initial setup phase and a controller being present. It is a bad idea
to keep the controller powered by just looking at the device list or
device information. Instead just tell userspace that the controller
is still down.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3321c65c73ac..02e464e7391f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2817,8 +2817,14 @@ int hci_get_dev_list(void __user *arg)
 
 	read_lock(&hci_dev_list_lock);
 	list_for_each_entry(hdev, &hci_dev_list, list) {
-		if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
-			cancel_delayed_work(&hdev->power_off);
+		unsigned long flags = hdev->flags;
+
+		/* When the auto-off is configured it means the transport
+		 * is running, but in that case still indicate that the
+		 * device is actually down.
+		 */
+		if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+			flags &= ~BIT(HCI_UP);
 
 		if (!test_bit(HCI_MGMT, &hdev->dev_flags))
 			set_bit(HCI_PAIRABLE, &hdev->dev_flags);
@@ -2844,6 +2850,7 @@ int hci_get_dev_info(void __user *arg)
 {
 	struct hci_dev *hdev;
 	struct hci_dev_info di;
+	unsigned long flags;
 	int err = 0;
 
 	if (copy_from_user(&di, arg, sizeof(di)))
@@ -2853,8 +2860,14 @@ int hci_get_dev_info(void __user *arg)
 	if (!hdev)
 		return -ENODEV;
 
-	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
-		cancel_delayed_work_sync(&hdev->power_off);
+	/* When the auto-off is configured it means the transport
+	 * is running, but in that case still indicate that the
+	 * device is actually down.
+	 */
+	if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+		flags = hdev->flags & ~BIT(HCI_UP);
+	else
+		flags = hdev->flags;
 
 	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
 		set_bit(HCI_PAIRABLE, &hdev->dev_flags);
@@ -2862,7 +2875,7 @@ int hci_get_dev_info(void __user *arg)
 	strcpy(di.name, hdev->name);
 	di.bdaddr   = hdev->bdaddr;
 	di.type     = (hdev->bus & 0x0f) | ((hdev->dev_type & 0x03) << 4);
-	di.flags    = hdev->flags;
+	di.flags    = flags;
 	di.pkt_type = hdev->pkt_type;
 	if (lmp_bredr_capable(hdev)) {
 		di.acl_mtu  = hdev->acl_mtu;
-- 
1.9.3

