Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <01815345-0542-4F64-8535-9193F31D123E@holtmann.org>
References: <CAAqhSf6mcSTrPyTrEu8KL7GFmnVGf9OjPNS+vNyARyhQZc=c6A@mail.gmail.com>
	<01815345-0542-4F64-8535-9193F31D123E@holtmann.org>
Date: Mon, 26 Jan 2015 23:58:23 -0800
Message-ID: <CAHrH25Rb_v_h_N3=90munc=OTLhkhbBdxRHDWdb4aLDfxZF+ww@mail.gmail.com>
Subject: Re: GATT plugin
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Tyler Arnold <choosetylernol@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> On Mon, Jan 26, 2015 at 10:11 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Tyler,
>
>> I am building a GATT service/plugin for the bluetooth daemon and have
>> ported 5.27 bluez to my embedded ARM platform.
>>
>> It seems like the GATT D-Bus API is not quite ready, so my options
>> appear to be either building the plugin and linking it as a statically
>> linked object or build it as a shared object library where the daemon
>> will pick it up from /usr/local/lib/bluetooth/plugins
>> Are both supported? I saw a message from about a year ago suggesting
>> the shared object approach was not the best path.
>
> actually I would prefer if we get the GATT D-Bus API ready so that you can use it. Have you tried it? I am actually curious to hear what would be missing.
>

The GATT D-Bus API was mostly implemented for client role a little
after the christmas release. I received push back on
StartNotify/StopNotify for an edge case and I haven't come up with an
alternative, so the API is behind the experimental flag and doesn't
support enabling notifications.

Server role support (over D-Bus) doesn't exist at all. If you run the
daemon with -E, you'll see the org.bluez.GattManager1 interface
exported but interacting with it virtually doesn't do anything.

The thing is, the upstream review process has been taking way too long
for us and we have some features to deliver, so I'm working on the
remaining features within the ChromiumOS tree for now. So you won't
see any patches from me any time soon. Last where I left off, we were
discussing replacing GattManager1 with a new GattProfile1 &
GattProfileManager1 API, so I may send out a proposal for that some
time next week.

Otherwise, that's where the API stands :)

Thanks,
Arman
