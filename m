Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v3] Add USB ID of HP's Broadcom BCM2035 Bluetooth
 [SOLVED]
From: Albert Pool <albertpool@solcon.nl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <padovan@profusion.mobi>,
 linux-bluetooth@vger.kernel.org
In-Reply-To: <1325012849.1965.273.camel@aeonflux>
References: <1324728064.3074.5.camel@albert-ASUSTeK-P4P800SE>
	 <20111227160323.GA8298@joana>  <1325008493.1965.270.camel@aeonflux>
	 <1325012535.2109.10.camel@albert-ASUSTeK-P4P800SE>
	 <1325012849.1965.273.camel@aeonflux>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Dec 2011 21:30:42 +0100
Message-ID: <1325017842.13539.10.camel@albert-ASUSTeK-P4P800SE>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Op dinsdag 27-12-2011 om 11:07 uur [tijdzone -0800], schreef Marcel
Holtmann:
> Hi Albert,
> 
> please refrain from top-posting on this mailing list.
> 
> The need for WRONG_SCO_MTU detail can be easily determined. Check the
> output of hciconfig without this quirk. If the SCO MTU essentially shows
> 0 values, then you need it.
> 
> But then again, you are just randomly adding quirks without
> understanding what they are for. This makes me worry a lot.
> 
> Are you actually running a recent 3.x kernel or are you just using an
> outdated kernel?
> 
> Regards
> 
> Marcel
> 
> 
Hi Marcel (and Gustavo),

You were right. I was using and old kernel, 2.6.38, and picking the
fixes from other Broadcom hardware to get Bluetooth working on that
kernel, and applying those fixes to the btusb module of compat-wireless.
I wasn't aware of hciconfig.
Using a recent btusb module (compat-wireless 2011-12-18) without any
patch, it's magically working 'just fine'. And it pairs to my desktop.
It still amazes me how some Broadcom 2035's need a patch while others
don't. I assumed that this Broadcom 2035 would need a patch as well, so
I hadn't even tried getting a recent kernel or module.
(Perhaps it would be a good idea to get a more recent btusb module on my
desktop as well...)
Anyway, thanks for pointing me into the right direction. I'm sorry for
disturbing you and your mailing list with what turned out to be
nonsense. I've learnt a lot about Bluetooth on Linux from this
adventure.

Regards,

Albert
