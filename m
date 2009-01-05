Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Brad Midgley" <bmidgley@gmail.com>
Subject: Re: SBC big endian issues?
Date: Mon, 5 Jan 2009 17:55:29 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200901051015.20512.siarhei.siamashka@nokia.com> <d89ddf300901050736n2615d812r85c8cc1d5df36898@mail.gmail.com>
In-Reply-To: <d89ddf300901050736n2615d812r85c8cc1d5df36898@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901051755.29164.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 05 January 2009 17:36:57 ext Brad Midgley wrote:
> Siarhei
>
> > SBC encoder contains the following fragment:
> >> #if __BYTE_ORDER == __LITTLE_ENDIAN
> >>                       if (sbc->endian == SBC_BE)
> >> #elif __BYTE_ORDER == __BIG_ENDIAN
> >>                       if (sbc->endian == SBC_LE)
> >> #else
> >> #error "Unknown byte order"
> >> #endif
> >>                               s = (ptr[0] & 0xff) << 8 | (ptr[1] &
> >> 0xff); else
> >>                               s = (ptr[0] & 0xff) | (ptr[1] & 0xff) <<
> >> 8;
> >
> > This does not look right. Because as far as I can see, it will work
> > differently on big and little endian systems
>
> I tested it some time ago on powerpc and I know Marcel also has a
> powerpc for testing. I'll need to update my machine for bluez 4.x.
>
> The logic here seems to be to swap bytes if the endian set in the sbc
> struct does not match host endian.

The logic is that the first line contains a portable endian neutral read of
big endian data into native format:
>                               s = (ptr[0] & 0xff) << 8 | (ptr[1] & 0xff);
The second line contains a portable endian neutral read of little endian
data into native format:
>                               s = (ptr[0] & 0xff) | (ptr[1] & 0xff) <<8;

If __BYTE_ORDER is defined as __LITTLE_ENDIAN, the first line is used when
sbc->endian == SBC_BE. But if __BYTE_ORDER is set to __BIG_ENDIAN, the
logic is reversed.

The behaviour and the end result seems to be different for the big endian
and little endian systems. This can be probably easily tested by encoding the
same file by sbcenc on big and little endian systems and comparing results.

-- 
Best regards,
Siarhei Siamashka
