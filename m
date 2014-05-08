Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1A84D9AC-18BD-4DAE-9456-202EC4BE2FB9@holtmann.org>
References: <1399553999-14566-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1A84D9AC-18BD-4DAE-9456-202EC4BE2FB9@holtmann.org>
Date: Fri, 9 May 2014 00:13:55 +0200
Message-ID: <CAN_7+YZqVrPZoZpoa2heUs4FYnwCpQhrVa9iChs9+65_4rEpdA@mail.gmail.com>
Subject: Re: [PATCH v3] mgmt-api: Add support to get connection information
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, May 8, 2014 at 4:54 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Lukasz,
>
>> This patch introduces Get Connection Information command.
>> ---
>>
>> v2: Changed Command name and add Flags into the response
>> v3: Added TXPowerMax into the response based on the comments we got.
>>
>> doc/mgmt-api.txt | 39 +++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 39 insertions(+)
>>
>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> index cd5cd24..8345048 100644
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -1679,6 +1679,45 @@ Load Identity Resolving Keys Command
>>                               Invalid Index
>>
>>
>> +Get Connection Information Command
>> +==================================
>> +
>> +     Command Code:           0x0031
>> +     Controller Index:       <controller id>
>> +     Command Parameters:     Address (6 Octets)
>> +                             Address_Type (1 Octet)
>> +                             Data_Type (4 Octet)
>> +     Return Parameters:      Address (6 Octets)
>> +                             Address_Type (1 Octet)
>> +                             RSSI (1 Octet)
>> +                             TXPowerMax (1 Octet)
>
> this one looks weird now. In this case, we better just do RSSI, TX Max Power and TX Power at the same time. So this needs a bit of thinking.
>
Unfortunately EIR has no place for TX Max power and TX power so it was
the only way to add it here.
Also, since spec defines max tx power per conn handle, I believe this
should be exposed with this command.

Other option as we could think of, to get TX Max from the kernel is in
EIR data in the Connected Event. But then we would delay Connected
event because we have to call additional hci command after connection
is done. Other counterargument for this solutions is that EIR contains
TX Power and not TX Max  according to spec.

So I'm coming back to idea that this command should give us
possibility to get TX Max.

I think that we have two options here:
1. fixed list of connection information types in the response like:
RSSI, TX power and TX max for now. Later this list could be extend and
it should be backward compatible.
 or
2. type and value list special for connection information. We would
keep in the command data type parameter which would indicate should be
read.

In both cases we have flexibility to add new things.

Frankly speaking I have feeling that EIR does not fit here. Those data
are already provided in different way to daemon and this is actually
inquiry data. As we can see now, it also limit us in extending this
command.

> Just start with the basic implementation and we sort out the details of the mgmt later. Right now I would have left the TX Max Power out of it completely.
>
> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


BR
Lukasz
