Return-Path: <ethan.hsieh@canonical.com>
MIME-Version: 1.0
From: Ethan Hsieh <ethan.hsieh@canonical.com>
Date: Thu, 6 Oct 2016 14:44:44 +0800
Message-ID: <CAD571NjHoR-i48hTNcXLam0FPPEmGNQbhkMB8Y+61_Vf9O+Jbg@mail.gmail.com>
Subject: [PATCH] Bluetooth: btusb: Fix atheros firmware download error
To: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Cc: Ethan Hsieh <ethan.hsieh@canonical.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Move usb_autopm_get_interface() ahead of setup_on_usb() to prevent device
from sending usb control message in usb suspend mode.

The error message is as below:

[   83.944103] btusb 1-2:1.1: usb_suspend_interface: status 0
[   83.944107] btusb 1-2:1.0: usb_suspend_interface: status 0
[   83.960132] usb 1-2: usb auto-suspend, wakeup 0
[   83.976156] usb 1-2: usb_suspend_device: status 0
[   83.976162] usb 1-2: usb_suspend_both: status 0
[  298.689106] Bluetooth: hci0
[  298.689399] Bluetooth: hci0: Failed to access otp area (-113)

Signed-off-by: Ethan Hsieh <ethan.hsieh@canonical.com>
---
 drivers/bluetooth/btusb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8896233..2f633df 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1043,6 +1043,10 @@ static int btusb_open(struct hci_dev *hdev)

        BT_DBG("%s", hdev->name);

+       err = usb_autopm_get_interface(data->intf);
+       if (err < 0)
+               return err;
+
        /* Patching USB firmware files prior to starting any URBs of HCI path
         * It is more safe to use USB bulk channel for downloading USB patch
         */
@@ -1052,10 +1056,6 @@ static int btusb_open(struct hci_dev *hdev)
                        return err;
        }

-       err = usb_autopm_get_interface(data->intf);
-       if (err < 0)
-               return err;
-
        data->intf->needs_remote_wakeup = 1;

        if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))

-- 
2.7.4
