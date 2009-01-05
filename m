Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300901051126g3f8c8dadq8effa23e0a7bf73f@mail.gmail.com>
Date: Mon, 5 Jan 2009 12:26:17 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "Siarhei Siamashka" <siarhei.siamashka@nokia.com>
Subject: Re: SBC big endian issues?
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200901052019.15656.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200901051015.20512.siarhei.siamashka@nokia.com>
	 <200901051755.29164.siarhei.siamashka@nokia.com>
	 <d89ddf300901050825h1654c869l22563783beeee7a8@mail.gmail.com>
	 <200901052019.15656.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Siarhei

The copy is inefficient but it would be even better if we didn't have
to do it at all. I was investigating zero copy here and came up with a
patch but it was too complicated to be accepted.

The messy part here is we let the caller specify the byte order of the
array. It would simplify a lot to standardize on host endian. I don't
remember what the reasoning was against this.

> Let's suppose that we have the following two bytes in memory:
>
> 0x12 0x34
>
> This equals to 0x1234 for big endian systems or 0x3412 for little endian
> systems if you read data via int16_t * pointer.

if sbc->endian is set to the same as the host endian, then this could
be done with a memcopy or skipped (zero copy).

I believe sbc->endian is always set to little endian the way it works
now, meaning the array is storing data little endian regardless of the
architecture. The patch I wrote made a copy of the memory, swapping
bytes, if sbc->endian didn't match host endian. The way we use the
code, this swapping only happens on big endian machines.

-- 
Brad Midgley
