Return-Path: <cyrus@holtmann.org>
Message-ID: <4D712A3D.6090402@codeaurora.org>
Date: Fri, 04 Mar 2011 10:06:53 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
CC: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH 1/5] Add new UUID utility functions
References: <1299255640-13599-1-git-send-email-epx@signove.com>
In-Reply-To: <1299255640-13599-1-git-send-email-epx@signove.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

I'm trying to understand the problem being addressed by these patches. I 
am guessing that there is a difference in behaviour between little 
endian and big endian architectures, but I still question some of the 
changes.

One example below.

On 11-03-04 08:20 AM, Elvis Pfützenreuter wrote:
[...]
> +
> +#if __BYTE_ORDER == __BIG_ENDIAN
> +static uint128_t bluetooth_base_uuid = {
> +	.data = {	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
> +			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB }
> +};
> +
> +#define BASE_UUID16_OFFSET	2
> +#define BASE_UUID32_OFFSET	0
> +
> +#else
> +static uint128_t bluetooth_base_uuid = {
> +	.data = {	0xFB, 0x34, 0x9B, 0x5F, 0x80, 0x00, 0x00, 0x80,
> +			0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 }
> +};
> +
> +#define BASE_UUID16_OFFSET	12
> +#define BASE_UUID32_OFFSET	BASE_UUID16_OFFSET
> +
> +#endif
> +
> +static void bt_uuid16_to_uuid128(const bt_uuid_t *uuid16, bt_uuid_t *uuid128)
> +{
> +	uint16_t data;
> +
> +	uuid128->value.u128 = bluetooth_base_uuid;
> +	uuid128->type = BT_UUID128;
> +
> +	memcpy(&data,&bluetooth_base_uuid.data[BASE_UUID16_OFFSET], 2);

This line should always be copying Zero, and so more directly should be 
data = 0; These appear to be bluetooth specific, so the 4 MSBs of the 
base are Zero by definition.

> +	data += uuid16->value.u16;

Given the above line, this would become "data = uuid16->value.16", and 
the other eliminated.

> +
> +	memcpy(&uuid128->value.u128.data[BASE_UUID16_OFFSET],&data, 2);

I don't believe this line to be always portable between platforms. This 
line makes the assumption that a uint16_t is two native units (not 
always true) and can therefore be directly memcopy'd into into an array 
of uint8_t array members. This is not always true. memcpy should never 
be used in portable code when packing data for network datagram usage 
models (anything that treats data as an octet stream).

I am not saying I agree with the need to store UUIDs in anything but 
network order, however if I were to write a portable function that will 
always work in this instance, I would eliminate all usage of memcpy here 
and do something like:

uuid128->value.u128.data[SHORT_UUID_LE_0] = (uint8_t) data;
uuid128->value.u128.data[SHORT_UUID_LE_1] = (uint8_t) (data >> 8);

And likewise for uuid32 to uui128:
uuid128->value.u128.data[SHORT_UUID_LE_2] = (uint8_t) (data >> 16);
uuid128->value.u128.data[SHORT_UUID_LE_3] = (uint8_t) (data >> 24);


Where depending on the endian, SHORT_UUID_LE_0 thru SHORT_UUID_LE_3 
would be defined as 3 thru 0 for Big Endian storage, and 12 thru 15 for 
Little Endian storage.

This is guaranteed to put the desired octet into it's correct position 
within the uuid128's data array, while it could not be guaranteed across 
platforms with memcpy.

> +}


Regards,

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
