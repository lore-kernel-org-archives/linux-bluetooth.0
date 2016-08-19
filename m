Return-Path: <leigh.fiddes@atomos.com>
Subject: Re: [Proposed Patch Bluez v5] btmon: Print connection latency
 correctly
To: Marcel Holtmann <marcel@holtmann.org>
References: <155e0135-7d14-259d-322b-a582afb979c9@atomos.com>
 <35A91F39-E5C2-47F2-81D5-398797B31C1C@holtmann.org>
CC: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
From: Leigh Fiddes <leigh.fiddes@atomos.com>
Message-ID: <ccb0c2f9-0643-4030-3111-93f4d36f5b4e@atomos.com>
Date: Fri, 19 Aug 2016 22:01:01 +1000
MIME-Version: 1.0
In-Reply-To: <35A91F39-E5C2-47F2-81D5-398797B31C1C@holtmann.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> Hi Leigh,
>
>> I submit the following small patch for consideration.
>> Leigh
>> ---
>>
>> In at least two places the Connection Latency field was being displayed by btmon in units of 1.25mS,
>> which is incorrect. Print in decimal instead of hex as it is a number.
> then print the connection latency with a correct unit and the hex value in parentheses. This way is not acceptable. If we need a print_field_msec helper, then introduce that and use it throughout.
>
> Regards
>
> Marcel
>
Thank you for the quick response.
I think there may be a misunderstanding here. In these LE messages, the 
Connection Latency is not a time unit. It is a count of the number of
Connection messages from the Host that the Peripheral can ignore if the 
Peripheral has no new data to send at that time.
Since it is just a count, printing the same value in both decimal and 
hex is a stylistic decision.
Regards,
Leigh
