Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/3] Add generic descriptor support to Attribute API document
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=iso-8859-1
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <AANLkTimDdtdSUFqoVyGUy-UC_r3y_pu9N5dO9CBD9dfi@mail.gmail.com>
Date: Mon, 21 Feb 2011 18:24:18 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4604BFBC-2A92-4885-BC7B-16A9E6856603@signove.com>
References: <1297880021-31728-1-git-send-email-epx@signove.com> <1297880021-31728-2-git-send-email-epx@signove.com> <AANLkTi=X=E_VA7p0J6aj+kcJYPA7mUJiqjs+xySKJ6EE@mail.gmail.com> <F8CC68A2-1854-466D-AC84-37B50D05F847@signove.com> <AANLkTimDdtdSUFqoVyGUy-UC_r3y_pu9N5dO9CBD9dfi@mail.gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On 21 Feb 2011, at 18:14 , Claudio Takahasi wrote:

> Hi Elvis,
> 
> On Mon, Feb 21, 2011 at 7:39 PM, Elvis Pfützenreuter <epx@signove.com> wrote:
>> 
>> On 21 Feb 2011, at 16:14 , Claudio Takahasi wrote:
>> 
>>> Hi,
>>> 
>>> 
>>> On Wed, Feb 16, 2011 at 6:13 PM, Elvis Pfützenreuter <epx@signove.com> wrote:
>>>> This patch proposes extensions to Attribute API, giving access to all
>>>> characteristic descriptors (beyond 'Description' and 'Format').
>>>> ---
>>>>  doc/attribute-api.txt |   28 ++++++++++++++++++++++++++++
>>>>  1 files changed, 28 insertions(+), 0 deletions(-)
>>>> 
>>>> diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
>>>> index 23808e6..5ee189e 100644
>>>> --- a/doc/attribute-api.txt
>>>> +++ b/doc/attribute-api.txt
>>>> @@ -104,6 +104,14 @@ Methods            dict GetProperties()
>>>> 
>>>>                        Possible Errors: org.bluez.Error.InvalidArguments
>>>> 
>>>> +               void SetDescriptorValue(object descriptor, array{byte} value)
>>>> +
>>>> +                       Sets descriptor value, provided that it is writable.
>>>> +
>>>> +                       Possible Errors: org.bluez.Error.InvalidArguments
>>>> +                                       org.bluez.Error.NotAuthorized
>>>> +
>>>> +
>>>>  Properties     string UUID [readonly]
>>>> 
>>>>                        UUID128 of this characteristic.
>>>> @@ -143,6 +151,26 @@ Properties         string UUID [readonly]
>>>>                        Friendly representation of the Characteristic Value
>>>>                        based on the format attribute.
>>>> 
>>>> +               dict Descriptors [readonly]
>>>> +
>>>> +                       List of descriptors for this characteristic.
>>>> +
>>>> +                       This list contains only the descriptors not already
>>>> +                       covered by other properties (v.g. Description, Format).
>>>> +
>>>> +                       Each descriptor is mapped to an unique object path,
>>>> +                       which is the key for the dict.
>>>> +
>>>> +                       Each dict value is, in turn, a dict with at least
>>>> +                       the following keys:
>>>> +
>>>> +                       {
>>>> +                               "UUID": string (descriptor UUID - mandatory),
>>>> +                               "Value": array of bytes (raw descriptor value -
>>>> +                                        optional, shows up when value can be
>>>> +                                        fetched)
>>>> +                       }
>>>> +
>>>> 
>>>>  Characteristic Watcher hierarchy
>>>>  ===============================
>>>> --
>>>> 1.7.1
>>>> 
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> 
>>> 
>>> In my opinion is not a good approach to allow applications(D-Bus
>>> clients) to change a behavior/value of the same characteristic
>>> descriptor. bluetoothd could manage automatically writing the client
>>> characteristic configuration and server characteristic configuration
>>> based on the registered watchers and supported client profiles.
>> 
>> I'm not sure I follow, but let's break it down:
>> 
>> 1) Note that this API is not just for client (and server) characteristic configuration descriptors. It is good for any kind of descriptor (like Valid Range, that client is supposed to be able to read, and set the related characteristic within its limits).
> 
> The API already has SetProperty and GetProperties that could expose
> the descriptors that you need.

Yes, but note that biggest part of proposal is exactly to add one more
item to be returned by GetProperties() :)

If you mean that a separate method to update descriptors is not ok, and
using SetProperty() to do that is the way, I understand.

> 
>> 
>> 2) Updating automatically CCC/SCC descriptors based on Watchers sounds nice. We just need to add some kind of flag to agent registering in order to tell if we want notification or indication.
> 
> This is our initial ideia, but it is not written in the stone yet. We
> need to investigate a little bit more and see which/how the Profiles
> are using these characteristics descriptors.

Ok, but I think it is near perfect.

>> 
>> 3) In terms of client profiles, the GATT API looks generic to me, not profile-specific. As there is a way to access characteristic values in a generic way, so there is a need to do the same for descriptors.
> 
> For some descriptors I agree that we need to expose through the D-Bus
> API. However for others such as CCC and SCC I don't think that we need
> to allow the apps to change it. If necessary we will also have a
> plugin or a service specific interface, one example is Proximity
> Profile. Do you have a good use case/example in health profiles using
> CCC and SCC?

Yes, I will send you the details.