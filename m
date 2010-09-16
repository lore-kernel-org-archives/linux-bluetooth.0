Return-Path: <cyrus@holtmann.org>
From: Matthew Garrett <mjg@redhat.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-usb@vger.kernel.org, marcel@holtmann.org,
        Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 2/3] bluetooth: Remove some unnecessary error messages
Date: Thu, 16 Sep 2010 13:58:14 -0400
Message-Id: <1284659895-27984-2-git-send-email-mjg@redhat.com>
In-Reply-To: <1284659895-27984-1-git-send-email-mjg@redhat.com>
References: <1284659895-27984-1-git-send-email-mjg@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The main reason for these urbs to error out on submission is that runtime
pm has kicked in, which is unnecessary noise. Let's just drop them.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/bluetooth/btusb.c |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d22ce3c..3ace025 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -229,11 +229,8 @@ static void btusb_intr_complete(struct urb *urb)
 	usb_anchor_urb(urb, &data->intr_anchor);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
-	if (err < 0) {
-		BT_ERR("%s urb %p failed to resubmit (%d)",
-						hdev->name, urb, -err);
+	if (err < 0)
 		usb_unanchor_urb(urb);
-	}
 }
 
 static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
@@ -313,11 +310,8 @@ static void btusb_bulk_complete(struct urb *urb)
 	usb_mark_last_busy(data->udev);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
-	if (err < 0) {
-		BT_ERR("%s urb %p failed to resubmit (%d)",
-						hdev->name, urb, -err);
+	if (err < 0)
 		usb_unanchor_urb(urb);
-	}
 }
 
 static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t mem_flags)
@@ -402,11 +396,8 @@ static void btusb_isoc_complete(struct urb *urb)
 	usb_anchor_urb(urb, &data->isoc_anchor);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
-	if (err < 0) {
-		BT_ERR("%s urb %p failed to resubmit (%d)",
-						hdev->name, urb, -err);
+	if (err < 0)
 		usb_unanchor_urb(urb);
-	}
 }
 
 static void inline __fill_isoc_descriptor(struct urb *urb, int len, int mtu)
-- 
1.7.2.3
