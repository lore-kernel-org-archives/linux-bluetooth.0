Return-Path: <frederic.danis.oss@gmail.com>
Subject: Re: Problem with re-loading hci_uart.ko on RPi3
To: Marcel Holtmann <marcel@holtmann.org>,
 Stefan Wahren <stefan.wahren@i2se.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>,
 Eric Anholt <eric@anholt.net>, mzoran@crowfest.net
References: <E4785C91-043A-4FF5-BFCA-5FADAFF81EE5@holtmann.org>
 <1941091231.91372.1518962068876@email.1und1.de>
 <414BD031-1C2F-4E27-BBB4-BEB9F71B099F@holtmann.org>
From: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>
Message-ID: <76f76129-dd3e-2d17-635d-18a563d12aa8@gmail.com>
Date: Mon, 19 Feb 2018 11:10:07 +0100
MIME-Version: 1.0
In-Reply-To: <414BD031-1C2F-4E27-BBB4-BEB9F71B099F@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Le 18/02/2018 à 20:07, Marcel Holtmann a écrit :
>
>>> One option is of course to keep the max-speed in the DT at 115200 Mbps. It would work, but seriously slow down the transport. Maybe this should be done until we get access to the GPIOs.
> So I am convinced when we run on hardware that has no GPIO resources exposed (as it is with RPi right now), we should limit the operational speed to the initialization speed. And then my problem actually goes away. It also forces people to get the GPIOs exposed or they have to stick with a slower HCI transport.

We may also reset to initialization speed on module unload.
This will allow multiple tests on the hardware, even if it does not have 
GPIOs exposed.

Regards,

Fred

-- 
Frédéric Danis                       Embedded Linux Consultant
frederic.danis.oss@gmail.com
