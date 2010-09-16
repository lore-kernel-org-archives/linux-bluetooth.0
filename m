Return-Path: <cyrus@holtmann.org>
From: Matthew Garrett <mjg@redhat.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-usb@vger.kernel.org, marcel@holtmann.org,
        Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 3/3] bluetooth: Enable USB autosuspend by default on btusb
Date: Thu, 16 Sep 2010 13:58:15 -0400
Message-Id: <1284659895-27984-3-git-send-email-mjg@redhat.com>
In-Reply-To: <1284659895-27984-1-git-send-email-mjg@redhat.com>
References: <1284659895-27984-1-git-send-email-mjg@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We've done this for a while in Fedora without any obvious problems other
than some interaction with input devices. Those should be fixed now, so
let's try this in mainline.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/bluetooth/btusb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3ace025..03b64e4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1014,6 +1014,8 @@ static int btusb_probe(struct usb_interface *intf,
 
 	usb_set_intfdata(intf, data);
 
+	usb_enable_autosuspend(interface_to_usbdev(intf));
+
 	return 0;
 }
 
-- 
1.7.2.3
