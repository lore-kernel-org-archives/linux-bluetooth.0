Return-Path: <cyrus@holtmann.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH 5/9] mfd: Add UART support for the ST-Ericsson CG2900.
Date: Mon, 6 Dec 2010 15:06:04 +0100
Cc: "Par-Gunnar Hjalmdahl" <pghatwork@gmail.com>,
 Alan Cox <alan@lxorguk.ukuu.org.uk>,
 linus.walleij@stericsson.com,
 linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>
References: <AANLkTi=XTUau_GbASJEUBgsZ_FYYmRAX6W43YtRdv2wS@mail.gmail.com> <AANLkTik4T=PsMzB+umSQPLDPmeD-6sebgCtrQRePH_2h@mail.gmail.com> <AANLkTimjACtU_Mx5mDHkm9OpVJ4ueNWgZPsX3YjL0cTi@mail.gmail.com>
In-Reply-To: <AANLkTimjACtU_Mx5mDHkm9OpVJ4ueNWgZPsX3YjL0cTi@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201012061506.04364.arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 06 December 2010, Vitaly Wool wrote:

> On Mon, Dec 6, 2010 at 10:06 AM, Par-Gunnar Hjalmdahl
> <pghatwork@gmail.com> wrote:

> >> Isn't it better to have a new line discipline that the standard
> >> drivers (H4, LL, ...) will be applicable to?
> 
> > I'm not certain what you mean. We are modifying the line discipline a
> > bit, but the only thing we have needed to do with existing protocol
> > drivers has been to add a boolean parameter for the protocol settings
> > (so they will register to the Bluetooth stack). I don't see why we
> > should create a new line discipline driver and then move the existing
> > protocol drivers to this.
> 
> Okay, let me try to be more specific. There's for instance
> drivers/bluetooth/hci_ll.c which is the line discipline driver that is
> meant to work with any BT chip supporting LL protocol. Your solution
> seems to imply that one will have to create a variation of this
> implementation for each BT chip supporting LL that will use your
> shared transport implementation. Is it really the case?

hci_ll is not the line discipline but the a TI specific uart protocol.
The line discipline driver (hci_ldisc.c) is shared across all protocols
(h4, ll, ...) and gets extended slightly so it can deal with cg2900
in addition to the existing HCIs. The rest of the cg2900 support is
about adding more hci_uart_protos.

	Arnd
