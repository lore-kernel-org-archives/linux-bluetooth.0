Return-Path: <stefan.wahren@i2se.com>
Subject: Re: Problem with re-loading hci_uart.ko on RPi3
To: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>,
 Eric Anholt <eric@anholt.net>
References: <E4785C91-043A-4FF5-BFCA-5FADAFF81EE5@holtmann.org>
 <1941091231.91372.1518962068876@email.1und1.de>
 <414BD031-1C2F-4E27-BBB4-BEB9F71B099F@holtmann.org>
 <76f76129-dd3e-2d17-635d-18a563d12aa8@gmail.com>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <f94056a0-ece7-c579-6b7d-d6589079d9e6@i2se.com>
Date: Mon, 19 Feb 2018 13:25:38 +0100
MIME-Version: 1.0
In-Reply-To: <76f76129-dd3e-2d17-635d-18a563d12aa8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Am 19.02.2018 um 11:10 schrieb Frédéric Danis:
> Hi Marcel,
>
> Le 18/02/2018 à 20:07, Marcel Holtmann a écrit :
>>
>>>> One option is of course to keep the max-speed in the DT at 115200 
>>>> Mbps. It would work, but seriously slow down the transport. Maybe 
>>>> this should be done until we get access to the GPIOs.
>> So I am convinced when we run on hardware that has no GPIO resources 
>> exposed (as it is with RPi right now), we should limit the 
>> operational speed to the initialization speed. And then my problem 
>> actually goes away. It also forces people to get the GPIOs exposed or 
>> they have to stick with a slower HCI transport.
>
> We may also reset to initialization speed on module unload.
> This will allow multiple tests on the hardware, even if it does not 
> have GPIOs exposed.

I prefer this solution instead of coding workarounds within the devicetree.

Thanks
Stefan

>
> Regards,
>
> Fred
>
