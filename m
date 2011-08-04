Return-Path: <cyrus@holtmann.org>
Message-ID: <4E3A9D0B.7080706@start.ca>
Date: Thu, 04 Aug 2011 09:22:19 -0400
From: Colin Beckingham <colbec@start.ca>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Permission denied (13) on Samsung WEP475 headset?
References: <4E3A7E09.6040503@start.ca> <20110804121703.GA23534@dell>
In-Reply-To: <20110804121703.GA23534@dell>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/04/2011 08:17 AM, Johan Hedberg wrote:
> Hi Colin,
>
> On Thu, Aug 04, 2011, Colin Beckingham wrote:
>> I'd like to provide some feedback regarding a Samsung WEP475 headset
>> which fails to connect to linux specifically.
>>
>> The USB bluetooth adapter is a Model: Belkin BLUETOOTH USB +EDR
>> ADAPTER v2.1 UHE which successfully interconnects with 2 Jabra and 1
>> Plantronics headsets, plus a Nokia E71 phone. Samsung WEP475
>> successfully connects to a Windows XP machine and to the Nokia E71.
>>
>> Using Opensuse 11.4 with custom kernel 3.0 currently, (also fails
>> with 2.6.38), bluez 4.96 and bluedevil manager.
>>
>> Symptoms are that bluedevil sees the headset in pairing mode and
>> correctly retrieves the name WEP475, connected button flashes green
>> and then returns to grey (not connected). WEP475 led changes to
>> connected status but bluedevil shows headset not connected and
>> headset does not work.
>>
>> With bluetoothd in debug mode, I get the following transactions in
>> /var/log/messages:
>
> There seems to be something strange going on with the secure simple
> pairing logic. For some reason the initial link key isn't good enough
> (auth request + link key negative reply after the initial key has been
> generated) and then there's a user confirm negative reply for the second
> attempt. It'd be good to get to the bottom of this and fix it properly,
> but meanwhile you can probably work around this by disabling SSP on your
> side (hciconfig hci0 sspmode 0) and retrying pairing.
>
> Johan
>

Johan, sspmode 0 did have a positive effect. I have now been able to 
pair the headset and use it in a pipe arecord to aplay context with good 
results at least two times from scratch. Thanks very much.

What further feedback would be useful to developers to track down the 
fundamental issue?
-- 
---
Colin Beckingham

