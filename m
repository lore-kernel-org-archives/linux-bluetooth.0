Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2 v3] Add generic descriptor support to Attribute API document
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=iso-8859-1
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <AANLkTik9wa_Pzezs3_udVD9MzwjxOaAAdEugjrD_U-KG@mail.gmail.com>
Date: Thu, 24 Feb 2011 16:34:26 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C0C1E181-6699-4545-9AEC-EB813F387EBD@signove.com>
References: <1298468980-2215-1-git-send-email-epx@signove.com> <AANLkTik9wa_Pzezs3_udVD9MzwjxOaAAdEugjrD_U-KG@mail.gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On 24 Feb 2011, at 15:29 , Anderson Lizardo wrote:

> Hi Elvis,
> 
> On Wed, Feb 23, 2011 at 10:49 AM, Elvis Pfützenreuter <epx@signove.com> wrote:
>> This patch proposes extensions to Attribute API, giving access to all
>> characteristic descriptors (beyond 'Description' and 'Format').
>> 
>> Client Characteristic Configuration automatic update upon Watcher
>> registering will be handled by another patch series.
>> ---
>>  doc/attribute-api.txt |   30 ++++++++++++++++++++++++++++++
>>  1 files changed, 30 insertions(+), 0 deletions(-)
>> 
>> diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
>> index 23808e6..bb7cbfa 100644
>> --- a/doc/attribute-api.txt
>> +++ b/doc/attribute-api.txt
>> @@ -104,6 +104,7 @@ Methods             dict GetProperties()
>> 
>>                        Possible Errors: org.bluez.Error.InvalidArguments
>> 
>> +
>>  Properties     string UUID [readonly]
>> 
>>                        UUID128 of this characteristic.
>> @@ -143,6 +144,35 @@ Properties         string UUID [readonly]
>>                        Friendly representation of the Characteristic Value
>>                        based on the format attribute.
>> 
>> +               dict Descriptors [readwrite]
>> +
>> +                       Dict of descriptors for this characteristic.
>> +
>> +                       This dict contains only the descriptors not already
>> +                       covered by other properties (v.g. Description, Format).
>> +
>> +                       Each descriptor is mapped to an unique object path,
>> +                       which is the dict key.
>> +
>> +                       Each dict value is, in turn, a dict with at least
>> +                       the following keys:
>> +
>> +                       {
>> +                               "UUID": string. Descriptor UUID, always present
>> +                               "Value": array of bytes. Raw descriptor value,
>> +                                        present only when/if descriptor value
>> +                                        has been fetched.
>> +                       }
>> +
>> +                       When updating a descriptor value using SetProperty(),
>> +                       only one descriptor at a time may be updated in order
>> +                       to guarantee unambiguous error reporting. In other
>> +                       words, when calling SetProperty('Descriptors', dict),
>> +                       dict must have exactly one entry.
>> +
>> +                       Descriptor's UUID may not be updated. If present, it is
>> +                       ignored by SetProperty().
> 
> With all those restrictions for writing, do you think it makes sense
> to allow writing to the "Descriptors" property? Can you mention
> situations where you might want applications to modify descriptors?

Apart from CCC (which we plan to deal with in another series), no :( 

But GATT has this feature, so a general API should IMHO have it, since some
future GATT-based profile may well use it.

Actually, there is just one restriction for writing: one descriptor at a time,
and I propose this just because of difficulties in error reporting (if e.g. 
2 out of 5 descriptors could not be updated due to lack of permissions, yet
just 1 error can be reported back).