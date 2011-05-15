Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: linus.ml.walleij@gmail.com
In-Reply-To: <1305040215-712-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
References: <1305040215-712-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
Date: Sun, 15 May 2011 12:20:51 +0200
Message-ID: <BANLkTinAtUQ8H1DQpqXxX_U4mLO617L3Eg@mail.gmail.com>
Subject: Re: [PATCH v6] Add ST-Ericsson CG2900 driver
From: Linus Walleij <linus.walleij@linaro.org>
To: Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Pavan Savoy <pavan_savoy@sify.com>, Vitaly Wool <vitalywool@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Marcel Holtmann <marcel@holtmann.org>, Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	Par-Gunnar Hjalmdahl <pghatwork@gmail.com>, Lee Jones <lee.jones@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

2011/5/10 Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>:

> Patch created on next-20110510.
> Compared to v5 this patch has the following update:
> =A0- Updated driver after changes to MFD interfaces in linux-next (from m=
fd_data
> =A0 to platform_data).
> =A0- Changed platform specific file dependencies (included correct nomadi=
k file).

Sorry I don't know if all this will work, it's due to all the churn created=
 by
the current push to get stuff out of the ARM tree so not much to do.

The Nomadik GPIO file was moved in next but I will take that code move
out today, because the GPIO maintainer has told me he couldn't
provide feedback on these patches in time for me to finalize the change
for kernel 2.6.40. Thus it won't go into 2.6.40 and I must remove it
from next.

The MFD changes will *probably* happen, if you're thinking about the
PRCMU movement etc.

To merge into the staging tree right now, you need to base it off
Gregs staging tree, which is where it'll be merged:
http://git.kernel.org/?p=3Dlinux/kernel/git/gregkh/staging-2.6.git;a=3Dsumm=
ary

Sorry about all the confusion, I think it's actually nobodys fault,
it's just reflecting the fact that embedded drivers with deep
platform dependencies are *really* *hard* to manage in staging.
It works best for things like a standard-form driver on a local bus
(I2C, PCI, USB ...) without any bindings to a lot of platform stuff.

Maybe the device tree will fix all this. Sometime.

Yours,
Linus Walleij
