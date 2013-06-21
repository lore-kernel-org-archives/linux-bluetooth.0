Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH BlueZ v3 1/5] build-sys: Don't build gdbus several times
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAMOw1v7gJ-dV5akn0F4bDmG2zo8MYyO1D68Q6MZCE8SVViTgMQ@mail.gmail.com>
Date: Fri, 21 Jun 2013 18:47:37 -0400
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <EF5E15A5-5F57-458F-8E6E-8B0850958E9A@holtmann.org>
References: <1371824255-3071-1-git-send-email-lucas.demarchi@profusion.mobi> <ED8EF8E2-B635-404D-A328-2DCC55EEBCA7@holtmann.org> <CAMOw1v7gJ-dV5akn0F4bDmG2zo8MYyO1D68Q6MZCE8SVViTgMQ@mail.gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

>>> We are currently compiling gdbus 3 times: one for tests, one for
>>> bluetoothd and another for obexd.
>> 
>> we recompile because of the different CFLAGS for these binaries.
> 
> But they shouldn´t be affecting gdbus.
> 
>> 
>>> $ ls gdbus/*watch.o
>>> gdbus/bluetoothd-watch.o  gdbus/obexd-watch.o  gdbus/watch.o
>>> 
>>> Instead of prepending $(gdbus_sources) to several _SOURCES variable, use
>>> a convenience library.
>> 
>> When we switched to non-recursive build, we stopped building interim libraries. What is the benefit of going back to building them. I am personally fine with building gdbus several times.
> 
> It´s more that there´s no advantage doing otherwise. The small benefit
> is building less files and letting it simpler.

then at least get into a bit of a standard habit. We are building libbluetooth into a public and private version.

Currently we name it libbluetooth-private, but maybe following the systemd "standard", we should start calling that libbluetooth-internal. And then libgdbus-internal.

You also do realize that I will make you do this for all other projects using gdbus.

Regards

Marcel

