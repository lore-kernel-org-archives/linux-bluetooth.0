Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120907124559.GA16092@x220>
References: <1346378760.7976.2.camel@obelisk.thedillows.org>
	<20120907124559.GA16092@x220>
Date: Mon, 10 Sep 2012 16:11:49 +0300
Message-ID: <CABBYNZ+5E+BC-+9fj0e7iUpEDFJrJBQo8aoMZj8ZEkmiuB=QLA@mail.gmail.com>
Subject: Re: [PATCH] Add support for Logitech Harmony Adapter for PS3
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: David Dillow <dave@thedillows.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David, Bastien,

So we are plannin to rid of the fakehid.c in favor of implementing it
properly inside the kernel similarly to what was done to wiimote, so
is there any obstacle for doing that?

The kernel seems to already have some support for sixaxis in
drivers/hid/hid-sony.c, so I suppose the following would enable us to
use it:

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 41c34f2..a34d92c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -684,6 +684,7 @@
 #define USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE      0x024b
 #define USB_DEVICE_ID_SONY_PS3_CONTROLLER      0x0268
 #define USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER       0x042f
+#define BT_DEVICE_ID_SONY_PS3_CONTROLLER       0x0306

 #define USB_VENDOR_ID_SOUNDGRAPH       0x15c2
 #define USB_DEVICE_ID_SOUNDGRAPH_IMON_FIRST    0x0034
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 5cd25bd..17dd1bb 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -216,6 +216,8 @@ static const struct hid_device_id sony_devices[] = {
                .driver_data = SIXAXIS_CONTROLLER_USB },
        { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY,
USB_DEVICE_ID_SONY_PS3_CONTROLLER),
                .driver_data = SIXAXIS_CONTROLLER_BT },
+       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY,
BT_DEVICE_ID_SONY_PS3_CONTROLLER),
+               .driver_data = SIXAXIS_CONTROLLER_BT },
        { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE),
                .driver_data = VAIO_RDESC_CONSTANT },
        { }

-- 
Luiz Augusto von Dentz
