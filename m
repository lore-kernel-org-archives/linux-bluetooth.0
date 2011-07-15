Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJXUZHHb8ZZk_wHpFVgO+w1CuE=HPNXwRsK9Z4tB5R5MQ@mail.gmail.com>
References: <1310564415-26093-1-git-send-email-dh.herrmann@googlemail.com>
	<1310564415-26093-2-git-send-email-dh.herrmann@googlemail.com>
	<CABBYNZJXUZHHb8ZZk_wHpFVgO+w1CuE=HPNXwRsK9Z4tB5R5MQ@mail.gmail.com>
Date: Fri, 15 Jul 2011 13:48:29 +0200
Message-ID: <CANq1E4R_i=3Z2Kga=9p9ULfgM47SCEjtawR-8qx9DKh+OQKj0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Add pin-code hook to adapter api
From: David Herrmann <dh.herrmann@googlemail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jul 15, 2011 at 12:41 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi David,
>
> The idea itself is nice, but having each callback to check for VID/PID
> seems inefficient, what could be done instead is to extend the device
> driver adding VID and PID so they can be used as device
> unique/specific drivers which could deal with predefined/hardcoded
> pincodes, how about that?

My intention was not to limit this to VID/PID checks. VID/PID
information may not be available at this point, yet and some devices
may provide no VID/PID information at all. So this callback was
created to support other checks, too.
But if I understand you right, you mean I should add a ->pin_cb
callback to each device instead of adapter which is NULL by default
and a device driver may set this callback on *_probe() if it thinks
the device requires a hardcoded pin?
And also extending the *_probe() function to also pass VID/PID
information so a device driver may be registered on matching UUID
*and* on matching VID/PID?

I have no objections to that, but I don't think very much devices
require hard-coded pins so I never thought performance would be an
issue here. If performance is the only problem I could also pass
VID/PID as callback arguments or combine all binary pin plugins that
depend on VID/PID into a single plugin and perform some kind of table
lookup on pin callback.
Johan already pushed the patches but if you think your idea would be
the cleaner implementation I will give it a try but I am not sure
whether the device drivers are already loaded when a pin is requested?

>
> --
> Luiz Augusto von Dentz

Regards
David
