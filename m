Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAOazyz2N++pmzPeoTrj=BGn1C6YfR1zbXD18-O8owWVDm7WLVg@mail.gmail.com>
References: <CAOazyz213Z61F4yiOE1hvCdrkgjWa1kBjoAaZ+b1WwDC1=ZtcA@mail.gmail.com>
 <CAMOw1v6Z9aKnJ9V4SJCCK5ruU21JnZSbiHyMAZEfvi5rUKFRtw@mail.gmail.com>
 <CAOazyz1MXi1v3O7RC-dTLhrLgPJ1Zk4+iKNu0ZMHQyFah1OFJg@mail.gmail.com>
 <CAMOw1v4YrqrpVYiiEE5cUj0Zx7p=KRopskMA2pYLJMFa7fTusA@mail.gmail.com> <CAOazyz2N++pmzPeoTrj=BGn1C6YfR1zbXD18-O8owWVDm7WLVg@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 11 Nov 2011 22:17:47 -0200
Message-ID: <CAMOw1v6LEFsRx6ADbWAmRY4cY6J=7cex8aF0PEu1f8cK+hi72g@mail.gmail.com>
Subject: Re: Out of tree plugins
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Nov 11, 2011 at 9:49 PM, Alon Bar-Lev <alon.barlev@gmail.com> wrote:
> On Sat, Nov 12, 2011 at 1:42 AM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>>> If you do not expose the plugin.h (install it as part of bluez package
>>> installation),
>>> it means that all plugins must be in tree.
>>> Or you require people to checkout bluez sources and compile against
>>> it, this is none standard approach.
>>> Same for other header files which may be used by out of tree plugins.
>>
>> The goal here is not to be able to build out of tree, but just as
>> module or builtin.
>
> <snip>
>
>> Then this is a bug and should be treated as such. In ConnMan/oFono we
>> prefix the functions and then we use a glob in the linker script. I
>> think we don't have that in bluez because there aren't that many
>> external plugins.
>
> Well, so there will be no out of tree plugins.
> So what is the process to get complex module such as sixaxis into tree?

Resolve the issue with a few symbols that should be exported.

Maybe we would need to start using prefixes like ofono/connman do.
Just patching the version script IMO is not a good thing

( e.g. in the mail thread you mentioned, dbus_connection_unref() and
dbus_bus_get() are not right. If you need those you should link
against d-bus instead when building as an external module )


>
> Adding the udev dependency to bluetoothd is ugly.
> Bloating the bluetoothd with a lot of more code is ugly.
> So at the very least the symbol issues should be resolved, so the plugin can
> be built into its own .so.

Correct. Patches for that would be appreciated.



Regards,
Lucas De Marchi
