Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <ED8EF8E2-B635-404D-A328-2DCC55EEBCA7@holtmann.org>
References: <1371824255-3071-1-git-send-email-lucas.demarchi@profusion.mobi> <ED8EF8E2-B635-404D-A328-2DCC55EEBCA7@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 21 Jun 2013 19:37:15 -0300
Message-ID: <CAMOw1v7gJ-dV5akn0F4bDmG2zo8MYyO1D68Q6MZCE8SVViTgMQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 1/5] build-sys: Don't build gdbus several times
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 21, 2013 at 7:02 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Lucas,
>
>> We are currently compiling gdbus 3 times: one for tests, one for
>> bluetoothd and another for obexd.
>
> we recompile because of the different CFLAGS for these binaries.

But they shouldn=B4t be affecting gdbus.

>
>> $ ls gdbus/*watch.o
>> gdbus/bluetoothd-watch.o  gdbus/obexd-watch.o  gdbus/watch.o
>>
>> Instead of prepending $(gdbus_sources) to several _SOURCES variable, use
>> a convenience library.
>
> When we switched to non-recursive build, we stopped building interim libr=
aries. What is the benefit of going back to building them. I am personally =
fine with building gdbus several times.

It=B4s more that there=B4s no advantage doing otherwise. The small benefit
is building less files and letting it simpler.


Lucas De Marchi
