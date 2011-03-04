Return-Path: <cyrus@holtmann.org>
Message-ID: <4D71435B.2090102@codeaurora.org>
Date: Fri, 04 Mar 2011 11:54:03 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>,
	linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH 1/5] Add new UUID utility functions
References: <1299255640-13599-1-git-send-email-epx@signove.com>	<4D712A3D.6090402@codeaurora.org>	<0881010B-89C3-40B7-A48E-A85E1BDD0E6C@signove.com>	<4D71361E.3020606@codeaurora.org> <AANLkTi=a0Wy-qxiRUVYH7TmaYe9yoBHc0U2JDPBs47B=@mail.gmail.com>
In-Reply-To: <AANLkTi=a0Wy-qxiRUVYH7TmaYe9yoBHc0U2JDPBs47B=@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On 11-03-04 11:17 AM, Anderson Lizardo wrote:
> Hi Brian,
>
> On Fri, Mar 4, 2011 at 2:57 PM, Brian Gix<bgix@codeaurora.org>  wrote:
>> On 11-03-04 10:32 AM, Elvis Pfützenreuter wrote:
>>>> I don't believe this line to be always portable between platforms. This
>>>> line makes the assumption that a uint16_t is two native units (not always
>>>> true) and can therefore be directly memcopy'd into into an array of uint8_t
>>>> array members. This is not always true. memcpy should never be used in
>>>> portable code when packing data for network datagram usage models (anything
>>>> that treats data as an octet stream).
>>>
>>> If we had used "unsigned char" and "unsigned short int", I'd agree, but
>>> uint8_t and uint16_t are *explicitly* 8-bit and 16-bit types, and thus there
>>> is a guaranteed 2:1 size relationship.
>>>
>>
>> Unfortunately, this is only part true. There are already CPU architectures
>> in the marketplace which define the smallest addressable unit as being 16
>> bits, which means that even if you have defined a uint8_t that has a valid
>> range of only 0-255, the sizeof(uint8_t) will == 1, and the sizeof(uint16_t)
>> will also == 1, and so a uint16_t of 0x1234 memcpy'd into a uint8_t array
>> will not appear as {0x12, 0x34} but rather as {0x34, 0x00} regardless of
>> your endian-ness (the Most Sig 8 bits hidden by the allowed range). Memcpy
>> is only portability-safe when used to copy between two identical data types.
>> It is also the reason you see things like sizeof(uint16_t) being passed as
>> arguments to the mem* functions.
>>
>> That axiom is also true when copying data between unions and/or stucts with
>> different underlying definitions. The layout of raw bits can never be
>> assumed.
>
> While your explanation looks really interesting (I always thought that
> sizeof() returned the number of bytes), keep in mind that there are
> tons of memcpy() calls beween different datatypes, at least on BlueZ
> and on Linux kernel. I'm not arguing that we should keep it as is, but
> I suppose there will be a lot of changes to be done even before BlueZ
> (or even the kernel) can run on these CPUs.
>
> If I understand your explanation, even memcpy(..., ...,
> sizeof(uint16_t)) would not work on these CPUs, as it copies the
> specified number of *bytes*.
>
> Simply grep for "memcpy" on BlueZ sources to get an idea.
>
> My two cents,


I suppose you are correct that for Linux and BlueZ, the damage is 
already done as far as mem* function usage, and that therefore all of my 
other objections are moot, and withdraw my fundamental memcpy objection.


However:
You are also correct that sizeof() returns the number of bytes, but 
bytes are not in fact the same thing as octets.  An octet is used in 
networking, and other inter-architecture communication, and is defined 
as being exactly eight bits of data.

A byte on the other hand is architecturally defined and is neither 
limited to, nor gaurenteed to be at least, 8 bits.  It is rather "the 
smallest addressable unit" of the target architecture. That is why if 
you read networking documents, you are more likely to hear the 
underlying data referred to as "octets" instead of bytes. Octets are 
precise, and bytes are imprecise.

byte != octet

So memcpy(a1, a2, sizeof(uint16_t)) would work as expected, assuming a1 
and a2 were both pointers to objects with underlying 16 bit definitions.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
