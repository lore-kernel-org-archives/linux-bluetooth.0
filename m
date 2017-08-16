Return-Path: <sukumar.ghorai@intel.com>
From: Sukumar Ghorai <sukumar.ghorai@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Sukumar Ghorai <sukumar.ghorai@intel.com>,
	Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH] Bluetooth: btusb: driver to enable the usb-wakeup feature
Date: Wed, 16 Aug 2017 14:46:55 -0700
Message-Id: <1502920015-6418-1-git-send-email-sukumar.ghorai@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

BT-Controller connected as platform non-root-hub device and
usb-driver initialize such device with wakeup disabled,
Ref. usb_new_device().

At present wakeup-capability get enabled by hid-input device from usb
function driver(e.g. BT HID device) at runtime. Again some functional
driver does not set usb-wakeup capability(e.g LE HID device implement
as HID-over-GATT), and can't wakeup the host on USB.

Most of the device operation (such as mass storage) initiated from host
(except HID) and USB wakeup aligned with host resume procedure. For BT
device, usb-wakeup capability need to enable form btusc driver as a
generic solution for multiple profile use case and required for USB remote
wakeup (in-bus wakeup) while host is suspended. Also usb-wakeup feature
need to enable/disable with HCI interface up and down.

Signed-off-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
---
 drivers/bluetooth/btusb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e8d8a3f61f5b..7a5c06aaa181 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1088,6 +1088,10 @@ static int btusb_open(struct hci_dev *hdev)
 	}
 
 	data->intf->needs_remote_wakeup = 1;
+	/* device specific wakeup source enabled and required for USB
+	 * remote wakeup while host is suspended
+	 */
+	device_wakeup_enable(&data->udev->dev);
 
 	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
 		goto done;
@@ -1151,6 +1155,7 @@ static int btusb_close(struct hci_dev *hdev)
 		goto failed;
 
 	data->intf->needs_remote_wakeup = 0;
+	device_wakeup_disable(&data->udev->dev);
 	usb_autopm_put_interface(data->intf);
 
 failed:
-- 
2.7.4
