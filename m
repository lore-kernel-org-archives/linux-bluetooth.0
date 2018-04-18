Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <B738AD8F-D0DA-4BFE-ADE9-9AEE08437D59@holtmann.org>
References: <20180418110502.13099-1-luiz.dentz@gmail.com> <20180418110502.13099-2-luiz.dentz@gmail.com>
 <B738AD8F-D0DA-4BFE-ADE9-9AEE08437D59@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 18 Apr 2018 17:44:34 +0300
Message-ID: <CABBYNZLCcws0W7yCXoV86M+NgjCEWzKwWzgakbswH-L6dLcMPg@mail.gmail.com>
Subject: Re: [RFC 2/7] doc/device-api: Add AdvertisingData property
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Apr 18, 2018 at 5:19 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> This adds AdvertisingData which exposes data being advertised which is
>> may be useful for profiles not handled by bluetoothd.
>> ---
>> doc/device-api.txt | 5 +++++
>> 1 file changed, 5 insertions(+)
>>
>> diff --git a/doc/device-api.txt b/doc/device-api.txt
>> index 1b448eef1..f2f8464bc 100644
>> --- a/doc/device-api.txt
>> +++ b/doc/device-api.txt
>> @@ -251,3 +251,8 @@ Properties        string Address [readonly]
>>               array{byte} AdvertisingFlags [readonly, experimental]
>>
>>                       The Advertising Data Flags of the remote device.
>> +
>> +             dict AdvertisingData [readonly, experimental]
>> +
>> +                     The Advertising Data of the remote device. Keys are
>> +                     are 8 bits AD Type followed by data as byte array.
>
> this somehow needs to be explained on how a dict like that would look like. And also which AD types are _not_ valid here. Or at least not valid in conjunction with using other properties.

Sure, I can add a couple of examples for the existing profiles like
Transport Discovery Data. For the peripheral we could limit the
available type to just AD types available in the assigned number, like
a whitelist, or blacklist the types that either kernel or bluetooothd
are managing, I guess either way would work but maintaining the first
option might be more troublesome since there are new profile being
adopted all the time which was the reason why I haven't bother adding
profile specific properties since we would end up with too many. There
is also the option to use Advertising1 interface instead of Device1
that way central and peripheral APIs would be symmetric.

Btw, I don't know what went wrong with Service Data type, afaik that
was meant for the profile to use instead of each creating its own AD
type, now types can be profile specific without the use of the UUIDs
which makes it hard to correlate with the actual profile.

> Regards
>
> Marcel
>



-- 
Luiz Augusto von Dentz
