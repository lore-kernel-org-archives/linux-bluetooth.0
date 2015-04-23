Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAD0=r8wwaphDe+sZCB1WiyZK0BvAD-hN40ReUud9mGe8F0mn6Q@mail.gmail.com>
References: <1429319372-25172-1-git-send-email-jpawlowski@google.com>
	<CABBYNZJjNLoeF3Yc5n+f7W7V0pN5tXmek9GyHNNmZ36Vy4Nhjw@mail.gmail.com>
	<CAD0=r8zdTAnR25junwBfU23KhCXMkxZXgUf3ouDsn9g6Y-PNjA@mail.gmail.com>
	<CAD0=r8x_sWuPo+JMhAdiA7GXJqX+XED7qwbJzBb7VF9tA1THPg@mail.gmail.com>
	<CABBYNZJJQvJD3wZ2GLQWeA9pJJ6u0v=X+ghZ-bZB-WHj6PSnhg@mail.gmail.com>
	<CAD0=r8wwaphDe+sZCB1WiyZK0BvAD-hN40ReUud9mGe8F0mn6Q@mail.gmail.com>
Date: Thu, 23 Apr 2015 23:07:33 +0300
Message-ID: <CABBYNZ+B_xa_ACHn+0TM6_6+AMgJ4WzPJfey3CAXb1tdQaYjkw@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc/device-api: Add TxPower
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thu, Apr 23, 2015 at 10:58 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> On Thu, Apr 23, 2015 at 12:50 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Jakub,
>>
>> On Thu, Apr 23, 2015 at 6:56 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>>> Ping ?
>>
>> Sorry, I forgot about this one.
>>
>>> On Mon, Apr 20, 2015 at 8:55 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>>>> Hi Luiz
>>>>
>>>> On Mon, Apr 20, 2015 at 7:32 AM, Luiz Augusto von Dentz
>>>> <luiz.dentz@gmail.com> wrote:
>>>>> Hi Jakub,
>>>>>
>>>>> On Sat, Apr 18, 2015 at 4:09 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>>>>>> This adds TxPower from advertisement data.
>>>>>>
>>>>>> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
>>>>>> ---
>>>>>>  doc/device-api.txt | 5 +++++
>>>>>>  1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/doc/device-api.txt b/doc/device-api.txt
>>>>>> index 72c597e..875fd9d 100644
>>>>>> --- a/doc/device-api.txt
>>>>>> +++ b/doc/device-api.txt
>>>>>> @@ -196,6 +196,11 @@ Properties string Address [readonly]
>>>>>>                         Received Signal Strength Indicator of the remote
>>>>>>                         device (inquiry or advertising).
>>>>>>
>>>>>> +               int16 TxPower [readonly, optional]
>>>>>> +
>>>>>> +                       Advertised transmitted power level (inquiry or
>>>>>> +                       advertising).
>>>>>> +
>>>>>>                 dict ManufacturerData [readonly, optional]
>>>>>>
>>>>>>                         Manufacturer specific advertisement data. Keys are
>>>>>> --
>>>>>> 2.2.0.rc0.207.ga3a616c
>>>>>
>>>>> I thought we discussed about this before and we would like to have the
>>>>> pathloss instead of TxPower, or do you have something else useful for
>>>>> TxPower?
>>>>
>>>> I don't remember such discussion, I remember we were discussing about
>>>> SetDiscoveryFilter, and it have option to filter by pathloss.
>>>> So I exposed TxPower for two reasons:
>>>> 1. It's just a field in advertisement, and I wanted just to access it
>>>> as any other.
>>>> 2. If I turn it into Pathloss field, it would change together with
>>>> RSSI, and PropertyChanged event will be doubled. Pathloss is very
>>>> simple to compute, so having only RSSI that change is more efficient.
>>
>> Fair enough, I just notice I did not mark the these properties as
>> experimental in the documentation, but no need to send another version
>> I will fix it when applying your patches.
>
> Ok, Thanks!

Applied after removing Signed-off-by line as well as fixing the
missing experimental flag, thanks.


-- 
Luiz Augusto von Dentz
