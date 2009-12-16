Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org,
 Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH]btusb:Prevent illtimed autosuspend
Date: Wed, 16 Dec 2009 19:23:43 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200912161923.43127.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

commit 0b72b0a05c1d950e4f35520926cc36bc01fb998a
Author: Oliver Neukum <oliver@neukum.org>
Date:   Mon Dec 14 22:09:49 2009 +0100

    btusb:Prevent illtimed autosuspend
    
    The device must be marked busy as it recieves data.
    
    Signed-off-by: Oliver Neukum <oliver@neukum.org>

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4d29059..a699f09 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -307,6 +307,7 @@ static void btusb_bulk_complete(struct urb *urb)
 		return;
 
 	usb_anchor_urb(urb, &data->bulk_anchor);
+	usb_mark_last_busy(data->udev);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err < 0) {
