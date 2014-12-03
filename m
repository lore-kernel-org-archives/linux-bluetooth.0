Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAK8d-aJvGHQHuWQYbXTLJp_Z9jitrCmBYuMaNRUoVwTixxCWaw@mail.gmail.com>
References: <CAK8d-aLtkB1RKm+HP92x45D7csVpPNHj--4SsOPG3aAcx9sj0Q@mail.gmail.com>
	<1417622074-20023-1-git-send-email-stevenrwalter@gmail.com>
	<1417622074-20023-3-git-send-email-stevenrwalter@gmail.com>
	<CAHrH25SpiBdLvihtTsM58skwShOpFGGQGXiMwwnm45bv4uzW3A@mail.gmail.com>
	<CAK8d-aJvGHQHuWQYbXTLJp_Z9jitrCmBYuMaNRUoVwTixxCWaw@mail.gmail.com>
Date: Wed, 3 Dec 2014 09:52:36 -0800
Message-ID: <CAHrH25RLd5Fzr-xVEgO+MGjof1nx_-dkh+uAGqVEv-zXefJMng@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/5] tools/btgatt-server.c: convert to glib mainloop
From: Arman Uguray <armansito@chromium.org>
To: Steven Walter <stevenrwalter@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steven,

> On Wed, Dec 3, 2014 at 9:24 AM, Steven Walter <stevenrwalter@gmail.com> wrote:
> On Wed, Dec 3, 2014 at 11:17 AM, Arman Uguray <armansito@chromium.org> wrote:
>> Hi Steven,
>>
>>> On Wed, Dec 3, 2014 at 7:54 AM, Steven Walter <stevenrwalter@gmail.com> wrote:
>>> Prep work for running gatt-dbus services
>>> ---
>>>  Makefile.tools        |   4 +-
>>>  tools/btgatt-server.c | 136 ++++++++++++++++++++++++++------------------------
>>>  2 files changed, 72 insertions(+), 68 deletions(-)
>>>
>>> diff --git a/Makefile.tools b/Makefile.tools
>>> index ef4162b..7520ab5 100644
>>> --- a/Makefile.tools
>>> +++ b/Makefile.tools
>>> @@ -277,8 +277,8 @@ tools_btgatt_client_LDADD = src/libshared-mainloop.la \
>>>                                                 lib/libbluetooth-internal.la
>>>
>>>  tools_btgatt_server_SOURCES = tools/btgatt-server.c src/uuid-helper.c
>>> -tools_btgatt_server_LDADD = src/libshared-mainloop.la \
>>> -                                               lib/libbluetooth-internal.la
>>> +tools_btgatt_server_LDADD = lib/libbluetooth-internal.la src/libshared-glib.la \
>>> +                                               @GLIB_LIBS@
>>>
>>
>> I'm not sure if this is something that we want. We've been using
>> monitor/mainloop in the newer tools as its more lightweight than glib.
>> I also don't see how gatt-dbus really fits into the scope of this
>> tool.
>
> The problem is probably that I don't understand the scope of the tool.
> Given its generic name, I was thinking that one would use
> btgatt-server to expose any kind of GATT attribute, in-process or not.
> Would it make more sense for there to be a stand-alone tool for
> publishing the GattManager1 D-Bus service?

At the moment, the purpose of the tool is to basically demonstrate how
shared/gatt-db and shared/gatt-server can be used in a standalone
application. The GattManager1 D-Bus service is really bluetoothd core
concept and that's why I don't think it belongs in that tool.

The D-Bus API would really only apply to the daemon, which still needs
to implement a cleaner version of src/attrib-server and properly
implement the GATT server role (GAP and GATT services) at least for
the plugins before there can be a D-Bus API anyway. We still need a
framework built into the daemon that will properly send Service
Changed indications to all devices during a connection and to bonded
devices at connection establishment when there are changes to services
published via plugins and the D-Bus API.

So to answer this question: the tool probably never needs to export a
D-Bus service.

To address the overall patch set: it's definitely good to start
converting the src/gatt-dbus code to use gatt-db - which is the
ultimate goal anyway - but we still need to bake the new shared/gatt
code into the daemon core before we can really do anything with D-Bus
(in fact, the files src/gatt, src/gatt-dbus themselves will likely get
renamed or moved around). I guess my overall understanding is that
those files aren't really meant to be general purpose GATT D-Bus
functions but rather belong to the bluetooth daemon's core
functionality. Though others can comment more on this.

Thanks,
Arman
