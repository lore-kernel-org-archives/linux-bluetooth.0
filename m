Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJb_UyNTkrO1qFTk2Uevv9UKnVWrU5rGy_-DPcKUWJY4w@mail.gmail.com>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org>
	<20140722085507.GA29664@t440s.lan>
	<CAHrH25SR83cXq-xGQz4x7axjcW=CUL_VCcAfhny_RyZ+t0oZ-g@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112D121F@SHSMSX104.ccr.corp.intel.com>
	<CAHrH25RpdMCS=eizPUa5S-y0qBHyWQk6co1sJcwAQO9iC0xL=Q@mail.gmail.com>
	<D03CCCE3-51B5-4B3F-AB2D-AA9D766DCCCC@holtmann.org>
	<3D02B219753AD44CBDDDE484323B1774112D143D@SHSMSX104.ccr.corp.intel.com>
	<CABBYNZJb_UyNTkrO1qFTk2Uevv9UKnVWrU5rGy_-DPcKUWJY4w@mail.gmail.com>
Date: Fri, 25 Jul 2014 11:50:41 -0700
Message-ID: <CAHrH25STb6kaLR5tNQNubJmBnRtNapb8SRQngjBWam4EjQ0QVA@mail.gmail.com>
Subject: Re: [RFC v1 0/1] doc/gatt-api: New API properties and methods for the
 GATT D-Bus API.
From: Arman Uguray <armansito@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "Gu, Chao Jie" <chao.jie.gu@intel.com>, Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> Im just wondering why we did not use variant type instead of array of bytes
> for value, imo it seems a better fit since it can be extended with different
> types in host byte order.
>

I don't think that is such a good idea. Characteristic/descriptor
values are usually meant to be interpreted as a series of bytes
encoding different kinds of data of various lengths based on the
profile (e.g. the first byte is a bit mask, the following two bytes
are a uint16, etc). I think it's better to just leave it as an array
of bytes in the order that it was received from the wire as this is
what clients will expect and the order in which the bytes should be
interpreted will be explicitly specified by the profile

On occasion you have a characteristic value that encodes, for example,
a complete string. Then again, if we put a variant of string as the
value property there, only those clients that know beforehand that the
value contains a string will be able to work with it. If you're
implementing a high-level generic application API, this won't work.

Cheers,
Arman
