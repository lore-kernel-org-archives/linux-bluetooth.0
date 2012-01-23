Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327334612.32646.97.camel@novo.hadess.net>
References: <1327100744-28782-1-git-send-email-scott@netsplit.com>
	<1327320873.32646.77.camel@novo.hadess.net>
	<CA+bD78h+vp5EY+HSvArRSfySr3EWSi3f0qvK+PiKX6OH8Q7w-A@mail.gmail.com>
	<1327334612.32646.97.camel@novo.hadess.net>
Date: Mon, 23 Jan 2012 08:10:45 -0800
Message-ID: <CAHZ1yCk3twweh031ff1UyLJtr3kkgQDAXiT56M0ANyiNe3uqhw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Generate PIN for keyboards inside bluetoothd
From: Scott James Remnant <keybuk@chromium.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: Scott James Remnant <scott@netsplit.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 23, 2012 at 8:03 AM, Bastien Nocera <hadess@hadess.net> wrote:

> And it's not relevant to the discussion. Any chance you could send me
> the details about your devices for me to add them to the database? :)
>

Not yet ;-)

(but they're not relevant to this patch, because this patch isn't
intended to cover them)

> We already know when we have a keyboard, we already know when we have a
> non-SSP device. Why can't we use RequestPincode in the UI? We already
> generate the random PIN for devices.
>

See Marcel's mails for why he doesn't want this done in the UI.

>From my point of view, because then we have give different UIs which
are all different. Implementing this in bluetoothd means GNOME, KDE,
Maemo/Moblin/MeeGo/Tizen, Android, Chrome OS, etc. can all share a
single behavior.

>> > From what I can see, the whole operation can be implemented from
>> > user-space without a problem.
>> >
>> > Care to explain what benefits this has for user-space?
>> >
>>
>> Marcel asked me to implement this in bluetoothd, so everyone can
>> benefit equally rather than four different bluetooth agents all
>> handling auto-pairing slightly differently.
>
> In which case it needs not to regress from the existing solutions. We
> have a database of devices with their specific pairing information, we
> also have ways to show the PIN in special ways depending on the remote
> device:
>

I don't disagree -  the "database of devices" is only relevant to the
other patch set I submitted for comments though, not this one.

You'll note that this keyboard PIN generation patch is deliberately
after any plugins, so that they (including the autopair plugin in the
previous patch) can handle the fixed PIN cases.

Scott
