Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Sukumar Ghorai <sukumar.ghorai@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
        Sukumar Ghorai <sukumar.ghorai@intel.com>,
        Amit K Bag # <amit.k.bag@intel.com>
Subject: [PATCH] bt usb-device initialize as wakeup enable
Date: Mon, 14 Aug 2017 11:24:48 -0700
Message-Id: <1502735088-4333-1-git-send-email-sukumar.ghorai@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BT-Controller connected as platform non-root-hub device and
usb-driver initialize such device with wakeup disabled,
Ref. usb_new_device().

At present wakeup-capability get enabled by hid-input device from usb
function driver(e.g. BT HID device) at runtime. Again some functional
driver does not set usb-wakeup capability(e.g LE HID device implement
as HID-over-GATT), and can't wakeup the host on USB.

Hence usb-wakeup capability enable form btusc driver as a generic
solution for multiple profile usecase and required for USB remote
wakeup (in-bus wakeup) while host is suspended.

Signed-off-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
Signed-off-by: Amit K Bag <amit.k.bag@intel.com>#
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e1124ba44154..7eeeeb6ffae6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1083,6 +1083,10 @@ static int btusb_open(struct hci_dev *hdev)
 	}
 
 	data->intf->needs_remote_wakeup = 1;
+	/* device specific wakeup source enabled and required for USB
+	 * remote wakeup while host is suspended
+	 */
+	device_init_wakeup(&data->udev->dev, true);
 
 	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
 		goto done;
-- 
2.7.4

