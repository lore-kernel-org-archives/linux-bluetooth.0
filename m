Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Leif Liddy <leif.linux@gmail.com>
Date: Sat, 8 Jul 2017 16:43:41 +0200
Message-ID: <CAAbRKOs0c3FSuZVXvXvdOCExVFA6m2wonTCD1iHtX-nJkv8DJw@mail.gmail.com>
Subject: [RFC PATCH] Bluetooth: btusb: fix QCA Rome suspend/resume
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

this is an reference to:
https://bugzilla.kernel.org/show_bug.cgi?id=193571

There's been numerous reported instances where BTUSB_QCA_ROME
bluetooth controllers stop functioning upon resume from suspend. These
devices seem to be losing power during suspend. Patch will detect a
status change on resume and perform a reset.

**patch below is based on this previous patch that affected Realtek
btusb devices
http://www.spinics.net/lists/linux-bluetooth/msg61943.html


diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fa24d69..2503709 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3067,6 +3067,12 @@ static int btusb_probe(struct usb_interface *intf,
        if (id->driver_info & BTUSB_QCA_ROME) {
                data->setup_on_usb = btusb_setup_qca;
                hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
+
+               /* QCA Rome devices lose their updated firmware over suspend,
+                * but the USB hub doesn't notice any status change.
+                * Explicitly request a device reset on resume.
+                */
+               set_bit(BTUSB_RESET_RESUME, &data->flags);
        }

 #ifdef CONFIG_BT_HCIBTUSB_RTL
