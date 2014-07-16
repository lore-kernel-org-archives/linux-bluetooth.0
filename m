Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan
	<gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Amitkumar
 Karwar <akarwar@marvell.com>,
        Avinash Patil <patila@marvell.com>, Chin-Ran Lo
	<crlo@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Bing Zhao
	<bzhao@marvell.com>
Subject: [PATCH 1/2] Bluetooth: add public address configuration for Marvell USB devices
Date: Wed, 16 Jul 2014 12:21:25 -0700
Message-ID: <1405538486-23533-1-git-send-email-bzhao@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Amitkumar Karwar <akarwar@marvell.com>

Implemented .set_bdaddr handler provided by bluetooth stack for
Marvell devices for public address configuration.

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 drivers/bluetooth/btusb.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ed7b33b..9846fc4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -48,6 +48,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL		0x100
 #define BTUSB_INTEL_BOOT	0x200
 #define BTUSB_BCM_PATCHRAM	0x400
+#define BTUSB_MARVELL		0x800
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -242,6 +243,10 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
 
+	/* Marvell device */
+	{ USB_DEVICE(0x1286, 0x2044), .driver_info = BTUSB_MARVELL },
+	{ USB_DEVICE(0x1286, 0x2046), .driver_info = BTUSB_MARVELL },
+
 	{ }	/* Terminating entry */
 };
 
@@ -1455,6 +1460,29 @@ static int btusb_set_bdaddr_intel(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return 0;
 }
 
+static int btusb_set_bdaddr_marvell(struct hci_dev *hdev,
+				    const bdaddr_t *bdaddr)
+{
+	struct sk_buff *skb;
+	u8 buf[8];
+	long ret;
+
+	buf[0] = 0xfe;
+	buf[1] = sizeof(bdaddr_t);
+	bacpy((bdaddr_t *)&buf[2], bdaddr);
+
+	skb = __hci_cmd_sync(hdev, 0xfc22, sizeof(buf), buf, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		BT_ERR("%s: changing Marvell device address failed (%ld)",
+		       hdev->name, ret);
+		return ret;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
 #define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
 
 static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
@@ -1766,6 +1794,9 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_bdaddr = btusb_set_bdaddr_intel;
 	}
 
+	if (id->driver_info & BTUSB_MARVELL)
+		hdev->set_bdaddr = btusb_set_bdaddr_marvell;
+
 	if (id->driver_info & BTUSB_INTEL_BOOT)
 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
 
-- 
1.8.2.3
