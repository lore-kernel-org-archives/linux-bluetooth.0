Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: linus.ml.walleij@gmail.com
In-Reply-To: <20110323142719.GA17369@suse.de>
References: <1300888803-26474-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
	<20110323142719.GA17369@suse.de>
Date: Wed, 23 Mar 2011 18:55:28 +0100
Message-ID: <AANLkTikZD5qie4y=tRpZXuea9D+_vDSGLMr+20p_PVkC@mail.gmail.com>
Subject: Re: [PATCH 2/2] mach-ux500: Add CG2900 devices
From: Linus Walleij <linus.walleij@linaro.org>
To: Greg KH <gregkh@suse.de>,
	Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, Pavan Savoy <pavan_savoy@sify.com>,
	Vitaly Wool <vitalywool@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, Marcel Holtmann <marcel@holtmann.org>,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>, Par-Gunnar Hjalmdahl <pghatwork@gmail.com>,
	Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

2011/3/23 Greg KH <gregkh@suse.de>:

>> =A0arch/arm/mach-ux500/Makefile =A0 =A0 =A0 =A0 | =A0 =A04 +
>> =A0arch/arm/mach-ux500/board-mop500.c =A0 | =A0160 ++++++++++++++++
>> =A0arch/arm/mach-ux500/devices-cg2900.c | =A0349 +++++++++++++++++++++++=
+++++++++++
>> =A0arch/arm/mach-ux500/devices-cg2900.h | =A0 19 ++
>> =A04 files changed, 532 insertions(+), 0 deletions(-)
>> =A0create mode 100644 arch/arm/mach-ux500/devices-cg2900.c
>> =A0create mode 100644 arch/arm/mach-ux500/devices-cg2900.h
>
> As this touches ARM specific code, I need an ack from the ARM maintainer
> before I can take this through the staging tree. =A0Is there any way to
> make it part of your drivers/staging/ submission? =A0There are other
> examples in the staging tree already that do this, why not do that here
> as well?

Hm yeah maybe it's possible if you move devices-cg2900.*
to staging/cg2900, then split off the stuff in board-mop500.c into
some drivers/staging/cg2900/board-mop500-cg2900.c which
adds the device in some proper initcall.

Do you think it can be done P-G? I might have overestimated
the work involved in moving that stuff to /staging.

Yours,
Linus Walleij
