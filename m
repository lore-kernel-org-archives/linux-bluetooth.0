Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <FBBCB89D-4126-4799-A7C0-811BAE12B7B0@holtmann.org>
References: <CAAqhSf6mcSTrPyTrEu8KL7GFmnVGf9OjPNS+vNyARyhQZc=c6A@mail.gmail.com>
	<01815345-0542-4F64-8535-9193F31D123E@holtmann.org>
	<CAHrH25Rb_v_h_N3=90munc=OTLhkhbBdxRHDWdb4aLDfxZF+ww@mail.gmail.com>
	<FBBCB89D-4126-4799-A7C0-811BAE12B7B0@holtmann.org>
Date: Tue, 27 Jan 2015 10:38:41 +0200
Message-ID: <CABBYNZK9grifuuy5exy-3EYn-mbDaYRaGXkSZwA9KqRZBQUMXg@mail.gmail.com>
Subject: Re: GATT plugin
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arman Uguray <armansito@chromium.org>, Tyler Arnold <choosetylernol@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Arman,

On Tue, Jan 27, 2015 at 10:10 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Arman,
>
>>>> I am building a GATT service/plugin for the bluetooth daemon and have
>>>> ported 5.27 bluez to my embedded ARM platform.
>>>>
>>>> It seems like the GATT D-Bus API is not quite ready, so my options
>>>> appear to be either building the plugin and linking it as a statically
>>>> linked object or build it as a shared object library where the daemon
>>>> will pick it up from /usr/local/lib/bluetooth/plugins
>>>> Are both supported? I saw a message from about a year ago suggesting
>>>> the shared object approach was not the best path.
>>>
>>> actually I would prefer if we get the GATT D-Bus API ready so that you can use it. Have you tried it? I am actually curious to hear what would be missing.
>>>
>>
>> The GATT D-Bus API was mostly implemented for client role a little
>> after the christmas release. I received push back on
>> StartNotify/StopNotify for an edge case and I haven't come up with an
>> alternative, so the API is behind the experimental flag and doesn't
>> support enabling notifications.
>>
>> Server role support (over D-Bus) doesn't exist at all. If you run the
>> daemon with -E, you'll see the org.bluez.GattManager1 interface
>> exported but interacting with it virtually doesn't do anything.
>>
>> The thing is, the upstream review process has been taking way too long
>> for us and we have some features to deliver, so I'm working on the
>> remaining features within the ChromiumOS tree for now. So you won't
>> see any patches from me any time soon. Last where I left off, we were
>> discussing replacing GattManager1 with a new GattProfile1 &
>> GattProfileManager1 API, so I may send out a proposal for that some
>> time next week.

Im surprised to hear that, I thought we were actually moving too fast
given the amount of regressions we have introduced and there are still
some left and lots of cleanups to do in the core and complete the unit
tests.

>> Otherwise, that's where the API stands :)
>
> actually I would prefer if we get this upstream quicker. And that applies to GATT client and GATT server support. I was under the assumption that Luiz was working on this as well. So what can we do to make this go faster?

Im doing the review as quick as I can, normally within 1-2 days, and
Im even fixing things myself to try to speed up the process.

> One small detail here. I hope we are clear that "service" in LE GATT means the server side and "profile" in LE GATT is actually the client. The GATT server exposes a service and the profile explains how a GATT client uses it.

That perhaps needs changes then, we start using GattService1 as client side API.

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
