Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1504627402.6911.48.camel@hadess.net>
References: <1504627402.6911.48.camel@hadess.net>
From: Szymon Janc <szymon.janc@codecoup.pl>
Date: Tue, 5 Sep 2017 19:37:08 +0200
Message-ID: <CAAEJBh+bjNrjSvTD-F1LBTKnO36kvDZmavJaRR8ZWhR6pTwz9g@mail.gmail.com>
Subject: Re: Bluetooth LE battery reporting?
To: Bastien Nocera <hadess@hadess.net>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On 5 September 2017 at 18:03, Bastien Nocera <hadess@hadess.net> wrote:
> Hey,
>
> I'm back looking into Bluetooth LE battery reporting, and I'm a bit
> stumped as to what would need to be done to add support for it.
>
> First, I've already found a few old implementations:
>
> - I cleaned this up a couple of years ago, to try it out, and it spit
> debug information as expected. Doesn't compile anymore:
> https://gfiber.googlesource.com/vendor/opensource/bluez/+/42bc327d464b1f7c2c73b3fecb2e9a8d3dc01035/profiles/battery/battery.c
>
> - chen.ganir@ti.com 's "Add Battery Service GATT Client" patchset that
> was posted to the list in 2012 (!)
>
> - and finally, there's bluez' very own "bas", the last commit touching it says:
> commit b6cb2d3ec320bdfdf1cdcdf750e767d214170efd
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Wed Nov 11 13:08:52 2015 +0200
>
>     bas: Move code from android to profiles
>
>     This is a place holder until the code is ported to use shared API so it
>     can be shared by android and D-Bus daemon.
>
> That last one is compiled, but doesn't seem to be hooked up (?). I
> tested this with a Microsoft Arc Touch Mouse SE (the same mouse I
> tested that first patch with).
>
> Is this all hooked up and I'd just need to export the battery
> information through D-Bus?
>
> Or does it need fixing, in which case, which plugin could I use as an
> example of what porting to that elusive "shared API" should look like?
>
> Cheers
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I think this should be done as "virtual" battery and reported to
system via standard means (upower?).

I was wondering it would be done in similar way uhid is designed (other option
would be bluez registering battery via D-Bus API in upower if such API
exists...)

-- 
pozdrawiam
Szymon K. Janc
