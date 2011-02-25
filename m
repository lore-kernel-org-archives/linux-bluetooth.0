Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: linus.ml.walleij@gmail.com
In-Reply-To: <AFCDDB4A3EA003429EEF1E7B211FDBBA334C0FB0E2@EXDCVYMBSTM005.EQ1STM.local>
References: <1292584829-28279-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
	<201101061946.04790.arnd@arndb.de>
	<AANLkTikJMx2QxYwXS_TrKK5hcnD3G0MNvEiDO+xAZrpo@mail.gmail.com>
	<201101091955.05174.arnd@arndb.de>
	<AFCDDB4A3EA003429EEF1E7B211FDBBA334C0FB0E2@EXDCVYMBSTM005.EQ1STM.local>
Date: Fri, 25 Feb 2011 18:08:16 +0100
Message-ID: <AANLkTi=HvRTfo84L_VwOVtVq5hfb1g+9ueH6SX8FWF2b@mail.gmail.com>
Subject: Re: [PATCH 00/11] mfd and bluetooth: Add CG2900 suppor
From: Linus Walleij <linus.walleij@linaro.org>
To: Par-Gunnar HJALMDAHL <par-gunnar.p.hjalmdahl@stericsson.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Pavan Savoy <pavan_savoy@sify.com>,
	Vitaly Wool <vitalywool@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcel Holtmann <marcel@holtmann.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>, Par-Gunnar Hjalmdahl <pghatwork@gmail.com>,
	Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

2011/2/24 Par-Gunnar HJALMDAHL <par-gunnar.p.hjalmdahl@stericsson.com>:

> I sent the mail below one month ago, but have still not received any answ=
ers or further comments.
> Has anyone of you who made comments on the CG2900 patches earlier, any mo=
re comments or questions?

I think I have provided
Acked-by: Linus Walleij <linus.walleij@linaro.org>
(or the earlier ST-Ericsson address, which is equal) for these patches.
Else I do so now.

FWIW: I think those who want another architectural solution
can propose a refactoring patch any day they like, and if it's
recieved like "ah, that's better" ACK from P=E4r-Gunnar et al, then
it's no big deal.

This makes the hardware work with 2.6.39 which is really most
important IMO, Sam can you merge this as it stands?

Yours,
Linus Walleij
