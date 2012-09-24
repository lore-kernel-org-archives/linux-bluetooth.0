Return-Path: <cyrus@holtmann.org>
Message-ID: <5060137B.6050302@tieto.com>
Date: Mon, 24 Sep 2012 10:02:03 +0200
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Cycling Speed and Cadence profile (CSCP) API
References: <1348218561-24509-1-git-send-email-andrzej.kaczmarek@tieto.com> <1348218561-24509-2-git-send-email-andrzej.kaczmarek@tieto.com> <CAJdJm_PyC22Les5_=+z+MjnbFzGGZ7CepQNEo9QRdV0z_SaUKA@mail.gmail.com>
In-Reply-To: <CAJdJm_PyC22Les5_=+z+MjnbFzGGZ7CepQNEo9QRdV0z_SaUKA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On 09/21/2012 05:51 PM, Anderson Lizardo wrote:
> Hi Andrzej,
>
> On Fri, Sep 21, 2012 at 5:09 AM, Andrzej Kaczmarek
> <andrzej.kaczmarek@tieto.com> wrote:
>> +Cycling Speed and Cadence API description
>> +****************************************
>> +
>> +Copyright (C) 2012     Tieto Poland
>> +
>> +Cycling Manager hierarchy
>> +============================
>> +
>> +Service                org.bluez
>> +Interface      org.bluez.CyclingManager
>
> I don't have much to comment on the API as I haven't had time to read
> the CSCP spec yet, but about the name prefix, what about
> "CyclingSpeed" (and "RunningSpeed" for the future RSCP) ? Too long?

Ok for me. Not too long for sure, Thermometer is just 1 letter shorter.

> The "Cycling" name is slightly uncommon, but still not that bad IMHO.

In spec there's also SC used as shortcut for 'Speed and Cadence' but I 
think CyclingSC does not work well with camel-case in interface name. Or 
actually is CyclingScManager ok? But plugin name (cyclingsc) will look a 
bit weird if derived from this name, cyclingspeed sounds better.

>> +Properties     String Location (optional) [readwrite]
>
> String -> string
>
>> +                               uint16 LastWheelEventTime (optional):
>> +
>> +                                       Value of Last Wheel Event time
>
> Better specify that this is in "1/1024 second units" (just checked on
> developer.bluetooth.org).
>
>> +
>> +                               uint16 CrankRevolutions (optional):
>> +
>> +                                       Cumulative number of crank revolutions
>> +
>> +                               uint16 LastCrankEventTime (optional):
>> +
>> +                                       Value of Last Crank Event time
>
> Same here.

Sure, I'll fix above issues.

BR,
Andrzej
