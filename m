Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1347591892.6145.14.camel@obelisk.thedillows.org>
References: <1346378760.7976.2.camel@obelisk.thedillows.org>
	<20120907124559.GA16092@x220>
	<CABBYNZ+5E+BC-+9fj0e7iUpEDFJrJBQo8aoMZj8ZEkmiuB=QLA@mail.gmail.com>
	<1347284864.3532.1.camel@sirocco.hadess.net>
	<CABBYNZJpHkt8CGDsfVwirZ=vecb-fhbpPbrVFKt1UR_rA25mSw@mail.gmail.com>
	<CABBYNZ+n9obON7iNcv66x2ZVQCeTs_JoJUDXZFwxJJ6C4cb4YQ@mail.gmail.com>
	<CABBYNZKggzJ7bzQWVmWi30kxOUR8bVCyMLL=SM1=Oe74YPwvKg@mail.gmail.com>
	<1347394656.1606.10.camel@sirocco.hadess.net>
	<CABBYNZ+gpheC9sNeTp2uvDFBV-yPs+cY4PUR2omPt_kLTCafKw@mail.gmail.com>
	<1347456657.23874.29.camel@sirocco.hadess.net>
	<CABBYNZLwXhF0gixPGKUTJY4sZ7EHynTYmHzGtiZsoRGXgeEFaw@mail.gmail.com>
	<CANq1E4SDXVHcumBbEA-4xpeuOQ0SjDxxtL_RqAiNYRPj6ccagQ@mail.gmail.com>
	<20120913003628.ce5babb2a66d09fe17fa15de@studenti.unina.it>
	<1347591892.6145.14.camel@obelisk.thedillows.org>
Date: Sun, 16 Sep 2012 21:35:00 +0200
Message-ID: <CANq1E4TptZt60phRu=yzGoeBF+v5vqoM=erkUPEj43v0f58xGQ@mail.gmail.com>
Subject: Re: [KERNEL PATCH] HID: Add support for Sony BD Remote
From: David Herrmann <dh.herrmann@googlemail.com>
To: David Dillow <dave@thedillows.org>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bastien Nocera <hadess@hadess.net>,
	Antonio Ospite <ospite@studenti.unina.it>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David

On Fri, Sep 14, 2012 at 5:04 AM, David Dillow <dave@thedillows.org> wrote:
> We also gain support for the Logitech Harmony Adapter for PS3.

Could you actually mention that this is based on the user-space BlueZ
code here? I know your comment below includes it but I think the
commit message could actually include some links/information on why we
do this.

> Signed-off-by: David Dillow <dave@thedillows.org>
> --
>  drivers/hid/Kconfig         |    7 +
>  drivers/hid/Makefile        |    1 +
>  drivers/hid/hid-core.c      |    2 +
>  drivers/hid/hid-ps3remote.c |  325 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 335 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index fbf4950..7e6ab25 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -534,6 +534,13 @@ config HID_PRIMAX
>         Support for Primax devices that are not fully compliant with the
>         HID standard.
>
> +config HID_PS3REMOTE
> +       tristate "Sony PS3 Bluetooth BD Remote"
> +       depends on BT_HIDP
> +       ---help---
> +       Support for Sony PS3 Bluetooth BD Remote and Logitech Harmony Adapter
> +       for PS3.
> +

Maybe we can add a link to HID_SONY that the USB PS3 remotes are
implemented there. And similar HID_SONY could include a link to
HID_PS3REMOTE that it implements the BT PS3 drivers.

>  config HID_ROCCAT
>         tristate "Roccat device support"
>         depends on USB_HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index f975485..333ed6c 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_HID_PANTHERLORD) += hid-pl.o
>  obj-$(CONFIG_HID_PETALYNX)     += hid-petalynx.o
>  obj-$(CONFIG_HID_PICOLCD)      += hid-picolcd.o
>  obj-$(CONFIG_HID_PRIMAX)       += hid-primax.o
> +obj-$(CONFIG_HID_PS3REMOTE)    += hid-ps3remote.o
>  obj-$(CONFIG_HID_ROCCAT)       += hid-roccat.o hid-roccat-common.o \
>         hid-roccat-arvo.o hid-roccat-isku.o hid-roccat-kone.o \
>         hid-roccat-koneplus.o hid-roccat-kovaplus.o hid-roccat-pyra.o \
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 60ea284..1838c12 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1591,6 +1591,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD2) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_SPACETRAVELLER) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_SPACENAVIGATOR) },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0x0306) },

As Luiz mentioned, the input drivers generally avoid magic-numbers
here (even though they're actually real magic numbers...).

>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICOLCD) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICOLCD_BOOTLOADER) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_MOUSE_4500) },
> @@ -1641,6 +1642,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER) },
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, 0x0306) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb304) },
> diff --git a/drivers/hid/hid-ps3remote.c b/drivers/hid/hid-ps3remote.c
> new file mode 100644
> index 0000000..a87346e
> --- /dev/null
> +++ b/drivers/hid/hid-ps3remote.c
> @@ -0,0 +1,325 @@
> +/*
> + * HID driver for Sony PS3 BD Remote
> + *
> + * Copyright (c) 2012 David Dillow <dave@thedillows.org>
> + * Based on a blend of the bluez fakehid user-space code by Marcel Holtmann
> + * and other kernel HID drivers.
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +
> +#include "hid-ids.h"
> +
> +enum ps3remote_special_keys {
> +       PS3R_BIT_PS       = 0,
> +       PS3R_BIT_ENTER    = 3,
> +       PS3R_BIT_L2       = 8,
> +       PS3R_BIT_R2       = 9,
> +       PS3R_BIT_L1       = 10,
> +       PS3R_BIT_R1       = 11,
> +       PS3R_BIT_TRIANGLE = 12,
> +       PS3R_BIT_CIRCLE   = 13,
> +       PS3R_BIT_CROSS    = 14,
> +       PS3R_BIT_SQUARE   = 15,
> +       PS3R_BIT_SELECT   = 16,
> +       PS3R_BIT_L3       = 17,
> +       PS3R_BIT_R3       = 18,
> +       PS3R_BIT_START    = 19,
> +       PS3R_BIT_UP       = 20,
> +       PS3R_BIT_RIGHT    = 21,
> +       PS3R_BIT_DOWN     = 22,
> +       PS3R_BIT_LEFT     = 23,
> +};
> +
> +static unsigned int ps3remote_bits[] = {
> +       [PS3R_BIT_ENTER]    = 0x0b,
> +       [PS3R_BIT_PS]       = 0x43,
> +       [PS3R_BIT_SQUARE]   = 0x5f,
> +       [PS3R_BIT_CROSS]    = 0x5e,
> +       [PS3R_BIT_CIRCLE]   = 0x5d,
> +       [PS3R_BIT_TRIANGLE] = 0x5c,
> +       [PS3R_BIT_R1]       = 0x5b,
> +       [PS3R_BIT_L1]       = 0x5a,
> +       [PS3R_BIT_R2]       = 0x59,
> +       [PS3R_BIT_L2]       = 0x58,
> +       [PS3R_BIT_LEFT]     = 0x57,
> +       [PS3R_BIT_DOWN]     = 0x56,
> +       [PS3R_BIT_RIGHT]    = 0x55,
> +       [PS3R_BIT_UP]       = 0x54,
> +       [PS3R_BIT_START]    = 0x53,
> +       [PS3R_BIT_R3]       = 0x52,
> +       [PS3R_BIT_L3]       = 0x51,
> +       [PS3R_BIT_SELECT]   = 0x50,
> +};
> +
> +const static unsigned int ps3remote_keymap[] = {
> +       [0x16] = KEY_EJECTCD,
> +       [0x64] = KEY_AUDIO,
> +       [0x65] = KEY_ANGLE,
> +       [0x63] = KEY_SUBTITLE,
> +       [0x0f] = KEY_CLEAR,
> +       [0x28] = KEY_TIME,
> +       [0x00] = KEY_1,
> +       [0x01] = KEY_2,
> +       [0x02] = KEY_3,
> +       [0x03] = KEY_4,
> +       [0x04] = KEY_5,
> +       [0x05] = KEY_6,
> +       [0x06] = KEY_7,
> +       [0x07] = KEY_8,
> +       [0x08] = KEY_9,
> +       [0x09] = KEY_0,
> +       [0x81] = KEY_RED,
> +       [0x82] = KEY_GREEN,
> +       [0x80] = KEY_BLUE,
> +       [0x83] = KEY_YELLOW,
> +       [0x70] = KEY_INFO,              /* display */
> +       [0x1a] = KEY_MENU,              /* top menu */
> +       [0x40] = KEY_CONTEXT_MENU,      /* pop up/menu */
> +       [0x0e] = KEY_ESC,               /* return */
> +       [0x5c] = KEY_OPTION,            /* options/triangle */
> +       [0x5d] = KEY_BACK,              /* back/circle */
> +       [0x5f] = KEY_SCREEN,            /* view/square */
> +       [0x5e] = BTN_0,                 /* cross */
> +       [0x54] = KEY_UP,
> +       [0x56] = KEY_DOWN,
> +       [0x57] = KEY_LEFT,
> +       [0x55] = KEY_RIGHT,
> +       [0x0b] = KEY_ENTER,
> +       [0x5a] = BTN_TL,                /* L1 */
> +       [0x58] = BTN_TL2,               /* L2 */
> +       [0x51] = BTN_THUMBL,            /* L3 */
> +       [0x5b] = BTN_TR,                /* R1 */
> +       [0x59] = BTN_TR2,               /* R2 */
> +       [0x52] = BTN_THUMBR,            /* R3 */
> +       [0x43] = KEY_HOMEPAGE,          /* PS button */
> +       [0x50] = KEY_SELECT,
> +       [0x53] = BTN_START,
> +       [0x33] = KEY_REWIND,            /* scan back */
> +       [0x32] = KEY_PLAY,
> +       [0x34] = KEY_FORWARD,           /* scan forward */
> +       [0x30] = KEY_PREVIOUS,
> +       [0x38] = KEY_STOP,
> +       [0x31] = KEY_NEXT,
> +       [0x60] = KEY_FRAMEBACK,         /* slow/step back */
> +       [0x39] = KEY_PAUSE,
> +       [0x61] = KEY_FRAMEFORWARD,      /* slow/step forward */
> +};

Is there a reason for this weird order? I guess it's copied unchanged
from userspace? (Or maybe I am just not getting the semantic order
here) But I think most entries can be changed to be ascending indexes.
Makes adding new ones much easier.

> +static __u8 ps3remote_rdesc[] = {
> +       0x05, 0x01,     /* USAGE PAGE (Generic Desktop) */
> +       0x09, 0x05,     /* USAGE (Game Pad) */
> +       0xa1, 0x01,     /* COLLECTION (Application) */
> +       0x05, 0x06,     /*   USAGE PAGE (Generic Device) */
> +       0x09, 0x20,     /*   USAGE (Battery Strength) */
> +       0x15, 0x00,     /*   LOGICAL MINIMUM (0) */
> +       0x25, 0x64,     /*   LOGICAL MAXIMUM (100) */
> +       0x75, 0x08,     /*   REPORT SIZE (8) */
> +       0x95, 0x01,     /*   REPORT COUNT (1) */
> +       0x81, 0x02,     /*   INPUT (Variable, Absolute) */
> +       0x05, 0x09,     /*   USAGE PAGE (Button) */
> +       0x19, 0x00,     /*   USAGE MINUMUM (0) */
> +       0x29, 0xfe,     /*   USAGE MAXIMUM (254) */
> +       0x15, 0x00,     /*   LOGICAL MINIMUM (0) */
> +       0x25, 0xfe,     /*   LOGICAL MAXIMUM (254) */
> +       0x75, 0x08,     /*   REPORT SIZE (8) */
> +       0x95, 0x01,     /*   REPORT COUNT (11) */
> +       0x81, 0x00,     /*   INPUT (Array, Absolute) */
> +       0xc0,           /* END_COLLECTION */
> +};
> +
> +struct ps3remote_data {
> +       u8  report[12];
> +       u8  last_key;
> +       u32 last_mask;
> +};
> +
> +static __u8 *ps3remote_fixup(struct hid_device *hdev, __u8 *rdesc,
> +                            unsigned int *rsize)
> +{
> +       *rsize = sizeof(ps3remote_rdesc);
> +       return ps3remote_rdesc;
> +}
> +
> +static int ps3remote_mapping(struct hid_device *hdev, struct hid_input *hi,
> +                            struct hid_field *field, struct hid_usage *usage,
> +                            unsigned long **bit, int *max)
> +{
> +       unsigned int key = usage->hid & HID_USAGE;
> +
> +       if ((usage->hid & HID_USAGE_PAGE) != HID_UP_BUTTON ||
> +           key >= ARRAY_SIZE(ps3remote_keymap))
> +               return -1;
> +
> +       key = ps3remote_keymap[key];
> +       if (!key)
> +               return -1;
> +
> +       hid_map_usage_clear(hi, usage, bit, max, EV_KEY, key);
> +       return 1;
> +}

I'd actually like the HID people review this usage-table and
report-fixup. It looks good to me, though.

> +static void ps3remote_keychange(struct ps3remote_data *data, u8 key, u8 pressed)
> +{
> +       /*
> +        * Update our report to include/exclude the key that changed, but
> +        * make sure it doesn't get listed twice. It's OK if we don't have
> +        * room to store a keypress, as that means 11 keys are simultaneously
> +        * pressed.
> +        */
> +       u8 *p = memchr(data->report + 1, key, 11);
> +       if (pressed) {
> +               if (p)
> +                       return;
> +
> +               /* Not present, find a free spot to add it */
> +               p = memchr(data->report + 1, 0xff, 11);
> +       } else
> +               key = 0xff;
> +
> +       if (p)
> +               *p = key;
> +}
> +
> +static int ps3remote_event(struct hid_device *hdev, struct hid_report *report,
> +                          u8 *raw_data, int size)
> +{
> +       struct ps3remote_data *data = hid_get_drvdata(hdev);
> +       u32 mask, changed;
> +       u8 key, pressed;
> +       int i;
> +
> +       if (size != 12) {
> +               hid_dbg(hdev, "unsupported report size\n");
> +               return 1;
> +       }
> +
> +       /* Battery appears to range from 0 to 5, convert into a percentage */
> +       data->report[0] = raw_data[11] * 20;
> +
> +       /*
> +        * Sometimes key presses are reported in the bitmask, sometimes
> +        * standalone. It appears the bitmask is used for buttons that
> +        * may pressed at the same time.
> +        */
> +       mask = be32_to_cpup((__be32 *) raw_data);
> +       mask &= ~0xff000000;
> +       key = raw_data[4];
> +       pressed = raw_data[10];
> +
> +       changed = data->last_mask ^ mask;
> +       if (changed) {
> +               /* Update any changed multiple keypress reports */
> +               for (i = 0; i < 24; i++) {
> +                       if ((changed & (1 << i)) && ps3remote_bits[i]) {
> +                               ps3remote_keychange(data, ps3remote_bits[i],
> +                                                   !!(mask & (1 << i)));
> +                       }
> +               }
> +               data->last_mask = mask;
> +       } else if (pressed && key != 0xff) {
> +               /* Single key pressed */
> +               ps3remote_keychange(data, key, 1);
> +               data->last_key = key;
> +       } else if (!pressed && data->last_key != 0xff) {
> +               /* Single key released */
> +               ps3remote_keychange(data, data->last_key, 0);
> +               data->last_key = 0xff;
> +       } else {
> +               hid_dbg(hdev, "Incoherent report, %06x %06x %02x %02x %02x\n",
> +                       mask, data->last_mask, key, data->last_key, pressed);
> +       }
> +
> +       /* Substitue our updated report */
> +       memcpy(raw_data, data->report, 12);
> +       return 0;
> +}
> +
> +static int ps3remote_probe(struct hid_device *hdev,
> +                          const struct hid_device_id *id)
> +{
> +       struct ps3remote_data *data;
> +       int ret = -ENOMEM;
> +
> +       data = kmalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data) {
> +               hid_err(hdev, "Can't alloc private data\n");
> +               goto err;
> +       }
> +
> +       data->report[0] = 0;
> +       memset(data->report + 1, 0xff, 11);
> +       data->last_key = 0xff;
> +       data->last_mask = 0;
> +
> +       hid_set_drvdata(hdev, data);
> +
> +       ret = hid_parse(hdev);
> +       if (ret) {
> +               hid_err(hdev, "HID parse failed\n");
> +               goto err;
> +       }
> +
> +       ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +       if (ret) {
> +               hid_err(hdev, "HW start failed\n");
> +               goto err;
> +       }
> +
> +       return ret;
> +
> +err:
> +       kfree(data);
> +       return ret;
> +}
> +
> +static void ps3remote_remove(struct hid_device *hdev)
> +{
> +       struct ps3remote_data *data = hid_get_drvdata(hdev);
> +
> +       hid_hw_stop(hdev);
> +       kfree(data);
> +}
> +
> +static const struct hid_device_id ps3remote_devices[] = {
> +       /* PS3 BD Remote */
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, 0x0306) },
> +       /* Logitech Harmony Adapter for PS3 */
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0x0306) },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(hid, ps3remote_devices);
> +
> +static struct hid_driver ps3remote_driver = {
> +       .name           = "ps3_remote",
> +       .id_table       = ps3remote_devices,
> +       .probe          = ps3remote_probe,
> +       .remove         = ps3remote_remove,
> +       .report_fixup   = ps3remote_fixup,
> +       .input_mapping  = ps3remote_mapping,
> +       .raw_event      = ps3remote_event,
> +};
> +
> +static int __init ps3remote_init(void)
> +{
> +       return hid_register_driver(&ps3remote_driver);
> +}
> +
> +static void __exit ps3remote_exit(void)
> +{
> +       hid_unregister_driver(&ps3remote_driver);
> +}
> +
> +module_init(ps3remote_init);
> +module_exit(ps3remote_exit);
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("David Dillow <dave@thedillows.org>");

Looks all good to me.
Regarding the lost keypresses during connection establishment: All HID
drivers loose them. Any input data is actually lost as long as no
driver is fully loaded. It's actually not that easy to change that
(feel free to have a look at hid-core.c) but I also don't understand
why you actually care about them so much? There is driver rebinding,
delayed driver loading and similar. So even if you fix it, it can
happen that your driver is loaded after a lot of communication has
already been done.
Could you explain why you actually need these?

The hidp_connadd_req.idle_to can be used for the automatic timeout.
It's Bluetooth only so USB devices won't even notice it.

Furthermore, please CC linux-input@vger.kernel.org and jkosina@suse.cz
(HID maintainer) in the next patches. The patch will go through Jiri's
tree.

Thanks a lot!
David
