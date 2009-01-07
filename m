Return-Path: <cyrus@holtmann.org>
Subject: Re: SBC big endian issues?
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: ext Brad Midgley <bmidgley@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <200901071440.01872.siarhei.siamashka@nokia.com>
References: <200901051015.20512.siarhei.siamashka@nokia.com>
	 <200901052019.15656.siarhei.siamashka@nokia.com>
	 <d89ddf300901051126g3f8c8dadq8effa23e0a7bf73f@mail.gmail.com>
	 <200901071440.01872.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Wed, 07 Jan 2009 14:43:57 +0100
Message-Id: <1231335837.5298.0.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> > The messy part here is we let the caller specify the byte order of the
> > array. It would simplify a lot to standardize on host endian. I don't
> > remember what the reasoning was against this.
> >
> > > Let's suppose that we have the following two bytes in memory:
> > >
> > > 0x12 0x34
> > >
> > > This equals to 0x1234 for big endian systems or 0x3412 for little endian
> > > systems if you read data via int16_t * pointer.
> >
> > if sbc->endian is set to the same as the host endian, then this could
> > be done with a memcopy or skipped (zero copy).
> >
> > I believe sbc->endian is always set to little endian the way it works
> > now, meaning the array is storing data little endian regardless of the
> > architecture. The patch I wrote made a copy of the memory, swapping
> > bytes, if sbc->endian didn't match host endian. The way we use the
> > code, this swapping only happens on big endian machines.
> 
> Well, having no other option to verify this big endian bug, I used this MIPS
> big endian QEMU image for testing: 
> http://people.debian.org/~aurel32/qemu/mips/
> 
> The current code is indeed broken on big endian systems. The attached
> patch makes it work correct. Of course this part needs heavy performance
> optimizations (as discussed above), but even just fixing it may be a good
> idea at the moment.

patch has been applied. Thanks.

Regards

Marcel


