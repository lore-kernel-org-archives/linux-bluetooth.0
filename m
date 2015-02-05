Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Feb 2015 18:28:59 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: "An, Tedd" <tedd.an@intel.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [RFC 2/2] Bluetooth: Add BT LED off routine for Intel Bluetooth
 device
Message-ID: <20150204182859.1a3080d8@tedd-test>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

Some platforms have an issue with BT LED on Intel Bluetooth device which
takes 5 seconds to BT LED goes off after BT is turned off.

For Intel Bluetooth device, When there is no active connection and
no other RF activity, BT LED is turned off if the device is in
low power mode(LPM) which is triggered by USB suspend.

So, when the BT is turned off, it takes 5 seconds (default is 5 seconds)
or it doesn't go off if autosuspend is not enabled.

To fix this issue, recently Intel Bluetooth firmware patch had been
submitted to turn off the BT LED explicitly with a vendor specific command,
and this patch sends the Intel specific HCI command before close the device.

For backward compatibility issue with old firmware, this command was supported
before, but internally, it was same as HCI_RESET. So, it won't be the problem
even if it doesn't have the latest firmware patch.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btusb.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b876888..f3d5dcf 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2331,6 +2331,23 @@ static int btusb_set_bdaddr_intel(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return 0;
 }
 
+static int btusb_led_off_intel(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	long ret;
+
+	skb = __hci_cmd_sync(hdev, 0xfc3f, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		BT_ERR("%s: turning off Intel device LED failed (%ld)",
+		       hdev->name, ret);
+		return ret;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
 static int btusb_set_bdaddr_marvell(struct hci_dev *hdev,
 				    const bdaddr_t *bdaddr)
 {
@@ -2709,6 +2726,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INTEL) {
 		hdev->setup = btusb_setup_intel;
 		hdev->set_bdaddr = btusb_set_bdaddr_intel;
+		hdev->led_off = btusb_led_off_intel;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
 
-- 
1.9.1

