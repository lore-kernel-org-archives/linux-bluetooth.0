Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org,
 Pavel Machek <pavel@ucw.cz>
Subject: fix bug in suspend/resume code of btusb
Date: Thu, 2 Oct 2008 22:32:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200810022232.07165.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this fixes an issue in btusb's suspend/resume support that strikes if
the adapter is suspended while the hci is down.
This probably fixes the bug Pavel sees with autosuspend and fixes a bug
for me. I am currently looking at issues with new hardware, but with this patch
it should work at least for the best hardware.

What tree should I base a clean patch against?

Signed-off-by: Oliver Neukum <oneukum@suse.de>

	Regards
		Oliver


---

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ef24515..47ff028 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1072,6 +1069,10 @@ static int btusb_resume(struct usb_interface *intf)
 			clear_bit(HCI_RUNNING, &hdev->flags);
 			return ret;
 		}
+	} else {
+		spin_lock_irq(&data->lock);
+		clear_bit(BTUSB_SUSPENDING, &data->flags);
+		spin_unlock_irq(&data->lock);
 	}
 
 	if (hdev->conn_hash.acl_num > 0) {
