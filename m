Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <AANLkTik20MfB5yta5mRoSny8NYOt3c0Rncg-rJY1SS9R@mail.gmail.com>
References: <AANLkTik20MfB5yta5mRoSny8NYOt3c0Rncg-rJY1SS9R@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 24 Mar 2011 10:10:12 -0600
Message-ID: <AANLkTi=-mGD670m9G31mYQjoj7Rt4_OveXOi2dTPYkxY@mail.gmail.com>
Subject: Re: [PATCH 2.6.38] bluetooth: add support for Apple MacBook Pro 8,2
To: Marc-Antoine Perennou <Marc-Antoine@perennou.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>, Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	stable@kernel.org, Travis Watkins <amaranth@ubuntu.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 21, 2011 at 10:28 AM, Marc-Antoine Perennou
<Marc-Antoine@perennou.com> wrote:
> Just adding the vendor details makes it work fine.
>
> Signed-off-by: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>

Acked by: Grant Likely <grant.likely@secretlab.ca>

Marcel, this one is pretty trivial.  Can we get it picked up for
2.6.39?  It would also be useful to backport it to stable once it hits
Linus' tree.

g.

>
> ---
> =A0drivers/bluetooth/btusb.c | =A0 =A03 +++
> =A01 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 8668114..2af2e77 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -71,6 +71,9 @@ static struct usb_device_id btusb_table[] =3D {
> =A0 =A0 /* Apple MacBookAir3,1, MacBookAir3,2 */
> =A0 =A0 { USB_DEVICE(0x05ac, 0x821b) },
>
> + =A0 =A0/* Apple MacBookPro8,2 */
> + =A0 =A0{ USB_DEVICE(0x05ac, 0x821a) },
> +
> =A0 =A0 /* AVM BlueFRITZ! USB v2.0 */
> =A0 =A0 { USB_DEVICE(0x057c, 0x3800) },
>
> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
