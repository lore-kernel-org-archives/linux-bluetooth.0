Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110510200801.GA8125@kroah.com>
References: <1305040232-750-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
	<20110510200801.GA8125@kroah.com>
Date: Wed, 11 May 2011 02:07:33 +0200
Message-ID: <BANLkTimimx-pW9mOtb_9yM5XcQ5nOeGYug@mail.gmail.com>
Subject: Re: [PATCH v6] staging: Add ST-Ericsson CG2900 driver
From: Linus Walleij <linus.ml.walleij@gmail.com>
To: Greg KH <greg@kroah.com>,
	Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Pavan Savoy <pavan_savoy@sify.com>, Vitaly Wool <vitalywool@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Marcel Holtmann <marcel@holtmann.org>, Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	Par-Gunnar Hjalmdahl <pghatwork@gmail.com>, Lee Jones <lee.jones@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

2011/5/10 Greg KH <greg@kroah.com>:

> On Tue, May 10, 2011 at 05:10:32PM +0200, Par-Gunnar Hjalmdahl wrote:
>> This patch adds support for the ST-Ericsson CG2900
>> Connectivity Combo controller (Bluetooth, FM, GPS).
>>
>> Signed-off-by: Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> {sigh}
>
> This breaks the build again, the error messages are below :(

I suspect the problem is that Per-Gunnar does not know how to reproduce
your build errors. Are you building for some x86 combination, allyes, etc
for example? This is likely currently only tested and applicable for ux500
so a simple  "depends on ARCH_U8500" under config CG2900 may solve
stuff.

Yours,
Linus Walleij
