Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1292585094-28544-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
References: <1292585094-28544-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
Date: Fri, 17 Dec 2010 12:40:34 +0100
Message-ID: <AANLkTi=f6XPbsUiTSiFru2tj_XsQSu=-h898b0R2AePo@mail.gmail.com>
Subject: Re: [PATCH 07/11] Bluetooth: Add UART API functions to ldisc
From: Vitaly Wool <vitalywool@gmail.com>
To: Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>
Cc: Pavan Savoy <pavan_savoy@sify.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, Samuel Ortiz <sameo@linux.intel.com>,
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>, Linus Walleij <linus.walleij@stericsson.com>,
	Par-Gunnar Hjalmdahl <pghatwork@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Par,

On Fri, Dec 17, 2010 at 12:24 PM, Par-Gunnar Hjalmdahl
<par-gunnar.p.hjalmdahl@stericsson.com> wrote:
> This patch adds new functions to control break and flow
> as well as changing UART baud rate directly through the ldisc API
> rather then using the TTY API directly.

What do you need that for?

> It also adds a boolean parameter so it is optional to register
> to the Bluetooth stack (for drivers where a separate module
> registers to the Bluetooth stack instead).

I never liked this idea and I don't like it now as it scatters the
changes needed to support devices you are aiming to support with your
changes.

Thanks,
   Vitaly
