Return-Path: <cyrus@holtmann.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>,
 Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [patch]fix memory leak in fixed btusb_close
From: Oliver Neukum <oliver@neukum.org>
Date: Fri, 13 Nov 2009 14:26:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200911131426.24001.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

If the waker is killed before it can replay outstanding URBs,
these URBs won't be freed or will be replayed at the next open.
This patch closes the window by explicitely discarding outstanding
URBs.

Signed-off-by: Oliver Neukum <oliver@neukum.org>

Linus,

this fixes a memory leak in your fix of btusb.

	Regards
		Oliver

--

commit 8a3e793888c75bc7a49ff8b0be7ec6bd5438d985
Author: Oliver Neukum <oliver@neukum.org>
Date:   Thu Nov 12 16:41:46 2009 +0100

    btusb: close race in disconnect leading to a memory leak
    
    if the waker work is cancelled any deferred IO must be discarded
    in close to free the memory and make sure the data isn't replayed
    later

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2fb3802..44bc8bb 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -600,11 +600,13 @@ static int btusb_close(struct hci_dev *hdev)
 	btusb_stop_traffic(data);
 	err = usb_autopm_get_interface(data->intf);
 	if (err < 0)
-		return 0;
+		goto failed;
 
 	data->intf->needs_remote_wakeup = 0;
 	usb_autopm_put_interface(data->intf);
 
+failed:
+	usb_scuttle_anchored_urbs(&data->deferred);
 	return 0;
 }
 
