Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar HJALMDAHL <par-gunnar.p.hjalmdahl@stericsson.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Greg KH <gregkh@suse.de>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Pavan Savoy <pavan_savoy@sify.com>,
	Vitaly Wool <vitalywool@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	Par-Gunnar Hjalmdahl <pghatwork@gmail.com>,
	Lee Jones <lee.jones@linaro.org>
Date: Thu, 24 Mar 2011 12:45:54 +0100
Subject: RE: [PATCH 2/2] mach-ux500: Add CG2900 devices
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA334C52AB89@EXDCVYMBSTM005.EQ1STM.local>
References: <1300888803-26474-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
	<20110323142719.GA17369@suse.de>
 <AANLkTikZD5qie4y=tRpZXuea9D+_vDSGLMr+20p_PVkC@mail.gmail.com>
In-Reply-To: <AANLkTikZD5qie4y=tRpZXuea9D+_vDSGLMr+20p_PVkC@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Linus,

> > As this touches ARM specific code, I need an ack from the ARM
> maintainer
> > before I can take this through the staging tree. =A0Is there any way to
> > make it part of your drivers/staging/ submission? =A0There are other
> > examples in the staging tree already that do this, why not do that
> here
> > as well?
>=20
> Hm yeah maybe it's possible if you move devices-cg2900.*
> to staging/cg2900, then split off the stuff in board-mop500.c into
> some drivers/staging/cg2900/board-mop500-cg2900.c which
> adds the device in some proper initcall.
>=20
> Do you think it can be done P-G? I might have overestimated
> the work involved in moving that stuff to /staging.
>=20
> Yours,
> Linus Walleij

As Arnd requested yesterday, I can move most of devices-cg2900, maybe all,
to the staging folder (probably to cg2900_lib.c). I will then minimize
whatever is needed in board-mop500.c. I will see what I can do.

Thanks,
/P-G
