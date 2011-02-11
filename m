Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oneukum@suse.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
	stable@kernel.org, ensonic@sonicpulse.de
Subject: [PATCH] btusb:fix crash with quirky dongles doing sound
Date: Fri, 11 Feb 2011 13:00:06 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201102111300.06470.oneukum@suse.de>
List-ID: <linux-bluetooth.vger.kernel.org>

=46rom befd2cd1a7875d395f72b38f2cb89a03f16edaba Mon Sep 17 00:00:00 2001
=46rom: Oliver Neukum <oliver@neukum.org>
Date: Fri, 11 Feb 2011 12:35:05 +0100
Subject: [PATCH] btusb:fix crash with quirky dongles doing sound

Quirky dongles sometimes do not use the iso interface which
causes a crash with runtime PM

Signed-off-by: Oliver Neukum <oneukum@suse.de>
=2D--
 drivers/bluetooth/btusb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1da773f..08c8629 100644
=2D-- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -826,7 +826,7 @@ static void btusb_work(struct work_struct *work)
=20
 	if (hdev->conn_hash.sco_num > 0) {
 		if (!test_bit(BTUSB_DID_ISO_RESUME, &data->flags)) {
=2D			err =3D usb_autopm_get_interface(data->isoc);
+			err =3D usb_autopm_get_interface(data->isoc ? data->isoc : data->intf);
 			if (err < 0) {
 				clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 				usb_kill_anchored_urbs(&data->isoc_anchor);
@@ -855,7 +855,7 @@ static void btusb_work(struct work_struct *work)
=20
 		__set_isoc_interface(hdev, 0);
 		if (test_and_clear_bit(BTUSB_DID_ISO_RESUME, &data->flags))
=2D			usb_autopm_put_interface(data->isoc);
+			usb_autopm_put_interface(data->isoc ? data->isoc : data->intf);
 	}
 }
=20
=2D-=20
1.7.1
