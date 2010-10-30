Return-Path: <cyrus@holtmann.org>
From: Arnd Bergmann <arnd@arndb.de>
To: "Par-Gunnar Hjalmdahl" <pghatwork@gmail.com>
Subject: Re: [PATCH 5/9] mfd: Add UART support for the ST-Ericsson CG2900.
Date: Sat, 30 Oct 2010 02:09:11 +0200
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linus.walleij@stericsson.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukasz.Rymanowski@tieto.com
References: <AANLkTi=XTUau_GbASJEUBgsZ_FYYmRAX6W43YtRdv2wS@mail.gmail.com> <AANLkTinh3D8V8UaN8FyCouwUQ98A4RRWEHXU7Tr9XMbs@mail.gmail.com> <AANLkTimyR7f=PdQbxxBLCnznTA4PT1TWEFiNX3C_qaZo@mail.gmail.com>
In-Reply-To: <AANLkTimyR7f=PdQbxxBLCnznTA4PT1TWEFiNX3C_qaZo@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201010300209.11220.arnd@arndb.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 29 October 2010, Par-Gunnar Hjalmdahl wrote:
> I might have been a bit too quick there.
> The actual channel matching and packet creation is done in hci_h4.c
> while ldisc registration is done in hci_ldisc.c.
> So it might to be enough to create a new hci_h4-cg2900.c (or similar
> name) that can separate the right channels.

That sounds good, but would that still be h4?

There are currently six UART protocols that have drivers in Linux:
H4, bcsp, 3Weire, h4ds, ll and ath3k.

Can cg2900 be simply another one of those, or is it different
from the others?

> We must however do changes
> to hci_ldisc as well since it seems to always register to the
> Bluetooth stack here, which we definitely don't want since that is
> handled by btcg2900.c.

Can you elaborate? You said earlier that cg2900 is a standard HCI
with some extensions. If that's the case, why do you need your own
btcg2900 driver to handle bluetooth instead of the regular hci code?

> Also note that this ldisc issue is only valid when using UART as
> transport. We will also support SPI and then we will probably run into
> completely new, interesting problems. :-)

Is the link layer on SPI different from the UART variant? Maybe you cna
just add a SPI TTY driver if that doesn't exist yet and bind the same
ldisc to the SPI device.

	Arnd
