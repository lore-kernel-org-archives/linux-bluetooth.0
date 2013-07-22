Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: 057c:3800 BlueFRITZ! Bluetooth Stick broken since 2.6.something
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <51ECDB03.8090109@boh.de>
Date: Mon, 22 Jul 2013 07:22:07 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <4A86B920-6A47-4E2D-8F6F-90A626CFC878@holtmann.org>
References: <51E7ED11.7010103@boh.de> <36A79410-3FA3-408F-BA16-6A30568A7035@holtmann.org> <51E8DBFF.4060702@boh.de> <5BE2601B-7C94-4C24-AB9B-EF187CAD9098@holtmann.org> <20130719162051.GA7373@x220.p-661hnu-f1> <51ECDB03.8090109@boh.de>
To: =?iso-8859-1?Q?J=F6rg_Esser?= <jackfritt@boh.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>>>> HCI Event: Command Complete (0x0e) plen 12 [hci0] 0.043811
>>>>      Read Local Version Information (0x04|0x0001) ncmd 1
>>>>        Status: Success (0x00)
>>>>        HCI version: 2 - 0x2006
>>>>        LMP version: 2 - 0x1806
>>>>        Manufacturer: AVM Berlin (31)
>>> it declares itself here as Bluetooth 1.2 device. Which means it is the
>>> second generation of BlueFritz! USB device.
>>> 
>>> <snip>
>>> 
>>>> < HCI Command: Read Local Supported Comm.. (0x04|0x0002) plen 0 [hci0] 0.210014
>>>>> HCI Event: Command Status (0x0f) plen 4 [hci0] 0.217361
>>>>      Read Local Supported Commands (0x04|0x0002) ncmd 1
>>>>        Status: Unknown HCI Command (0x01)
>>> And here is your failing command. Newer kernels have been strict with
>>> failing commands and will just abort the setup if anything goes wrong.
>>> 
>>> Johan, we need to figure out on how to work around this one. Might
>>> just match for the manufacturer before sending the command.
>> Either that or a quirk based on the USB id. Wouldn't matching just the
>> manufacturer be a bit problematic for any newer chips from this company,
>> or they stopped doing Bluetooth dongles after this one?
> They stopped doing Bluetooth dongles after this one. I found no more Product with bluetooth on their website.
> The support from AVM endet on 01.12.2009.
> As I read here http://www.wehavemorefun.de/fritzbox/BlueFRITZ!_USB

yes, they ever only made two products. And their baseband was based on Silicon Wave which actually got bought by Qualcomm if I remember this correctly. So going by the manufacturer id and adding a good comment into the code might make this work nicely again.

Johan, if you prefer a quirk, then go for that one.

> Should I open my trash bin?

It is nice to have these old-timers around. And we do want to make them work. Knowing where they fail is actually pretty good. Then again, it is a Bluetooth 1.2 dongle and your are missing features like Secure Simple Pairing or Low Energy.

Regards

Marcel

