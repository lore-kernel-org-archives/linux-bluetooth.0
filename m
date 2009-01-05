Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300901050736n2615d812r85c8cc1d5df36898@mail.gmail.com>
Date: Mon, 5 Jan 2009 08:36:57 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "Siarhei Siamashka" <siarhei.siamashka@nokia.com>
Subject: Re: SBC big endian issues?
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200901051015.20512.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200901051015.20512.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Siarhei

> SBC encoder contains the following fragment:
>
>> #if __BYTE_ORDER == __LITTLE_ENDIAN
>>                       if (sbc->endian == SBC_BE)
>> #elif __BYTE_ORDER == __BIG_ENDIAN
>>                       if (sbc->endian == SBC_LE)
>> #else
>> #error "Unknown byte order"
>> #endif
>>                               s = (ptr[0] & 0xff) << 8 | (ptr[1] & 0xff);
>>                       else
>>                               s = (ptr[0] & 0xff) | (ptr[1] & 0xff) << 8;
>
> This does not look right. Because as far as I can see, it will work
> differently on big and little endian systems

I tested it some time ago on powerpc and I know Marcel also has a
powerpc for testing. I'll need to update my machine for bluez 4.x.

The logic here seems to be to swap bytes if the endian set in the sbc
struct does not match host endian.

-- 
Brad Midgley
