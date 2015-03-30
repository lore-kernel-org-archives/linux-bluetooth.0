Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <55185E7F.9040604@cchtml.com>
References: <5517B933.1080809@cchtml.com>
	<CABBYNZ+VdZkU9y2TyH_6rsM_=8tVdGNrXUp9yX5NTAjy5k06bQ@mail.gmail.com>
	<55185E7F.9040604@cchtml.com>
Date: Mon, 30 Mar 2015 10:13:53 +0300
Message-ID: <CABBYNZJS9e2aGeX+cWnNWycvDv6XNKs-xNyoPqKLzdJrqzd-vw@mail.gmail.com>
Subject: Re: header change affects c++ projects
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Cronenworth <mike@cchtml.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Sun, Mar 29, 2015 at 11:20 PM, Michael Cronenworth <mike@cchtml.com> wrote:
> On 03/29/2015 01:57 PM, Luiz Augusto von Dentz wrote:
>>
>> It will probably get applied, no reason to get neurotic on the weekend
>> no one said we would not take it, so please be patience.
>
>
> I'm not following you here. What are you trying to say?

I though you were the same guy sending the patch, nevermind we have a
fix already.

>> It is a fix to uuid: Add bt_uuid_to_le since the convention is to define
>> 128 bit UUIDs as big endian which then need to be swaped regardless of
>> endianess.
>
>
> The commit doesn't change anything though. Please revert it or fix it to not
> have a conversion or precision loss. If you need help I will make a patch.

uint128_t is a byte array:

typedef struct {
uint8_t data[16];
} uint128_t;

There is no precision loss.


-- 
Luiz Augusto von Dentz
