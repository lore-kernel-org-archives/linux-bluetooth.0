Return-Path: <cyrus@holtmann.org>
References: <1343911365-3376-1-git-send-email-shea@shealevy.com>
In-Reply-To: <1343911365-3376-1-git-send-email-shea@shealevy.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <6FC304BB-1C26-4A60-A797-309CC7506626@shealevy.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Shea Levy <shea@shealevy.com>
Subject: Re: [PATCH] Bluetooth: Add support for Apple MacBook Pro 9,2
Date: Thu, 2 Aug 2012 08:45:07 -0400
To: "shea@shealevy.com" <shea@shealevy.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Argh, sorry, forgot the sign-off. Will resend after checkpatch passes. Sorry=
 for the noise.

On Aug 2, 2012, at 8:42 AM, shea@shealevy.com wrote:

> From: Shea Levy <shea@shealevy.com>
>=20
> ---
> drivers/bluetooth/btusb.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index e272214..e4ecd5e 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -73,6 +73,9 @@ static struct usb_device_id btusb_table[] =3D {
>    /* Apple MacBookPro8,2 */
>    { USB_DEVICE(0x05ac, 0x821a) },
>=20
> +    /* Apple MacBookPro9,2 */
> +    { USB_DEVICE(0x05ac, 0x821d) },
> +
>    /* Apple MacMini5,1 */
>    { USB_DEVICE(0x05ac, 0x8281) },
>=20
> --=20
> 1.7.11
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
