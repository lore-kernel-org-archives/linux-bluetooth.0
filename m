Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: linus.ml.walleij@gmail.com
In-Reply-To: <1292584829-28279-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
References: <1292584829-28279-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
Date: Sun, 19 Dec 2010 22:23:32 +0100
Message-ID: <AANLkTimCYea+G7Z+o-2BDCGHbRobM2n+VJLLcDO6g=9d@mail.gmail.com>
Subject: Re: [PATCH 00/11] mfd and bluetooth: Add CG2900 support
From: Linus Walleij <linus.walleij@linaro.org>
To: Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>
Cc: Pavan Savoy <pavan_savoy@sify.com>, Vitaly Wool <vitalywool@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Samuel Ortiz <sameo@linux.intel.com>, Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>, Par-Gunnar Hjalmdahl <pghatwork@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

2010/12/17 Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>:

> This is the 3rd patch set for the ST-Ericsson CG2900 connectivity
> controller. The CG2900 is a combo controller supporting GPS, Bluetooth,
> and FM radio. It uses HCI H:4 protocol to combine different functionalities
> on a common transport, where first byte in the data indicates the current
> channel. Channels 1-4 are standardized in the Bluetooth Core specification
> while the other channels are vendor specific.

I'm slightly confused by different comment threads on this patch set.

I would certainly appreciate if the subsystem maintainers and reviewers
who shaped this patch set could add their Acked-by to the parts
they're happy with.

Alan, Marcel, Sam & Arnd especially. (Your work is MUCH
appreciated.)

I'm trying to get an idea of what patches are OK and what patches
are being disputed here, so as to whether there is some consensus
or not.

Yours,
Linus Walleij
