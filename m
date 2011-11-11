Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v6Z9aKnJ9V4SJCCK5ruU21JnZSbiHyMAZEfvi5rUKFRtw@mail.gmail.com>
References: <CAOazyz213Z61F4yiOE1hvCdrkgjWa1kBjoAaZ+b1WwDC1=ZtcA@mail.gmail.com>
	<CAMOw1v6Z9aKnJ9V4SJCCK5ruU21JnZSbiHyMAZEfvi5rUKFRtw@mail.gmail.com>
Date: Sat, 12 Nov 2011 00:25:57 +0200
Message-ID: <CAOazyz1MXi1v3O7RC-dTLhrLgPJ1Zk4+iKNu0ZMHQyFah1OFJg@mail.gmail.com>
Subject: Re: Out of tree plugins
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

On Fri, Nov 11, 2011 at 11:59 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> Hi Alon
>
> On Fri, Nov 11, 2011 at 7:08 PM, Alon Bar-Lev <alon.barlev@gmail.com> wrote:
>> Hello,
>>
>> Reading the tread about Sixaxis [1], and actually want to use this device...
>>
>> I could not figure out the end conclusion... as discussion was
>> terminated in the middle.
>>
>> Bluez is already implemented in modular way.
>>
>> However, there is no sense in having the ability to be modular and not
>> expose it to out of tree modules.
>
> It does make sense. It means you can have it builtin or as a .so that
> will be loaded at runtime.
>

If you do not expose the plugin.h (install it as part of bluez package
installation),
it means that all plugins must be in tree.
Or you require people to checkout bluez sources and compile against
it, this is none standard approach.
Same for other header files which may be used by out of tree plugins.

>> And if there is out of tree modular support, features like new devices
>> may be added without upstream involvement.
>
> Why do you want that?
>

This provides the flexibility to maintain new features within its own
release cycle.
If I have a special device, why should all people be effected by the plugin?
Why people should beg to revbump and change the way bluez is built on
distributions?
For example, having bluez-wiiremote, bluez-sixaxis packages will
effect only people which actually use this hardware, and bugs/features
may be pushed much faster to users.
Isn't this a win-win situation?
Do you prefer to handle all devices and functionality in tree?

>> I tried to compile the echo, wiiremote, sixaxis and most other, and
>> found that plugins may be compiled using the simple command:
>>
<snip>

>
> All the symbols needed by plugins should be covered by bluetooth.ver

Not exactly.

Example:
---
$ gcc -pthread -shared -fPIC -fpic -o a.out sixaxis.c $(pkg-config
--cflags glib-2.0) $(pkg-config --cflags dbus-1) $(pkg-config --cflags
bluez) $(pkg-config --libs glib-2.0) $(pkg-config --libs dbus-1)
'-DVERSION="1"' -ludev -ldl -I../gdbus -II -Wl,--no-undefined
/usr/sbin/bluetoothd
/tmp/ccSJ9537.o: In function `create_sixaxis_association':
sixaxis.c:(.text+0x48): undefined reference to `str2ba'
sixaxis.c:(.text+0x5b): undefined reference to `adapter_get_address'
sixaxis.c:(.text+0x6e): undefined reference to `ba2str'
sixaxis.c:(.text+0x85): undefined reference to `write_device_name'
sixaxis.c:(.text+0x94): undefined reference to `record_from_string'
sixaxis.c:(.text+0xb2): undefined reference to `store_record'
sixaxis.c:(.text+0xbe): undefined reference to `sdp_record_free'
sixaxis.c:(.text+0xf6): undefined reference to `store_device_id'
sixaxis.c:(.text+0x118): undefined reference to `write_trust'
sixaxis.c:(.text+0x184): undefined reference to `adapter_get_device'
sixaxis.c:(.text+0x1d5): undefined reference to `device_set_temporary'
sixaxis.c:(.text+0x1e8): undefined reference to `device_set_name'
/tmp/ccSJ9537.o: In function `sixpair':
sixaxis.c:(.text+0x7a0): undefined reference to `adapter_get_address'
sixaxis.c:(.text+0x7b3): undefined reference to `ba2str'
/tmp/ccSJ9537.o: In function `handle_device_plug':
sixaxis.c:(.text+0xf4e): undefined reference to `manager_get_default_adapter'
collect2: ld returned 1 exit status
---

>> After doing that, most of in-tree plugins may be split out of
>> bluetoothd, and plugins as wiiremote, sixaxis may
>> be maintained in its own repository and release cycle.
>
> The internal interface is subject to change. And it does change (make
> a `git log' in these header files to see).

That's is understandable.
I guess that in time it will get more stabilized.

>>
>> Thoughts?
>
>
> Yes, it's relatively easy to compile a plugin out of tree, but you
> assume the burden to maintain and you are on your own.
>

In order to do so:

1. internal headers should be installed.
For example to /usr/include/bluetooth/plugin, in order to avoid
conflict with external API.

2. More symbols should be exported from bluetoothd, to match the headers at [1].

This will allow an external package to be built and installed.


Alon
