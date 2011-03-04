Return-Path: <cyrus@holtmann.org>
Message-ID: <4D71361E.3020606@codeaurora.org>
Date: Fri, 04 Mar 2011 10:57:34 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
CC: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH 1/5] Add new UUID utility functions
References: <1299255640-13599-1-git-send-email-epx@signove.com> <4D712A3D.6090402@codeaurora.org> <0881010B-89C3-40B7-A48E-A85E1BDD0E6C@signove.com>
In-Reply-To: <0881010B-89C3-40B7-A48E-A85E1BDD0E6C@signove.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On 11-03-04 10:32 AM, Elvis Pfützenreuter wrote:
> Hi Brian,
>
> On 4 Mar 2011, at 15:06 , Brian Gix wrote:
>
>> Hi Elvis,
>>
>> I'm trying to understand the problem being addressed by these patches. I am guessing that there is a difference in behaviour between little endian and big endian architectures, but I still question some of the changes.
>>
>> One example below.
>>
>> On 11-03-04 08:20 AM, Elvis Pfützenreuter wrote:
>> [...]
>>> +
>>> +	memcpy(&uuid128->value.u128.data[BASE_UUID16_OFFSET],&data, 2);
>>
>> I don't believe this line to be always portable between platforms. This line makes the assumption that a uint16_t is two native units (not always true) and can therefore be directly memcopy'd into into an array of uint8_t array members. This is not always true. memcpy should never be used in portable code when packing data for network datagram usage models (anything that treats data as an octet stream).
>
> If we had used "unsigned char" and "unsigned short int", I'd agree, but uint8_t and uint16_t are *explicitly* 8-bit and 16-bit types, and thus there is a guaranteed 2:1 size relationship.
>

Unfortunately, this is only part true. There are already CPU 
architectures in the marketplace which define the smallest addressable 
unit as being 16 bits, which means that even if you have defined a 
uint8_t that has a valid range of only 0-255, the sizeof(uint8_t) will 
== 1, and the sizeof(uint16_t) will also == 1, and so a uint16_t of 
0x1234 memcpy'd into a uint8_t array will not appear as {0x12, 0x34} but 
rather as {0x34, 0x00} regardless of your endian-ness (the Most Sig 8 
bits hidden by the allowed range). Memcpy is only portability-safe when 
used to copy between two identical data types. It is also the reason you 
see things like sizeof(uint16_t) being passed as arguments to the mem* 
functions.

That axiom is also true when copying data between unions and/or stucts 
with different underlying definitions. The layout of raw bits can never 
be assumed.

>>
>> I am not saying I agree with the need to store UUIDs in anything but network order, however if I were to write a portable function that will always work in this instance, I would eliminate all usage of memcpy here and do something like:
>>
>> uuid128->value.u128.data[SHORT_UUID_LE_0] = (uint8_t) data;
>> uuid128->value.u128.data[SHORT_UUID_LE_1] = (uint8_t) (data>>  8);
>>
>> And likewise for uuid32 to uui128:
>> uuid128->value.u128.data[SHORT_UUID_LE_2] = (uint8_t) (data>>  16);
>> uuid128->value.u128.data[SHORT_UUID_LE_3] = (uint8_t) (data>>  24);
>
> I don't feel it's any better. This is Claudio's style, I'd prefer something like
>
> *((uint16_t* )&uuid128->value.u128.data[BASE_UUID16_OFFSET]) = data;

I personally think this slightly preferable to memcpy, but still not 
100% portable unless targeted only for 8-bit addressable CPUs.


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
