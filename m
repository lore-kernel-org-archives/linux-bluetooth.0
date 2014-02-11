Return-Path: <cyrus@holtmann.org>
From: "Viswanatham, RaviTeja"
	<RaviTeja.Viswanatham.EDUCATION@eberspaecher.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>, Marcel Holtmann
	<marcel@holtmann.org>
CC: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Subject: AW: Bluetooth with full AMP 
Date: Tue, 11 Feb 2014 12:15:14 +0000
Message-ID: <9BC883E0D59F6B4DBD525D460025714B08AE363D@deessmx03.dees.eberspaecher.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>



-----Urspr=FCngliche Nachricht-----
Von: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vg=
er.kernel.org] Im Auftrag von Andrei Emeltchenko
Gesendet: Dienstag, 11. Februar 2014 08:13
An: Marcel Holtmann
Cc: Viswanatham, RaviTeja; bluez mailin list (linux-bluetooth@vger.kernel.o=
rg)
Betreff: Re:=20

Hi All,

On Mon, Feb 10, 2014 at 10:35:24AM -0800, Marcel Holtmann wrote:
> Hi Ravi,
>=20
> > I am working on Ubuntu 12.04 with a Bluetooth 3.0 +HS + wifi combo=20
> > USB dongle.
> >=20
> > I want to reach a data transfer speed of up to 24 Mbit/s.=20
> >=20
> > My Questions: Does Bluez support high speed data transfer rates up=20
> > to
> > 24 Mbit/s (Bluetooth 3.0+HS) ?=20
> >=20
> > If it does, is there any user configuration involved to achieve that?
> > What other requirements need to be met?  Does, Bluetooth enables AMP=20
> > function to communicate 802.11n channel to support high speed or it=20
> > has to be configure with any other drivers?
> >=20
> > I am new to Linux a detail explanation would be really appreciated.
> > Thank you in advance for your support.
>=20
> we do support Bluetooth HS operation. However your WiFi device needs=20
> to be exposed as AMP Controller. Most WiFi hardware needs a special=20
> driver to expose itself as AMP Controller. There is no generic driver=20
> for
> mac80211 subsystem in the kernel.

Some devices have AMP Controller implemented in firmware.
I was using Marvell SD8787, probably newer Marvell devices also works.

You may check drivers/bluetooth/btmrvl_main.c to see how HCI dev_type HCI_A=
MP is assigned.

Best regards
Andrei Emeltchenko=20

Hello Andrei Emelchenko,

Thanks for replying me. I would like to know some more information about th=
e Bluetooth dongle. As you said the Marvell SD8787 is kind of a SoC chipset=
. Is there any USB Bluetooth  device available in the market which supports=
 out of the box.  I am running 3.11 kernel and I already build the Marvell =
option inside the kernel.=20

Is there any dongles available in the market which supports full AMP. If no=
t are there any other possibilities to fix the Marvell driver with the exis=
ting dongle. Please any hints as I am working on ARM board I need to fix th=
e USB Bluetooth device which can transfer with high speed.=20

Thanks in advance.=20

Regards,
Raviteja=20



--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" =
in the body of a message to majordomo@vger.kernel.org More majordomo info a=
t  http://vger.kernel.org/majordomo-info.html
