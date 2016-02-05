Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH] 0cf3:3004 Atheros Communications, Inc. AR3012 Bluetooth
 4.0
To: =?UTF-8?Q?Cl=c3=a9ment_de_l'Hamaide?=
	<clement.delhamaide@gmail.com>, linux-bluetooth@vger.kernel.org
References: <CAG4Y7ev8wYnKyrTp-3QAP7O17ypAU9PYBD_QJdcR-8bPLZ=xCw@mail.gmail.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <56B4EEFF.1000603@gmail.com>
Date: Fri, 5 Feb 2016 19:50:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAG4Y7ev8wYnKyrTp-3QAP7O17ypAU9PYBD_QJdcR-8bPLZ=xCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Clement,

Am 05.02.2016 um 13:12 schrieb Clément de l'Hamaide:
> Hi,
> 
> Some months ago I posted a patch.
> I can see some people around internet reporting 0cf3:3004 not working
> then I realized that my patch have not been reviewed/commited.
> 
> My bluetooth is working well since end of October with my patch.
> I'm sure Linux users who have this hardware would be thanksful if my
> patch is reviewed and commited.
> 
chances for review would be higher if you keep to the formal criteria
for patches. Please have a look at Documentation/SubmittingPatches.
Things to improve:
- replace subject with a a proper description of the patch including
  appropriate module prefix
- add patch description
- address patch to maintainer + list on cc

> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index b6aceaf..884dbe5 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -199,7 +199,6 @@ static const struct usb_device_id blacklist_table[] = {
>         { USB_DEVICE(0x0930, 0x0227), .driver_info = BTUSB_ATH3012 },
>         { USB_DEVICE(0x0b05, 0x17d0), .driver_info = BTUSB_ATH3012 },
>         { USB_DEVICE(0x0cf3, 0x0036), .driver_info = BTUSB_ATH3012 },
> -       { USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
>         { USB_DEVICE(0x0cf3, 0x3008), .driver_info = BTUSB_ATH3012 },
>         { USB_DEVICE(0x0cf3, 0x311d), .driver_info = BTUSB_ATH3012 },
>         { USB_DEVICE(0x0cf3, 0x311e), .driver_info = BTUSB_ATH3012 },
> @@ -230,6 +229,7 @@ static const struct usb_device_id blacklist_table[] = {
>         { USB_DEVICE(0x0cf3, 0xe007), .driver_info = BTUSB_QCA_ROME },
>         { USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME },
>         { USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME },
> +       { USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_QCA_ROME },
> 
>         /* Broadcom BCM2035 */
>         { USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
> 
> 
> 
> Regards,
> Clément
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

