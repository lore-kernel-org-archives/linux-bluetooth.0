Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar HJALMDAHL <par-gunnar.p.hjalmdahl@stericsson.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Linus WALLEIJ <linus.walleij@stericsson.com>,
	Arnd Bergmann <arnd@arndb.de>, Vitaly Wool <vitalywool@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Pavan Savoy <pavan_savoy@sify.com>, Lee Jones <lee.jones@linaro.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Par-Gunnar Hjalmdahl <pghatwork@gmail.com>
Date: Wed, 23 Mar 2011 16:26:42 +0100
Subject: RE: [PATCH 1/2] staging: Add ST-Ericsson CG2900 driver
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA334C4DE8B7@EXDCVYMBSTM005.EQ1STM.local>
References: <1300888771-26437-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
 <20110323082002.bd60cea1.rdunlap@xenotime.net>
In-Reply-To: <20110323082002.bd60cea1.rdunlap@xenotime.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Randy,

> > +
> > +config CG2900_AUDIO
> > +	tristate "Support CG2900 audio interface"
> > +	depends on CG2900
> > +	help
> > +	  Support for ST-Ericsson CG2900 Connectivity audio
> interface. Gives a
> > +	  module the ability to setup audio paths within the CG2900
> controller.
> > +
>=20
> Just to be clear:  the cg2900_audio driver does not use any current
> kernel
> sound/audio interfaces, right?
>=20

No, it provides an interface to the audio features within the chip.
So it is rather used by other sound/audio drivers, but it never
use any sound/audio interfaces itself.

Thanks,
/P-G
