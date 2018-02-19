Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Problem with re-loading hci_uart.ko on RPi3
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <76f76129-dd3e-2d17-635d-18a563d12aa8@gmail.com>
Date: Mon, 19 Feb 2018 14:12:08 +0100
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>, mzoran@crowfest.net
Message-Id: <32F7EB0D-756C-4CF5-BBD6-574A222401DE@holtmann.org>
References: <E4785C91-043A-4FF5-BFCA-5FADAFF81EE5@holtmann.org>
 <1941091231.91372.1518962068876@email.1und1.de>
 <414BD031-1C2F-4E27-BBB4-BEB9F71B099F@holtmann.org>
 <76f76129-dd3e-2d17-635d-18a563d12aa8@gmail.com>
To: =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

>>>> One option is of course to keep the max-speed in the DT at 115200 Mbps. It would work, but seriously slow down the transport. Maybe this should be done until we get access to the GPIOs.
>> So I am convinced when we run on hardware that has no GPIO resources exposed (as it is with RPi right now), we should limit the operational speed to the initialization speed. And then my problem actually goes away. It also forces people to get the GPIOs exposed or they have to stick with a slower HCI transport.
> 
> We may also reset to initialization speed on module unload.
> This will allow multiple tests on the hardware, even if it does not have GPIOs exposed.

you would have to do that on hci_unregister_dev and that is also tricky. If the device is down, we need to spin the transport back up and actually support HCI transaction like within hdev->setup(). It also means that we would have to take care of a lot of struct device lifetime rules etc since this might actually take some time. And if it still fails, the device is still borked.

So I had thought about this briefly and looked into adding infrastructure into Bluetooth core for a hdev->cleanup() function, but just adding it for a hardware that actually has a GPIO, but doesn’t expose it right now seems really like a lot of code for nothing. This means limiting it to 115200 baud initially until someone comes along and gets the GPIO integrated seems more encouraging than hacking around it. And this would be hacking around it.

Regards

Marcel

