Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar HJALMDAHL <par-gunnar.p.hjalmdahl@stericsson.com>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Pavan Savoy <pavan_savoy@sify.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	Linus WALLEIJ <linus.walleij@stericsson.com>,
	Par-Gunnar Hjalmdahl <pghatwork@gmail.com>
Date: Fri, 17 Dec 2010 13:17:35 +0100
Subject: RE: [PATCH 07/11] Bluetooth: Add UART API functions to ldisc
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA33489D2B4F@EXDCVYMBSTM005.EQ1STM.local>
References: <1292585094-28544-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
 <AANLkTi=f6XPbsUiTSiFru2tj_XsQSu=-h898b0R2AePo@mail.gmail.com>
In-Reply-To: <AANLkTi=f6XPbsUiTSiFru2tj_XsQSu=-h898b0R2AePo@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vitaly,

> -----Original Message-----
> From: Vitaly Wool [mailto:vitalywool@gmail.com]
> Sent: den 17 december 2010 12:41
> To: Par-Gunnar HJALMDAHL
> Cc: Pavan Savoy; Alan Cox; Arnd Bergmann; Samuel Ortiz; Marcel
> Holtmann; linux-kernel@vger.kernel.org; linux-
> bluetooth@vger.kernel.org; Lukasz Rymanowski; Linus WALLEIJ; Par-Gunnar
> Hjalmdahl
> Subject: Re: [PATCH 07/11] Bluetooth: Add UART API functions to ldisc
>=20
> Hi Par,
>=20
> On Fri, Dec 17, 2010 at 12:24 PM, Par-Gunnar Hjalmdahl
> <par-gunnar.p.hjalmdahl@stericsson.com> wrote:
> > This patch adds new functions to control break and flow
> > as well as changing UART baud rate directly through the ldisc API
> > rather then using the TTY API directly.
>=20
> What do you need that for?
>=20

For the break and flow control it is a means for the protocol driver to set=
 break and flow using only the hci_uart structure, i.e. without interfacing=
 directly towards tty. This is of course not 100% necessary to make it work=
, but it means a clean API where the protocol drivers can perform their tas=
ks without performing different operations on different stack levels. As it=
 was before write was performed using hci_uart structure while flow control=
 was done using tty structure and API, even though you could consider these=
 functions to be similar (not in functionality of course but from a stack l=
evel perspective).

For baud rate changes it also simplifies handling a bit, since the new func=
tion also implements using the proper mutexes and calling right termios fun=
ctions. It should work simply (as long as you don't want different baud rat=
es for TX and RX which should be pretty rare).

> > It also adds a boolean parameter so it is optional to register
> > to the Bluetooth stack (for drivers where a separate module
> > registers to the Bluetooth stack instead).
>=20
> I never liked this idea and I don't like it now as it scatters the
> changes needed to support devices you are aiming to support with your
> changes.
>=20

OK. Sadly I can't do much about how you feel towards the change. In my opin=
ion this is probably the best reuse we can get of existing protocols and pa=
rts. There is so much that is vendor specific if you look at for example cg=
2900_uart.c that it is not much you could do generic.

> Thanks,
>    Vitaly
