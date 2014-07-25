Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <49D1965F-1FE3-4C48-9186-F203E51ACEEA@holtmann.org>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org>
	<20140722085507.GA29664@t440s.lan>
	<CAHrH25SR83cXq-xGQz4x7axjcW=CUL_VCcAfhny_RyZ+t0oZ-g@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112D121F@SHSMSX104.ccr.corp.intel.com>
	<CAHrH25RpdMCS=eizPUa5S-y0qBHyWQk6co1sJcwAQO9iC0xL=Q@mail.gmail.com>
	<D03CCCE3-51B5-4B3F-AB2D-AA9D766DCCCC@holtmann.org>
	<3D02B219753AD44CBDDDE484323B1774112D143D@SHSMSX104.ccr.corp.intel.com>
	<CABBYNZJb_UyNTkrO1qFTk2Uevv9UKnVWrU5rGy_-DPcKUWJY4w@mail.gmail.com>
	<CAHrH25STb6kaLR5tNQNubJmBnRtNapb8SRQngjBWam4EjQ0QVA@mail.gmail.com>
	<CABBYNZJPdDc_tUZYvG_Dpx7ywe+nxCjryH+N55ajrUYKMwCn9A@mail.gmail.com>
	<49D1965F-1FE3-4C48-9186-F203E51ACEEA@holtmann.org>
Date: Fri, 25 Jul 2014 14:06:30 -0700
Message-ID: <CAHrH25TsqMVZQ8xqOvwsW1WNn7DHu0wsxLUOEuEZvVv5tbxB2g@mail.gmail.com>
Subject: Re: [RFC v1 0/1] doc/gatt-api: New API properties and methods for the
 GATT D-Bus API.
From: Arman Uguray <armansito@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "Gu, Chao Jie" <chao.jie.gu@intel.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz & Marcel,


> The one thing I always wanted is a string representation of the Value property as a second property. That way some clients and tools that only need to display the value can rely on bluetoothd giving it a nice translated string.
>

We could do something like this, then again, if a tool wants to
display the value as a string couldn't they just convert it to a
string themselves and simply format it however they like?


>> Well a variant is a container so it can carry any of those values
>> including string or even an array of strings and I believe it would
>> make things even more simple to a client generic API because it can
>> directly be based on D-Bus variant type that most bindings do already
>> support.
>

IMO bluetoothd is not the right place to do this. The high-level API
can allow programmers to do some of these conversions, using features
of the programming language (like in JavaScript or Python) or by
providing additional API functions to perform these conversions (like
on Android). Just returning the raw value also makes the development
of these APIs easier, especially those that have internal bindings for
other platforms such as Windows and Mac that don't necessarily provide
the same variant-based data in their Bluetooth APIs (the new Chrome
bluetooth APIs are such an example).

Cheers,
Arman
