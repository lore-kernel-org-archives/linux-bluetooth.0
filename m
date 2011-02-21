Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=ghX3SS0CUZDKM4pwOt9bPJBnRZGA3cRojwOgs@mail.gmail.com>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
	<AANLkTinzZ+nNSx6qq0xMXO8ZVLt5r-r0pgcjRBa7MaxY@mail.gmail.com>
	<AANLkTimjYJTVq5dgmisV8c74rZAvpmpHL=g78feOG-_T@mail.gmail.com>
	<AANLkTi=ghX3SS0CUZDKM4pwOt9bPJBnRZGA3cRojwOgs@mail.gmail.com>
Date: Mon, 21 Feb 2011 15:52:58 +0200
Message-ID: <AANLkTimR3cpHEVBUOrPH9LRnmszNdmfg37hN__PWkYUQ@mail.gmail.com>
Subject: Re: [RFC v2 00/14] Store UUID-128 on host order
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>, linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Feb 21, 2011 at 3:43 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi,
>
> On Mon, Feb 21, 2011 at 10:14 AM, Claudio Takahasi
> <claudio.takahasi@openbossa.org> wrote:
>> On Sat, Feb 19, 2011 at 6:07 PM, Luiz Augusto von Dentz
>>> IMO it would be easier to have specific functions for uuid128 that can
>>> take data in host order, so that we don't break existing API. Note
>>> that the internal representation could be changed to host order, that
>>> is fine, but then you convert the existing function to do the
>>> conversion internally without breaking compatibility.
>>
>> Yes, it is easier. It will be necessary to add a function to convert
>> from little endian to big endian for ATT when the data is received.
>> I am not changing the API, it changes only the internal
>> representation(to host order) of the UUID128 values.
>
> Just throwing my own bits on this: I think making the internal
> representation for uuid_t consistent is important to avoid bugs when
> handling the different UUID types.
>
> currently uuid_t stores 16/32-bit uuids and 128-bit uuid differently.

The problem is not the internal representation, but things like this:

-       sdp_uuid128_create(&svclass_uuid, SYNCMLC_UUID);
+       ntoh128(SYNCMLC_UUID, &h128);
+       sdp_uuid128_create(&svclass_uuid, &h128);

This means the API has changed, it now takes host order where it used
to be network order. We could have a new function e.g.
sdp_uuid128h_create to handle such cases and not break existing
applications using this API.

-- 
Luiz Augusto von Dentz
Computer Engineer
