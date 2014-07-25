Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RFC v1 0/1] doc/gatt-api: New API properties and methods for the GATT D-Bus API.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJPdDc_tUZYvG_Dpx7ywe+nxCjryH+N55ajrUYKMwCn9A@mail.gmail.com>
Date: Fri, 25 Jul 2014 21:28:27 +0200
Cc: Arman Uguray <armansito@google.com>,
	"Gu, Chao Jie" <chao.jie.gu@intel.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <49D1965F-1FE3-4C48-9186-F203E51ACEEA@holtmann.org>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org> <20140722085507.GA29664@t440s.lan> <CAHrH25SR83cXq-xGQz4x7axjcW=CUL_VCcAfhny_RyZ+t0oZ-g@mail.gmail.com> <3D02B219753AD44CBDDDE484323B1774112D121F@SHSMSX104.ccr.corp.intel.com> <CAHrH25RpdMCS=eizPUa5S-y0qBHyWQk6co1sJcwAQO9iC0xL=Q@mail.gmail.com> <D03CCCE3-51B5-4B3F-AB2D-AA9D766DCCCC@holtmann.org> <3D02B219753AD44CBDDDE484323B1774112D143D@SHSMSX104.ccr.corp.intel.com> <CABBYNZJb_UyNTkrO1qFTk2Uevv9UKnVWrU5rGy_-DPcKUWJY4w@mail.gmail.com> <CAHrH25STb6kaLR5tNQNubJmBnRtNapb8SRQngjBWam4EjQ0QVA@mail.gmail.com> <CABBYNZJPdDc_tUZYvG_Dpx7ywe+nxCjryH+N55ajrUYKMwCn9A@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>>> Im just wondering why we did not use variant type instead of array of bytes
>>> for value, imo it seems a better fit since it can be extended with different
>>> types in host byte order.
>>> 
>> 
>> I don't think that is such a good idea. Characteristic/descriptor
>> values are usually meant to be interpreted as a series of bytes
>> encoding different kinds of data of various lengths based on the
>> profile (e.g. the first byte is a bit mask, the following two bytes
>> are a uint16, etc). I think it's better to just leave it as an array
>> of bytes in the order that it was received from the wire as this is
>> what clients will expect and the order in which the bytes should be
>> interpreted will be explicitly specified by the profile
> 
> In case we know the profile we could go ahead an decode upfront and in
> case we don't know how to decode we keep the array of bytes inside the
> variant.

I prefer we keep the Value property as array of bytes. We should always expose the real value information for all characteristics. This is especially important for custom services.

The one thing I always wanted is a string representation of the Value property as a second property. That way some clients and tools that only need to display the value can rely on bluetoothd giving it a nice translated string. 

>> On occasion you have a characteristic value that encodes, for example,
>> a complete string. Then again, if we put a variant of string as the
>> value property there, only those clients that know beforehand that the
>> value contains a string will be able to work with it. If you're
>> implementing a high-level generic application API, this won't work.
> 
> Well a variant is a container so it can carry any of those values
> including string or even an array of strings and I believe it would
> make things even more simple to a client generic API because it can
> directly be based on D-Bus variant type that most bindings do already
> support.

The problem is that values are include also types of what their content is. Being it a temperature value, percentage or some other value.

Regards

Marcel

