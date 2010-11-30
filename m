Return-Path: <cyrus@holtmann.org>
From: stefan.seyfried@googlemail.com
To: gregkh@suse.de
Cc: linux-bluetooth@vger.kernel.org,
	Stefan Seyfried <seife+kernel@b1-systems.com>,
	Oliver Neukum <oneukum@suse.de>
Subject: [PATCH] btusb: Fix log spamming due to autosuspend
Date: Tue, 30 Nov 2010 21:49:08 +0100
Message-Id: <1291150148-14376-1-git-send-email-stefan.seyfried@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Stefan Seyfried <seife+kernel@b1-systems.com>

If a device is autosuspended an inability to resubmit URBs is
to be expected. Check the error code and only log real errors.
(Now that autosuspend is default enabled for btusb, those log
messages were happening all the time e.g. with a BT mouse)

Signed-off-by: Stefan Seyfried <seife+kernel@b1-systems.com>
Signed-off-by: Oliver Neukum <oneukum@suse.de>
---
 drivers/bluetooth/btusb.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ab3894f..d323c1a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -239,7 +239,8 @@ static void btusb_intr_complete(struct urb *urb)
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err < 0) {
-		BT_ERR("%s urb %p failed to resubmit (%d)",
+		if (err != -EPERM)
+			BT_ERR("%s urb %p failed to resubmit (%d)",
 						hdev->name, urb, -err);
 		usb_unanchor_urb(urb);
 	}
@@ -323,7 +324,8 @@ static void btusb_bulk_complete(struct urb *urb)
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err < 0) {
-		BT_ERR("%s urb %p failed to resubmit (%d)",
+		if (err != -EPERM)
+			BT_ERR("%s urb %p failed to resubmit (%d)",
 						hdev->name, urb, -err);
 		usb_unanchor_urb(urb);
 	}
@@ -412,7 +414,8 @@ static void btusb_isoc_complete(struct urb *urb)
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err < 0) {
-		BT_ERR("%s urb %p failed to resubmit (%d)",
+		if (err != -EPERM)
+			BT_ERR("%s urb %p failed to resubmit (%d)",
 						hdev->name, urb, -err);
 		usb_unanchor_urb(urb);
 	}
-- 
1.7.3.1

