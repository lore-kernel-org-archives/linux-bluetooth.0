Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <9D01587F-3821-46CF-B8CE-2311BE8E8592@holtmann.org>
References: <1504627402.6911.48.camel@hadess.net> <CAAEJBh+bjNrjSvTD-F1LBTKnO36kvDZmavJaRR8ZWhR6pTwz9g@mail.gmail.com>
 <9D01587F-3821-46CF-B8CE-2311BE8E8592@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 6 Sep 2017 11:29:03 +0300
Message-ID: <CABBYNZLDGJTj+jeKUuRAmm_FznUzAy--zE1YVto2t5Fb4zOQ6w@mail.gmail.com>
Subject: Re: Bluetooth LE battery reporting?
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Szymon Janc <szymon.janc@codecoup.pl>, Bastien Nocera <hadess@hadess.net>,
	Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Sep 5, 2017 at 8:44 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Szymon,
>
>>> I'm back looking into Bluetooth LE battery reporting, and I'm a bit
>>> stumped as to what would need to be done to add support for it.
>>>
>>> First, I've already found a few old implementations:
>>>
>>> - I cleaned this up a couple of years ago, to try it out, and it spit
>>> debug information as expected. Doesn't compile anymore:
>>> https://gfiber.googlesource.com/vendor/opensource/bluez/+/42bc327d464b1f7c2c73b3fecb2e9a8d3dc01035/profiles/battery/battery.c
>>>
>>> - chen.ganir@ti.com 's "Add Battery Service GATT Client" patchset that
>>> was posted to the list in 2012 (!)
>>>
>>> - and finally, there's bluez' very own "bas", the last commit touching it says:
>>> commit b6cb2d3ec320bdfdf1cdcdf750e767d214170efd
>>> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>> Date:   Wed Nov 11 13:08:52 2015 +0200
>>>
>>>    bas: Move code from android to profiles
>>>
>>>    This is a place holder until the code is ported to use shared API so it
>>>    can be shared by android and D-Bus daemon.
>>>
>>> That last one is compiled, but doesn't seem to be hooked up (?). I
>>> tested this with a Microsoft Arc Touch Mouse SE (the same mouse I
>>> tested that first patch with).
>>>
>>> Is this all hooked up and I'd just need to export the battery
>>> information through D-Bus?
>>>
>>> Or does it need fixing, in which case, which plugin could I use as an
>>> example of what porting to that elusive "shared API" should look like?
>>>
>>> Cheers
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> I think this should be done as "virtual" battery and reported to
>> system via standard means (upower?).
>>
>> I was wondering it would be done in similar way uhid is designed (other option
>> would be bluez registering battery via D-Bus API in upower if such API
>> exists...)
>
> for LE HID devices we could just convert their battery service into HID battery events. For non-HID devices, we could create a HID device via uhid anyway and just expose only battery information.

You mean we create USB reports for the battery status? While this is
possible what if the remote is also doing this already, it would be
quite hard to detect this but perhaps it is fine since the values
should be consistent. For non-HID devices that sound pretty easy to do
though perhaps having the a Battery property in the Device interface
wouldn't be a bad idea either as that may be more convenient for D-Bus
clients to read.

> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
