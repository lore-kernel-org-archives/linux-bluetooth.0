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
Date: Fri, 17 Dec 2010 13:43:42 +0100
Subject: RE: [PATCH 00/11] mfd and bluetooth: Add CG2900 support
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA33489D2B94@EXDCVYMBSTM005.EQ1STM.local>
References: <1292584829-28279-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
 <AANLkTikboaQGMGTVchXyo6tidtq7c33KDRU2puL1youv@mail.gmail.com>
In-Reply-To: <AANLkTikboaQGMGTVchXyo6tidtq7c33KDRU2puL1youv@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vitaly,

> -----Original Message-----
> From: Vitaly Wool [mailto:vitalywool@gmail.com]
> Sent: den 17 december 2010 13:11
> To: Par-Gunnar HJALMDAHL
> Cc: Pavan Savoy; Alan Cox; Arnd Bergmann; Samuel Ortiz; Marcel
> Holtmann; linux-kernel@vger.kernel.org; linux-
> bluetooth@vger.kernel.org; Lukasz Rymanowski; Linus WALLEIJ; Par-Gunnar
> Hjalmdahl
> Subject: Re: [PATCH 00/11] mfd and bluetooth: Add CG2900 support
>=20
> Hi Par,
>=20
> On Fri, Dec 17, 2010 at 12:20 PM, Par-Gunnar Hjalmdahl
> <par-gunnar.p.hjalmdahl@stericsson.com> wrote:
> > This is the 3rd patch set for the ST-Ericsson CG2900 connectivity
> > controller. The CG2900 is a combo controller supporting GPS,
> Bluetooth,
> > and FM radio. It uses HCI H:4 protocol to combine different
> functionalities
> > on a common transport, where first byte in the data indicates the
> current
> > channel. Channels 1-4 are standardized in the Bluetooth Core
> specification
> > while the other channels are vendor specific.
> >
> > Compared to 2nd patch set this patch set has the following changes:
> > =A0* UART handling is moved from mfd to bluetooth folder. It now reuses
> the
> > =A0 existing N_HCI line discipline.
> > =A0* mfd creation has been moved from cg2900_core into chip specific
> files.
> > =A0* All information for each channel, including API functions, exist
> in each
> > =A0 MFD devices, making them independent of each other.
> > =A0* All chip specific information has been moved from cg2900_core into
> the
> > =A0 chip specific files. cg2900_core now only handles registration and
> > =A0 connection between transport and chip driver.
> > =A0* Fixes for several review comments including use of existing debug
> system.
>=20
> this patchset has only multiplied my confusion.
>=20
> Not really diving into the details, I'm just trying to understand how
> I'd rewrite the TI shared transport using your approach if I had to.
> It looks like I'd have to, at least:
>  - implement a heavyweight line discipline driver (like cg2900_uart.c)
> half duplicating the functionality in yours;
>  - implement specific MFD driver.
>=20
> Actually the reuse of this implementation will be at a level of
> statistics error. The only thing to reuse is actually the approach
> which I'm not really happy about.
>=20
> So...
>=20
> If you are aiming for a generic solution, then why you get more and
> more things handled in cg2900-specific code (e. g. packet routing
> which is fairly generic)?
>=20

You are absolutely correct that there is not much that is generic and the r=
eason for this is that it is not much that is generic. If you for example l=
ook at packet routing the method can be considered pretty generic. Check fi=
rst byte and choose a structure type... But first of all this must be done =
with minimum overhead since it is done on every packet received. And second=
ly if you look at number of lines of code, it is not really much you save.
If you look closer at the code for the CG2900 you will see that the majorit=
y of the code is things that you could probably never apply to the chip of =
another vendor. A lot of the code in e.g. cg2900_chip.c is regarding bt_aud=
io and fm_audio, which is really chip specific.
Also, if you want to keep the structure modular and supporting e.g. multipl=
e transports with the same chip driver, you must focus on what is chip spec=
ific, what is transport specific, and what is chip and transport specific. =
When you start to think about it like this it becomes very hard to make too=
 much code generic. Usually what you get with that kind of generic code is =
a solution way more complex than you started out with.

> If you are solving your particular problems, isn't the change too
> dramatic e. g. when it comes to line discipline drivers and baudrate
> manipulation?
>=20

The changes in hci_ldisc.c is not what I would call dramatic. It is quite s=
imple functions. As I've stated earlier, if people object to this, there is=
 no big issue to solve this within cg2900_uart.c instead. But we think that=
 these API functions are a proper extension to the current hci_ldisc API.

> As of now, I really see no reason why anyone would promote this
> solution instead of making something more generic out of ti-st and
> reusing it then.
>=20
> Thanks,
>    Vitaly

Just to be clear, I have no problem with having both solutions (our and ti-=
st) side by side. They are structured quite differently and has different f=
ocus. I'm in no way trying to replace ti-st. I'm not trying to force anyone=
 into using our structure.

/P-G
