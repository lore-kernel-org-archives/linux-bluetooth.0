Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <FBBCB89D-4126-4799-A7C0-811BAE12B7B0@holtmann.org>
References: <CAAqhSf6mcSTrPyTrEu8KL7GFmnVGf9OjPNS+vNyARyhQZc=c6A@mail.gmail.com>
	<01815345-0542-4F64-8535-9193F31D123E@holtmann.org>
	<CAHrH25Rb_v_h_N3=90munc=OTLhkhbBdxRHDWdb4aLDfxZF+ww@mail.gmail.com>
	<FBBCB89D-4126-4799-A7C0-811BAE12B7B0@holtmann.org>
Date: Tue, 27 Jan 2015 00:34:30 -0800
Message-ID: <CAHrH25ReY0sU9BCSUtLY26nyGgH4CEL+UeQgdPXjAgqB+rUNTQ@mail.gmail.com>
Subject: Re: GATT plugin
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Tyler Arnold <choosetylernol@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> On Tue, Jan 27, 2015 at 12:10 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
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
>>
>> Otherwise, that's where the API stands :)
>
> actually I would prefer if we get this upstream quicker. And that applies to GATT client and GATT server support. I was under the assumption that Luiz was working on this as well. So what can we do to make this go faster?
>

For me it's just a matter of long reviews and a general lack of
consensus on a finalized API, mostly due to the timezone difference.
Basically the whole review-revise-reupload cycle takes too long, with
a 12h delay between each email. The GATT D-Bus features are something
that we've all been working towards and it's high priority for
everybody then again I don't want to take another 6 months just
getting the basic external GATT service support merged.

Feature-wise, there are some points that Luiz raised about the way the
current API design handles notifications that we need to address.
Essentially, we want to have a reference counted way to enable remote
notifications (i.e. StartNotify/StopNotify) while also being able to
register a notification handler with shared/gatt-client immediately
after connection so that we can receive notifications that are sent
immediately. This makes things slightly tricky mainly because we don't
want to unnecessarily send notifications over D-Bus for a
characteristic if nobody requested to start them, but then if we wait
until an application calls StartNotify, some important notifications
might get missed.

Another point was regarding how external applications can manage the
lifetime of a connection and request things like auto-connect. There
is currently no GATT equivalent of "ConnectProfile/DisconnectProfile"
so if one app calls the regular Device.Disconnect, it will tear-down
the connection for everybody.

I think Luiz and I agreed that the above points can be addressed by
using a GattProfile1-like API, so that client-role applications can
register for certain types of behavior, pre-register for
notifications, enable auto-connect, etc.

Cheers,
Arman
