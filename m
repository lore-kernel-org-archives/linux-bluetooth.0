Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAOazyz213Z61F4yiOE1hvCdrkgjWa1kBjoAaZ+b1WwDC1=ZtcA@mail.gmail.com>
References: <CAOazyz213Z61F4yiOE1hvCdrkgjWa1kBjoAaZ+b1WwDC1=ZtcA@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 11 Nov 2011 19:59:20 -0200
Message-ID: <CAMOw1v6Z9aKnJ9V4SJCCK5ruU21JnZSbiHyMAZEfvi5rUKFRtw@mail.gmail.com>
Subject: Re: Out of tree plugins
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alon

On Fri, Nov 11, 2011 at 7:08 PM, Alon Bar-Lev <alon.barlev@gmail.com> wrote:
> Hello,
>
> Reading the tread about Sixaxis [1], and actually want to use this device...
>
> I could not figure out the end conclusion... as discussion was
> terminated in the middle.
>
> Bluez is already implemented in modular way.
>
> However, there is no sense in having the ability to be modular and not
> expose it to out of tree modules.

It does make sense. It means you can have it builtin or as a .so that
will be loaded at runtime.


>
> And if there is out of tree modular support, features like new devices
> may be added without upstream involvement.

Why do you want that?

>
> I tried to compile the echo, wiiremote, sixaxis and most other, and
> found that plugins may be compiled using the simple command:
>
> gcc \
>    -shared -fPIC -fpic -o a.out $f \
>   $(pkg-config --cflags glib-2.0) $(pkg-config --cflags dbus-1)
> $(pkg-config --cflags bluez) \
>   '-DVERSION="1"' -I../gdbus -Iextra_include
>
> While /usr/include/bluetooth has whatever bluez installs.
> And while in extra_include the following files:
> ---
> adapter.h
> btio.h
> device.h
> hcid.h
> log.h
> manager.h
> oob.h
> plugin.h
> sdpd.h
> sdp-xml.h
> storage.h
> textfile.h
> ---
>
> Note: Not sure about the requirement of gdbus.h if dbus-glib is available.
>
> Of course src/bluetooth.ver needs to be updated to export the above
> headers' symbols to make it work.

All the symbols needed by plugins should be covered by bluetooth.ver

>
> After doing that, most of in-tree plugins may be split out of
> bluetoothd, and plugins as wiiremote, sixaxis may
> be maintained in its own repository and release cycle.

The internal interface is subject to change. And it does change (make
a `git log' in these header files to see).

>
> Thoughts?


Yes, it's relatively easy to compile a plugin out of tree, but you
assume the burden to maintain and you are on your own.



Regards,
Lucas De Marchi
