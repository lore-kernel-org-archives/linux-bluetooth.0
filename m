Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Brad Midgley" <bmidgley@gmail.com>
Subject: Re: SBC big endian issues?
Date: Mon, 5 Jan 2009 20:19:15 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200901051015.20512.siarhei.siamashka@nokia.com> <200901051755.29164.siarhei.siamashka@nokia.com> <d89ddf300901050825h1654c869l22563783beeee7a8@mail.gmail.com>
In-Reply-To: <d89ddf300901050825h1654c869l22563783beeee7a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901052019.15656.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 05 January 2009 18:25:24 ext Brad Midgley wrote:
> Siarhei
>
> > The logic is that the first line contains a portable endian neutral read
> > of
> >
> > big endian data into native format:
> >>                               s = (ptr[0] & 0xff) << 8 | (ptr[1] &
> >> 0xff);
>
> the intent is to swap bytes using this first statement if either
>
> - host order is little endian and the ptr array is stored big endian
> - host order is big endian and the ptr array is stored little endian
>
> the second case could be done with a cast to a 16-bit int rather than
> bit arithmetic.
>
> We don't exercise all the various cases.

No, it's a bit different. There is no 'swap byte' operation here, but just
portable reading of data in big endian format.

Let's suppose that we have the following two bytes in memory:

0x12 0x34

This equals to 0x1234 for big endian systems or 0x3412 for little endian
systems if you read data via int16_t * pointer.

But in the case of SBC, data is read one byte at a time and results in the
same value regardless of the endianness of the system. It will be always
0x1234 and this is generally a portable, but slow way of reading big endian
data (host system endian order does not matter).

So unless __BYTE_ORDER is somehow defined to be __LITTLE_ENDIAN on big
endian systems (two bugs which cancel each other ;-) ),  the code from SBC is
supposed to work incorrectly and sbcenc should produce broken files
with distorted sound (though somewhat resembling the original file). I just
want somebody to verify this on real big endian hardware.

PS. I'm interested in this code because it is very slow and needs to be
optimized. In the case of single channel and no endian conversion, just
memcpy can be used. Other cases can be improved too.

-- 
Best regards,
Siarhei Siamashka
