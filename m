Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Feb 2015 11:44:08 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: "An, Tedd" <tedd.an@intel.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 2/2] Bluetooth: Add device shutdown routine for Intel
 Bluetooth device
Message-ID: <20150205114408.7c50ab05@tedd-test>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds the device shutdown routine for Intel Bluetooth device.

Some platforms have BT LED issue with Intel Bluetooth device that BT LED goes
off 5 seconds after BT is turned off

For Intel Bluetooth device, the BT LED is turned off when:
- there is no active connection or radio activity
- USB is suspend

So, when the BT is turned off, it takes 5 seconds because USB suspend timeone
is 5 seconds by default. And if the USB suspend is not enabled, BT LED won't be
turned off.

To fix this issue, recently Intel Bluetooth firmware patch had been submitted
to turn off the BT LED explicitly by the vendor specific command(0xFC3F). And
this patch sends this command to the device before closing the device.

For backward compatibility of this command  with old firmware, this command was
supported before, but it behaves same as HCI_RESET internally. So, it won't be
the problem even if the system doesn't have the latest firmware patch.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btusb.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b876888..e0f8a15 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2331,6 +2331,23 @@ static int btusb_set_bdaddr_intel(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return 0;
 }
 
+static int btusb_shutdown_intel(struct hci_dev *hdev)
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
+		hdev->shutdown = btusb_shutdown_intel;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
 
-- 
1.9.1

