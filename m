Return-Path: <cyrus@holtmann.org>
From: "Viswanatham, RaviTeja"
	<RaviTeja.Viswanatham.EDUCATION@eberspaecher.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>, "bluez mailin list
 (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>,
	"bzhao@marvell.com" <bzhao@marvell.com>
Subject: AW: Bluetooth with full AMP
Date: Tue, 11 Feb 2014 13:38:46 +0000
Message-ID: <9BC883E0D59F6B4DBD525D460025714B08AE368D@deessmx03.dees.eberspaecher.com>
References: <9BC883E0D59F6B4DBD525D460025714B08AE363D@deessmx03.dees.eberspaecher.com>
 <20140211122616.GF8980@aemeltch-MOBL1>
In-Reply-To: <20140211122616.GF8980@aemeltch-MOBL1>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>



-----Urspr=FCngliche Nachricht-----
Von: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vg=
er.kernel.org] Im Auftrag von Andrei Emeltchenko
Gesendet: Dienstag, 11. Februar 2014 13:27
An: Viswanatham, RaviTeja
Cc: Marcel Holtmann; bluez mailin list (linux-bluetooth@vger.kernel.org); b=
zhao@marvell.com
Betreff: Re: Bluetooth with full AMP

Hi Raviteja,

> On Mon, Feb 10, 2014 at 10:35:24AM -0800, Marcel Holtmann wrote:
> > Hi Ravi,
> >=20
> > > I am working on Ubuntu 12.04 with a Bluetooth 3.0 +HS + wifi combo=20
> > > USB dongle.
> > >=20
> > > I want to reach a data transfer speed of up to 24 Mbit/s.=20
> > >=20
> > > My Questions: Does Bluez support high speed data transfer rates up=20
> > > to
> > > 24 Mbit/s (Bluetooth 3.0+HS) ?=20
> > >=20
> > > If it does, is there any user configuration involved to achieve that?
> > > What other requirements need to be met?  Does, Bluetooth enables=20
> > > AMP function to communicate 802.11n channel to support high speed=20
> > > or it has to be configure with any other drivers?
> > >=20
> > > I am new to Linux a detail explanation would be really appreciated.
> > > Thank you in advance for your support.
> >=20
> > we do support Bluetooth HS operation. However your WiFi device needs=20
> > to be exposed as AMP Controller. Most WiFi hardware needs a special=20
> > driver to expose itself as AMP Controller. There is no generic=20
> > driver for mac80211 subsystem in the kernel.
>=20
> Some devices have AMP Controller implemented in firmware.  I was using=20
> Marvell SD8787, probably newer Marvell devices also works.
>=20
> You may check drivers/bluetooth/btmrvl_main.c to see how HCI dev_type=20
> HCI_AMP is assigned.
>=20
> Thanks for replying me. I would like to know some more information=20
> about the Bluetooth dongle. As you said the Marvell SD8787 is kind of=20
> a SoC chipset. Is there any USB Bluetooth  device available in the=20
> market which supports out of the box.

The only possibility I know is Marvell development board like:
http://avnetexpress.avnet.com/store/em/EMController/Development-Kits/Marvel=
l/RD-88W-SD-8787-A0/_/R-10001817/A-10001817/An-0?action=3Dpart&catalogId=3D=
500201&langId=3D-1&storeId=3D500201


> I am running 3.11 kernel and I already build the Marvell option inside=20
> the kernel.
>=20
> Is there any dongles available in the market which supports full AMP.=20

At least I couldn't find one. If you find it let us know ;)

> If
> not are there any other possibilities to fix the Marvell driver with=20
> the existing dongle. Please any hints as I am working on ARM board I=20
> need to fix the USB Bluetooth device which can transfer with high speed.
>=20

Try to contact Marvell and ask which one supports FullAMP.

Thanks for the reply. I will try to find out about the hardware while conta=
cting Marvell. :)

I bought a USB Bluetooth 3.0 HS + wlan combo dongle. The wlan driver is bas=
ed on realtek8192cu  in the mailing list they mentioned it is based on soft=
 AMP. I found that the realtek they didn't upgrade new driver which support=
s new kernel (3.11 and above). =20

As I understood that Marvell they developed the driver with the FullAMP so =
that the device can run  with high speed. In the same way is there any othe=
r possibilities drivers or else patches available. Any suggestion or hint c=
ould be really appreciated.=20

Thanks in advance,
=20
Regards,
Raviteja
