Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Add public address configration for Broadcom USB devices
Date: Wed,  2 Jul 2014 00:53:48 +0200
Message-Id: <1404255228-51661-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For the Broadcom based USB devices add support for configuration of
the public device address.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6250fc2fb93a..e0e39cc1af31 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1530,6 +1530,23 @@ done:
 	return ret;
 }
 
+static int btusb_set_bdaddr_bcm(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	struct sk_buff *skb;
+	long ret;
+
+	skb = __hci_cmd_sync(hdev, 0xfc01, 6, bdaddr, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		BT_ERR("%s: BCM: Change address command failed (%ld)",
+			hdev->name, ret);
+		return ret;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
 static int btusb_probe(struct usb_interface *intf,
 				const struct usb_device_id *id)
 {
@@ -1635,8 +1652,10 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_BCM92035)
 		hdev->setup = btusb_setup_bcm92035;
 
-	if (id->driver_info & BTUSB_BCM_PATCHRAM)
+	if (id->driver_info & BTUSB_BCM_PATCHRAM) {
 		hdev->setup = btusb_setup_bcm_patchram;
+		hdev->set_bdaddr = btusb_set_bdaddr_bcm;
+	}
 
 	if (id->driver_info & BTUSB_INTEL)
 		hdev->setup = btusb_setup_intel;
-- 
1.9.3

