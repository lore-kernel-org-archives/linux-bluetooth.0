Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar HJALMDAHL <par-gunnar.p.hjalmdahl@stericsson.com>
To: Vitaly Wool <vitalywool@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Pavan Savoy <pavan_savoy@sify.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	Par-Gunnar Hjalmdahl <pghatwork@gmail.com>
Date: Mon, 20 Dec 2010 10:15:37 +0100
Subject: RE: [PATCH 00/11] mfd and bluetooth: Add CG2900 support
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA3348A3A516@EXDCVYMBSTM005.EQ1STM.local>
References: <1292584829-28279-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
	<AANLkTimCYea+G7Z+o-2BDCGHbRobM2n+VJLLcDO6g=9d@mail.gmail.com>
 <AANLkTi=J1AdOgxA_S9p9Ts65PL3Mi5NXXWMf0f-=0AwN@mail.gmail.com>
In-Reply-To: <AANLkTi=J1AdOgxA_S9p9Ts65PL3Mi5NXXWMf0f-=0AwN@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vitaly,

> -----Original Message-----
> From: Vitaly Wool [mailto:vitalywool@gmail.com]
> Sent: den 19 december 2010 23:58
> To: Linus Walleij
> Cc: Par-Gunnar HJALMDAHL; Pavan Savoy; Alan Cox; Arnd Bergmann; Samuel
> Ortiz; Marcel Holtmann; linux-kernel@vger.kernel.org; linux-
> bluetooth@vger.kernel.org; Lukasz Rymanowski; Par-Gunnar Hjalmdahl
> Subject: Re: [PATCH 00/11] mfd and bluetooth: Add CG2900 support
>=20
> Hi Linus,
>=20
> On Sun, Dec 19, 2010 at 10:23 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
> > I'm slightly confused by different comment threads on this patch set.
>=20
> let me first first repost the part from Arnd's email on the
> architecture of the "shared transport" type of thing:
>=20
> > I believe we already agree it should be something like
> >
> >   bt   ti-radio    st-e-radio    ti-gps   st-e-gps  broadcom-radio
> ...
> >   |         |          |            |          |          |         |
> >   +---------+----------+---------+--+----------+----------+---------+
> >                                  |
> >                         common-hci-module
> >                                  |
> >                      +-----------+-----------+
> >                      |        |       |      |
> >                    serial    spi     i2c    ...
>=20
> I think an explanation on how the patchset from Par maps to this
> architecture could be a good starting point for confusion minimization
> :)
>=20
> Thanks,
>    Vitaly

I would say our design would map like this:
common-hci-module: cg2900_core
serial, spi, i2c,... : cg2900_uart together with hci_ldisc (for other trans=
ports it would be different files)
bt, ti-radio, st-e-radio,...: cg2900_chip together with btcg2900 and other =
users per channel (cg2900_char_devices for users in User space)
So it is not a 1-to-1 mapping for the upper parts. I would draw it like thi=
s:

                               bt   st-e-radio  st-e-gps
                                |         |          |
                                +---------+----------+
                                          |
                   ti-xx                st-e cg2900...
                     |                    |
                     +---------+----------+
                               |
                       common-hci-module
                               |
                   +-----------+-----------+
                   |        |       |      |
                 serial    spi     i2c    ...

The reason for this difference I've gone through before. Basically there ar=
e so many special behaviors and needed handling that is individual for each=
 chip (like startup and shutdown and in the case of CG2900 flow control ove=
r FM and BT channels for audio commands). If you then look at the users I g=
uess it would be possible to have one BT user, but it would have to be modi=
fied to handle vendor specific commands (as btcg2900 does with BT_ENABLE co=
mmand). As Arnd has drawn for FM and GPS the users would be completely indi=
vidual since they don't have a standardized  interface.

/P-G
