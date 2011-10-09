Return-Path: <cyrus@holtmann.org>
Subject: [PATCH 2/2] Bluetooth: btusb: hide more usb_submit_urb errors
From: Paul Bolle <pebolle@tiscali.nl>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>, Marcel Holtmann
 <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 09 Oct 2011 12:12:22 +0200
Message-ID: <1318155142.1903.24.camel@x61.thuisdomein>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

There are still three calls of usb_submit_urb() that will print errors
if those calls return -EPERM or -ENODEV. I have never triggered these,
so I'm not sure when these return values might be seen. It still makes
sense to be silent if these occur (since "urb is being killed" and
"device got disconnected" aren't things to worry about).

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
 drivers/bluetooth/btusb.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3d1afe7..5816527 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -309,7 +309,8 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 
 	err = usb_submit_urb(urb, mem_flags);
 	if (err < 0) {
-		BT_ERR("%s urb %p submission failed (%d)",
+		if (err != -EPERM && err != -ENODEV)
+			BT_ERR("%s urb %p submission failed (%d)",
 						hdev->name, urb, -err);
 		usb_unanchor_urb(urb);
 	}
@@ -394,7 +395,8 @@ static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t mem_flags)
 
 	err = usb_submit_urb(urb, mem_flags);
 	if (err < 0) {
-		BT_ERR("%s urb %p submission failed (%d)",
+		if (err != -EPERM && err != -ENODEV)
+			BT_ERR("%s urb %p submission failed (%d)",
 						hdev->name, urb, -err);
 		usb_unanchor_urb(urb);
 	}
@@ -517,7 +519,8 @@ static int btusb_submit_isoc_urb(struct hci_dev *hdev, gfp_t mem_flags)
 
 	err = usb_submit_urb(urb, mem_flags);
 	if (err < 0) {
-		BT_ERR("%s urb %p submission failed (%d)",
+		if (err != -EPERM && err != -ENODEV)
+			BT_ERR("%s urb %p submission failed (%d)",
 						hdev->name, urb, -err);
 		usb_unanchor_urb(urb);
 	}
-- 
1.7.4.4
