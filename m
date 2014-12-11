Return-Path: <cyrus@holtmann.org>
From: Toshi Kikuchi <toshik@chromium.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: support public address configuration for ath3012
Date: Thu, 11 Dec 2014 14:44:25 -0800
Message-Id: <1418337865-3596-1-git-send-email-toshik@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set hdev->set_bdaddr handler for ath3012. It sends the vendor specific HCI
command to change the public address.

Signed-off-by: Toshi Kikuchi <toshik@chromium.org>
---
 drivers/bluetooth/btusb.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index edfc17b..413f0e6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1935,6 +1935,31 @@ static int btusb_set_bdaddr_bcm(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return 0;
 }
 
+static int btusb_set_bdaddr_ath3012(struct hci_dev *hdev,
+				    const bdaddr_t *bdaddr)
+{
+	struct sk_buff *skb;
+	u8 buf[10];
+	long ret;
+
+	buf[0] = 0x01;
+	buf[1] = 0x01;
+	buf[2] = 0x00;
+	buf[3] = 0x06;
+	memcpy(buf + 4, bdaddr, sizeof(bdaddr_t));
+
+	skb = __hci_cmd_sync(hdev, 0xfc0b, sizeof(buf), buf, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		BT_ERR("%s: Change address command failed (%ld)",
+		       hdev->name, ret);
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
@@ -2047,6 +2072,10 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INTEL_BOOT)
 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
 
+	if (id->driver_info & BTUSB_ATH3012) {
+		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
+	}
+
 	/* Interface numbers are hardcoded in the specification */
 	data->isoc = usb_ifnum_to_if(data->udev, 1);
 
-- 
2.2.0.rc0.207.ga3a616c

