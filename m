Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: acelan@gmail.com
In-Reply-To: <000601cd0ce8$ddf02020$99d06060$@com>
References: <1331799788-20129-1-git-send-email-acelan.kao@canonical.com>
	<000601cd0ce8$ddf02020$99d06060$@com>
Date: Thu, 29 Mar 2012 10:09:59 +0800
Message-ID: <CAMz9Wg9ZE2ysQma_M-=KrNJLPUaZ5=WyypSNbijps2t7h5J7qw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add support for AR3012 [0cf3:e004]
From: AceLan Kao <acelan.kao@canonical.com>
To: "Kris, Chen" <bluefrog2012@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=Big5
List-ID: <linux-bluetooth.vger.kernel.org>

Dear Kris,

Actually, I don't know.
This id is found in the DW1703 combo card, it combo with ath9k wifi.
And the OEM/OEM engineer told us that the BT could be enabled by just
adding the id in the list.

BTW, sorry, this patch is not against the bluetooth-next tree, I'll
resend it again.

Best regards,
AceLan Kao.

=A6b 2012=A6~3=A4=EB28=A4=E9=A4U=A4=C89:44=A1AKris, Chen <bluefrog2012@gmai=
l.com> =BCg=B9D=A1G
> Hi, Acelan
>
> I want to know, compared with { USB_DEVICE(0x0CF3, 0x3004) }, is {
> USB_DEVICE(0x0CF3, 0xE004) } a new product of Atheros, or for a specific
> customer of Atheros?
>
> Thanks!
>
> Kris
>
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org
> [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of AceLan Kao
> Sent: 2012=A6~3=A4=EB15=A4=E9 16:23
> To: linux-bluetooth@vger.kernel.org; Gustavo F. Padovan; Marcel Holtmann
> Subject: [PATCH] Bluetooth: Add support for AR3012 [0cf3:e004]
>
> Add another vendor specific ID for Atheros AR3012
>
> output of usb-devices:
> T:  Bus=3D02 Lev=3D02 Prnt=3D02 Port=3D04 Cnt=3D01 Dev#=3D  4 Spd=3D12  M=
xCh=3D 0
> D:  Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D0cf3 ProdID=3De004 Rev=3D00.02
> S:  Manufacturer=3DAtheros Communications
> S:  Product=3DBluetooth USB Host Controller
> S:  SerialNumber=3DAlaska Day 2006
> C:  #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
>
> BugLink: https://bugs.launchpad.net/bugs/922715
>
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> ---
>  drivers/bluetooth/ath3k.c |    2 ++
>  drivers/bluetooth/btusb.c |    1 +
>  2 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 07f14d1..b55fc76 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -71,6 +71,7 @@ static struct usb_device_id ath3k_table[] =3D {
>
>        /* Atheros AR3012 with sflash firmware*/
>        { USB_DEVICE(0x0CF3, 0x3004) },
> +       { USB_DEVICE(0x0CF3, 0xE004) },
>
>        /* Atheros AR5BBU12 with sflash firmware */
>        { USB_DEVICE(0x0489, 0xE02C) },
> @@ -87,6 +88,7 @@ static struct usb_device_id ath3k_blist_tbl[] =3D {
>
>        /* Atheros AR3012 with sflash firmware*/
>        { USB_DEVICE(0x0cf3, 0x3004), .driver_info =3D BTUSB_ATH3012 },
> +       { USB_DEVICE(0x0cf3, 0xe004), .driver_info =3D BTUSB_ATH3012 },
>
>        { }     /* Terminating entry */
>  };
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 789c9b5..2b7d2d1 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -127,6 +127,7 @@ static struct usb_device_id blacklist_table[] =3D {
>
>        /* Atheros 3012 with sflash firmware */
>        { USB_DEVICE(0x0cf3, 0x3004), .driver_info =3D BTUSB_ATH3012 },
> +       { USB_DEVICE(0x0cf3, 0xe004), .driver_info =3D BTUSB_ATH3012 },
>
>        /* Atheros AR5BBU12 with sflash firmware */
>        { USB_DEVICE(0x0489, 0xe02c), .driver_info =3D BTUSB_IGNORE },
> --
> 1.7.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



--=20
Chia-Lin Kao(AceLan)
http://blog.acelan.idv.tw/
E-Mail: acelan.kaoATcanonical.com (s/AT/@/)
