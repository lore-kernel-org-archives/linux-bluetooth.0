Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110221165431.GA9130@jh-x301>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
	<AANLkTinzZ+nNSx6qq0xMXO8ZVLt5r-r0pgcjRBa7MaxY@mail.gmail.com>
	<AANLkTimjYJTVq5dgmisV8c74rZAvpmpHL=g78feOG-_T@mail.gmail.com>
	<AANLkTi=ghX3SS0CUZDKM4pwOt9bPJBnRZGA3cRojwOgs@mail.gmail.com>
	<AANLkTimR3cpHEVBUOrPH9LRnmszNdmfg37hN__PWkYUQ@mail.gmail.com>
	<20110221165431.GA9130@jh-x301>
Date: Mon, 21 Feb 2011 20:37:50 +0200
Message-ID: <AANLkTind73aFXZOo0NgLPYknuUmyNoU4amUDid6bLAWj@mail.gmail.com>
Subject: Re: [RFC v2 00/14] Store UUID-128 on host order
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Feb 21, 2011 at 6:54 PM, Johan Hedberg <johan.hedberg@gmail.com> wr=
ote:
> Hi Luiz,
>
> On Mon, Feb 21, 2011, Luiz Augusto von Dentz wrote:
>> > Just throwing my own bits on this: I think making the internal
>> > representation for uuid_t consistent is important to avoid bugs when
>> > handling the different UUID types.
>> >
>> > currently uuid_t stores 16/32-bit uuids and 128-bit uuid differently.
>>
>> The problem is not the internal representation, but things like this:
>>
>> - =A0 =A0 =A0 sdp_uuid128_create(&svclass_uuid, SYNCMLC_UUID);
>> + =A0 =A0 =A0 ntoh128(SYNCMLC_UUID, &h128);
>> + =A0 =A0 =A0 sdp_uuid128_create(&svclass_uuid, &h128);
>>
>> This means the API has changed, it now takes host order where it used
>> to be network order. We could have a new function e.g.
>> sdp_uuid128h_create to handle such cases and not break existing
>> applications using this API.
>
> In this particular case the prefix sdp_ already implies that this is for
> SDP and shouldn't be used in other code. I think what makes sense (and
> Marcel supported it in IRC) is to a new bt_uuid_t struct and bt_uuid_*
> helper functions which internally store everything in host byte order.
> Then in the first phase we can make the ATT code use the new API and
> later in a second phase start converting existing SDP code to use it.

Sound good to me.



--=20
Luiz Augusto von Dentz
Computer Engineer
