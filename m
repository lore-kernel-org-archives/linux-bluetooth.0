Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <EF5E15A5-5F57-458F-8E6E-8B0850958E9A@holtmann.org>
References: <1371824255-3071-1-git-send-email-lucas.demarchi@profusion.mobi>
 <ED8EF8E2-B635-404D-A328-2DCC55EEBCA7@holtmann.org> <CAMOw1v7gJ-dV5akn0F4bDmG2zo8MYyO1D68Q6MZCE8SVViTgMQ@mail.gmail.com>
 <EF5E15A5-5F57-458F-8E6E-8B0850958E9A@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 25 Jun 2013 15:50:00 -0300
Message-ID: <CAMOw1v6rsJA2R3xcTYjaRYsOX6N2jPhvTskVmn+ugqxUbLpgAg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 1/5] build-sys: Don't build gdbus several times
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 21, 2013 at 7:47 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Lucas,
>
>>>> We are currently compiling gdbus 3 times: one for tests, one for
>>>> bluetoothd and another for obexd.
>>>
>>> we recompile because of the different CFLAGS for these binaries.
>>
>> But they shouldn=B4t be affecting gdbus.
>>
>>>
>>>> $ ls gdbus/*watch.o
>>>> gdbus/bluetoothd-watch.o  gdbus/obexd-watch.o  gdbus/watch.o
>>>>
>>>> Instead of prepending $(gdbus_sources) to several _SOURCES variable, u=
se
>>>> a convenience library.
>>>
>>> When we switched to non-recursive build, we stopped building interim li=
braries. What is the benefit of going back to building them. I am personall=
y fine with building gdbus several times.
>>
>> It=B4s more that there=B4s no advantage doing otherwise. The small benef=
it
>> is building less files and letting it simpler.
>
> then at least get into a bit of a standard habit. We are building libblue=
tooth into a public and private version.
>
> Currently we name it libbluetooth-private, but maybe following the system=
d "standard", we should start calling that libbluetooth-internal. And then =
libgdbus-internal.

ok

>
> You also do realize that I will make you do this for all other projects u=
sing gdbus.

hahaha... ok

Lucas De Marchi
