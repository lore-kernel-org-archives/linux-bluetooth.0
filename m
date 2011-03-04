Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4D71361E.3020606@codeaurora.org>
References: <1299255640-13599-1-git-send-email-epx@signove.com>
	<4D712A3D.6090402@codeaurora.org>
	<0881010B-89C3-40B7-A48E-A85E1BDD0E6C@signove.com>
	<4D71361E.3020606@codeaurora.org>
Date: Fri, 4 Mar 2011 15:17:15 -0400
Message-ID: <AANLkTi=a0Wy-qxiRUVYH7TmaYe9yoBHc0U2JDPBs47B=@mail.gmail.com>
Subject: Re: [PATCH 1/5] Add new UUID utility functions
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>,
	linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Fri, Mar 4, 2011 at 2:57 PM, Brian Gix <bgix@codeaurora.org> wrote:
> On 11-03-04 10:32 AM, Elvis Pfützenreuter wrote:
>>> I don't believe this line to be always portable between platforms. This
>>> line makes the assumption that a uint16_t is two native units (not always
>>> true) and can therefore be directly memcopy'd into into an array of uint8_t
>>> array members. This is not always true. memcpy should never be used in
>>> portable code when packing data for network datagram usage models (anything
>>> that treats data as an octet stream).
>>
>> If we had used "unsigned char" and "unsigned short int", I'd agree, but
>> uint8_t and uint16_t are *explicitly* 8-bit and 16-bit types, and thus there
>> is a guaranteed 2:1 size relationship.
>>
>
> Unfortunately, this is only part true. There are already CPU architectures
> in the marketplace which define the smallest addressable unit as being 16
> bits, which means that even if you have defined a uint8_t that has a valid
> range of only 0-255, the sizeof(uint8_t) will == 1, and the sizeof(uint16_t)
> will also == 1, and so a uint16_t of 0x1234 memcpy'd into a uint8_t array
> will not appear as {0x12, 0x34} but rather as {0x34, 0x00} regardless of
> your endian-ness (the Most Sig 8 bits hidden by the allowed range). Memcpy
> is only portability-safe when used to copy between two identical data types.
> It is also the reason you see things like sizeof(uint16_t) being passed as
> arguments to the mem* functions.
>
> That axiom is also true when copying data between unions and/or stucts with
> different underlying definitions. The layout of raw bits can never be
> assumed.

While your explanation looks really interesting (I always thought that
sizeof() returned the number of bytes), keep in mind that there are
tons of memcpy() calls beween different datatypes, at least on BlueZ
and on Linux kernel. I'm not arguing that we should keep it as is, but
I suppose there will be a lot of changes to be done even before BlueZ
(or even the kernel) can run on these CPUs.

If I understand your explanation, even memcpy(..., ...,
sizeof(uint16_t)) would not work on these CPUs, as it copies the
specified number of *bytes*.

Simply grep for "memcpy" on BlueZ sources to get an idea.

My two cents,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
