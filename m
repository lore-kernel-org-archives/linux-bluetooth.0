Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar HJALMDAHL <par-gunnar.p.hjalmdahl@stericsson.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Vitaly Wool <vitalywool@gmail.com>,
	Par-Gunnar Hjalmdahl <pghatwork@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Lee Jones <lee.jones@linaro.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	Pavan Savoy <pavan_savoy@sify.com>
Date: Tue, 1 Mar 2011 15:02:56 +0100
Subject: RE: [PATCH 00/11] mfd and bluetooth: Add CG2900 suppor
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA334C187A7F@EXDCVYMBSTM005.EQ1STM.local>
References: <1292584829-28279-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
	<201101061946.04790.arnd@arndb.de>
	<AANLkTikJMx2QxYwXS_TrKK5hcnD3G0MNvEiDO+xAZrpo@mail.gmail.com>
	<201101091955.05174.arnd@arndb.de>
	<AFCDDB4A3EA003429EEF1E7B211FDBBA334C0FB0E2@EXDCVYMBSTM005.EQ1STM.local>
	<AANLkTi=HvRTfo84L_VwOVtVq5hfb1g+9ueH6SX8FWF2b@mail.gmail.com>
	<AANLkTik3hiNj7=K+uE6eQW2CokZtCz7Zwvt-+6PkD_Mo@mail.gmail.com>
 <AANLkTimcBL6D7bGGt-QSWDEE=nnpK0hy1CQZK_JEmEYA@mail.gmail.com>
In-Reply-To: <AANLkTimcBL6D7bGGt-QSWDEE=nnpK0hy1CQZK_JEmEYA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

As you say, I think it could be good to put it into staging so we have a dr=
iver in place and then we can continue discussing the architecture from the=
re.

/P-G

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij@linaro.org]
> Sent: den 28 februari 2011 23:44
> To: Vitaly Wool; Par-Gunnar Hjalmdahl
> Cc: Par-Gunnar HJALMDAHL; Samuel Ortiz; Marcel Holtmann; Lee Jones;
> Alan Cox; Arnd Bergmann; linux-bluetooth@vger.kernel.org; linux-
> kernel@vger.kernel.org; Lukasz Rymanowski; Pavan Savoy
> Subject: Re: [PATCH 00/11] mfd and bluetooth: Add CG2900 suppor
>=20
> On Fri, Feb 25, 2011 at 6:55 PM, Vitaly Wool <vitalywool@gmail.com>
> wrote:
>=20
> > Making hardware work is, if course, a valid point, but porting a
> windows
> > driver would do that as well, and it's not the reason to pull windows
> > drivers' ports into mainline.
>=20
> Yeah hm, that sounds like it has "drivers/staging" printed all over it
> then,
> so either we solve these issues or we need to put it into staging so we
> can get help from others in fixing it up (we have a similar situation
> with
> the U8500 graphics stuff).
>=20
> P-G do you think it would be proper to take this into staging for the
> moment, or do you prefer to drive it outside the mainline kernel tree
> until
> it lands in the proper place(s)?
>=20
> Yours,
> Linus Walleij
