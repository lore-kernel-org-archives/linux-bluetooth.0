Return-Path: <cyrus@holtmann.org>
Message-ID: <1345835818.3840.0.camel@jlt4.sipsolutions.net>
Subject: [PATCH] btusb: add another Foxconn/Hon Hai ID
From: Johannes Berg <johannes@sipsolutions.net>
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
 <gustavo@padovan.org>,  Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 24 Aug 2012 21:16:58 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

I found a device using 0xe052 for idProduct, add it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/bluetooth/btusb.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e272214..fc0063a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -102,6 +102,7 @@ static struct usb_device_id btusb_table[] = {
 
 	/* Foxconn - Hon Hai */
 	{ USB_DEVICE(0x0489, 0xe033) },
+	{ USB_DEVICE(0x0489, 0xe052) },
 
 	{ }	/* Terminating entry */
 };
