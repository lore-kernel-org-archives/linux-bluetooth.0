Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar HJALMDAHL <par-gunnar.p.hjalmdahl@stericsson.com>
To: Greg KH <greg@kroah.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Pavan Savoy <pavan_savoy@sify.com>,
	Vitaly Wool <vitalywool@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	Linus WALLEIJ <linus.walleij@stericsson.com>,
	Par-Gunnar Hjalmdahl <pghatwork@gmail.com>,
	Lee Jones <lee.jones@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 5 Apr 2011 10:28:22 +0200
Subject: RE: [PATCH v3] staging: Add ST-Ericsson CG2900 driver
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA3393929516@EXDCVYMBSTM005.EQ1STM.local>
References: <1301399358-10783-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
 <20110405060844.GA15065@kroah.com>
In-Reply-To: <20110405060844.GA15065@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: den 5 april 2011 08:09
> > +config CG2900_UART
> > +	tristate "Support CG2900 UART transport"
> > +	depends on CG2900
> > +	select BT
> > +	select BT_HCIUART
>=20
> No, depend on this, don't have a staging driver select any other config
> options, sorry.
>=20
> Care to fix this up, and your drivers/staging/Kconfig fuzz in the patch
> and resend it?
>=20
> thanks,
>=20
> greg k-h

This is code left from the non-staging state. I will update and resend.

Thanks,
P-G
