Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH BlueZ v3 01/11] doc/mgmt-api: Add support for Set Phy
 Configuration command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJzH+bo0GnRa-5uvkYHWekPWsjHVmm_6gZTgHhJQ_n6j7fLzBw@mail.gmail.com>
Date: Thu, 28 Jun 2018 10:41:23 +0200
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <E90B469C-7FC2-4B52-A6D2-0FDCE0C1BDA1@holtmann.org>
References: <1528978884-3882-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1528978884-3882-2-git-send-email-jaganathx.kanakkassery@intel.com>
 <8ACDAD02-53CF-4D39-A533-918154485903@holtmann.org>
 <CAJzH+bo0GnRa-5uvkYHWekPWsjHVmm_6gZTgHhJQ_n6j7fLzBw@mail.gmail.com>
To: Jaganath K <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

>>> This also adds PHY Configuration Changed Event.
>>> ---
>>> doc/mgmt-api.txt | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>> 1 file changed, 81 insertions(+)
>>> 
>>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>>> index 8e7de14..caba22d 100644
>>> --- a/doc/mgmt-api.txt
>>> +++ b/doc/mgmt-api.txt
>>> @@ -2917,6 +2917,72 @@ Set Appearance Command
>>>                              Invalid Index
>>> 
>>> 
>>> +Get PHY Configuration Command
>>> +==========================
>>> +
>>> +     Command Code:           0x0043
>>> +     Controller Index:       <controller id>
>>> +     Command Parameters:
>>> +     Return Parameters:      Supported_phys (2 Octet)
>>> +                             Selected_phys (2 Octet)
>>> +
>>> +     This command is used to retrieve the supported PHYs and currently
>>> +     selected PHYs.
>>> +
>>> +     Supported_phys and Selected_phys is a bitmask with the following bits.
>>> +             0       LE 1M TX
>>> +             1       LE 1M RX
>>> +             2       LE 2M TX
>>> +             3       LE 2M RX
>>> +             4       LE CODED TX
>>> +             5       LE CODED RX
>>> +
>>> +     LE 1M TX and LE 1M RX would be supported by default.
>>> +
>>> +     This command is only available for LE capable controllers.
>>> +        It will return Not Supported otherwise.
>>> +
>>> +        Possible errors:     Not Supported
>>> +                             Invalid Index
>> 
>> so I spent some time thinking about how useful it is to make this LE specific or if we allow BR/EDR configuration as well. I concluded that we want to include BR/EDR as well and also tell exactly what options are configurable and which ones are static.
>> 
>>        Command Code:           0x0043
>>        Controller Index:       <controller id>
>>        Command Parameters:
>>        Return Parameters:      Supported_PHYs (4 Octets)
>>                                Configurable_PHYs (4 Octets)
>>                                Selected_PHYs (4 Octets)
>> 
>>        The PHYs parameters are a bitmask with currently the
>>        following available bits:
>> 
>>                0       BR 1M 1-Slot
>>                1       BR 1M 3-Slot
>>                2       BR 1M 5-Slot
>>                3       EDR 2M 1-Slot
>>                4       EDR 2M 3-Slot
>>                5       EDR 2M 5-Slot
>>                6       EDR 3M 1-Slot
>>                7       EDR 3M 3-Slot
>>                8       EDR 3M 5-Slot
> 
> Accordingly set the packet type in "HCI CreateConnection”?

initially I would be fine if this gets reported correctly as what is supported and what is selected, but yes, set them according via HCI Create Connection. However there is a legacy ioctl for pkt_type that we need to make work correctly. Mind you that EDR bits are inverted in the pkt_type mask.

>>                9       LE 1M TX
>>                10      LE 1M RX
>>                11      LE 2M TX
>>                12      LE 2M RX
>>                13      LE Coded TX
>>                14      LE Coded RX
>> 
>>        If BR/EDR is supported, then BR 1M 1-Slot is supported by
>>        default and can also not be deselected. If LE is supported,
>>        then LE 1M TX and LE 1M RX are supported by default and can
>>        not be deselected.
>> 
> 
> I think in LE case user should be able to select only CODED and deselect
> 1M as there can be use cases which need only LR.

That is why I added Configurable_PHYs. Initially LE 1M TX/RX would not be configurable if LE is available, they would be always present. We can change that later once we can do Coded only devices.

Regards

Marcel

