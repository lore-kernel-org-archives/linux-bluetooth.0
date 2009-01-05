Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300901050825h1654c869l22563783beeee7a8@mail.gmail.com>
Date: Mon, 5 Jan 2009 09:25:24 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "Siarhei Siamashka" <siarhei.siamashka@nokia.com>
Subject: Re: SBC big endian issues?
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200901051755.29164.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200901051015.20512.siarhei.siamashka@nokia.com>
	 <d89ddf300901050736n2615d812r85c8cc1d5df36898@mail.gmail.com>
	 <200901051755.29164.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Siarhei

> The logic is that the first line contains a portable endian neutral read of
> big endian data into native format:
>>                               s = (ptr[0] & 0xff) << 8 | (ptr[1] & 0xff);

the intent is to swap bytes using this first statement if either

- host order is little endian and the ptr array is stored big endian
- host order is big endian and the ptr array is stored little endian

the second case could be done with a cast to a 16-bit int rather than
bit arithmetic.

We don't exercise all the various cases.

-- 
Brad Midgley
