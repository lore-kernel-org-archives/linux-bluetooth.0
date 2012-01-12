Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: lexicall@gmail.com
In-Reply-To: <1322649157-20479-1-git-send-email-kengyu@canonical.com>
References: <1321422409.15441.510.camel@aeonflux> <1322649157-20479-1-git-send-email-kengyu@canonical.com>
From: =?UTF-8?B?S2VuZy1Zw7wgTGlu?= <kengyu@canonical.com>
Date: Thu, 12 Jan 2012 10:23:38 +0100
Message-ID: <CADXHx7ZP=kGfP7Pz3Wq-Kpae9D=4JRmQOWXkiy5T2tfAVewQMQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add AR30XX device ID on Asus laptops
To: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Cc: Anthony Wong <anthony.wong@canonical.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Heya,
 No intent to push in rush, but the patch is not applied in the tree
after a while. just want to make sure it looks ok and is ready to be
applied in the next round.

  Thanks,
-kengyu

On Wed, Nov 30, 2011 at 11:32 AM, Keng-Yu Lin <kengyu@canonical.com> wrote:
> The ID is found on Asus K54HR and K53U.
> Blacklist the AR3011-based device ID [0489:e03d]
> and add to ath3k.c for firmware loading.
>
> Below is the output of usb-devices script:
>
> Before the fiwmware loading:
>
> T: =C2=A0Bus=3D01 Lev=3D02 Prnt=3D02 Port=3D00 Cnt=3D01 Dev#=3D =C2=A03 S=
pd=3D12 =C2=A0MxCh=3D 0
> D: =C2=A0Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=
=3D =C2=A01
> P: =C2=A0Vendor=3D0489 ProdID=3De03d Rev=3D00.01
> C: =C2=A0#Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> I: =C2=A0If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 D=
river=3Dbtusb
> I: =C2=A0If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 D=
river=3Dbtusb
>
> After the fiwmware loading:
>
> T: =C2=A0Bus=3D01 Lev=3D02 Prnt=3D02 Port=3D00 Cnt=3D01 Dev#=3D =C2=A05 S=
pd=3D12 =C2=A0MxCh=3D 0
> D: =C2=A0Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=
=3D =C2=A01
> P: =C2=A0Vendor=3D0cf3 ProdID=3D3005 Rev=3D00.01
> C: =C2=A0#Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> I: =C2=A0If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 D=
river=3Dbtusb
> I: =C2=A0If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 D=
river=3Dbtusb
>
> Signed-off-by: Keng-Yu Lin <kengyu@canonical.com>
> ---
> =C2=A0drivers/bluetooth/ath3k.c | =C2=A0 =C2=A01 +
> =C2=A0drivers/bluetooth/btusb.c | =C2=A0 =C2=A01 +
> =C2=A02 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 106beb1..db811d2 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -64,6 +64,7 @@ static struct usb_device_id ath3k_table[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ USB_DEVICE(0x0CF3, 0x3002) },
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ USB_DEVICE(0x13d3, 0x3304) },
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ USB_DEVICE(0x0930, 0x0215) },
> + =C2=A0 =C2=A0 =C2=A0 { USB_DEVICE(0x0489, 0xE03D) },
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Atheros AR9285 Malbec with sflash firmware =
*/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ USB_DEVICE(0x03F0, 0x311D) },
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index fe4ebc3..d5b9aa4 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -119,6 +119,7 @@ static struct usb_device_id blacklist_table[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ USB_DEVICE(0x0cf3, 0x3002), .driver_info =3D=
 BTUSB_IGNORE },
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ USB_DEVICE(0x13d3, 0x3304), .driver_info =3D=
 BTUSB_IGNORE },
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ USB_DEVICE(0x0930, 0x0215), .driver_info =3D=
 BTUSB_IGNORE },
> + =C2=A0 =C2=A0 =C2=A0 { USB_DEVICE(0x0489, 0xe03d), .driver_info =3D BTU=
SB_IGNORE },
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Atheros AR9285 Malbec with sflash firmware =
*/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ USB_DEVICE(0x03f0, 0x311d), .driver_info =3D=
 BTUSB_IGNORE },
> --
> 1.7.5.4
>
