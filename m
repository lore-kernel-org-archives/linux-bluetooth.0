Return-Path: <cyrus@holtmann.org>
Message-ID: <4E5342AE.10908@nokia.com>
Date: Tue, 23 Aug 2011 09:03:26 +0300
From: Antti Julku <antti.julku@nokia.com>
MIME-Version: 1.0
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
        ext Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
CC: johan.hedberg@gmail.com
Subject: Re: [PATCH] Bluetooth: Add mgmt command for fast connectable mode
References: <1308737516-3303-1-git-send-email-antti.julku@nokia.com> <1309309092.2208.25.camel@aeonflux> <CAHMBquWSLjzKKyM2xuMUakHeBb-FMLUWXLj2_Tz4Ye1MWj37qw@mail.gmail.com> <CAKT1EBfQaTSjQe6sZnC5Wx52iPmyo6SSfYD0Ci+_qb1Dbq32+g@mail.gmail.com> <4E3A5BFB.1050201@nokia.com> <4E425061.6080206@nokia.com> <1312984559.3373.122.camel@aeonflux> <4E4E592C.7060103@nokia.com> <20110822180151.GB21949@joana> <CAKT1EBfpB8DfOBgj=gwKTKGecmj-R-7gZ3zJm+8OQFekZPu7HQ@mail.gmail.com> <20110822194844.GC21949@joana>
In-Reply-To: <20110822194844.GC21949@joana>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Gustavo,

On 08/22/2011 10:48 PM, ext Gustavo Padovan wrote:

>>>> Set Fast Connectable Command
>>>> ============================
>>>>
>>>> Command Code:           0x0001F
>>>> Controller Index:<controller id>
>>>> Command Parameters:     Enable (1 Octet)
>>>> Return Parameters:      Status (1 octet)
>>>>
>>>> Configure BR Fast Connectable Mode Command
>>>> ==========================================
>>>>
>>>> Command Code:           0x00020
>>>> Controller Index:<controller id>
>>>> Command Parameters:     Page_scan_type (1 Octet)
>>>>                          Page_scan_interval (1 Octet)
>>>> Return Parameters:      Status (1 octet)
>>>>
>>>> Configure LE Fast Connectable Mode Command
>>>> ==========================================
>>>>
>>>> Command Code:           0x00021
>>>> Controller Index:<controller id>
>>>> Command Parameters:     Adv_interval (1 Octet)
>>>>                          ...and maybe some other settings if needed
>>>> Return Parameters:      Status (1 octet)
>>>
>>> Can't both command be merged into one? LE Advertisement could be a scan type.
>>> But this won't work if we need more settings for LE.
>>>
>>>         Gustavo
>>>
>>
>> Another input: for GATT based profiles after the disconnection the
>> specs are recommending advertising interval values for fast
>> reconnection in the first 30 seconds and reduced power mode after 30
>> seconds.
>> Of course, there are some implementations that disable advertising
>> after some time.
>>
>> At the moment, the incoming connection for dual mode device are not
>> allowed by the spec.
>>
>> My opinion is: parameters could be omitted. BR/EDR and LE could use
>> hard-coded settings for on/off of each transport. Add BR/EDR or LE
>> specific parameter in the Management interface commands doesn't look a
>> suitable approach. A simple on/off command seems to be more flexible
>> for future changes.
>
> Ok, so we could go only with Set Fast Connectable for now and use hardcoded
> values It's too early to say if we will need to to tune the those values for
> LE.
>
> 	Gustavo

So the initial fast connectable patch I sent is actually what we want? 
Implementation for LE can be easily added later, when it's clear how LE 
fast connectable should work. Please apply the patch then.

Br,
Antti
