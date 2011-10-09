Return-Path: <cyrus@holtmann.org>
Subject: [PATCH 1/2] Bluetooth: btusb: also be quiet when suspending
From: Paul Bolle <pebolle@tiscali.nl>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>, Marcel Holtmann
 <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 09 Oct 2011 12:12:16 +0200
Message-ID: <1318155136.1903.23.camel@x61.thuisdomein>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

usb_submit_urb() returns -ENODEV when a usb device is disconnected. In
commit 4935f1c164ac528dff3538f97953b385ba500710 ("Bluetooth: btusb: be
quiet on device disconnect") I stopped treating that return as an error
in the three btusb_*_complete() functions.

It turns out btusb_send_frame() generates a similar error if the system
is suspended while the bluetooth usb device is enabled. The sensible
thing to do here seems to be to treat -ENODEV (and -EPERM) just like the
btusb_*_complete() functions now do.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
 drivers/bluetooth/btusb.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9cbac6b..3d1afe7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -765,7 +765,9 @@ skip_waking:
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err < 0) {
-		BT_ERR("%s urb %p submission failed", hdev->name, urb);
+		if (err != -EPERM && err != -ENODEV)
+			BT_ERR("%s urb %p submission failed (%d)",
+						hdev->name, urb, -err);
 		kfree(urb->setup_packet);
 		usb_unanchor_urb(urb);
 	} else {
-- 
1.7.4.4
