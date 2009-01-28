Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1233121919.18259.15.camel@violet>
References: <a172fe730901222111i1837081apadbf9402d57868c2@mail.gmail.com>
	 <1233121919.18259.15.camel@violet>
Date: Wed, 28 Jan 2009 15:23:51 +0800
Message-ID: <a172fe730901272323i7950cc46k3f9d9b94e4d8707f@mail.gmail.com>
Subject: Re: Can we connected HFP and A2DP at the same time?
From: =?GB2312?B?seXA2g==?= <mykofzone@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
   You are right. I make a mistake about HFP rfcomm channel num. Now,
i can connected HFP/A2DP at the sametime. Thanks.

Regards,
LeiBian.

2009/1/28 Marcel Holtmann <marcel@holtmann.org>:
> Hi,
>
>>      This is the case for the cellphone : suppose the user is
>> listening music via A2DP, then a call coming, the user can answer this
>> call via HFP (press answer key in the bluetooth headset). After the
>> call ending, the cellphone will continue to play music via A2DP.
>>     I test several headset on Moto A1200
>> (iTech/Jabra/SonyEricsson/Moto bluetooth headset). But not all the
>> headset can answer the call by pressing answer key. Only the
>> iTech/Jabra can pass this case.
>>     My question is : does the bluez protocol support connected HFP and
>> A2DP at the same time? Then how can i judge whether a headset support
>> this or not? Thanks.
>
> in theory you can, but there are certain physical limits and I don't
> know of any headset that does support it. BlueZ would be just fine in
> doing so.
>
> Regards
>
> Marcel
>
>
>
