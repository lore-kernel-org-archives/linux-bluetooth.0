Return-Path: <cyrus@holtmann.org>
References: <1344374463-21231-1-git-send-email-shea@shealevy.com>
In-Reply-To: <1344374463-21231-1-git-send-email-shea@shealevy.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <7D86F475-50AC-42CF-8D29-C4E8F9B86D0D@shealevy.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Gustavo Padovan <gustavo@padovan.org>,
 Marcel Holtmann <marcel@holtmann.org>, Shea Levy <shea@shealevy.com>
From: Shea Levy <shea@shealevy.com>
Subject: Re: [PATCH RESEND] Bluetooth: Add support for Apple MacBook Pro 9,2
Date: Tue, 14 Aug 2012 06:25:41 -0400
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Is there a problem with this patch?

Thanks,
Shea

On Aug 7, 2012, at 5:21 PM, Shea Levy <shea@shealevy.com> wrote:

> $ usb-devices
> <snip>
> T:  Bus=3D04 Lev=3D04 Prnt=3D04 Port=3D02 Cnt=3D01 Dev#=3D  9 Spd=3D12  Mx=
Ch=3D 0
> D:  Ver=3D 2.00 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D05ac ProdID=3D821d Rev=3D00.86
> S:  Manufacturer=3DApple Inc.
> S:  Product=3DBluetooth USB Host Controller
> C:  #Ifs=3D 4 Cfg#=3D 1 Atr=3De0 MxPwr=3D0mA
> I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=3D=
btusb
> I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
btusb
> I:  If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=3D=
(none)
> I:  If#=3D 3 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D01 Driver=3D=
(none)
> <snip>
>=20
> Signed-off-by: Shea Levy <shea@shealevy.com>
> ---
> drivers/bluetooth/btusb.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index f637c25..038acc7 100644
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
