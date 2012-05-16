Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANT-zCV57v6yPy=eLg8g9LfC8igZt5Pete3t=OUsJ31z8m0kXw@mail.gmail.com>
References: <1337009584-17181-1-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZKyPPb=Ov+6p6-9PUY6nrBTD1M_Ew9YeF_cxt8OQ5x85Q@mail.gmail.com>
	<CANT-zCU-CTWq-9ZR+YQQfuQWKHnxut_dXBA1Cpna9vTJvO5J9w@mail.gmail.com>
	<CABBYNZJwOvn48nx7y=T=64A+8MnmxS2vdVD+3A9TK7v89T2wHQ@mail.gmail.com>
	<CANT-zCXBoa+SsSqrMahPFumww65GaNVyYKCWefZK-a+pzS+RXg@mail.gmail.com>
	<CABBYNZ+030STq_Z4iNFCThAbLv5ZMaxkiMUzv4CtSi656ohkRw@mail.gmail.com>
	<CANT-zCV57v6yPy=eLg8g9LfC8igZt5Pete3t=OUsJ31z8m0kXw@mail.gmail.com>
Date: Wed, 16 May 2012 09:28:08 -0500
Message-ID: <CAB7rCTitrvDEsOGy_RAXS4=2D0YUBmLhQAyejvPVacc_sTXHpA@mail.gmail.com>
Subject: Re: [RFC BlueZ v0 0/5] ACL disconnect reason
From: Mike <puffy.taco@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz, Mikel,

On Wed, May 16, 2012 at 2:12 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> Hi Luiz,
>
>>> From my point of view, the exact policy of which devices, how many of
>>> them, using which priorities, which profiles, etc. is manufacturer and
>>> model-specific. I don't think these policies should be embedded in
>>> BlueZ. After all, we already have a nice D-Bus API to handle these
>>> use-cases, and only the disconnect reason seems to be missing.
>>
>> Disconnect reason doesn't solve all the problems, specially in multi
>> profile case when just one profile has disconnected but the link is
>> still active. Besides that I would be very interested to know why each
>> model has to have a different behavior this goes completely in
>> opposite of having a common stack with a well defined behavior.
>
> The ACL disconnect case might not cover all use-cases, but it does
> cover the most important one: the link loss. Exposing if a specific
> profile has disconnected cleanly is IMO way too much.

You must know if the profile disconnected cleanly.  The spec is very
clear that a user must initiate re-connection in the event of a clean
disconnect (via any means, rebooting a device, clicking a button,
etc).  Somewhere there must be state stored that knows if the profile
was previously connected and if it needs to reconnect it.

>> When you say you want this specific per model all I can think of is
>> how much IOP problems it can cause and in the end I see no benefit for
>> the user, we should aim for re-connect as quick as possible and that
>> should be enough for any model.
>
> Let's not make a big deal out of this. We are talking about small
> differences in policies, such as how many devices and profiles are
> connected, and according to which priorities.
>
> I do agree that anything that could cause IOP problems should be
> handled inside BlueZ. And the immediate reconnection try after a link
> loss does sound an example of this kind. So I would be fine if BlueZ
> internally handles this, but I still think we need to expose this in
> D-Bus somehow.

The reason this is per model is that there is no spec on this and
hence it will be very implementation specific.  If you are a desktop
hooked up to AC, you really don't care, but an embedded device will
need to implement something that meets its battery constraints.  As
well, the efforts of bluez will be fruitless if the rest of the system
goes into suspend.  In my case, my device goes to suspend as soon as
possible (and wakes if there is BT UART traffic).  Hence, timers that
implement re-connection need to let the system know when the next
attempt will occur.

> One alternative to my original proposal -adding a Disconnected(uint8
> reason) signal- would be to use the state property of each interface
> (HFP, A2DP). If the autoreconnect policy is enabled, a link loss would
> generate the transition "connected"->"connecting" (or
> "playing"->"connecting"). Never setting the state to "disconnected"
> would effectively be equivalent as reporting a link loss.

That could appear awkward during the interval between connection attempts.

Mike

> Any thoughts on this second approach? Any other proposal?
