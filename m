Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC PATCH 0/3] UART slave device bus
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20160818105759.GA642@kroah.com>
Date: Thu, 18 Aug 2016 13:14:08 +0200
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Jiri Slaby <jslaby@suse.com>,
	Sebastian Reichel <sre@kernel.org>,
	Peter Hurley <peter@hurleysoftware.com>,
	NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-Id: <23B59EBB-DD4E-4F79-8294-BCE1BE7B9888@goldelico.com>
References: <20160818011445.22726-1-robh@kernel.org> <118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com> <20160818104749.GB7427@amd> <1ED14975-FC0C-44AB-8F05-782DBC9E98F8@goldelico.com> <20160818105759.GA642@kroah.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Greg,

> Am 18.08.2016 um 12:57 schrieb Greg Kroah-Hartman =
<gregkh@linuxfoundation.org>:
>=20
> On Thu, Aug 18, 2016 at 12:54:15PM +0200, H. Nikolaus Schaller wrote:
>> Hi Pavel,
>>=20
>>> Am 18.08.2016 um 12:47 schrieb Pavel Machek <pavel@ucw.cz>:
>>>=20
>>>=20
>>>>=20
>>>> Thereof 4 files, ~260 changes w/o gps demo and =
documentation/bindings.
>>>=20
>>> So what do you use for the serial devices? platform_device was =
vetoed
>>> for that purpose by Greg.
>>=20
>> device tree?
>=20
> No.

? Sorry, but each time Pavel jumps in, he just copies half of a =
statement and
any reply gets misunderstood.

I did not even mention platform_device, still you disagree to device =
tree for the
*slave driver*?

>=20
> This patchset from Rob is the way I have been saying it should be done
> for years now.  Yes, a "bus" takes up more boilerplate code (blame me
> for that), but overall, it makes the drivers simpler,

Sorry, but I don't see how Rob's approach makes it simpler to write a =
device driver
than our original proposal, which btw is also sort of a bus and I see =
only some implementation
differences.

Except that IMHO Rob's approach lacks functions we need (which maybe can =
added).

> and fits into the
> rest of the kernel driver/device model much better.

BR and thanks,
Nikolaus=
