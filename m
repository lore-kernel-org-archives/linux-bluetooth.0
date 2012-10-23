Return-Path: <cyrus@holtmann.org>
References: <1350995487.13036.YahooMailNeo@web125402.mail.ne1.yahoo.com> <1351003333.1785.26.camel@aeonflux>
Message-ID: <1351008306.9213.YahooMailNeo@web125405.mail.ne1.yahoo.com>
Date: Tue, 23 Oct 2012 09:05:06 -0700 (PDT)
From: Dwaine Garden VE3GIF <dwainegarden@rogers.com>
Reply-To: Dwaine Garden VE3GIF <dwainegarden@rogers.com>
Subject: Re: [PATCH] Bluetooth: Add support for Atheros [04ca:3004]
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1351003333.1785.26.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks. =A0I will get the right output and fix the tabbing probleem; resend=
ing the patch again.=0A=0ADwaine=0A=0A=0A=0A----- Original Message -----=0A=
From: Marcel Holtmann <marcel@holtmann.org>=0ATo: Dwaine Garden VE3GIF <dwa=
inegarden@rogers.com>=0ACc: "linux-bluetooth@vger.kernel.org" <linux-blueto=
oth@vger.kernel.org>=0ASent: Tuesday, October 23, 2012 10:42:13 AM=0ASubjec=
t: Re: [PATCH] Bluetooth: Add support for Atheros [04ca:3004]=0A=0AHi Dwain=
e,=0A=0A> Add another vendor specific ID for Atheros AR3012 device.=0A> Thi=
s chip is wrapped by Lite-On Technology Corp.=0A> =0A> output of usb-device=
s:=0A> Bus 001 Device 008: ID 04ca:3004 Lite-On Technology Corp. =0A> Devic=
e Descriptor:=0A>=A0  bLength=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 18=0A> =0A> bD=
escriptorType=A0 =A0 =A0 =A0  1=0A>=A0  bcdUSB=A0 =A0 =A0 =A0 =A0 =A0 =A0  =
1.10=0A>=A0  bDeviceClass=A0 =A0 =A0 =A0 =A0 224 Wireless=0A>=A0  bDeviceSu=
bClass=A0 =A0 =A0 =A0  1 Radio Frequency=0A>=A0  bDeviceProtocol=A0 =A0 =A0=
 =A0  1 Bluetooth=0A>=A0  bMaxPacketSize0=A0 =A0 =A0 =A0 64=0A>=A0  idVendo=
r=A0 =A0 =A0 =A0 =A0  0x04ca Lite-On Technology Corp.=0A>=A0  idProduct=A0 =
=A0 =A0 =A0 =A0 0x3004 =0A>=A0  bcdDevice=A0 =A0 =A0 =A0 =A0 =A0 0.02=0A>=
=A0  iManufacturer=A0 =A0 =A0 =A0 =A0  1 Atheros Communications=0A> =0A> iP=
roduct=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2 Bluetooth USB Host Controller=0A>=
=A0  iSerial=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0  3 Alaska Day 2006=0A>=A0  bNum=
Configurations=A0 =A0 =A0 1=0A=0AI prefer /sys/kernel/debug/usb/devices out=
put here.=0A=0A> =0A> =0A> Signed-off-by: Dwaine Garden <DwaineGarden@roger=
s.com>=A0 ---=0A> =0A> diff --git a/drivers/bluetooth/ath3k.c b/drivers/blu=
etooth/ath3k.c=0A> index fc2de55..1486f15 100644=0A> --- a/drivers/bluetoot=
h/ath3k.c=0A> +++ b/drivers/bluetooth/ath3k.c=0A> @@ -75,6 +75,7 @@ static =
struct usb_device_id ath3k_table[] =3D {=0A> { USB_DEVICE(0x0CF3, 0x3004) }=
,=0A> { USB_DEVICE(0x0CF3, 0x311D) },=0A> { USB_DEVICE(0x13d3, 0x3375) },=
=0A> +=A0 =A0 { USB_DEVICE(0x04CA, 0x3004) },=0A=0AAnd you need to use an e=
mail client that does not mess up the tabs vs=0Awhite spaces.=0A=0ARegards=
=0A=0AMarcel
