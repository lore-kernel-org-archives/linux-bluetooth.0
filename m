Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar HJALMDAHL <par-gunnar.p.hjalmdahl@stericsson.com>
To: Greg KH <gregkh@suse.de>, Arnd Bergmann <arnd@arndb.de>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Pavan Savoy <pavan_savoy@sify.com>,
	Vitaly Wool <vitalywool@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcel Holtmann <marcel@holtmann.org>,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	Linus WALLEIJ <linus.walleij@stericsson.com>,
	Par-Gunnar Hjalmdahl <pghatwork@gmail.com>,
	Lee Jones <lee.jones@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 28 Mar 2011 16:29:44 +0200
Subject: RE: [PATCH v2 2/2] mach-ux500: Add CG2900 devices
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA3377B51A1F@EXDCVYMBSTM005.EQ1STM.local>
References: <1301302992-10671-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
 <201103281500.38954.arnd@arndb.de> <20110328141237.GB19350@suse.de>
In-Reply-To: <20110328141237.GB19350@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

> >
> > Not exactly what I had in mind, but probably good enough for a start.
> > This adds a dependency from core code to the staging driver now,
> > which shouldn't be there. I suppose we can add
> >
> > "Clean up device registration path to register the main device from
> board code"
> >
> > to the TODO file.
>=20
> No, please do not make any core code dependant on a staging driver,
> this
> isn't ok, it needs to be stand-alone, or at the least, the rest of the
> kernel needs to be able to be built with no staging drivers enabled.
>=20
> thanks,
>=20
> greg k-h

But how should I then do this? As I understood it I was told that I should
call an init function, but I was not allowed to add any staging folder
inclusion in the board config makefile. And now I can't do any extern
declaration either. I don't really see how I could do it then.

The only thing I can think of is to use platform device and driver for
the cg2900_init. But I wouldn't call that to call an init-function, but tha=
t
might be OK for this purpose?

Thanks,
P-G
