Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC PATCH 0/3] UART slave device bus
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20160820143405.04303834@lxorguk.ukuu.org.uk>
Date: Sun, 21 Aug 2016 09:50:57 +0200
Cc: Oleksij Rempel <linux@rempel-privat.de>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Hurley <peter@hurleysoftware.com>,
        NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <B4DF8974-1C6B-432E-AD1A-1E6067B9C158@goldelico.com>
References: <20160818011445.22726-1-robh@kernel.org> <20160818202900.hyvm4hfxedifuefn@earth> <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com> <20160819052125.ze5zilppwoe3f2lx@earth> <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com> <efcd1fe0-52f8-ba84-1310-9f4c24ad35bc@rempel-privat.de> <53A846F1-33E5-48C3-B3A6-DB251661CDD5@goldelico.com> <20160820143405.04303834@lxorguk.ukuu.org.uk>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> Am 20.08.2016 um 15:34 schrieb One Thousand Gnomes =
<gnomes@lxorguk.ukuu.org.uk>:
>> What it is not about are UART/RS232 converters connected through USB =
or virtual
>> serial ports created for WWAN modems (e.g. /dev/ttyACM, /dev/ttyHSO). =
Or BT devices
>> connected through USB (even if they also run HCI protocol).
>=20
> It actually has to be about both because you will find the exact same
> device wired via USB SSIC/HSIC to a USB UART or via a classic UART. =
Not is
> it just about embedded boards.=20

Not necessarily.

We often have two interface options for exactly the sam sensor chips. =
They can be connected
either through SPI or I2C. Which means that there is a core driver for =
the chip and two different
transport glue components (see e.g. iio/accel/bmc150).

This does not require I2C to be able to handle SPI or vice versa or =
provide a common API.

And most Bluetooth devices I know have either UART or a direct USB =
interface. So in the
USB case there is no need to connect it through some USB-UART bridge and =
treat it as
an UART at all.

BR,
Nikolaus

