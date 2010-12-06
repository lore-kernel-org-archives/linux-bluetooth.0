Return-Path: <cyrus@holtmann.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH 5/9] mfd: Add UART support for the ST-Ericsson CG2900.
Date: Mon, 6 Dec 2010 16:15:27 +0100
Cc: "Par-Gunnar Hjalmdahl" <pghatwork@gmail.com>,
 Alan Cox <alan@lxorguk.ukuu.org.uk>,
 linus.walleij@stericsson.com,
 linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>
References: <AANLkTi=XTUau_GbASJEUBgsZ_FYYmRAX6W43YtRdv2wS@mail.gmail.com> <201012061506.04364.arnd@arndb.de> <AANLkTikUeH2BL3svwydt1kGGuzn7C8QxiqRqMZPXHhZ_@mail.gmail.com>
In-Reply-To: <AANLkTikUeH2BL3svwydt1kGGuzn7C8QxiqRqMZPXHhZ_@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201012061615.28093.arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 06 December 2010, Vitaly Wool wrote:
> On Mon, Dec 6, 2010 at 3:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > hci_ll is not the line discipline but the a TI specific uart protocol.
> > The line discipline driver (hci_ldisc.c) is shared across all protocols
> > (h4, ll, ...) and gets extended slightly so it can deal with cg2900
> > in addition to the existing HCIs. The rest of the cg2900 support is
> > about adding more hci_uart_protos.
> 
> I was referring to hci_ll as to the line discipline driver, not the
> line discipline itself.
> 
> The thing is, there are different Bluetooth combo chips which use HCI
> to encapsulate commands to the sub-chips behind, and there's also the
> implementation for TI chip doing that which is in the mainline. So
> instead of keeping reinventing the wheel, I think it's fairly
> beneficial for everything if we finally agree on something that works
> for all the combo chips of the type.

Yes, that makes sense. I'm probably missing something here, but
it seems to me that hci_ll is only about the power management stuff
on TI (and broadcom, as you say) chips, and the multi-protocol
support is currently handled in hci_ldisc by allowing multiple
protocols like h4 and ll to be registered. It that correct?

One aspect that Par-Gunnar mentioned was that the multi-protocol
stuff for cg2900 and I suspect other similar devices would also
need to work with non-UART-based HCIs, which don't use hci_uart_proto
but would need something similar. Also, hci_uart is currently not
modular, e.g. you cannot build hci_ll as a loadable module
as you'd need for dynamic registration.

	Arnd
