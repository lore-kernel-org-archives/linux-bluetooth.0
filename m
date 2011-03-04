Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/5] Add new UUID utility functions
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=iso-8859-1
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <4D712A3D.6090402@codeaurora.org>
Date: Fri, 4 Mar 2011 15:32:00 -0300
Cc: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Message-Id: <0881010B-89C3-40B7-A48E-A85E1BDD0E6C@signove.com>
References: <1299255640-13599-1-git-send-email-epx@signove.com> <4D712A3D.6090402@codeaurora.org>
To: Brian Gix <bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On 4 Mar 2011, at 15:06 , Brian Gix wrote:

> Hi Elvis,
> 
> I'm trying to understand the problem being addressed by these patches. I am guessing that there is a difference in behaviour between little endian and big endian architectures, but I still question some of the changes.
> 
> One example below.
> 
> On 11-03-04 08:20 AM, Elvis Pfützenreuter wrote:
> [...]
>> +
>> +#if __BYTE_ORDER == __BIG_ENDIAN
>> +static uint128_t bluetooth_base_uuid = {
>> +	.data = {	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
>> +			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB }
>> +};
>> +
>> +#define BASE_UUID16_OFFSET	2
>> +#define BASE_UUID32_OFFSET	0
>> +
>> +#else
>> +static uint128_t bluetooth_base_uuid = {
>> +	.data = {	0xFB, 0x34, 0x9B, 0x5F, 0x80, 0x00, 0x00, 0x80,
>> +			0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 }
>> +};
>> +
>> +#define BASE_UUID16_OFFSET	12
>> +#define BASE_UUID32_OFFSET	BASE_UUID16_OFFSET
>> +
>> +#endif
>> +
>> +static void bt_uuid16_to_uuid128(const bt_uuid_t *uuid16, bt_uuid_t *uuid128)
>> +{
>> +	uint16_t data;
>> +
>> +	uuid128->value.u128 = bluetooth_base_uuid;
>> +	uuid128->type = BT_UUID128;
>> +
>> +	memcpy(&data,&bluetooth_base_uuid.data[BASE_UUID16_OFFSET], 2);
> 
> This line should always be copying Zero, and so more directly should be data = 0; These appear to be bluetooth specific, so the 4 MSBs of the base are Zero by definition.
> 
>> +	data += uuid16->value.u16;
> 
> Given the above line, this would become "data = uuid16->value.16", and the other eliminated.

Perhaps we were a bit precious here :)

> 
>> +
>> +	memcpy(&uuid128->value.u128.data[BASE_UUID16_OFFSET],&data, 2);
> 
> I don't believe this line to be always portable between platforms. This line makes the assumption that a uint16_t is two native units (not always true) and can therefore be directly memcopy'd into into an array of uint8_t array members. This is not always true. memcpy should never be used in portable code when packing data for network datagram usage models (anything that treats data as an octet stream).

If we had used "unsigned char" and "unsigned short int", I'd agree, but uint8_t and uint16_t are *explicitly* 8-bit and 16-bit types, and thus there is a guaranteed 2:1 size relationship.

> 
> I am not saying I agree with the need to store UUIDs in anything but network order, however if I were to write a portable function that will always work in this instance, I would eliminate all usage of memcpy here and do something like:
> 
> uuid128->value.u128.data[SHORT_UUID_LE_0] = (uint8_t) data;
> uuid128->value.u128.data[SHORT_UUID_LE_1] = (uint8_t) (data >> 8);
> 
> And likewise for uuid32 to uui128:
> uuid128->value.u128.data[SHORT_UUID_LE_2] = (uint8_t) (data >> 16);
> uuid128->value.u128.data[SHORT_UUID_LE_3] = (uint8_t) (data >> 24);

I don't feel it's any better. This is Claudio's style, I'd prefer something like

*((uint16_t* ) &uuid128->value.u128.data[BASE_UUID16_OFFSET]) = data;

> 
> 
> Where depending on the endian, SHORT_UUID_LE_0 thru SHORT_UUID_LE_3 would be defined as 3 thru 0 for Big Endian storage, and 12 thru 15 for Little Endian storage.
> 
> This is guaranteed to put the desired octet into it's correct position within the uuid128's data array, while it could not be guaranteed across platforms with memcpy.
> 
>> +}
> 
> 
> Regards,
> 
> -- 
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

