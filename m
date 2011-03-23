Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar HJALMDAHL <par-gunnar.p.hjalmdahl@stericsson.com>
To: Greg KH <gregkh@suse.de>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
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
	Lee Jones <lee.jones@linaro.org>
Date: Wed, 23 Mar 2011 15:35:27 +0100
Subject: RE: [PATCH 2/2] mach-ux500: Add CG2900 devices
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA334C4DE825@EXDCVYMBSTM005.EQ1STM.local>
References: <1300888803-26474-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
 <20110323142719.GA17369@suse.de>
In-Reply-To: <20110323142719.GA17369@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Greg,

> -----Original Message-----
> From: Greg KH [mailto:gregkh@suse.de]
> Sent: den 23 mars 2011 15:27
> To: Par-Gunnar HJALMDAHL
> Cc: devel@driverdev.osuosl.org; Linus Walleij; linux-
> kernel@vger.kernel.org; linux-bluetooth@vger.kernel.org; Pavan Savoy;
> Vitaly Wool; Alan Cox; Arnd Bergmann; Marcel Holtmann; Lukasz
> Rymanowski; Linus WALLEIJ; Par-Gunnar Hjalmdahl; Lee Jones
> Subject: Re: [PATCH 2/2] mach-ux500: Add CG2900 devices
>=20
> On Wed, Mar 23, 2011 at 03:00:03PM +0100, Par-Gunnar Hjalmdahl wrote:
> > This patch adds the board specific data for the CG2900
> > driver on a UX500 board.
> >
> > Signed-off-by: Par-Gunnar Hjalmdahl <par-
> gunnar.p.hjalmdahl@stericsson.com>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  arch/arm/mach-ux500/Makefile         |    4 +
> >  arch/arm/mach-ux500/board-mop500.c   |  160 ++++++++++++++++
> >  arch/arm/mach-ux500/devices-cg2900.c |  349
> ++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-ux500/devices-cg2900.h |   19 ++
> >  4 files changed, 532 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-ux500/devices-cg2900.c
> >  create mode 100644 arch/arm/mach-ux500/devices-cg2900.h
>=20
> As this touches ARM specific code, I need an ack from the ARM
> maintainer
> before I can take this through the staging tree.  Is there any way to
> make it part of your drivers/staging/ submission?  There are other
> examples in the staging tree already that do this, why not do that here
> as well?
>=20
> thanks,
>=20
> greg k-h

I've been discussing this with Linus Walleij, who is the maintainer of
arch/arm/mach-ux500.
He suggested that I should let this be a separate patch and that I
should include it in the same patch set where he would pick the patch
from it.
I guess he will respond soon since he's on cc.

/P-G
